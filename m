Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE36AC55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:08:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82FEB206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JZJay9Au"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FEB206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRAQy-0003P2-Mg
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 04:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRAPz-0002BL-LG
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRAPz-00075U-5s
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:07:39 -0400
Received: from mail-eopbgr60105.outbound.protection.outlook.com
 ([40.107.6.105]:52545 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jRAPv-0006hK-KH; Wed, 22 Apr 2020 04:07:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxNZjG/mU+FhbWFnpvILY6HC3Rnkzd7fePsnXe/cl+D/P+BQRnLYmGpRwYIyaHrF6ufg+PgA4H7J1EYCHeqJfahm4UtbxR/L6QQbdVjyBha+ebb5XKKGE8HHkGYF8iafGT9mJX2y3LT4TuU9KkTb95NFeZQEhozyW3sTzv7dc52lnEJuBaR+f33RTxTbcwGPAjPcwKNRo2Qr6osWlU0v03hy3q4aB3+XAfB3HW6xTLw2bqJexJmcfyODAy/NgoUwF6enFcDUrlYToTEsv5FQqLQ55uCl+MjlvBLO+Fv8ftHA7XAis1I4hXPxOdENJONbAY56X1fEbDY1qkkgh0X8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZYrQVitrQZHEluEADjRwA4wsMeFxcKxqneo06oAgBg=;
 b=G0sD+NY5WHV/jgLT7QqRCAL+JdI2EVlWz6ziPJatgK3/L7TU56dXDH2LIUvcC1c7sWaWyzYCXByypkCeeTXJqUI1CX/syRKjTP77uC26snNvxjlQ6nPp+fOoK9OYx560fenRskzj7ndUb4g8Ul8dWyKontCNaxwBd/W3Sk8FTmlXhWjpI0GLREtIzgzzq3rnayiQCtuoHsn1q7Sql2YH2TETJLxjaOctKQjmWCO3z5irRsZsSzimcqyW37gIBuWDwQY6I28t1LRHEletfBsTxHDd88Yly8UuucV3yfaeoC0b6MAc/KDncViMBisEGbxxAWwreGtUwGrxi9oyaJlgKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZYrQVitrQZHEluEADjRwA4wsMeFxcKxqneo06oAgBg=;
 b=JZJay9Au8lMHuv0t7DRW1nUzpcYwSH2kbotSKMIowyjz5NMKleLijYWTh34RrWQW26s+OyNWQZWq9C3Y5ZcbEFxh1Rp4i02GmujsTdzSIojQ5LtGaRG49o0ICmb/rxj/M2b/NXs1OHS6NbX/ewiZkiGNh26Z++EhYaMQwwshVWk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26; Wed, 22 Apr
 2020 08:07:32 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 08:07:32 +0000
Subject: Re: [PATCH v4 18/30] qcow2: Add subcluster support to
 qcow2_get_host_offset()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <1cc780f735044ac9138808234589d2c278c9cfbf.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200422110730685
Message-ID: <b3f2ddad-2053-0839-ae97-3d886790a131@virtuozzo.com>
Date: Wed, 22 Apr 2020 11:07:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <1cc780f735044ac9138808234589d2c278c9cfbf.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM0P190CA0004.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Wed, 22 Apr 2020 08:07:31 +0000
X-Tagtoolbar-Keys: D20200422110730685
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67ebd240-09f6-43cf-9fa1-08d7e694356d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54786D5DE8F95AFDAC14E94DC1D20@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39830400003)(376002)(396003)(346002)(136003)(366004)(36756003)(2616005)(8936002)(66556008)(66476007)(66946007)(4326008)(8676002)(81156014)(956004)(2906002)(478600001)(16576012)(6486002)(52116002)(31686004)(26005)(186003)(16526019)(316002)(31696002)(86362001)(5660300002)(107886003)(54906003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ia9DM2rtXj+Rj0PsUWo6CWjo8F7+PdeBBXagh2uKEYzTFFVLZyMH1vUFBvsX08DIPDY6B4UpHYZG12Scv2QtYZ33KP2HFuL349ZC82dZvnNLzB3Yb0VxLap6ywIBb9z4PkGzqUWwD/pNwGwhuNuNZA3CdsF1zo0eHsnaYjIizRyfL4lYbpv9doIx2qMuuig179zTBbHue4gWJtRtWZ5FPuc/dSz9+aMnIqOPqcAkbiaD3XS2xViTN0MqoJz2WIGYjbCY2ClyScO5ryJspMJaA7W50wHxQ7WUls+E4p05g8vMiY9aQOir7BY7JpCvXoRmAFJfoc8cqlb6WhHKXpHLH9YQiU4Ik7cs28Ph1mCiPFU5Bz6znrHywrsNrKyBWIHEHipUq2y2v0edcqUNJmKwSmLmfAZ6b1HkBSvGVV/A1dfBLZ2V7j2UWSWYw0SWi4am
X-MS-Exchange-AntiSpam-MessageData: sABH/HASYfEJ/uriftJZh7dtmG6l+0b65LLpTHLCNkx4D+DoogsvizKprd6FOAWakh8OByfaaAjDf3sgJcN8T+lQ9uvhLX5vSQwIWOZkH2Do36Ag6i8cGhekqEQ3saS3VIsgnvljzMpxZhQ1r8r+2A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ebd240-09f6-43cf-9fa1-08d7e694356d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 08:07:32.3632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xMjcQHHQD0d20YVWtIKD2RSYg/ONJKduku6U0TxjLSTJ4gjmHoB4x6zZJF6GFdtq8EH8nI5nsPxZvnM46nqDwRNbsF9eVqbX/ULCA5G9Ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.6.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:07:33
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.6.105
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.03.2020 21:16, Alberto Garcia wrote:
> The logic of this function remains pretty much the same, except that
> it uses count_contiguous_subclusters(), which combines the logic of
> count_contiguous_clusters() / count_contiguous_clusters_unallocated()
> and checks individual subclusters.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---

[..]

> +static int count_contiguous_subclusters(BlockDriverState *bs, int nb_clusters,
> +                                        unsigned sc_index, uint64_t *l2_slice,
> +                                        int l2_index)
>   {
>       BDRVQcow2State *s = bs->opaque;

preexist, but, worth asserting that nb_clusters are all in this l2_slice?

[..]

> +        for (j = (i == 0) ? sc_index : 0; j < s->subclusters_per_cluster; j++) {
> +            if (qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, j) != type) {
> +                goto out;

why not just return count from here? And then you don't need goto at all. Hmm, may be out: code will be extended in further patches..

> +            }
> +            count++;
>           }
> +        expected_offset += s->cluster_size;
>       }
>   
> -    return i;
> +out:
> +    return count;
>   }
>   

[..]

> @@ -607,21 +607,20 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
>               goto fail;
>           }
>           /* Compressed clusters can only be processed one by one */
> -        c = 1;
> +        sc = s->subclusters_per_cluster - sc_index;

should not we assert here that sc_index == 0? Otherwise the caller definitely doing something wrong.

>           *host_offset = l2_entry & L2E_COMPRESSED_OFFSET_SIZE_MASK;
>           break;
> -    case QCOW2_CLUSTER_ZERO_PLAIN:
> -    case QCOW2_CLUSTER_UNALLOCATED:
> -        /* how many empty clusters ? */
> -        c = count_contiguous_clusters_unallocated(bs, nb_clusters,
> -                                                  l2_slice, l2_index, type);
> +    case QCOW2_SUBCLUSTER_ZERO_PLAIN:
> +    case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
> +        sc = count_contiguous_subclusters(bs, nb_clusters, sc_index,
> +                                          l2_slice, l2_index);
>           *host_offset = 0;
>           break;
> -    case QCOW2_CLUSTER_ZERO_ALLOC:
> -    case QCOW2_CLUSTER_NORMAL:
> -        /* how many allocated clusters ? */
> -        c = count_contiguous_clusters(bs, nb_clusters, s->cluster_size,
> -                                      l2_slice, l2_index, QCOW_OFLAG_ZERO);
> +    case QCOW2_SUBCLUSTER_ZERO_ALLOC:
> +    case QCOW2_SUBCLUSTER_NORMAL:
> +    case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
> +        sc = count_contiguous_subclusters(bs, nb_clusters, sc_index,
> +                                          l2_slice, l2_index);
>           *host_offset = l2_entry & L2E_OFFSET_MASK;
>           if (offset_into_cluster(s, *host_offset)) {

Hmm, you may move "sc = count_contiguous_subclusters" to be after the switch-block, as it is universal now. And keep only offset calculation and error checking in the switch-block.

>               qcow2_signal_corruption(bs, true, -1, -1,
> @@ -651,7 +650,7 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
>   
>       qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
>   
> -    bytes_available = (int64_t)c * s->cluster_size;
> +    bytes_available = ((int64_t)sc + sc_index) << s->subcluster_bits;
>   
>   out:
>       if (bytes_available > bytes_needed) {
> @@ -664,7 +663,7 @@ out:
>       assert(bytes_available - offset_in_cluster <= UINT_MAX);
>       *bytes = bytes_available - offset_in_cluster;
>   
> -    *subcluster_type = qcow2_cluster_to_subcluster_type(type);
> +    *subcluster_type = type;
>   
>       return 0;
>   
> 


-- 
Best regards,
Vladimir


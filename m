Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A890C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 18:20:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8070C20853
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 18:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OjRqQyiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8070C20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPV5j-00044j-EG
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 14:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kPV4H-0003C6-4z; Mon, 05 Oct 2020 14:18:37 -0400
Received: from mail-am6eur05on2122.outbound.protection.outlook.com
 ([40.107.22.122]:22881 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kPV4D-0003jS-NN; Mon, 05 Oct 2020 14:18:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyuUsNocHq9W/Ivl4pyXOXR0sjih1gZpR/tZSjo0jeKciZnT3lhyY3YllkJRRfcH2gOknFBXVPxQz78DSZSKTf91qq6fwbAbx4jhqEWEk/e+s/gHGdBWArhLFRMCChx83KXsEraltL6G4Haz/SL7P7lXlNy3w5slmItWR0vAQYS7zDdZjUFl6wR2DKr1xMNnDv8ebNBb3VXkNfK1l8TUR6u25rDYgKQ3U/bSEYN8zbmbWMEKSsOIsqvY4GM6iG/JYYxR5o3N2UG/Nt9/0YqTGucDfBBvHee0leEJ2qPsDv4QlPqdSNn0Gzv4CiONZaDBmVYgEmLbX4iRECSAuz3Llw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7G0RJTgxXvayBQyDpJg68kLY0KF50bOnBrj5NvMm4yU=;
 b=ZT96AdcpVjWcCSF9gCxmkxNTrA0d0ntIE/mNxf/5wdGVGtuUEbOEiQTB99OpYruDdS19zvVM/p9gpqxTgQ5W5R0kzG7Vkyiz+csxYiFhsXMLZZDAZns7NEpi6RVWfKAz5yU5EfPxu9jD/co+ySSAUu42YDNiKgomgi6RfDk5exSnShAJk9TT6afsNQjPKAWGvI++bl8dNYtvdNbEG7IeOpkHuRH4i9C653yKTzTSPE0ma4jVh1Bh5qiFgBMhQv5PwThxfcHgjWG2+NlA0LiDdkasrycXXqyv9h0PdJmQx2f4ark95rYlSVKGngcI6ptEEoqvPxW5KsMHn9n8WT/J+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7G0RJTgxXvayBQyDpJg68kLY0KF50bOnBrj5NvMm4yU=;
 b=OjRqQyiwmi/Td9eDtmdbIOsNhVHPL8+ZYn2CiOq9i1P40atKabuoi2w5XeADkyDN6TrNrN1FQmaZFr4T5iYb9ds5r3iYqRfUG5hyvPJ0xsc6Ws+42AsZUBoDgh6Yx5WxoarWPYUikWBW3117KUUToIo1jUMhwx0VmbOdSAM6JyU=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR08MB2779.eurprd08.prod.outlook.com (2603:10a6:7:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.43; Mon, 5 Oct
 2020 18:18:28 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3433.043; Mon, 5 Oct 2020
 18:18:28 +0000
Subject: Re: [PATCH v10 5/9] copy-on-read: limit guest COR activity to base in
 COR driver
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1601383109-110988-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1601383109-110988-6-git-send-email-andrey.shinkevich@virtuozzo.com>
 <ab11d5f1-0832-ced7-cee7-c791d65b7131@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <c3297360-5d6d-667c-2677-be1bba8bb564@virtuozzo.com>
Date: Mon, 5 Oct 2020 21:18:25 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <ab11d5f1-0832-ced7-cee7-c791d65b7131@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM4PR05CA0012.eurprd05.prod.outlook.com (2603:10a6:205::25)
 To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM4PR05CA0012.eurprd05.prod.outlook.com (2603:10a6:205::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32 via Frontend Transport; Mon, 5 Oct 2020 18:18:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bc42ee9-ba71-4afe-097b-08d8695b0e41
X-MS-TrafficTypeDiagnostic: HE1PR08MB2779:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB277973C407F7598503C568D5F40C0@HE1PR08MB2779.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5tf+tmDeeNB27cvFKnmsi0as9E02dS9CSn4QLvSwobRkjgbJ8G6DAteMbemIjZPNLr9axHvkGDqT3J5RfW6SG1qZpmV5aODEPrYTClJXILea4OCTF7tQb+ixWrr9wVIwMLKwzwgVgt1MBzRIgEs5BO1viT+CEG6kfIepw4wHLJDO03xjfM5H4KpwdxGock0bwkU/qwFsFQYD4u9i8GeP6FFPLTzphq1WidJMFSOm63sakcMlnBVfwE8nkdm3p55bZbWIY1v8Vm98TEqdtDoU090Iwf5x/h/bE0HeKutlU3Le6EetlpVCy2P2sCPEJ/5wXChhHcFm4vtuzbRB/CK3P9kFYuSVSJzKA5bYfAwHM7BDmiDRuGfkClkXy/JaUU1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39850400004)(44832011)(5660300002)(52116002)(186003)(53546011)(16526019)(2616005)(31696002)(6506007)(107886003)(956004)(31686004)(6512007)(86362001)(26005)(8676002)(316002)(2906002)(36756003)(66556008)(478600001)(66946007)(4326008)(8936002)(66476007)(83380400001)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jI4bSgQi0Dmv5YIae0Qi2Dbx5IzbYLLOcMIioDxGpYiwFhw0UPTnhIh1+fEkYN0N65Fg91Sw2KG1QEZ5DDuTPQJEUovszZo125uDrdeULs20cdMJVeV0rOudm8KSGU3PypIOLKM+IfrLaqERTOdm2UL8G+ObfnEeifSjOBbK4pyBltPslWTPMEYqIDMW9JDarlkoOgqR/xgdutTeVzyY+LsjZVvcQS5Ou+/VX8eKoY2vEQo22RRTeQCtiUewb5Ywz+4YJ79e1/NPHqZdff2e1qkfYaX4TLZ1SloJtFsmL8zYnxjI2DI5vDwvJ7Sqf7Eea7KB8OuX7+7a0c72Dm95rzrxhk0XCDz+Y3Q8KnCVyjCIEE6SCqEVkRRr/XZsKUNWCUXAn1VhN9ovr04CS4j/PSWueEvvIMu5dA69IXlckPMuL63mZLyOwEzfX2YB6clsJ3F7EecXP9fmtN21LPxupyv3nXYl7YFAkjsjDjNMEO83+2Q7mJZjsZeSn/lvrQkcjMuqo5sAMEIdlDxFidf8tRvcHNto7hUZmeq8E/JKo6+01/FTM6XsQ7JdIq2Q6pfTLz7WaySrU0gDvy7sMUjrg8fz/WjAQ/390eSLXG896pai9ZUdsBFGDi9bdSnlhfFXIF+yZgMKagLUmWIrhpmTAg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc42ee9-ba71-4afe-097b-08d8695b0e41
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 18:18:27.9896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMyMFq/qbyuhBt3mEgTQ6h+CWsWwK7tb+F9yATA4FZo91E70DWXURa8oZEPFBzFMZDpYSrb22sXi1DXpXGBQ64eJLfSQjg0ik7E3+gGWfE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2779
Received-SPF: pass client-ip=40.107.22.122;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 14:18:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05.10.2020 17:58, Vladimir Sementsov-Ogievskiy wrote:
> 29.09.2020 15:38, Andrey Shinkevich wrote:
>> Limit the guest's COR operations by the base node in the backing chain
>> when the base node name is given. It will be useful for a block stream
>> job when the COR-filter is applied.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/copy-on-read.c | 38 ++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>> index e04092f..f53f7e0 100644
>> --- a/block/copy-on-read.c
>> +++ b/block/copy-on-read.c
>> @@ -121,8 +121,42 @@ static int coroutine_fn 
>> cor_co_preadv_part(BlockDriverState *bs,
>>                                              size_t qiov_offset,
>>                                              int flags)
>>   {
>> -    return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, 
>> qiov_offset,
>> -                               flags | BDRV_REQ_COPY_ON_READ);
>> +    int64_t n = 0;
>> +    int64_t size = offset + bytes;
>> +    int local_flags;
>> +    int ret;
>> +    BDRVStateCOR *state = bs->opaque;
>> +
>> +    if (!state->base_bs) {
>> +        return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, 
>> qiov_offset,
>> +                                   flags | BDRV_REQ_COPY_ON_READ);
>> +    }
>> +
>> +    while (offset < size) {
>> +        local_flags = flags;
>> +
>> +        /* In case of failure, try to copy-on-read anyway */
> 
> But you add the flag only in case of success.. On any failure of furhter 
> is*allocated calls we should set the flag.
> 

Actually, myself would prefer returning the error instead.

Andrey

>> +        ret = bdrv_is_allocated(bs->file->bs, offset, bytes, &n);
>> +        if (!ret) {
>> +            ret = bdrv_is_allocated_above(bdrv_cow_bs(bs->file->bs),
>> +                                          state->base_bs, false, 
>> offset, n, &n);
>> +            if (ret > 0) {
>> +                local_flags |= BDRV_REQ_COPY_ON_READ;
>> +            }
>> +        }
>> +
>> +        ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, 
>> qiov_offset,
>> +                                  local_flags);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +
>> +        offset += n;
>> +        qiov_offset += n;
>> +        bytes -= n;
>> +    }
>> +
>> +    return 0;
>>   }
>>
> 
> 


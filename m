Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0DDC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 07:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB182083B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 07:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Q+trY8Uc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB182083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc1TO-0007P9-W9
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 02:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc1Sd-0006ul-OJ; Mon, 09 Nov 2020 02:19:31 -0500
Received: from mail-vi1eur05on2091.outbound.protection.outlook.com
 ([40.107.21.91]:50866 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc1Sb-0007tb-PC; Mon, 09 Nov 2020 02:19:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6mnY4Pss4svqogOxoLFNjMKa+i6npL6FRvfD3yDY+pmU0lTZqjvkz1APBvpFaPKqEIZXCnQtXHF7vf4KSYHw4ecbthGwV4X3SI0uKAEFTFTlSrsVoKm7rLVT0CSw2/VpL8ty5Hwu6pMBhFNp4wcmWCSH1skxEZMxH054qnJaCRn9OqUEgGyRipF6GPKwOqui5oZODdtFBti+3K+xj7vLoQVm+BN0Cg3HOaVPx/qrEnP/skHgmHvjpDrySs30yGY3ExomgdgNPf6MMrCzU12I9NXq/vs0u5F8St41cvrrM2ix/NnJ8uyPx8C8UX0en3WqD9OLw/B8daHkKQqVbGOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LB11i1mdAC9m3IfW9gWciUd9feqdRNsrHP4tW0lLO/0=;
 b=h0s2f+cXAP6bXUtJWs02QIfKl3bJuUQJXzWO/CX/CQoZvM2hjpHnH71dgOk6ZpavpSawI2gDXXtw0+X4Bzw3SM3w6vrX0LN4OTEn9/1bwMo8XIqEXOYIrohwIUUSliOEhcbi0xwl7gAF4KB4yuE8k1clCxapVnsBOIf53sKEnS2BYR4Z7E6QB7E/tQk/ujgPDrlsW5URrHl360vRzWrR1UWkrCJD4N7+qCJPrJuGqlKnHa1oha9UrNxgzlqNVvNLLdBeQI79xw/AvvcD9iHXk07g4FzxdBCOfG5b2itF9TF0/R9dQFZJE9yDzBh0RIq55zW3vSoWEbMSck0gm03xtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LB11i1mdAC9m3IfW9gWciUd9feqdRNsrHP4tW0lLO/0=;
 b=Q+trY8UcDEOWBRveRSJU57UgnUAtRH4ff1YJwpugPI8X4aCY4VIjulNc9reqxPgXhItAbEZ81zB2L5egJbtV1xodntc67RG19RM/dPPK3iqYxmC714/fgIsIu2M9of7Q7s7eCz38DiHdhmsnvvIJbH9hO0bywrsuH5mCa+yTGc8=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3720.eurprd08.prod.outlook.com (2603:10a6:20b:8f::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 9 Nov
 2020 07:04:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 07:04:22 +0000
Subject: Re: [PATCH v2 4/7] block: add bdrv_refresh_perms() helper
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
References: <20201106124241.16950-1-vsementsov@virtuozzo.com>
 <20201106124241.16950-5-vsementsov@virtuozzo.com>
 <w51zh3u8qlx.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6bc178d3-8c9e-b2e9-8606-97a2b222d63a@virtuozzo.com>
Date: Mon, 9 Nov 2020 10:04:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <w51zh3u8qlx.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.85]
X-ClientProxiedBy: AM4PR07CA0028.eurprd07.prod.outlook.com
 (2603:10a6:205:1::41) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.85) by
 AM4PR07CA0028.eurprd07.prod.outlook.com (2603:10a6:205:1::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.21 via Frontend Transport; Mon, 9 Nov 2020 07:04:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ae2c61e-6b9e-42ca-a03f-08d8847daf77
X-MS-TrafficTypeDiagnostic: AM6PR08MB3720:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB37200E496342250532FCAABBC1EA0@AM6PR08MB3720.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZQkmiP3oVqgK9GYWrgYR21Lm4LzWYC5qtxPiI5VGaw0Od+a5ksctsPCr28nw6FrozbpuISoo7kOCbF7cyUKQNOt0aaRTVV/wChzcuCVlN75GS358iklOwt0zovzDKbhVHwxlYyz2mtw1a4KKNUTxamAKsuUHW2ssSJ9xNJ5WP3m9gLsux2pU0qqV8TbQL79nZuJslVFKThCTa37LBy/5z85FkA1yfSJhr51wEcPFfbIm0tPFpECU9PjrwIM7YoG1PKUGayB37/1VRg/1ruOHcpaMY2dYsguD1G0FVpS3pmZMko/98o3F9k2H+TlUiVBUojCE4ygP/swJRG6jq9G0IT+d3+T59iSBMAnDy29qHozFdK8oQIeSW9H64EG4PD5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39840400004)(366004)(346002)(376002)(316002)(66556008)(52116002)(66476007)(4326008)(36756003)(2616005)(956004)(16576012)(8936002)(6486002)(31696002)(31686004)(66946007)(16526019)(83380400001)(86362001)(186003)(8676002)(478600001)(5660300002)(26005)(2906002)(107886003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 0iXv7Q4SihWJUHCFht67pQsbl5mvOFNj9G0vfDtqBnDGiXX9wjgIlGrdG2Kr0s2tWTBfi9V011SxZFwZSdZ6JqQkftk+nlNb//ipwZyEsXZYvqfRoOUnL412OCcy4J0TBqjkPWFauhrxWN4K1znrW4QZTyvhkaX43fJWSO6vxVCkQVx7ysQNIjuBmChd4bfAlxWUChaBxonvoMVVyELTVRauHXs0DW3nKxweNCus0ovwoNWuthH9Ycedck0Ji5seisdsNhwUNMcJicFsjk4ciygXjlHJZr9zwdEtPFE3rnCR1WIfefEI3bGUWkLvAbOs5UjgzEHsKVPRtwM1iVPYhmgSjDv7lFhPFR2FNeB5whpgEiWOx5IoD/K3fIn4TtuS2A4a+rAuIkuF/dOrjzaKSianpqa6YgjeBXE6HmtgC6tNSuwch9yaP+7QzEj7pEl9+PoPDjZyiTPAp+JQdGcNPKyHR1yTKUsa0Cn2Fxu+DEuLcxEFgwiMOONQN2s/zBPcFmHtP0ziAJ/sOpmtefVZ8Ggo1HN2vL05zdaJZ4SKUi7XSkYdDjk/Tll4myG4UU6ayVjr2ZRcHEPHowi16JCE+1UDI46Q7vUH+bCjz1dcPIFZv7/RWIrMfdgVa7bg+wgUSgRE4j1AVTGTkIqJNkAbQg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae2c61e-6b9e-42ca-a03f-08d8847daf77
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 07:04:22.4129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDudouw8TYZBJIwNoaqGzBmntKV3hnRfgZzMwAlrxqVQaXnFhfhIcD8lWufrwVFYha87ia4Hiyt9IK92beEK+AE/WXtkJ2BDJZeSSmAShwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3720
Received-SPF: pass client-ip=40.107.21.91;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 02:19:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

06.11.2020 18:14, Alberto Garcia wrote:
> On Fri 06 Nov 2020 01:42:38 PM CET, Vladimir Sementsov-Ogievskiy wrote:
>> Make separate function for common pattern.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block.c | 60 ++++++++++++++++++++++++++++-----------------------------
>>   1 file changed, 30 insertions(+), 30 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 77a3f8f1e2..fc7633307f 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -2321,6 +2321,23 @@ static void bdrv_child_abort_perm_update(BdrvChild *c)
>>       bdrv_abort_perm_update(c->bs);
>>   }
>>   
>> +static int bdrv_refresh_perms(BlockDriverState *bs, bool *tighten_restrictions,
>> +                              Error **errp)
>> +{
>> +    int ret;
>> +    uint64_t perm, shared_perm;
>> +
>> +    bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
>> +    ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL,
>> errp);
> 
> Aren't you supposed to pass tighten_restrictions here ?
> 

Oops, yes I should


-- 
Best regards,
Vladimir


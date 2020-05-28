Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1ACC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4152075F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="t4dc9CT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4152075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeEtW-0000iV-Hv
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeEsr-0007wy-Mo; Thu, 28 May 2020 05:31:30 -0400
Received: from mail-db8eur05on2139.outbound.protection.outlook.com
 ([40.107.20.139]:21685 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeEsn-0008Ft-63; Thu, 28 May 2020 05:31:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQDX5frwXDNeaMIq8d/WtMUJGji7M14+wlRz78qehDGMmX/EHhluumffBykssYvb9noRWOUjdsBm1EmkQeqK9V3wYCuWrfMrPNWyVyHwiQOVKbdHIHcm6fw1zxPB+Q/ktvoeZNXVWo1aBByVhxZ4hZmmIJvfe72qd2IXRxSX4JFdYPYdFwU5zCgvu13vGaiM1IMzoxkDOznxx4aPR6/CzTow/T2bha/jKMlqgtBT0GZayFivzV8AxfI/sGAViOkjC+z7slVX5U6dFqZlX+SJwyOjJ+GG2fyzWpGfll6QkPH4tCePVk3TcfzfcFVyBR8K6LwBCBKjTSa+GI+RNQU/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atLmTHZ8O6Z6309bOyTEtSE14dJ84itBjOd5s5n4cSg=;
 b=gs2RwejRFcmoUWPQ8g+immtGMfSQQqBr/ZqT7StgerQGmBv3lKALHrXXNe3UN/rRrE0CAUG2vFT4gbNZfDo6HGLSiaeVR/Z3seRgT/ZpPPUpLlWtekM2iXNiB52j3t9YbfTW2VDYoqoHUolRFanDMvKVDfBcQskRtMpQ+SLdD+zktfShMYlMguoo9ISAF0kfwGKSNTE3mCqfIP4GAdcJsK34Pz55Q1oGPpxrtbcA3QrwXumGjiYkszgQbqL5INIpTJmy3ywCZjl0MDzsplM7DkFFMoJm0+t+jxxB80xtLrBXAHd2PKNoRplOM9jFM3+9s6WFMydD6O0eRTBew3Be7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atLmTHZ8O6Z6309bOyTEtSE14dJ84itBjOd5s5n4cSg=;
 b=t4dc9CT4ZHfLXpsVapX+EkkfDRLpCqc6L6nTOscOD+axDnZlmneAb2gMBP1VrgYKjwUzIFvmUgGugjuO49mNXOY9Hvcyz7om/kl8o+1VUzzCumqOGwtxTSoJXmxnbyYwVLu7Nh82q7IAEguqD0jxhsjJRWzVcNmKeeqb4ZPpQjY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 09:31:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 09:31:20 +0000
Subject: Re: [PATCH v2 2/9] block: inline bdrv_unallocated_blocks_are_zero()
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200507084800.20596-1-vsementsov@virtuozzo.com>
 <20200507084800.20596-3-vsementsov@virtuozzo.com>
 <066235a9-72ee-f9bc-7d5b-1f664a7d36b7@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0f60a27b-1f83-58e8-8a87-463f32b021cf@virtuozzo.com>
Date: Thu, 28 May 2020 12:31:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <066235a9-72ee-f9bc-7d5b-1f664a7d36b7@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR07CA0031.eurprd07.prod.outlook.com
 (2603:10a6:205:1::44) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM4PR07CA0031.eurprd07.prod.outlook.com (2603:10a6:205:1::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.14 via Frontend Transport; Thu, 28 May 2020 09:31:19 +0000
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6193e76-38b1-45e3-6042-08d802e9e178
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53177626B2C23A661EDDA822C18E0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUbyG0Slrx1TJUKH0JICX3tQL0wVGT5veXFYraa8A+1aRMunOm+9y1rh7POLmPEynIhbKq4Uwg+J+9q4lIN5oyQnVQdOZtGHSshYqLFX+aCftvlmMZxzVAuVBXne7zvA2km1RO0y+4WhhC6MzzBuFRDtpbGidnwqvmmjKeF+6xEHK48CMVyTxmoZGyg1omABMZ2tiRZ/onz5/sKlJocNLGVrRxvXi6Iw0klgECmYRjkyBJ1Gvhcpv7SbVwd9ec/mIvfL/3nsM+gg74akZllRVpnMlXByDd/yy7amwuU4UGFQ6b59gmBr+I5j6/omDViLQMi9dCF9aWJ/6YI5GwIET9mFRclCchCy5UhujKisnrWuBJtaU85Rt4DTbzy/RoIu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(366004)(376002)(396003)(39840400004)(36756003)(66946007)(2616005)(31696002)(31686004)(86362001)(8676002)(66476007)(2906002)(66556008)(956004)(316002)(53546011)(52116002)(8936002)(6486002)(26005)(5660300002)(186003)(4326008)(16576012)(83380400001)(7416002)(478600001)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: uWyjS+UmjByY0SgbNCMciQkEMnP87wiihpPiXK5JOrx/uTh450Ju61v2wRyOzsK+6MsNdjWpMeTACNhIjOnX1GUwbuNOAFKXjLsInHd1ajKk2cFqqVAlkBt2egMqFhHJxwU6C4T35DRD/FIBSGmy2rV6uOGkdLgIqHItzn36JshwuI7yZlF+gBCguFQ666iv3oZ1Z4d1vQtnYayfpOXVUQ7HqknzU8ZoG4YvrcF7/Xd1iXoKwKIOOPEzopuhIXee9u6FpkZU+AYw0F8lYSrQt9xX4dNal/JqJSVugPf1bnanvSigG7P5mAIgAxnVJLhOHvTrDHGvX6FvJ26+PjkBcqDZWi3fSZJ6N/+Fe65vhuywr0E8WBM0QBV7ve08qfhl6hK1OpUimYU8USi1C5M6vcZkVkVs9naql22QRnEfTu0G2HrHnd6esoO/aGp186C2/d63hcC68Kdki/pw/EbnQwi07onCNUGoQmb1b6Wnx9ODEQewcF8rfXOUKOs6kIvV
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6193e76-38b1-45e3-6042-08d802e9e178
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 09:31:20.8478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IP+2FjN8h8UFaEEksXjW5FkgAC1zJbFpdaUHC6QxFkoxdjbg/0WwI9xE4jmMHAXlGOyj4vnE1eb0nO3AcEf44f9RHSuWBIJhyFQDNjR0Yqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.20.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 05:31:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_DKIM_INVALID=0.01,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, ronniesahlberg@gmail.com,
 codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.05.2020 17:08, Eric Blake wrote:
> On 5/7/20 3:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>> The function has the only user: bdrv_co_block_status(). Inline it to
> 
> s/the only/only one/
> 
>> simplify reviewing of the following patches, which will finally drop
>> unallocated_blocks_are_zero field too.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/block.h |  1 -
>>   block.c               | 15 ---------------
>>   block/io.c            | 11 ++++++++---
>>   3 files changed, 8 insertions(+), 19 deletions(-)
>>
> 
>> +++ b/block/io.c
>> @@ -2386,15 +2386,20 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
>>       if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
>>           ret |= BDRV_BLOCK_ALLOCATED;
>>       } else if (want_zero) {
>> -        if (bdrv_unallocated_blocks_are_zero(bs)) {
>> -            ret |= BDRV_BLOCK_ZERO;
>> -        } else if (bs->backing) {
>> +        if (bs->backing) {
>>               BlockDriverState *bs2 = bs->backing->bs;
>>               int64_t size2 = bdrv_getlength(bs2);
>>               if (size2 >= 0 && offset >= size2) {
>>                   ret |= BDRV_BLOCK_ZERO;
>>               }
>> +        } else {
>> +            BlockDriverInfo bdi;
>> +            int ret2 = bdrv_get_info(bs, &bdi);
>> +
>> +            if (ret2 == 0 && bdi.unallocated_blocks_are_zero) {
> 
> Could perhaps condense to:
> 
> else {
>      BlockDriverInfo bdi;
> 
>      if (bdrv_get_info(bs, &bd) == 0 &&
>          bdi.unallocated_blocks_are_zero) {
> 
> but that's cosmetic.

I'll keep it as is, as it is to be removed in 09 anyway.

> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 


-- 
Best regards,
Vladimir


Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD10C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE26E2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="R14hPOGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE26E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iygNK-0003k0-7E
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 13:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iygL0-0001FJ-Pi
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:20:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iygKz-00044a-MC
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:20:46 -0500
Received: from mail-eopbgr40131.outbound.protection.outlook.com
 ([40.107.4.131]:6823 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iygKz-00040P-Fg; Mon, 03 Feb 2020 13:20:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8W7S1vaoHmdL7euYhaYczYZnTck9f5PO+7oRhAEIJz9eRf/Or2QXCoxNzIZ+2n/ZaY/Yq7LxPdJg4BefdrdgUI6+99jRIKTPTGBr6B5t38WiszMEOx5m9o1pFTPDcSZZSiKmODD2R/s4CJ2T3P+PEqIcXwQOLxLhB9CMWqQ6NL2+lZbmaTtfaB/KG0uai+1DJDOcfdm5v/A60ITGgicW3cmkAgQFTXwAkVKq38HNYtqR8K21KVh8kwcIl4RIplZzyNcbBclP3UBOGX59Tp+7gV919FqFaIBKnuRsT21+CynCVIWxiPA5J5+l965Ya9/2jK6Dy2q7wLegJ5dqhAa2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWDsSCfeH2Bf5R9Hir//Ru+iV8OEPivRJgXN/SqHTnA=;
 b=fqMtv17IqywA9rEtrrFGyK9YFn0WGZWh4DbO5RpPv7l+e+iSULhWt3pmcmxFBTsKLApMbN8uzM4xXIxXHOecCNz6KRiChUtksHLKAizDSIv65mq5DEgzIR76XdlJ/VUlpAoT8f136DsIghMjURYqOCYm2dSfMyTIK8v9LobR9M8vAP0zWcZh8a34sZcNoX2hCiiXdqtJ59GAk7rGbAmXE2dQ5CU2WwD/5c+SPoOAyEus0+z0EvTEUOj0So5tsuJq2v+Cm8/bdmQcoHdMkRLeQSlL+WUZn4Bu0EIrFPGtT2dv7Zy9tNHBq3f1Aj2SEm/mMBUqHrCMG4jzorl1Fvx7EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWDsSCfeH2Bf5R9Hir//Ru+iV8OEPivRJgXN/SqHTnA=;
 b=R14hPOGaLmAEJclmAax6CFZBA8ifOQh8Vqd51ePfdki9jhxKeRBcjmee3XyouzMiAOFBN3J9jkaxPUIx0Dm2IBNkHwGfNXHczeTE75p7v007AOnKfMnygl4rEz42aegPxdvUJqmslhv9yW+z8gz8rEmZoOABMKvMpKOjaem8kS8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3655.eurprd08.prod.outlook.com (20.177.113.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Mon, 3 Feb 2020 18:20:43 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.030; Mon, 3 Feb 2020
 18:20:43 +0000
Subject: Re: [PATCH v2] block/backup-top: fix flags handling
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200203134213.2173-1-vsementsov@virtuozzo.com>
 <e93d8452-cb06-0342-be9f-176e2b50e24f@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200203212041431
Message-ID: <d51ca194-e478-0ecb-4ae5-fe8f62a12035@virtuozzo.com>
Date: Mon, 3 Feb 2020 21:20:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <e93d8452-cb06-0342-be9f-176e2b50e24f@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P18901CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::16) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P18901CA0006.EURP189.PROD.OUTLOOK.COM (2603:10a6:3:8b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Mon, 3 Feb 2020 18:20:43 +0000
X-Tagtoolbar-Keys: D20200203212041431
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 327a74bd-7950-4833-77ad-08d7a8d5c835
X-MS-TrafficTypeDiagnostic: AM6PR08MB3655:
X-Microsoft-Antispam-PRVS: <AM6PR08MB36559D7C24E6B7E2115102ADC1000@AM6PR08MB3655.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(366004)(396003)(346002)(376002)(199004)(189003)(956004)(26005)(86362001)(31696002)(5660300002)(2616005)(8936002)(6486002)(16576012)(81156014)(81166006)(316002)(8676002)(52116002)(66476007)(66556008)(66946007)(31686004)(4744005)(53546011)(16526019)(186003)(478600001)(4326008)(36756003)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3655;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+d/7dP6szRC/69kxCATVqAnxA1MtVLO5YsZ1WUiCC7eVunMjF3ugjAH/SGJwA95qnWq1vs+bRFHfTOCDisMbE9h1fwcYtdMtrlCgBeYbI4lpAx+VPQUcuzYig114kSbyb34O7hv8Qa3/m/TOcKuH6Th6kp7YmtpOL3lStXaTNbVB7bbvmUs1LoAsUSaiD1NGPh6whs3citFIsCgqoVn6oTEG6MvzUpGZw27sl5tk+CHpqmuyvg2Q3pwSGDOnd1VnoNqDpMgDyumLDANnPda37qmIHkTn10Sh0KprufyXpZcYDX3PRg6S/SY9XkULXJDxQAZ5kECx3Fs1dI+ZE/xve5EMMqqcrGpqxc3EURhFPikQCFfjKidnwkfxcQcUyUkjPX8EtOzQoSYlpTOFc8s6Akv0QhY8WzuZ2sxMltzNQ5B/kRjDjG4i4VnXmDMNfTJ
X-MS-Exchange-AntiSpam-MessageData: f94wWccGY0fbvBWD0baI/RYcDgnol7pjuoYh8V5b1Bub2Ng1wbfi2EoWFCrWSD94B+E2rSmEMcG2dvvqKUJMLr09xppLLpEA9QIhL5hBetQflhflaW4hZH0qKw0oydV2DjmbOIsdfFgV28OIK2Hzpg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327a74bd-7950-4833-77ad-08d7a8d5c835
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 18:20:43.8251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5i3JsnhUCb00iXzBtoLTht29kVLW7yDHf+le3P8OB4G1BrzzvVtu0e7PHcadcEAFKXz9NQ8SKYUHMQ5cdhD46/xQS/xTbUr3QwRqSdZLeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3655
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.131
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.02.2020 18:42, Eric Blake wrote:
> On 2/3/20 7:42 AM, Vladimir Sementsov-Ogievskiy wrote:
>> backup-top "supports" write-unchanged, by skipping CBW operation in
>> backup_top_co_pwritev. But it forgets to do the same in
>> backup_top_co_pwrite_zeroes, as well as declare support for
>> BDRV_REQ_WRITE_UNCHANGED.
>>
>> Fix this, and, while being here, declare also support for flags
>> supported by source child.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

Thanks!

-- 
Best regards,
Vladimir


Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8470C2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7008B206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="b/My755m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7008B206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkI6-0000iT-Kz
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLkFj-0006as-6e
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLkFh-0005VS-DM
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:10:38 -0400
Received: from mail-db8eur05on2099.outbound.protection.outlook.com
 ([40.107.20.99]:14080 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jLkFf-0005Ri-9l; Tue, 07 Apr 2020 05:10:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYvhVMnMw1pc44WZ9odJeSUHyUVcyLynFuQnDWKOtKxs2/3h3XwC5Ed0vvIriS+fdn6z4SZDWGpEB8yxaFDTwbLPtvHusaR4rORtSrdl20Qs+tH5JttXCNiRJDtWVYObepmCREM+KEzsaJ2zFw6zv2pBGzvPZ/EG6C6nGtbCM9mDfNHZVxAHD6wePOCFVR/zil62KU5mlqvKKO8syI2nlvPAiOrO+kf+sF14RIc1+mxW5b7ZsRcGqV6FyQ8R/JaWAXjxydRZ0h3MLEj91YArf3gOzajCBtPI2vWDvAwngtvNm0auJ5bAwXU6ls9a/kSQQ2yf0TRJlysLxh4zkcrFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB7VcgwnXnqyJ7nzu+jk3kyAJDW2bDBjKaeMIpRk2jU=;
 b=Vb2P2UXs63HCrrr/Q89tdU+uOlxUlCgrWWzOxlnzoWl4H6BzI6DrEnPfRObvEDxPzmbzFcYM3kQ4Z0GG5biW/7fCzP6r+3QXh6j/HNI1+jEAB6sIhqIcY59s+DF6XJ4gtwNzhgFCbxVumss1HDtE3tlufpvOqcChfxIkUC6THwJMMTWHTmKGA6bBaEPxVKthGiQVDvEBm1sCDDnxMozLly1SSEgLGzrROy89Caho0P0DNfUD2kEcvumLqNbu4KQoywkYs3zQiRTvcdm64tMMuO5wTilW7lQD16K+HqW3agssETLun8iF3ziI3myUFLVCZuib0fCCp6jgA04jpJYNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB7VcgwnXnqyJ7nzu+jk3kyAJDW2bDBjKaeMIpRk2jU=;
 b=b/My755mmpgMaHflq4XiOHRRs49iF407XI5ch5za0Pn8MLjGyq9jhslY7I1axJ+TOUDpXrRRO4LCGSAcZCbvq+qdg7e14PD11EtdNCkKEXAEQECcDk/IbNsNWN3x8FLHHA5XOyhzEGy8+OlvD9WzcAfDDBBdtATTbgZv2pQHWBg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5432.eurprd08.prod.outlook.com (10.141.173.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Tue, 7 Apr 2020 09:10:32 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 09:10:32 +0000
Subject: Re: [PATCH for-5.0 v2 2/3] block: Increase BB.in_flight for coroutine
 interfaces
To: Kevin Wolf <kwolf@redhat.com>
References: <20200406171403.6761-1-kwolf@redhat.com>
 <20200406171403.6761-3-kwolf@redhat.com>
 <9d0aa9cc-61a1-fd14-357e-6fb0ba2742dd@virtuozzo.com>
 <20200407085216.GA7695@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200407121030038
Message-ID: <b1a2cb59-7969-5bb7-f5ce-ec4ab51199cb@virtuozzo.com>
Date: Tue, 7 Apr 2020 12:10:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200407085216.GA7695@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR0502CA0067.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::44) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM6PR0502CA0067.eurprd05.prod.outlook.com (2603:10a6:20b:56::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Tue, 7 Apr 2020 09:10:31 +0000
X-Tagtoolbar-Keys: D20200407121030038
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd87f7e2-b073-47ca-fcd8-08d7dad3863e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5432:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5432E91CEEFEAC4123F251FBC1C30@AM7PR08MB5432.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(346002)(39840400004)(396003)(376002)(136003)(16526019)(81166006)(31686004)(66476007)(8676002)(36756003)(2906002)(66556008)(81156014)(8936002)(4326008)(66946007)(6916009)(52116002)(86362001)(16576012)(6486002)(186003)(478600001)(5660300002)(316002)(2616005)(26005)(31696002)(956004);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zlc7HPXR42NjIoCvYAsRvsqkQNxSMHjjFmQ9sKPPetmrkB7M8qvKqKHpSVY9fhlPMRzGaAdGl6BHS1pmZE0Em115sT4otNzYAR7RDEWAFgqkfeTUrnFzm5ZR1UYflt++vPJ4LJbU+Umel6EjJ6DG5BSdVm4QGPwFHbUO6vUKqSGwfrhCd7CWx0XGpgEjfC7juY13XKYOVy7btd3yzQYS22LDbAJIFobOcw1nt/O1jw28PEYQ9VDXpjQSH0Y1e9t2TlrIjEAK2phSHFWRFETsSGyXpXREr2xA4lPeTHwdT6/a1vyaqxZ6kISt1J1PacQ8klQnWWG4F1pHgywFGtNyjnaN4Rym+jKvPGf8bnxNAY5A58WOx6WTpKDuGszo5//D/Zqa9HP81qV4R9AeMCoAtvwWhSDGN73fwKY2dxZWzHtpMJeFSz/tUK/g8nkzxUWy
X-MS-Exchange-AntiSpam-MessageData: gfyIMqO5/36cq74jWlr1jVzcs9XmZ38DNYNqHllgXv9oNTENVRB9jJRKXoMjoFapkBHhDWCvxfT9Bp8ORFkZJhUZcouVX28LRxHp6psZQh3TTO1Arn2qjFRGrZyzZffm5oPV6p3QObTFJZ4Cte1NKA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd87f7e2-b073-47ca-fcd8-08d7dad3863e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 09:10:32.2927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFtmVPOgLY9SCdpym+9vsYrQKU3Lj9ocn2tf5G/SELlmc/DlVzvwDGH9J+Uovaj38mlEdLuBj+JUdFQz0vpkx3wrEj9EewG+JJyayIWOFGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5432
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.99
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
Cc: qemu-block@nongnu.org, s.reiter@proxmox.com, qemu-devel@nongnu.org,
 dietmar@proxmox.com, stefanha@redhat.com, mreitz@redhat.com,
 t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.04.2020 11:52, Kevin Wolf wrote:
> Am 07.04.2020 um 08:41 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 06.04.2020 20:14, Kevin Wolf wrote:
>>> External callers of blk_co_*() don't currently increase the
>>> BlockBackend.in_flight counter, but calls from blk_aio_*() do, so there
>>> is an inconsistency whether the counter has been increased or not.
>>>
>>> This patch moves the actual operations to static functions that can
>>> later know they will always be called with in_flight increased exactly
>>> once, even for external callers using the blk_co_*() coroutine
>>> interfaces.
>>>
>>> If the public blk_co_*() interface is unused, remove it.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Still, did you consider instead just move inc/dec to _co_ functions, like
>> [...]
>> (and same for write, ioctl, flush, discard). It seems more
>> consistent.. Should it work?
> 
> No, it would be wrong because it would be too late. The main purpose of
> blk_inc_in_flight() is to keep the request covered during the first and
> the last phase outside of blk_co_*(), which can potentially involve BHs
> like blk_aio_complete_bh().
> 
> Kevin
> 

OK, thanks, I see now, we want to caver possible completion BH.
Hmm, not too late but too early (for decrement).. As nothing interesting
happening between increment in blk_aio_prwv and entering the coroutine with
_do_ function.

-- 
Best regards,
Vladimir


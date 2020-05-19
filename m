Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8554C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6212072C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="es1SCa+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6212072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6F1-0007rw-Ni
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 13:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb6EJ-0007NZ-Ma; Tue, 19 May 2020 13:40:39 -0400
Received: from mail-eopbgr80100.outbound.protection.outlook.com
 ([40.107.8.100]:2695 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb6EH-00082q-Bb; Tue, 19 May 2020 13:40:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQlYOaDOrb4yo/h+5WFckOE/qsjj7Mu8V5+yOITX+UP59UGTaSZcrwnFqAYde8aWtjndTReaEr1Sbo2PVAx9oLYERvyjfgv80tc4UlXqVasAX42uYtrtX14MMEfg8VdQkSFrbZD9DL8f1/cW50+bxxYpj5G3bdeHqa/RibTZzqd0Vrp0Fm56EKokyNPj7/u85ClJkPOqB4GUbcTDIGpVeSXwFcTHpYq98wt+SbMWTJ8UGWKXTGZDqo9poLSk8JW5JLqMZDSzQmr1ibyDaHoMtYYSEFPikuUGpPrpzYKoe3UxyPt3EZiKcHP/WBprGWNnwmxxmeB/oVU7ZGPfA51dLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6jeHvZwz+nvhN4ixmprUtVbBWdmEmBoVFjpcqEuZ3w=;
 b=JfZLYEvY5X91vnV9+pAUv9nL4cxAj7wWBNvJzsiOH+KhA7isukGpyz598L68LHbt94IHyoU6rwOKUd6k8oSLVuMwvnSTS9/HQf8YXfEASAlNETI1Q6maRLO83yQtQOVPyq9z/qO+jLVjMKTGZIISAGG8FDBZDsUq4fvmnuZu6agNywoarXoDOaMvIEy9amElGtFlJf0IeQUr16D7S+4/0KrusGVXTpO8nlkNnRx48JEgH/pAUX1VwsiCjfQXxkOWSorv7/qhT1fmAo6/httXVkBIbELwlwcM2bWh6aeYj1ANZWGYldX0HkOJXTc89kh9E1DtldBhLd6Lx3sb4kbR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6jeHvZwz+nvhN4ixmprUtVbBWdmEmBoVFjpcqEuZ3w=;
 b=es1SCa+jeSrqhxCqQRpLhPnu+NiWei9EYOL1IGpXqomyAMoSuUL6fnYoc3CvWvDrV12gxzwyzpta1n77FSzC+QzoeV4atHdEhQAwYPzIQeo89ebJ1MoqGMda8cqU+j0fhlbsScFfo8URhAPDeWWLQqSKeTfsSbzKmNtUXJHTND8=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5430.eurprd08.prod.outlook.com (2603:10a6:20b:106::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 17:40:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 17:40:33 +0000
Subject: Re: [PATCH v2 0/9] drop unallocated_blocks_are_zero
To: qemu-block@nongnu.org
References: <20200507084800.20596-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1f485616-819c-8089-bc25-1ad697d8972d@virtuozzo.com>
Date: Tue, 19 May 2020 20:40:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200507084800.20596-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0042.eurprd04.prod.outlook.com
 (2603:10a6:208:1::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM0PR04CA0042.eurprd04.prod.outlook.com (2603:10a6:208:1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Tue, 19 May 2020 17:40:32 +0000
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10a6c1dd-25df-4bae-1111-08d7fc1bbb53
X-MS-TrafficTypeDiagnostic: AM7PR08MB5430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5430AA3306AC2E1196766F5EC1B90@AM7PR08MB5430.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1d7ziWgsO+6TvdJpQO+BZ2+LeJAS7UnB33FRHYI11F6/0/UBDH7mQ2XX06xiHpnw9FNywDrCuU37CZIcBayZ9c0DoYva4ieldEjO9WsA4AypYALPZ0yNnOdMyLENouttxiBUvuTCYFA7VjW5ob8hy2O8YHxJnxiGWKwLzUybZKOlRlMVzonwxGJUkFraKRvrN1tU+5u++MtqxCSgccEKcAj01xuRz0dF8r3y1S/YKMtogTsDrgR3hgGc7fX49H38jam9cy3pVQnIENlD2za1EmHolcKuG92I1o4sWS6YLZVOfer9sWuJDOHprwN8hIuQPHyZozcwyS76+4E2IrR+j0uB8rLUrunYmmFni6Fub+nI3uvgFJveAEKWU9pL1thm6xni+pwECEj3iuK08H3eOnQZDlz16o9pf8RPsMhnGEjQBOddFzSnszqgMyo+t8pWxa0azCejTZ7aEyRgCIc1byptZrH87M4NsfLUr32yfdN3fxxE1SW4YT6Not2PRbfStupxYrhOUUBejZzdOqcVFPSZXGDhkmhTSC7Y231oCTwL6vtETiPimPoSnAzzBjQ3dEbKcL5KPLCcG8lDczR9zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(346002)(39830400003)(376002)(5660300002)(66556008)(966005)(107886003)(316002)(2616005)(956004)(66946007)(8936002)(31696002)(36756003)(6486002)(4326008)(478600001)(66476007)(6916009)(16576012)(7416002)(86362001)(26005)(186003)(16526019)(31686004)(52116002)(8676002)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: LUzZguewanEiSZL53vpvZM15yCzyyfp9WofThr2xqRhOFWw3bf5AyXzHO5mRbVbvHvAtPsKirhpcSe6QGEjh5DfMUAlEM1LqejdrPiTq+TmANmNQu6Xg3W6qzQHeBqw6xezeptsJmLylX+3/d1+tmeWvyHUkyNlBSRLLsdid52Tor1kntueaMOPvBq6PN6a8mHabebVWEewfefspwKYDv+a3IVXzgJnic3n1LIQiXa5s43wBimi0wNlLcTMp0gsXrd7vUw1PSkOXsuCV4i2uPcmkacB1Hy+Sl5gggqczeRxk/TAc8NNNHbSNRHBb/yN/JH23L+jc8KuXESTIbZH0P37+mbyUiBwq4EJJPgWrzVyIcCF9PK2cggFsHXVH2Qhmov8xuugW2FpptehqMgbhk1lbt9Am3k6r4osnIN55EwrkkabpS/PLDm/w5x9Nm2bNFy5YofMZtcIC/Wl72nfBaqprJ8yYjjjXhU6PUQledzPjFBivHQkUk5ov5VjlLGmY
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a6c1dd-25df-4bae-1111-08d7fc1bbb53
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 17:40:33.4578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ehuo0NJFOs11qDi/ezlPCJZWqLz4ALEd1yD//LYKE3sUnzI8vtU8qQEF7vvoHlx6Jm8SBe+MznKFq4ishyU2BsiuTUV9XinUf3xaKJXU4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5430
Received-SPF: pass client-ip=40.107.8.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 13:40:34
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, stefanha@redhat.com, codyprime@gmail.com,
 sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org, mreitz@redhat.com,
 ronniesahlberg@gmail.com, den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping

The whole series reviewed by Eric, with only one grammar fix needed in 02 commit message (and possible drop of ret2, up to maintainer).

07.05.2020 11:47, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> v2 (by Eric's review):
> 
> 01: moved to the start of the series, add Eric's r-b
> 02: new
> 03-04: improve commit message
> 05: add Eric's r-b
> 06-08: improve commit message a bit, add Eric's r-b
> 09: typos and wording, rebase on 02
> 
> 
> This is first step to block-status refactoring, and solves most simple
> problem mentioned in my investigation of block-status described in
> the thread "backing chain & block status & filters":
>    https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg04706.html
> 
> 
> unallocated_blocks_are_zero doesn't simplify all the logic about
> block-status, and happily it's not needed, as shown by the following
> patches. So, let's get rid of it.
> 
> Vladimir Sementsov-Ogievskiy (9):
>    qemu-img: convert: don't use unallocated_blocks_are_zero
>    block: inline bdrv_unallocated_blocks_are_zero()
>    block/vdi: return ZERO block-status when appropriate
>    block/vpc: return ZERO block-status when appropriate
>    block/crypto: drop unallocated_blocks_are_zero
>    block/iscsi: drop unallocated_blocks_are_zero
>    block/file-posix: drop unallocated_blocks_are_zero
>    block/vhdx: drop unallocated_blocks_are_zero
>    block: drop unallocated_blocks_are_zero
> 
>   include/block/block.h     |  6 ------
>   include/block/block_int.h | 12 +++++++++++-
>   block.c                   | 15 ---------------
>   block/crypto.c            |  1 -
>   block/file-posix.c        |  3 ---
>   block/io.c                |  8 ++++----
>   block/iscsi.c             |  1 -
>   block/qcow2.c             |  1 -
>   block/qed.c               |  1 -
>   block/vdi.c               |  3 +--
>   block/vhdx.c              |  3 ---
>   block/vpc.c               |  3 +--
>   qemu-img.c                |  4 +---
>   13 files changed, 18 insertions(+), 43 deletions(-)
> 


-- 
Best regards,
Vladimir


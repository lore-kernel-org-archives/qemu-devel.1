Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B97C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98CD2076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Y/6kU4jX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98CD2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jETck-0006Wm-1v
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 04:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jETbv-00066r-Ln
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 03:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jETbt-0006Ra-RV
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 03:59:31 -0400
Received: from mail-am6eur05on2102.outbound.protection.outlook.com
 ([40.107.22.102]:12640 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jETbt-0006P0-7d
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 03:59:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaoAv0aAQWXjq3FIW1kyI5zpMUnUPfct9CHCyAq5Bi27DBOpVc7BTIeLDSfglxvHMXOY9rg1htWZpc6MdPh9AyYt3Iy3AAAiVcwYi2vq9/6ch5ie36I67gVbBn+m6XBz32z1IZg1UKATMVe/E6JWAXfdMlsMFnJKw7aMjGqyxG7uaWIR6mnNlTHKHdT7RVWg1aNUwDNMFGvcxL8bmjX6qpgcLSC32B2gXvMr2Y9ULK725cXA0vzXoSryf5lxI7RjjaU/tcQtzkeE3CiLyfVThro7I+RaZRmxBkcmtX3oTqdE3o+hdXSxGP2uoWyRESkNjVJPNzS+dH0jVU1HoF6Xuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1s0PmxUrUsJxATbRZckibgTh49qSFDkmlaSn812JEM=;
 b=FD94+ngO7ZxjM34rNbC4oEvuDfUWHQM251lVe/PXU+crX9lUbz7cI2Ah3kUn2rVZ+rmGX8T12rPLFPAGznleJEEZ6F/TYrVE5FGBEU+O19DNpJKNbfHKkG8n5Q29I8KFbtq+/4AtE52s1g8iP5If8ORA3oq/YWczz2w3I2ngpl31rL0e7v4vKFp9Fyv3+C10eeikyArgZUfdu/5VJ1u8dBgu4IwOCyMAgzils5nYlVpWZHZpO6uNmnBMnnGi3dTWQfTljKfirlE8vHX9hyan6kCMpgDmUancGU1K/Qj/T6Dqtb610YWYUwlP6SliBYZtMl4t4iETg7IxkqPTucf0Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1s0PmxUrUsJxATbRZckibgTh49qSFDkmlaSn812JEM=;
 b=Y/6kU4jXJK3WmkJRCy32fEyl/tCLMI5FBo6183qOsmqt9Yj5tsgom/Yru/J8s2LhG763CRI822CBKNdKKNtp6Bkltm5Sh8iYg/Rbt22mz/dWRumco0E9J5DlbUAtIjQmzZI29SXHH+U3rQSzCnBIQrJCH3fahqdiSOWBX4kQ+i8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2185.eurprd08.prod.outlook.com (10.172.130.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Wed, 18 Mar 2020 07:59:25 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2835.017; Wed, 18 Mar
 2020 07:59:25 +0000
Subject: Re: [PULL 0/4] Python queue for 5.0 soft freeze
To: qemu-devel@nongnu.org, ehabkost@redhat.com
References: <158450473711.25478.16951249008771308992@39012742ff91>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200318105922212
Message-ID: <04961888-5610-6805-c4c0-6f952df99d4f@virtuozzo.com>
Date: Wed, 18 Mar 2020 10:59:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <158450473711.25478.16951249008771308992@39012742ff91>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0115.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::20) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.249) by
 AM0PR01CA0115.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Wed, 18 Mar 2020 07:59:23 +0000
X-Tagtoolbar-Keys: D20200318105922212
X-Originating-IP: [185.215.60.249]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dcbdefd-d7a8-4618-98a1-08d7cb12462f
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2185:
X-Microsoft-Antispam-PRVS: <HE1PR0802MB21856AEF3AAE5255D3B3B178C1F70@HE1PR0802MB2185.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10001)(10019020)(4636009)(346002)(136003)(396003)(376002)(366004)(39850400004)(199004)(316002)(66476007)(66556008)(26005)(16576012)(36756003)(5660300002)(8936002)(16526019)(478600001)(186003)(6486002)(966005)(2616005)(31696002)(52116002)(956004)(81156014)(31686004)(86362001)(8676002)(4326008)(81166006)(66946007)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2185;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iLXk3aHX/8cMh9i/419TEF8LVTMSX/DLrB/Fbed6AQ8fDZhso2T5XEWNXXIfT4QTR87S/k9FI6zTBgTNmwpfjqnJOnrta+XWioA8kLkuX1AEL7xCSqycxq5xr7Pzz1YHmmcR1Et8kcNjyWoaYXMaTIauvrZQpchqICwsl0c6Xajgev62HJzGIT+XgbCCQGr0monK1Nv3KRGbNv8ImSB9V/fGaPqQNh8sf1E8TgCvNm7JXaHkycM0FYQiyCtEXokXrEHyjL5kR1v+l3l0E4/u/HtnZvHmvRRDhMmdGYmLnC5nABrS9Pg7MLxtVv7CVKDofgve52EbNp8Un5U1fgEqgOeHtcXrf3ETjavdqZ7RsF5ZFJjiEdrz18Oesb1ExL3mgjgM03+D0733BGteGB0o+875vcDoyfzg6tkul7jLtxwXKU1bj+bK00tEu9ZZlx1PCGE2tgLPh8Ghn/J7IvRenyRoPmT3aTC68g8VzW99Hyz9lvHtWNGLmY2xsS68tBGRlY1marXcTF7MKtlCf2UIQJD2iBxGal74TNDYj+UdZFNN90KBE8LZVSlgNWm9xc150GdQYwxu/QmANS5/yZi3Vg==
X-MS-Exchange-AntiSpam-MessageData: qvsDjc9Oh27Ji6bX07KZBlaJAT5sCh/K6Kovxf09eAJdIlfTq8fjJBOLqAu/Q624ie+N10ve8OHUf67f47tY2+9pjNwWDF7zbzPA2/jZhGOZZFunPvyKySUm7XeDXOIJ0zodkiGpg2eGZ8GlSXh2Ag==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcbdefd-d7a8-4618-98a1-08d7cb12462f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 07:59:24.9576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4ijv7MYyEFTG5M10p0BlbKJF0Zz9h8EHy7j0e4Tkp9i3EeJCQ4B+3jjwdNqv5YgGvlCDK90ApTM7foQR6k2h1mGvNtFhEnx/2gciZFvnK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2185
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.102
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
Cc: peter.maydell@linaro.org, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

18.03.2020 7:12, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200318011217.2102748-1-ehabkost@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [PULL 0/4] Python queue for 5.0 soft freeze
> Message-id: 20200318011217.2102748-1-ehabkost@redhat.com
> Type: series
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 1b4f6f3 MAINTAINERS: add simplebench
> 57b42b6 scripts/simplebench: add example usage of simplebench
> 99ea4d7 scripts/simplebench: add qemu/bench_block_job.py
> 196f97d scripts/simplebench: add simplebench.py
> 
> === OUTPUT BEGIN ===
> 1/4 Checking commit 196f97d8566d (scripts/simplebench: add simplebench.py)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #16:
> new file mode 100644
> 
> ERROR: please use python3 interpreter
> #21: FILE: scripts/simplebench/simplebench.py:1:
> +#!/usr/bin/env python

Hmm, yes, we need to fix it.

Should I resend?

> 
> total: 1 errors, 1 warnings, 128 lines checked
> 
> Patch 1/4 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 2/4 Checking commit 99ea4d73bba8 (scripts/simplebench: add qemu/bench_block_job.py)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #16:
> new file mode 100755
> 
> ERROR: please use python3 interpreter
> #21: FILE: scripts/simplebench/bench_block_job.py:1:
> +#!/usr/bin/env python

and here.

> 
> total: 1 errors, 1 warnings, 119 lines checked
> 
> Patch 2/4 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 3/4 Checking commit 57b42b691f7b (scripts/simplebench: add example usage of simplebench)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #21:
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 80 lines checked
> 
> Patch 3/4 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 4/4 Checking commit 1b4f6f3850f4 (MAINTAINERS: add simplebench)
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20200318011217.2102748-1-ehabkost@redhat.com/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


-- 
Best regards,
Vladimir


Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E72AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1769920707
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="b3kDYMjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1769920707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkmPO-0005FG-8K
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 06:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Aleksandar.Rikalo@syrmia.com>)
 id 1jkmOd-0004nK-CQ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:31:19 -0400
Received: from mail-eopbgr70094.outbound.protection.outlook.com
 ([40.107.7.94]:29213 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Aleksandar.Rikalo@syrmia.com>)
 id 1jkmOZ-0006KD-Ie
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:31:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTOYpF0PfExkUbZPBpOUZt5i4ZkPY83VUxdgrVdLqQjL8mo0mh8UznxxrBo1PdeEiRsUCtFLiTU30X/dWuOZLknSh3lyf5LTlMFfVzM468ztvyI3ouZ6dPyyxmfjj28QkW1te3b1qTLKTtEn8ePRk+PTmVkYNUiN8kjVjAHpnDRYHuRKQU1OvGdbZQC2FcL1H58NTivXWfHdlilmOS1iMDvTdHVFHQGqg4eqfyzP086U/OBt01oRKjGWQXnKnmW3VJFaJhuYUWXikBTlGMD1u6By9veSQ+8zGjtwkBpYtDRXm2sB/YqKC2xkZkg1a/0AS+kJRIF+jy0IlQvfYqILqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPBfW6xMUCIyZTzFuzrsmuWAcPCWn5lOU/nJhnAzxWw=;
 b=fJ1Hncs43CSgzOjjVQ+a+riTZYEGkXAwCxm9Ch8/JCAPiL7UAouAPzNyBInDaWtd9qy3OzI7f3Dg2MhqmeswyvXZPxO9UpwmLdsLnXiquOUTPeVaiBbO5D3MlghKyDEkmWsdDiDAeCXmS8f5vFTHV2aO5hphRPc3gYSMOljlBo3qqhXyf5sszK/2FyPa+0/+6Ky0dQUH/cepXW4EE/IOSG8JFkJLW92W/6KFPZybW+M8LhU3L+Ec9IL33PITtLnXXkZ7ebs6+xhTol1d2OEAuzpr3IM718sj06jQtmNmJP+sGYw81mdst73ivHKXg6RObZ4Do+mYBR8IdRYtRWpssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPBfW6xMUCIyZTzFuzrsmuWAcPCWn5lOU/nJhnAzxWw=;
 b=b3kDYMjMwQuC7cQiut18Q9jzh6zq5tUUg29FuV0SkXzEIkM2ICE896AB0WC2E6XHVW6LZYezx4W4xRyAqJLNwxq6xlTsf9bqvbSJAoXibUDfk2+aJP5OV8l9Guo04zcZBgr3TQSQuZ/BZXgP9/poYlkPbVF+gAj5wIbrPeqoqGg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4462.eurprd03.prod.outlook.com (2603:10a6:803:62::24)
 by VI1PR03MB4445.eurprd03.prod.outlook.com (2603:10a6:803:5f::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Mon, 15 Jun
 2020 10:16:05 +0000
Received: from VI1PR03MB4462.eurprd03.prod.outlook.com
 ([fe80::202a:274c:c5e1:77fd]) by VI1PR03MB4462.eurprd03.prod.outlook.com
 ([fe80::202a:274c:c5e1:77fd%3]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 10:16:05 +0000
Subject: Re: [PATCH v8 00/14] target/mips: MSA, FPU and other cleanups and
 improvements
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <20200613152133.8964-1-aleksandar.qemu.devel@gmail.com>
From: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Message-ID: <4fca6ca7-3898-8356-ca57-cf75d4ef5f46@syrmia.com>
Date: Mon, 15 Jun 2020 12:16:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20200613152133.8964-1-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: VI1PR10CA0096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::25) To VI1PR03MB4462.eurprd03.prod.outlook.com
 (2603:10a6:803:62::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.253.18] (82.208.234.200) by
 VI1PR10CA0096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:28::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Mon, 15 Jun 2020 10:16:04 +0000
X-Originating-IP: [82.208.234.200]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db14ca54-33b2-4781-69b7-08d811151ca9
X-MS-TrafficTypeDiagnostic: VI1PR03MB4445:
X-Microsoft-Antispam-PRVS: <VI1PR03MB4445EB12E76B4B8A87B6A4059C9C0@VI1PR03MB4445.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0ql5ekNGZG/2kXMZg8tZsTXCEJpcv6Nk4i+8BLUfv/E87UidnmUYS73qfZrSF1PBohLSmr9ukhRwxMW/OB/oSxhfg9PigOl6pkyegF3sLweBOronnOjXuoMKc7Rb/CSgMleDO2+eSboGi0Ltdi0IxkgF5/EJDfgeAolzenWGaa5GW1bvZuWmyDsgwyLW3d/tZxbdt8CXlDWk04cUrzYKjIGkHySagpragZwsPm0bUxEi7v7OmQrLVLcPdizEKMgX2wR37peIpoTrtv1r3fTk61jv+HfjKQwE9UzCqxxPUuqyvmMzUbEOyaNpF2xOJ++9O7xBA/zmJbof3BO27hruRgswBatVgJ791ExHif7ZBsRTgPZPFhmZk1uYh+doyXI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR03MB4462.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(396003)(366004)(346002)(136003)(376002)(5660300002)(66556008)(66946007)(66476007)(31696002)(86362001)(186003)(16526019)(26005)(2906002)(52116002)(83380400001)(6486002)(956004)(2616005)(36756003)(44832011)(8676002)(316002)(8936002)(16576012)(31686004)(508600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: R19Pmu6ThdhMan6WHoC4eRjFGkAU2gvJ2sZ33kjlQ2Ij8C1YKs49ZSqT7+jHDw1MuQCNZrd0LKENkNq8Vx4CbLTLHpyezNX+/+r3if5SRt7qEjljv+2NiDIYefxDu3/taxFE6BW0nLRnhdmOkXr3kkZxw/jQvcz3d9820t/ZE+APHXo+RFdbzVNzkp+a/tNNei1yks+BCM4cUHDQh8RT5eLJJiQgWm4gPMxyDWDJ6f6TwYJp0c8Hy+gJptM5dx2zE/RPpRdlTHsqE7FYpMzwHtzDRsD3RCgwPhYMgascDGzZiVHgaBymQfcjgDHYqUSnveKaOO7wpLTNkZ6ads/6jlDdFSi37061zsJovLg5bVB/cpmZAnU9qQ9XE3nHw8S013Zv0PiuqLtj9P88bmUsHvNs/TZhGrmJ9RCyI/mpP7AXZWhRuBNlk1jfdoXT9lTj730cIM8SpT05tboPSnqlVypCH/B3m5dhUQTYqBjFDJs=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db14ca54-33b2-4781-69b7-08d811151ca9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 10:16:04.8203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBrTx1viqMW4sOjDQMHV35PnareZTo9fOayS6Vjekt/J9GfqL/O061gnc3tNR40ze7o28fSwbRug5CUpBP1wkQxtcXN7MJk9vRRRtQ/KWPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4445
Received-SPF: pass client-ip=40.107.7.94;
 envelope-from=Aleksandar.Rikalo@syrmia.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 06:31:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> This series contains some patches that split heprers in msa_helper.c.
> It will make easier for debugging tools to display involved source
> code, and also introduces some modest performance improvements gains
> for all involved MSA instructions.
>
> v7->v8:
>
>    - added six new demacroing patches
>
> v6->v7:
>
>    - excluded patches that have been already upstreamed
>    - added six new demacroing patches
>
> v5->v6:
>
>    - excluded a patch that was included by mistake
>
> v4->v5:
>
>    - corrected some spelling and style mistakes in commit messages
>    - added changing MAINTAINERS too while renaming files
>    - added two patches on splitting helpers in msa_helper.c
>
> v3->v4:
>
>    - corrected some spelling and style mistakes in commit messages
>    - added a patch on renaming some files in hw/mips
>
> v2->v3:
>
>    - changed Malta patch to perform logging
>    - added change of Aleksandar Rikalo's email
>
> v1->v2:
>
>    - added more demacroing
>
> Aleksandar Markovic (14):
>    target/mips: msa: Split helpers for MADDV.<B|H|W|D>
>    target/mips: msa: Split helpers for MSUBV.<B|H|W|D>
>    target/mips: msa: Split helpers for DPADD_S.<H|W|D>
>    target/mips: msa: Split helpers for DPADD_U.<H|W|D>
>    target/mips: msa: Split helpers for DPSUB_S.<H|W|D>
>    target/mips: msa: Split helpers for DPSUB_U.<H|W|D>
>    target/mips: msa: Split helpers for DOTP_S.<H|W|D>
>    target/mips: msa: Split helpers for DOTP_U.<H|W|D>
>    target/mips: msa: Split helpers for SUBS_S.<B|H|W|D>
>    target/mips: msa: Split helpers for SUBS_U.<B|H|W|D>
>    target/mips: msa: Split helpers for SUBSUS_U.<B|H|W|D>
>    target/mips: msa: Split helpers for SUBSUU_S.<B|H|W|D>
>    target/mips: msa: Split helpers for SUBV.<B|H|W|D>
>    target/mips: msa: Split helpers for MULV.<B|H|W|D>
>
>   target/mips/helper.h     |   73 ++-
>   target/mips/msa_helper.c | 1296 ++++++++++++++++++++++++++++++--------
>   target/mips/translate.c  |  200 +++++-
>   3 files changed, 1271 insertions(+), 298 deletions(-)
>
For the whole series:
Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>

Please run all regression tests. Thank you.

Aleksandar Rikalo




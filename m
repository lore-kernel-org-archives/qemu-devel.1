Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C321C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2564C20671
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="e2RjryC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2564C20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jafYG-00059J-DP
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 09:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Aleksandar.Rikalo@syrmia.com>)
 id 1jadkr-0008VU-1j
 for qemu-devel@nongnu.org; Mon, 18 May 2020 07:16:21 -0400
Received: from mail-eopbgr10100.outbound.protection.outlook.com
 ([40.107.1.100]:52615 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Aleksandar.Rikalo@syrmia.com>)
 id 1jadkp-0007Lk-G1
 for qemu-devel@nongnu.org; Mon, 18 May 2020 07:16:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkYAmRLphuAOZZDOit53BDXwRH/SZSQ6s0Onu5zFE2v2V30CGuEEwLdnen+LVLVmp18aByUBuXM0iO9+3xRFcJlesvIuwk8FfGMDQZQGbDU3wKLtGDABvE+FVxZhjzAQBwLEvDjZKDsLheKSgrJ373RqkkCRU61t8pEZ92r6b3Xv/6VvbDpsZqojr1U3G2BQO/dwIG+z4SKjCOq+k9oor4LoOUFnEnZja3jRVGcZFl9lhpdRbz09+DvU/45odt76wq2j2ut861gqirlty0W712zX5+tEl39iAfO16JQr1/2lXcPaK7SabdO88ZqtAn5hFos1+MLpgiBteXsFKKwNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxzAFdGsX8jW2obzthTnZy/E1pZmf/JFJGh56WLlJg8=;
 b=ZdHq4lCGEdPlW6hO4FEqtylIcEqlxI4Xgjn723olfG9wzrM77llv428cGkgMxGwMMsu9G8YxqpX4uuZG6Pmrquu2Sg4CpVx9FEW2mjlEll81tS5yHlnaLp+RTW+gkYxsA+pvud9o5epO9Op8azl/08hA/RWL60U8TL5rtVnpNC/1TvnDLqNCcW88z2HdLhjTZJrBcpGQd+2ev9b3/ogysh3YnYnZW/ganCN4m7rn20uA9f6+EU5Qb8+dHH+J3ZkM39M0WfXRK8QqersPnkCk7GTJkPJuRmAIO2iBJ315Y8sn+SgZjg6gwsFkA32mkDBgkQzD7yNc4qZccQPz0UUgQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxzAFdGsX8jW2obzthTnZy/E1pZmf/JFJGh56WLlJg8=;
 b=e2RjryC/LVivBLkxNTYdMPDXfN7fR30XYlLJ0iKF63ku3pGVJRpCjtTyOKhFCagqqLYAwlU5v6EMfLRRbwweBVASGt4ezrdG+mrGwAiJKc9MmzPh75q0r+mWltX86wCfthjxslqxatC2sGo/9kdf7myn/Okca0l6nymPGU515Gs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4462.eurprd03.prod.outlook.com (2603:10a6:803:62::24)
 by VI1PR03MB3037.eurprd03.prod.outlook.com (2603:10a6:802:2e::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Mon, 18 May
 2020 11:01:13 +0000
Received: from VI1PR03MB4462.eurprd03.prod.outlook.com
 ([fe80::49c:b9d7:8ac5:3dbc]) by VI1PR03MB4462.eurprd03.prod.outlook.com
 ([fe80::49c:b9d7:8ac5:3dbc%7]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 11:01:13 +0000
Subject: Re: [PATCH v4 00/19] target/mips: FPU and other cleanups and
 improvements
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
From: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Message-ID: <78f4e779-246a-c7c2-d295-6b97dcd6cc31@syrmia.com>
Date: Mon, 18 May 2020 13:01:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: VI1PR07CA0198.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::22) To VI1PR03MB4462.eurprd03.prod.outlook.com
 (2603:10a6:803:62::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.253.18] (82.208.234.200) by
 VI1PR07CA0198.eurprd07.prod.outlook.com (2603:10a6:802:3f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.11 via Frontend Transport; Mon, 18 May 2020 11:01:13 +0000
X-Originating-IP: [82.208.234.200]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b258ab2c-15db-41d0-875d-08d7fb1ac78f
X-MS-TrafficTypeDiagnostic: VI1PR03MB3037:
X-Microsoft-Antispam-PRVS: <VI1PR03MB303778B8473477BF4E6E63B89CB80@VI1PR03MB3037.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +aRYG3hj0f2hygZoOzQM70xalx5zI4p3wjsgJoGkqy+8W8Wyvxw4O+fcLjhCl3sD5qA7rIrPmGa6mNMtKJkNIbmUAH78egbpri9XZxJSbHU/MLqVTRYLOPDm/RuU3+F2aOmgbUR1lh2BkXIo5n7qX4v/H5FbGgqVuUNWWDReokmpGrcwQtMVjCXb8/s21Ng650GwUJG8EWCIzo9byShJDspTpfATMIdQtNibYV00E99Lo6nMMtpBGjXZJqDPM+FEgc8sILkssHODeojmz4ioFnHwq0FAk/nNR+DqQeqC3lE6I8+yNVDC//kdL7YI3Yf33v1y581CyDzZdDCsUM7DW4rXuyK9yjG5tOQ5xz+Qs/CUd1q1k7EXLCqWBJOrhVrIdMDQFFhZU6K1VWHrYuIhl2WgvRycDsrv7whhUijO27G2BpRMjCEbsyS2MM6j3LK0HHk7fDoYRP5Ywe6u69UhVMbY40QPwO2P2B94HwprZUn8YH8mybeTylkQyUciNJ1N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR03MB4462.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(366004)(136003)(396003)(346002)(376002)(36756003)(31696002)(16576012)(66556008)(316002)(31686004)(66946007)(66476007)(2616005)(8936002)(508600001)(956004)(2906002)(6486002)(186003)(44832011)(16526019)(26005)(52116002)(8676002)(86362001)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 5H6RUNUg+EjiFO4MZ9VrFsdAXWZluweh1cEZWoQXDmgGlxeMof6B7pyoD+GKQHNHobbg4iAKOvdTyw2QtdBKVnxb9p/YhWUpHh5qZCQHJEsmNyJ5ZA1r3Gp1opBkdI0J5blpPjGLCeASjqku1awWeRrM78AJQ//F2cdA5ucvM/GjFro7OjiAgK10aDQ64Md4O7+k6jPcevv4uq1IgxqRi+ijD8NWDKcKM3/uUJjg6Xay3ox1lqgTHPGReDL2ucqvgw5+VEv9cHibQmpt1JHKisc3zgeMUceOPFKiU5whs9nm7lxx81ziDnwJwG3BPHNwB+29GF6gwBplgCw6ctM2OGHPMQJd7ygwgFQ1KE0sv1QYh8KvhFGInJRQsD1X/WovYDdQ5IKxM1Iz35NbTIFtsgG6JbXfPtGDgwAIwoFTL2cTPsNapQfDdaqyF+Xb/NuzOMZryWFLTzwhGaLWQVjWzZIxsm3VgKahhLp/YU6o8C8=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b258ab2c-15db-41d0-875d-08d7fb1ac78f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 11:01:13.4766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIZdSSWIM+xchepOh1DoxcgFLh4dQb2lCEsFh/kQwsYt/mN8JMaEbYu/7MbIuGe0z5ZngOhevQRSNhw7TtckPy5UFMX68H9JMC4A9tTOilI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB3037
Received-SPF: pass client-ip=40.107.1.100;
 envelope-from=Aleksandar.Rikalo@syrmia.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 07:16:17
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
X-Mailman-Approved-At: Mon, 18 May 2020 09:10:42 -0400
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

 > This series contains mostly cosmetic FPU cleanups aimed to make
 > source code recognition easier for tools like gdb, gcov, calgrind,
 > and others.
 >
 > There is also a patch that refactors conversion from ieee to mips
 > fp exception flags. This refactoring will improve the performance
 > of almost all fp-related mips instructions, albait very modestly
 > (less that one percent).
 >
 > There is a patch that introduces some logging in mips_malta.c.
 >
 > There is a patch on change of Aleksandar Rikalo's email.
 >
 > Finally, there is a patch on renaming some files in hw/mips folder.
 >
 > v3->v4:
 >
 >   - corrected some spelling and style mistakes in commit messages
 >   - added a patch on renaming some files in hw/mips
 >
 > v2->v3:
 >
 >   - changed Malta patch to perform logging
 >   - added change of Aleksandar Rikalo's email
 >
 > v1->v2:
 >
 >   - added more demacroing
 >
 > Aleksandar Markovic (19):
 >   target/mips: fpu: Demacro ADD.<D|S|PS>
 >   target/mips: fpu: Demacro SUB.<D|S|PS>
 >   target/mips: fpu: Demacro MUL.<D|S|PS>
 >   target/mips: fpu: Demacro DIV.<D|S|PS>
 >   target/mips: fpu: Remove now unused macro FLOAT_BINOP
 >   target/mips: fpu: Demacro MADD.<D|S|PS>
 >   target/mips: fpu: Demacro MSUB.<D|S|PS>
 >   target/mips: fpu: Demacro NMADD.<D|S|PS>
 >   target/mips: fpu: Demacro NMSUB.<D|S|PS>
 >   target/mips: fpu: Remove now unused UNFUSED_FMA and FLOAT_FMA macros
 >   target/mips: fpu: Demacro CLASS.<D|S>
 >   target/mips: fpu: Remove now unused FLOAT_CLASS macro
 >   target/mips: fpu: Demacro RINT.<D|S>
 >   target/mips: fpu: Remove now unused FLOAT_RINT macro
 >   target/mips: fpu: Name better paired-single variables
 >   target/mips: fpu: Refactor conversion from ieee to mips exception
 >     flags
 >   hw/mips: Add some logging for bad register offset cases
 >   MAINTAINERS: Change Aleksandar Rikalo's email address
 >   hw/mips: Rename malta/mipssim/r4k/jazz files in hw/mips
 >
 >  .mailmap                              |   3 +-
 >  MAINTAINERS                           |  12 +-
 >  hw/mips/Makefile.objs                 |   8 +-
 >  hw/mips/{mips_jazz.c => jazz.c}       |   0
 >  hw/mips/{mips_malta.c => malta.c}     |  14 +-
 >  hw/mips/{mips_mipssim.c => mipssim.c} |   0
 >  hw/mips/{mips_r4k.c => r4k.c}         |   0
 >  target/mips/fpu_helper.c              | 658 ++++++++++++++++++--------
 >  target/mips/internal.h                |   1 -
 >  target/mips/msa_helper.c              |  77 ++-
 >  10 files changed, 523 insertions(+), 250 deletions(-)
 >  rename hw/mips/{mips_jazz.c => jazz.c} (100%)
 >  rename hw/mips/{mips_malta.c => malta.c} (99%)
 >  rename hw/mips/{mips_mipssim.c => mipssim.c} (100%)
 >  rename hw/mips/{mips_r4k.c => r4k.c} (100%)
 >
 > --
 > 2.20.1
 >

For patches 1-16 and 18:

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>

Please make sure you rerun our MIPS FPU regression tests after the 
series is applied.

Thanks,
Aleksandar Rikalo



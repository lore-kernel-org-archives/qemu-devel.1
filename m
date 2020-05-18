Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DA6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515F920674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="eOca622e";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="eOca622e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515F920674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaffL-0008JJ-5h
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 09:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Szabolcs.Nagy@arm.com>)
 id 1jafb5-0006Wj-HH
 for qemu-devel@nongnu.org; Mon, 18 May 2020 09:14:23 -0400
Received: from mail-eopbgr10064.outbound.protection.outlook.com
 ([40.107.1.64]:47854 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Szabolcs.Nagy@arm.com>)
 id 1jafb1-00054x-5o
 for qemu-devel@nongnu.org; Mon, 18 May 2020 09:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PK8ZSadaU9hD2aiuPuhEisXWY/6pnLzDyn0fURN0pgo=;
 b=eOca622enZMm0HT9yXjbxlhX5TSkAxZammTAY/9I1YxdhKqysVxZdXLz0OI+nLyexEx8iqrVKni0XZ4O3xGLko98l6uXTdwZgmTM9M/G4tA3giwf57NIupRv+geaT2bsWz2+bqrMEbPzcgnAtmY+xZsPpuuOg6fYpMOSpcapT74=
Received: from MR2P264CA0127.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:30::19)
 by AM6PR08MB4613.eurprd08.prod.outlook.com (2603:10a6:20b:80::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Mon, 18 May
 2020 12:59:11 +0000
Received: from VE1EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:30:cafe::46) by MR2P264CA0127.outlook.office365.com
 (2603:10a6:500:30::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Mon, 18 May 2020 12:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; nongnu.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;nongnu.org; dmarc=bestguesspass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT041.mail.protection.outlook.com (10.152.19.163) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.19 via Frontend Transport; Mon, 18 May 2020 12:59:10 +0000
Received: ("Tessian outbound b3a67fbfbb1f:v54");
 Mon, 18 May 2020 12:59:10 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 86ecd719dd79b040
X-CR-MTA-TID: 64aa7808
Received: from 565cd4f053a4.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 5FDE4628-4531-422B-8E93-3F8BAA72D4A5.1; 
 Mon, 18 May 2020 12:59:05 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 565cd4f053a4.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Mon, 18 May 2020 12:59:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8/pBlZ2VAppr55Z1mnzFgEoDiF0fteseru3Hl8hX1NgdQqCcJtkwT1p3K1FFNHvzT20B3kWcefxNGnx8SE0Rrhp3XAWscvtvIJylajOBb6bNxP6fNwumqLqVAtYBzDc9DaH8EPbSLGcBVNGedBsau0Iqe94xpaQby35klGEpnfl3PQ+o6vBnsBpIcJ9VsJvRiC5uqbkOES4WtvxzZrDfS9PmJhxQhkUNOz7jCsnkXorx8vZWH/S91r0thQC7Q9ccYQboaUCptEaccSwhDFBLcyZjqSWvMvEugav64/8qWiDx0KuU5YLAjhQsqsqtmYGtKoYieOIY033s24jvloiyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PK8ZSadaU9hD2aiuPuhEisXWY/6pnLzDyn0fURN0pgo=;
 b=WEqNIVbaOzQ3CLM0TnhFeGFDCrft/cgVnSOOwcyXLUNdeltsnHEGiabAAUK49l+L6QHa94zyyRTlnxVhzlrVqPBO/APhkyiWQ7e7afzeRdRcnaVf30JUM+AZWyvuxsr6Ww3+B8zmz7QC5l6bCE8OIz0EQN0PwMvZT3sIOl6EtYM7MssSIm1R2gI6h4jhuVZ7vjTZ0dyqdVfNMvvA17iVb1isoOGeMKbAWymxDpF2o6DTKiKvuzbWXhuThV/BykhmmUhoqao4gabmJdHz4xpEOgxhH7oseysb1y88ZoFhuneuS+l+OshuvQBz9/VVwkESmldpcLNx5cB0oTWMRn0fZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PK8ZSadaU9hD2aiuPuhEisXWY/6pnLzDyn0fURN0pgo=;
 b=eOca622enZMm0HT9yXjbxlhX5TSkAxZammTAY/9I1YxdhKqysVxZdXLz0OI+nLyexEx8iqrVKni0XZ4O3xGLko98l6uXTdwZgmTM9M/G4tA3giwf57NIupRv+geaT2bsWz2+bqrMEbPzcgnAtmY+xZsPpuuOg6fYpMOSpcapT74=
Authentication-Results-Original: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB4739.eurprd08.prod.outlook.com (2603:10a6:20b:c6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Mon, 18 May
 2020 12:59:03 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862%7]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 12:59:03 +0000
Date: Mon, 18 May 2020 13:59:01 +0100
From: Szabolcs Nagy <szabolcs.nagy@arm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: tst-arm-mte bug: PSTATE.TCO is cleared on exceptions
Message-ID: <20200518125901.GI27289@arm.com>
References: <20200420102902.GE15401@arm.com>
 <a36c670a-5cef-f8c6-ce1d-4fbb28f9488d@linaro.org>
 <ec85fd40-229b-c965-1f58-d4cbe825419c@linaro.org>
 <20200506125709.GK23080@arm.com> <20200507095902.GA30635@arm.com>
 <5d0ae4c0-70a8-255c-9493-ca8b65e572fb@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d0ae4c0-70a8-255c-9493-ca8b65e572fb@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0371.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::23) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by
 LO2P265CA0371.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a3::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Mon, 18 May 2020 12:59:03 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd844c3e-20d4-4d83-d26d-08d7fb2b4239
X-MS-TrafficTypeDiagnostic: AM6PR08MB4739:|AM6PR08MB4613:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4613FBCD1CDCEB92373A6A24EDB80@AM6PR08MB4613.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: wrwEnFwNyKB7EJT07MRwkSknm1mm7eI5HNgtWOeKoaK6WJ18WmiaD6MLHKQk+L5vpRRoe3Df9dvX05rP5Gj1YMloWlq1VQbkUGFFrLHVJ1p9QksJDjw7+UyLrfoFCCAwY5egtkYy658dLDaAvKfpqvTQMgUjguJpQTtblIOwL4bTk/6hoHgo0WhaoXAoOubcLq59M3bLkcVLpF3jPysqsWvvYG6yA/wDGkW9hkA3D/TMHQl5JdIT6Z0DXX4L/Z5B0V066I2yCjDwF3Cppj0tB/RsSfXBaQLZbM9PW0gX+n6/lcX3xi832XGu5mTK4fbwrM5/BNOMOKk+b2sCQn/HLTgfPapUXFQ1MUC144KXhTsEya7EflomsmK0fu7kP7dlTC3l2X6+pcwl3iJtJN4Vfhnk938iw108dC2j6xJk5oV+cc/3IhHxfUyBMrcwGyhVtEzRboTcvVRUrvK5rXaPSYje5A7sfOCBRCorC0s9w9FcEBUB39OFsYucoVyqtxILOc7T6rkV++T/EyLo2f0nOQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM6PR08MB3047.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(26005)(7696005)(33656002)(52116002)(2906002)(16526019)(44832011)(186003)(966005)(5660300002)(8676002)(86362001)(1076003)(55016002)(66556008)(316002)(478600001)(8886007)(36756003)(6916009)(8936002)(66946007)(66476007)(2616005)(956004)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0ezGgRs2aHZiGFgwxBUk2/Q2rHqZmv6fhCE3nYtRZ/SzvvedPpNF1tjuvwa1eLZ+zPZya8FJJa5aNI0ETlOF+q+im5xRF5TKDM2XLdtBUD1zvbdjDXfuAoCfXYzz5zGcR+qrntvh2b6jR8hVmHfyd52lVVn0U3++Pc/KoDD6jxpgirBr7ugeurzVj+Tnzzn7Epsn85dD4TkMHUXgOjkxGtED5bW5IXWA6/dIf3rwq0/DRxYpJt0AWfB5InpJKcEh9lJ4VfPfCH8eVQkeRMxcG+4U772wBSW6FYfrtQObj6QNCxB4O7SorrgtjP83moHdqey8/qI+WnIqdpgMImrd1o3ivpOWmPr4VY9oi2IJ2HtiJTUKTaAV66YRLRagxnrq0SiAkzcmaPfc0UvzDIWRFtZY+X8xj5S9w39PdJ+CXy7E8nbxCWAPZ6Ai0nIiCluTVb0xK2UiQg995jrI3phAT2GICxKqGoQzjG32NzLAUzupVj+xEkoMgPs4Kfngzilz
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4739
Original-Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE; SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966005)(2906002)(86362001)(186003)(16526019)(26005)(336012)(2616005)(70586007)(70206006)(82740400003)(44832011)(33656002)(8886007)(956004)(1076003)(356005)(36906005)(47076004)(316002)(5660300002)(81166007)(478600001)(8676002)(4326008)(6862004)(82310400002)(8936002)(55016002)(7696005)(36756003)(966005);
 DIR:OUT; SFP:1101; 
X-MS-Office365-Filtering-Correlation-Id-Prvs: 824606db-4e52-4b3a-514b-08d7fb2b3dbc
X-Forefront-PRVS: 04073E895A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hN574aueDlM48P8uqnf7i3gMU81+z6o4cnJgY7dRhUVSBWZ0nihW50Rw/89NSwS1j7C40+2RbRUwNrY85HX02zkRY/gkO+Atj4Z4opOm1Ugur3mMzkPw8CIWBTac/ljNYUDrHH/d/N+DL0YcZ2FOJnsgbjQKs+479w2PbrfzEh4xxINqszEBDXwZGWxesdPG+min81sAVUxAxpImCtRydgiTJd45jf/SQWTbN1YsSa13pxxt1khQo++aqrRPcs8/7rMSSGcsITlM3fjOe7Dwj8MruW4VQPSS7tHkw7Y3fzQoeiFuL067Cbx0hwLZVgf4OpJfT3XyJn4LEjTEo5j9A4qvmI/aPfGRmeotHMsDY2i563s1bxCC/gqvETlLIMq7cjInqYUjXik5rKCQk7PKTEYpmIII/lgvQSZCIKuuSNoxcn17OW8cNVV0XjVTj/U9z9fj9ze4IOjfzZJzpHiH34y1N64Nn9LwfWM1M0XvEY/ZVQzqoQ5IjZpkf3ah/kICc4lomXoF0bnQPMilbOXrMrERR6/DDqVf4LbvqqowJkwAX70d6/VBygeNpZUbNvscSoAt1rSFLbdtnCSO/epkDg==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 12:59:10.8366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd844c3e-20d4-4d83-d26d-08d7fb2b4239
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4613
Received-SPF: pass client-ip=40.107.1.64; envelope-from=Szabolcs.Nagy@arm.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 09:14:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
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
Cc: nd@arm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 05/07/2020 10:21, Richard Henderson wrote:
> A reproducer would be most helpful.
> 
> Something that can help is saving a VM snapshot with the kernel booted and the
> user logged in, just ready to run the test program.  Then you can get back to
> exactly the state you want before things go wrong, even with a different qemu
> build.

i got some time to create a reproducer (with public code),
temporarily hosting the binaries at

http://port70.net/~nsz/tmp/qemu-bug.tar.gz
~251M

here

echo ./bug.sh | ./qemu-bug.sh

crashes in about 1 minute (where qemu-bug.sh
loads a snapshot with root shell and ./bug.sh
triggers the bug)

the disk rootfs is based on
https://distfiles.adelielinux.org/adelie/1.0/iso/rc1/adelie-rootfs-aarch64-1.0-rc1-20200206.txz
the kernel Image is linux mte-v3 with reverting the commit
"arm64: mte: Check the DT memory nodes for MTE support"
qemu is static linked from the branch tgt-arm-mte.

the userspace workload that triggers the bug is using the
adelie linux package manager with a malloc with tagging.
(the malloc implementation is a modified version of
https://github.com/richfelker/mallocng-draft
the code is on the disk image, it has known issues, but
it should not crash qemu)

i will remove the file after a few days. hope this helps.


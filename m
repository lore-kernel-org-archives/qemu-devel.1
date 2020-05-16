Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99E6C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 06:41:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E0A92065C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 06:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Qn7/oPN/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yAee/jsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0A92065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZqVH-0003ul-K2
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 02:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=398f0481b=Anup.Patel@wdc.com>)
 id 1jZqSh-0000Ki-Of; Sat, 16 May 2020 02:38:19 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=398f0481b=Anup.Patel@wdc.com>)
 id 1jZqSf-0001Um-Ig; Sat, 16 May 2020 02:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589611098; x=1621147098;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=/wgu4JZlHzbbok9+1Rjpt1sEYUrRqwuvEf+j4Dsb9+c=;
 b=Qn7/oPN/SksmQNLABhpvgbwBoStCQYtJNN55HXQrtYme9sxyGnXDFFTz
 83qxdRDcusJQPaZW6s3Z3ZrdrUhNI3Eb55cx8brVdbgQU7mPNV7p3drHW
 lSSWSyeV9DEqoElBQO4FNpOQpFK/hBBYSfTkG7yMaMZ1ciE/NRFjIHcqX
 ysv+YvnB7QJAiixebENQadFvO7MssMPSZujWVcWQZ3XJLp8fxQVdmVFO0
 tqlw19rncIRTRB20ENmZUqBi1Rrj4nJh6zEfpKKo5QQsEGY5KRVb3p0NM
 43n2qv8KVVevC25YGmPsyLeQkMADbdaXCGqa9A02xNPoD9nz/MV/fbAaG A==;
IronPort-SDR: uK0kUY8ECj9fPn82PHMq8DBfMevXaJagbGTDcVGNWdQhBchTjrw4Jkvx/iQrrQR+5hp3PJWV0p
 zKJSel+xGj2WJSHhjGV4ufYjh82H28Z4RG4vxWSVZG7YWjNS05pVijf+JE3R/8a9ElwO1qAfNG
 NVM4MYQjgZj31M0ujvZyKBQOLEkM4ch05/7C7lXYkhpqJIty3IH0P8hL6zHY0x10DCdPNBGmKl
 icJEYEDvFfbj8sMbkFEj9K7fKqtrtn79R7C5vGiMR9V7mbC8w4IR9tT1LvgP63AMRFrlNoa/q7
 oWM=
X-IronPort-AV: E=Sophos;i="5.73,398,1583164800"; d="scan'208";a="240555168"
Received: from mail-sn1nam04lp2053.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.53])
 by ob1.hgst.iphmx.com with ESMTP; 16 May 2020 14:38:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhQzHyIsnPafYgXTac3PZBklys2Vi0ESWP84rEJz8UAvCtoBtTogI1yqbTV6UyLfXycjUFYX9bwWMQWY4wTSkAcLVJ/Pn+s/SmU4TWEHAmsFomQfA98gILfNlE/giG9BTwI2qfYgSEsvxv9FVp9VewRug/jDEQmH4IwPacskdIV5954usbQfB1qtbMYMuRql6ZWLaLaHKMVS+6REOlI9z/Fc3ZOWCioq+tuHL8cFS3sSBegnaQhi6X7Wdb0GVNhqjyNbVacfnmCqriGvwEcd6HBcWp2JY1pWZ6DMcs0EIDm8J0MJnJIiPW9ZMrQZIykYoVnZcWEh6PesSd9tJCPFzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKijAsFdMppQE2eeB0wGxXujYQP743duev/UvZu2hNw=;
 b=PTVAl2Qmep67Z0xiM7oJtFjGHTfYL+HTa061Y1hugXcUvNJ7uD9netG3PQ8Ws88Zm1g+rqf8lL3AFLJB/+knfkfQU7qnpfQBUTdxRbzBaJScnZj3Xv75dHdCpgPQEmOY7WbG5rwy3uWAegoxjzf02ANC1aqSM0RwUR1kN9ownpB4bbt63ncGRAWILRprnnLA1nTzVMU7C3ehZo79QsR0AjL1TFc93bfpz+JD1n6dnFl5cFUdTX/AdG7e1CW2LoF7EIHmp9jCFix8AA+j1e19L2t79SM4WQW+4kooCtH2BdQOb+WC70hHALdOxLVqUyFajDdrdF2elilDOsZ0Sf8xfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKijAsFdMppQE2eeB0wGxXujYQP743duev/UvZu2hNw=;
 b=yAee/jsiBLXQRVtccMxZu/8As2/7GnwpoBKN+V2GP59sycz8jKCAnkh1v3jYV/vWguY0Nn9njhHz6PpCw3BOkX4gimVhJEt64nrk3FI53+nVPmg1kGVCEmxqRujVXHxtwy0xa4GF4fqky4F6UyaAODps9hp1NmpnCA18NELFaCQ=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4539.namprd04.prod.outlook.com (2603:10b6:5:2c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Sat, 16 May
 2020 06:38:09 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.2979.033; Sat, 16 May 2020
 06:38:09 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH 0/4] RISC-V multi-socket support
Date: Sat, 16 May 2020 12:07:42 +0530
Message-Id: <20200516063746.18296-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::27) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (49.207.60.36) by
 MAXPR01CA0109.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.25 via Frontend Transport; Sat, 16 May 2020 06:38:05 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [49.207.60.36]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2a62b2b-fc6b-4166-c74c-08d7f963b2d3
X-MS-TrafficTypeDiagnostic: DM6PR04MB4539:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB4539B87498BF4A1D1D04E8DE8DBA0@DM6PR04MB4539.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 040513D301
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lcgbk5T/57UuR0XKJz/9wgOADO7DAwEDuwacUMdG/eDut4vvihCWdG2s6mKYnXHAjgeangD8XyahrWhYVGfqkUP4BK9Ixi1ZCYaW0mK2mVhuW8kcc3zJrn5GCgFNR1e2fHsWhs6g5ElUQRhsnXjQ0s9M5mOUxDPn3Z3ky3Ayobo2QXRajPkWoQ7kMLmY+N30po2XMPv5fspbL4XUbZHCKAkdEqVOKKb5FLO16r9i86fPIMam0BBwW9RuUXczdYFQA4k5M9v1B9ko6InVx+3W81LqEl/CT+4sF/FECXURfaKxC1rEd/gdf0FGZZ1w+gIe0so32oIxUzHdNtUopzisE/PKcYTuG6LopCM6v7AornAAqS1V5OL2nKYtM9o8Xp+amqcUZorsNEJgvQb6GQ9FZJJ+vAiuUKbthLP2GeAbvfuft7AZRk6KQd8uMb9UspA97sKLFC97jdF4FtVlCyo1Scac+XNsficSmZ0QmPPYCxAx/SeMJQqbaD4ly+GQoOHmrBzyloATgA7L42SHsx4z/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(6666004)(1006002)(2906002)(8676002)(36756003)(8936002)(966005)(44832011)(26005)(54906003)(86362001)(7696005)(52116002)(55236004)(110136005)(1076003)(16526019)(186003)(316002)(5660300002)(66946007)(8886007)(55016002)(66476007)(66556008)(478600001)(956004)(4326008)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cM6lSpGgNUfzlWmErxsaJ3yIjQn9mUvR5KENMrpMGA3a4sz6FsdNWcMe+auv+TjXbMBJBBzRf66Iz+UkJ+sSLPFcLPIko67IpSeXDcVdLBAFBUHYCoJu3od8Qc6NpJo2hI+RAGRrSk3gFnCoCV1pkGd64C1z1gSinCxFT6naVYDL+mb0DqfGIECpOw8e1IIroBRdUFq9/lJLQy5Vu2IJ39zLz7oUyb6nCsYRxrGhDDYqyRs9igGrHgVvfYmW58MwhNeMhToQ8OJC1ILcFBFBdcxJOeIKDrXG8H2BC6+EhKSMEqf4KgPnO0uskiYmgTXDi6s3RUU5mZND2B3tgr7QCtUKO0nfzqzSMryMFNumS1Xc6EnHC2skznDqNfaDUV8+K/SdrY7tPIM61Y9Gnvv3LWpFkQ9kLhie7Uo3du7K7p5apMjha20ZiOlReQL0if33/PmMrNxrT4Fn+NcuUvrYAdabbJoWrrZxf+JwHojIr6M=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a62b2b-fc6b-4166-c74c-08d7f963b2d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2020 06:38:09.5065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6Qw4yamhFBrypEdB4wat3bTWG9WSssZpXLCjsVCJxMWnBpqhZlULbWCGIC/EqIUjzF6qpWynzlNk2FtQ6BKOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4539
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=398f0481b=Anup.Patel@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 02:38:11
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds multi-socket support for RISC-V virt machine and
RISC-V spike machine. The multi-socket support will help us improve
various RISC-V operating systems, firmwares, and bootloader to
support RISC-V NUMA systems.

These patch can be found in riscv_multi_socket_v1 branch at:
https://github.com/avpatel/qemu.git

To try this patches, we will need:
1. OpenSBI multi-PLIC and multi-CLINT support which can be found in
   multi_plic_clint_v1 branch at:
   https://github.com/avpatel/opensbi.git
2. Linux multi-PLIC improvements support which can be found in
   plic_imp_v1 branch at:
   https://github.com/avpatel/linux.git

Anup Patel (4):
  hw/riscv: Allow creating multiple instances of CLINT
  hw/riscv: spike: Allow creating multiple sockets
  hw/riscv: Allow creating multiple instances of PLIC
  hw/riscv: virt: Allow creating multiple sockets

 hw/riscv/sifive_clint.c         |  20 +-
 hw/riscv/sifive_e.c             |   4 +-
 hw/riscv/sifive_plic.c          |  24 +-
 hw/riscv/sifive_u.c             |   4 +-
 hw/riscv/spike.c                | 210 ++++++++------
 hw/riscv/virt.c                 | 495 ++++++++++++++++++--------------
 include/hw/riscv/sifive_clint.h |   7 +-
 include/hw/riscv/sifive_plic.h  |  12 +-
 include/hw/riscv/spike.h        |   8 +-
 include/hw/riscv/virt.h         |  12 +-
 10 files changed, 458 insertions(+), 338 deletions(-)

-- 
2.25.1



Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B729DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C9B206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ReuBAE8U";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zI5pcz+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C9B206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnJPe-0008MF-Ph
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 06:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=435c605ae=Anup.Patel@wdc.com>)
 id 1jnJOm-0007gD-Vb; Mon, 22 Jun 2020 06:09:57 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:43054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=435c605ae=Anup.Patel@wdc.com>)
 id 1jnJOj-0008I9-Vu; Mon, 22 Jun 2020 06:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592820593; x=1624356593;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RWN8JAWGEmGlLhlMCfdbnIKFaMvQtgb+tnOupQ8LP7w=;
 b=ReuBAE8UIE+9hwVD1/NozRiCFnkxLeMEcl3U0Reu7pQay/bdYndIVevj
 lYAd0qn+OSbcPvIgrsOLq1yYm4QO9GglCtnBvt6b0NtKC5Ly8j5oDaK1k
 YlxYdh688pJP20Lri1ZgWnAOd4JC1FvY6i2/BMhY2ErkL1m5EyemaY4tZ
 dhY5ysOeMFe+DZmW7wFlNR4wDD9vLYMcuTz73g2QioMhhwZ1RNxPPA5mh
 FTSRQKgXiUwkQjsARfnCUZqmSMbHwkpLmVzMj7mlmuud8GJspToF4dtoV
 8w7JuakfWlysAmMLBCIXvsVAecNzZbjLgHsLT2MJT7UhR35suJEwkWR3d A==;
IronPort-SDR: WqFpz9w1rPQUserzTI4BrnovhxzZZUKpb5rCjMDaUeFJ5p7Oq3jvjPA/6RphRXjtSFMtSxqE0c
 KLDKRvuXjHmg0YmZ9FlEHXLTW1TAMJ2v49yOXchQvhoe8PkJ5/08UyvUfEYyZ2IQ/dkvAUbm+g
 pbLVbfYIWWwaD0Fpck5S2rwIdV7p1Cr0DiAJrohpdBq5BlhShkRittlUZ6Vl6pgI8J+fVs5Peg
 PdBexjSuBDyN+xs5Pl6rTpqX5EZ5FAICkv/O+DGk8y/IR6fCy8kQCRRxaSElR6VQ5LGQwZjQGW
 Ai8=
X-IronPort-AV: E=Sophos;i="5.75,266,1589212800"; d="scan'208";a="249801140"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 18:09:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IamLkJIlMq2PkVV4kTNJ4wgV8nr9dMLtvJsJame5bNmtOy3w9tZz988tx8Rry818hqmdZQLvV31l6FNu4qtidAqBzdn5idXImpWcJbrFDrEy3nrCWxVjA5VVGCYX96ig9mMMMNeUNoh1uuVW0ZtZYcB8TJJ3kchK98PmIRQ7T1LPS1AXj5yA5eR4in+PMFzSmEA4yOGfN9YFSms0K185Sjy2X+ZWWaGvKSPqwSJ/vdIOvWDjhfozkQIH+nPxtoNNrWKrTaXkoBGIw1iGc1oEBtVwSI4zK32hkp9NusCMJCUWeLD/Dn5g7tqKDFzFBv603GePcClytoCDdlKvbSPOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvoA6XrG9g4pAF/gHWoQ437tF/AL/fMxW8DAxgBYtMQ=;
 b=Zp2eGMWxAp5MNU0BEKSoa5JIUaDPw3NW1TyIVSEP/DeU8imEyj2t5t6VtRmAgUHGJ+oFGkJupPAE5nLZhsXxlbSxpEGT09SC+6Sp2DnvV8Ipk04hx/bx1QNDl0Xt2IA/KoSrajv0f+WD2eeYYRk4up9UiwWb62nv9h4GTDSr+DL8dLvIFQwzYhbH8YndWwKU94qVnXg/3TI122PQjnMs6F/vXDHaDyHMXpKkSfmzjeZsCqgrjH/FrzhTK7oNYoBCb2tVfdeLWi2ac0xWnxHwFU7RvuiLa/mkae419mxVF9RPrmgTI0GgR5S7tuQF2Vusxqya3DDZQIShNlN39Hft9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvoA6XrG9g4pAF/gHWoQ437tF/AL/fMxW8DAxgBYtMQ=;
 b=zI5pcz+R4MHS7WAbjqNI3EDp6MlI3rrHkTOg27Aw6+ESTBcME0Mz1YPTJCzxFQHo2qme299RhLHexTNHq6XMUuTmCrUhStWzA+Q447n7ZZyL1U64uQsb4wE0xfksSdlNJsNdrfOCVIaZ9VtYcJ0b3QegweTjdoaQifpoyzA1Twg=
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6633.namprd04.prod.outlook.com (2603:10b6:5:24a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Mon, 22 Jun
 2020 10:09:47 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 10:09:47 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Subject: RE: [PATCH v2 0/7] riscv: Switch to use generic platform of opensbi
 bios images
Thread-Topic: [PATCH v2 0/7] riscv: Switch to use generic platform of opensbi
 bios images
Thread-Index: AQHWSF8bvVpcQ8q0fEm5PQ775A0UKqjkaUTQ
Date: Mon, 22 Jun 2020 10:09:47 +0000
Message-ID: <DM6PR04MB620142B152292DD3945E4D3C8D970@DM6PR04MB6201.namprd04.prod.outlook.com>
References: <1592807604-20805-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1592807604-20805-1-git-send-email-bmeng.cn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [103.56.182.118]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da7c642c-d636-4f51-e6bb-08d8169464cb
x-ms-traffictypediagnostic: DM6PR04MB6633:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6633997717F22B84544B63778D970@DM6PR04MB6633.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lmvWrk8kk3UcZqndFImuHbRMGU0yjFO0sd7ngO563yXTAScS9N2psxcHkLqIIRLSiLxm1crhKZOwnQ1M8Yj4RwD8FdkuDof4S70PVM3W17kA1itlrNvWS5VTDAt+7XTslfQllnAUQKuOPkV/M9ISRRZwMKf+t0OzGI8aeGPX9B6vNTRBuSkNTTgDYIa/msAAQZ1cyZ0H842z83AZ6DUMzWt/8lF9eC7cnXmzhu0jGKNh5Je06mROnuyW1vIJI1Pwgkxtw90n1/WLXq4TDTHSi/fCyCJEm55lsXEwIZwVnekd61ecG3YHkJQtxDNqEZ1mVpqvbSxsM/K1H1mstfvpLEaK8zNkbWVzXA3kHTReFCpTth6/vvkSv4ogPnnJJ1u3z4fM3wKn03xJxrSdM+Ea17W8xRJnbuKVaaQQeltADGrYhMmCu2zWFMWcVEFuKS0s
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(2906002)(86362001)(8676002)(8936002)(66556008)(64756008)(5660300002)(71200400001)(76116006)(4326008)(66476007)(66446008)(83380400001)(66946007)(52536014)(478600001)(9686003)(7696005)(55016002)(54906003)(110136005)(966005)(316002)(186003)(26005)(33656002)(6506007)(53546011)(41533002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: KJnRT7gyuU4K1Tz63Wx3uhhaJg9Zl41/62JCDnvdaIBlhWMzpBeNXU27Ed2zBVp2rbwxmYY/tBsa+P38bFUPEgZ0s+phKzjMnnxY/RvDl3vE28gtS06x9JuXM7+BeAq15TWm9onwvHXa5qpepHHIKzVjvcEriAyJHLEH81Wtz/E+UWcVdTGwhn69CfcZ2fzF9vws/xhUHT9duQEp6kjtjDuT4KXYvL2C64zSopl7kmkGmuSKUC3zMNJqh0bVJBASLEBNM1PnFqo0C80bwXS2558Mga7K/LKDMtyOjVM/Kw0UAjX9eAbQ+wAYnlFpstTCOu/Egh/PjeMQFDDmp25KMIxLlBNJzHI1Zl+PtVw5qE4rtOgfqAJOzIEBw1S+giVbsKK033UIIlEfhLLTnhdos44GhiKIYhscizkwJLDZfgxAYq3sokhsf3kLLl0nP0J+uXi9oUE082aXvZBTxYvnLy7dcDKtH+i0c2OuyiWxvro=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7c642c-d636-4f51-e6bb-08d8169464cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 10:09:47.4151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5agqQNN3/pwwJZQAR2FQ7TN1Gzd5ZzKI+3gBfQeR0SfIZJzT5I1L1dqvo1ZHVX/8Hm3P0K23tL954p8PcCvOdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6633
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=435c605ae=Anup.Patel@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 06:09:49
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Anup Patel <anup@brainfault.org>, Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Qemu-riscv <qemu-riscv-
> bounces+anup.patel=3Dwdc.com@nongnu.org> On Behalf Of Bin Meng
> Sent: 22 June 2020 12:03
> To: Alistair Francis <Alistair.Francis@wdc.com>; Bastian Koppelmann
> <kbastian@mail.uni-paderborn.de>; Palmer Dabbelt
> <palmerdabbelt@google.com>; Sagar Karandikar
> <sagark@eecs.berkeley.edu>; qemu-devel@nongnu.org; qemu-
> riscv@nongnu.org
> Cc: Anup Patel <anup@brainfault.org>; Bin Meng
> <bin.meng@windriver.com>
> Subject: [PATCH v2 0/7] riscv: Switch to use generic platform of opensbi =
bios
> images
>=20
> From: Bin Meng <bin.meng@windriver.com>
>=20
> The RISC-V generic platform is a flattened device tree (FDT) based platfo=
rm
> where all platform specific functionality is provided based on FDT passed=
 by
> previous booting stage. The support was added in the upstream OpenSBI
> v0.8 release recently.
>=20
> This series updates QEMU to switch to use generic platform of opensbi bio=
s
> images.
>=20
> The patch emails do not contain binary bits, please grab all updates at
> https://github.com/lbmeng/qemu.git bios branch.

It will be nice to have this series updated to for fw_dynamic.bin .

Maybe you can rebase your series on top of Atish's patches ??=20

Regards,
Anup

>=20
> Changes in v2:
> - new patch: configure: Create symbolic links for pc-bios/*.elf files
> - Upgrade OpenSBI to v0.8 release
> - Copy the ELF images too in the make rules
> - Include ELF images in the artifacts
> - new patch: Makefile: Ship the generic platform bios images for RISC-V
>=20
> Bin Meng (7):
>   configure: Create symbolic links for pc-bios/*.elf files
>   roms/opensbi: Upgrade from v0.7 to v0.8
>   roms/Makefile: Build the generic platform for RISC-V OpenSBI firmware
>   hw/riscv: Use pre-built bios image of generic platform for virt &
>     sifive_u
>   hw/riscv: spike: Change the default bios to use generic platform image
>   gitlab-ci/opensbi: Update GitLab CI to build generic platform
>   Makefile: Ship the generic platform bios images for RISC-V
>=20
>  .gitlab-ci.d/opensbi.yml                     |  28 +++++++++------------=
--
>  Makefile                                     |   4 ++--
>  configure                                    |   1 +
>  hw/riscv/sifive_u.c                          |   4 ++--
>  hw/riscv/spike.c                             |   9 ++++++--
>  hw/riscv/virt.c                              |   4 ++--
>  pc-bios/opensbi-riscv32-generic-fw_jump.bin  | Bin 0 -> 58048 bytes  pc-
> bios/opensbi-riscv32-generic-fw_jump.elf  | Bin 0 -> 554156 bytes  pc-
> bios/opensbi-riscv32-sifive_u-fw_jump.bin | Bin 49520 -> 0 bytes
>  pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 49504 -> 0 bytes
>  pc-bios/opensbi-riscv64-generic-fw_jump.bin  | Bin 0 -> 70792 bytes  pc-
> bios/opensbi-riscv64-generic-fw_jump.elf  | Bin 0 -> 619960 bytes  pc-
> bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 57936 -> 0 bytes
>  pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 57920 -> 0 bytes
>  roms/Makefile                                |  32 +++++++++------------=
------
>  roms/opensbi                                 |   2 +-
>  16 files changed, 35 insertions(+), 49 deletions(-)  create mode 100644 =
pc-
> bios/opensbi-riscv32-generic-fw_jump.bin
>  create mode 100644 pc-bios/opensbi-riscv32-generic-fw_jump.elf
>  delete mode 100644 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
>  delete mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
>  create mode 100644 pc-bios/opensbi-riscv64-generic-fw_jump.bin
>  create mode 100644 pc-bios/opensbi-riscv64-generic-fw_jump.elf
>  delete mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
>  delete mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin
>=20
> --
> 2.7.4
>=20



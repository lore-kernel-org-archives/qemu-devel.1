Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D39C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 17:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 997F32065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 17:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hX/qhcFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997F32065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZHJ4-0001Ga-P4
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 13:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jZHIJ-0000m3-8p
 for qemu-devel@nongnu.org; Thu, 14 May 2020 13:05:15 -0400
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com
 ([40.107.223.47]:57025 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jZHIG-0000bB-Vo
 for qemu-devel@nongnu.org; Thu, 14 May 2020 13:05:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSZE9AGhKPyD+mEbqH3SJ1Np/GF4j9hKsnfr74+Kv94+A8GfrUVhpEoHgWFx3PCXdOusKx1C523kSVixu7j8yB5iB1Q4QHC1Hwkm9tuF5xyaGfmgfkYSdsAP2U6MuBccMDO5FigdjUojzJa+adXJAaXMN/2GWNckHhA6ndHBT3WUZ1rnXaEGsdtxsq9WXO2epsOE6rsaLSW7h2dbyPXQTjxcECedwGh0EwjIZ8K23Es7UBRb1ukqCkhSaXCTwt3YX3FOt+8YB3mJRZOZ1KApzYpW6lsbrhKysM40UFBZkv9GN6JvehIswA7rxTP2cSlYWFkPiYlq75jG+34y8HU1Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXQ/7vWskGTw37FRFkjalcw5fICalBVaEfddDmObSao=;
 b=UaS3IBUeTA/rlJa2NWmRZBosYPnN+FunTAKUwtYyNd2m7crEBTRfRNzya8xpS8aqtdPMuATeCau2mmkfTdPMHgOsOquBvg/hAolvjHMOPgzW/QB76XIA45ZYXwNfxT0EX/RNU4ZeWqVPRo/8JA6Oq30qLhXtn61bVqGyoT2ETimB6bNeqoheiT7ShyqWxtF7mGNgtSYLogg9g9NiSemgimpZOj6AlDsynwHirRZEUOLmdegQ6sL+zyWfSMnJZmFqpvzNrAIb8r+IHtdlebqoJcR5zADNjAA4rYYFRPb193xUxIv8yKSMw1LOxnowcQR8AvOFHYO0j6/0D6o8efr6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXQ/7vWskGTw37FRFkjalcw5fICalBVaEfddDmObSao=;
 b=hX/qhcFjcC1DhHihZyT3m8+QNIMrxeHInuMkNXtRLS0keGBeG5XRCAgkFWGWDpiujUtIdaSFgsbAUx8Gu0/8KcPipaGXWQDcxswdfALzptPknoVIWIPtqdUAwtaoF86c4MB9lLRlcr7UNSr56tlIqb5+OR8SB3FvagJMGuzWs/A=
Received: from BY5PR02MB6033.namprd02.prod.outlook.com (2603:10b6:a03:1ff::10)
 by BY5PR02MB7012.namprd02.prod.outlook.com (2603:10b6:a03:233::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 17:05:10 +0000
Received: from BY5PR02MB6033.namprd02.prod.outlook.com
 ([fe80::f824:4502:4930:8144]) by BY5PR02MB6033.namprd02.prod.outlook.com
 ([fe80::f824:4502:4930:8144%5]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 17:05:10 +0000
From: Joe Komlodi <komlodi@xilinx.com>
To: Edgar Iglesias <edgari@xilinx.com>
Subject: RE: [PATCH V2 1/4] target/microblaze: gdb: Add dynamic GDB XML
 register support
Thread-Topic: [PATCH V2 1/4] target/microblaze: gdb: Add dynamic GDB XML
 register support
Thread-Index: AQHWKVHwoYikaQyJUEuR+wF17cVh7KinmAMAgAAzdDA=
Date: Thu, 14 May 2020 17:05:10 +0000
Message-ID: <BY5PR02MB6033D1DD9CB4A9FE1279193ED0BC0@BY5PR02MB6033.namprd02.prod.outlook.com>
References: <1589393329-223076-1-git-send-email-komlodi@xilinx.com>
 <20200514134110.GQ2945@toto>
In-Reply-To: <20200514134110.GQ2945@toto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15820684-9e55-4c90-694b-08d7f828f5fe
x-ms-traffictypediagnostic: BY5PR02MB7012:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB70125C308303F9CA7E161AADD0BC0@BY5PR02MB7012.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hxabRU4MbRM++aRmeTJ5dtJwSLuvgBpT3pRCAeR+nZt4cG/SouxdyQMse+KvJKUj5zHGNeNtXq+io/8Hl+Bpu2DdDGk9VjcHWIm73xN1cajan1aYhyi/PqkunGoKDmwqWEpOfh8efPtsRKxbX7Hhf5UGRVBKYdsp6w+0bb0M1QI/HAtXmW6ke9RMmz80iZoQAzK2sfXPxISDsIVKSM23ElfLrslmaRxX42uaq+CPkmMeNkgbLaeubGmLb7vnLdFRxZVZ9njl70nx4YqjKGFKebacDJbyRXp450hBX9bgx4kichmorYuP8jeAV6skLpr4yblAB4LR+a7USIDDJzEBNga52eQafR987qCwgcdl/os6WTkC4Hmi9xeOOqPk1B6dLSRkHIn4h7xlk3Z1/J052+Or+hNebA3AvbGmWKMWO17ENxk6lrciWROJCc4nlXx9xu4KaBsX5aOAiJpmk93o4lNwYBVGHMuQZzEvrQwO38T1szbMrNSVHSj/uTHmKTXalUcjj4S2xtD0Orwd86e+iw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6033.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(396003)(346002)(39860400002)(366004)(376002)(52536014)(7696005)(71200400001)(5660300002)(186003)(86362001)(316002)(53546011)(6506007)(8936002)(8676002)(2906002)(66556008)(55016002)(6636002)(9686003)(33656002)(76116006)(26005)(4326008)(6862004)(66476007)(21490400003)(64756008)(66946007)(66446008)(478600001)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: BnPIo3NlVR39BJ1Z1qlD8AsLYCam99/Q1F1n+mkc6zQce5zkMzU/FXqfK4Ylmhv5MBBPg4vhQBd5U+X3x3UJkVyxaPa8xCMFn5nNCJ6zjv8v3VtWZ8/mKwYiLyTULC4fWBBNDxjkk61n2lt/3KtDOt5/q/5jpV7SAgB1B7E9/lNIO8u2ygNsw/Ij8Q1TicJ4xBPUo5jaxr0k+EA2LhcUsuIsYJ9E8824QWI2iqOk27MSTiDCl8KEdu6CClBH3NRF8zIDXlreT3h7NruUkGILtdNegsTRm9XeHsMM0VkVFgylSKCsfCBZy2UnccvVUNw+r3bmX3wE+Cc36lTEyIIsUdgm6xlR0Iah7gpC8LoK5720LwaPxPnfBCT5KxflOY4JxKOC4fhn0mNyqWi1ZnMl9mAmH/5s6sBH4mOSAMeNuEP13e+atU8x9v2MElNpQsHpwi/pZ0w1dZy/rU/NlJtvlSuda5BH61G7t31mctkatDJ6pnwT7qxgYb1CKwZXI0lM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15820684-9e55-4c90-694b-08d7f828f5fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 17:05:10.4376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jtqz8Qd664xRNQ1sWoMHUoOFRmtHBhTSCeEisMvV6iJDnSCvASX5UQafAqt6VmFJAS9hWTV1onZoXvM38AeNEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7012
Received-SPF: pass client-ip=40.107.223.47; envelope-from=komlodi@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 13:05:11
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Edgar,

Comments marked with [Joe]

-----Original Message-----
From: Edgar E. Iglesias <edgar.iglesias@xilinx.com>=20
Sent: Thursday, May 14, 2020 6:41 AM
To: Joe Komlodi <komlodi@xilinx.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH V2 1/4] target/microblaze: gdb: Add dynamic GDB XML reg=
ister support

On Wed, May 13, 2020 at 11:08:45AM -0700, Joe Komlodi wrote:
> Add dynamic GDB register XML for Microblaze, and modify the config=20
> file to use XML when building for Microblaze.
> For the dynamic XML to be read, there still needs to be a core XML file.

Hi Joe,

I was looking a little closer at this and got a bit confused with this appr=
oach.

So we're adding microblaze-core.xml but we're actually at runtime dynamical=
ly generating and providing the contents for it. So the static builtin file=
 does not get used.

[Joe] If I recall correctly, the GDB stub wouldn't use any dynamic XML file=
s without a static XML file present.  This might have changed since then, s=
ince this was written on an older version of QEMU.

We should do either (not both):
1. Keep the dynamic generation of the XML file and remove the addintion
   of gdb_xml_files=3D and microblaze-core.xml.

or

2. Keep the addition of static microblaze-core.xml and remove the dynamic
   generation of it.

Since we're not yet using the dynamic aspects for anything relevant (only
r17 code_ptr) my preference would be to use the static files for now.

[Joe] That sounds good to me.

Also, it's probably a good idea to move this patch to after the patches tha=
t fix the register ordering.

A few more comments inline.

>=20
> Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
> ---
>  configure                   |   1 +
>  gdb-xml/microblaze-core.xml |  64 +++++++++++++++++++++++
>  target/microblaze/cpu.c     |   4 ++
>  target/microblaze/cpu.h     |   9 ++++
>  target/microblaze/gdbstub.c | 123=20
> ++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 201 insertions(+)
>  create mode 100644 gdb-xml/microblaze-core.xml
>=20
> diff --git a/configure b/configure
> index 0d69c36..5a099b6 100755
> --- a/configure
> +++ b/configure
> @@ -7832,6 +7832,7 @@ case "$target_name" in
>      TARGET_ARCH=3Dmicroblaze
>      TARGET_SYSTBL_ABI=3Dcommon
>      bflt=3D"yes"
> +    gdb_xml_files=3D"microblaze-core.xml"
>      echo "TARGET_ABI32=3Dy" >> $config_target_mak
>    ;;
>    mips|mipsel)
> diff --git a/gdb-xml/microblaze-core.xml b/gdb-xml/microblaze-core.xml=20
> new file mode 100644 index 0000000..13e2c08
> --- /dev/null
> +++ b/gdb-xml/microblaze-core.xml
> @@ -0,0 +1,64 @@
> +<?xml version=3D"1.0"?>
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd"> <feature=20
> +name=3D"org.gnu.gdb.microblaze.core">
> +  <reg name=3D"r0" bitsize=3D"32"/>
> +  <reg name=3D"r1" bitsize=3D"32" type=3D"data_ptr"/>
> +  <reg name=3D"r2" bitsize=3D"32"/>
> +  <reg name=3D"r3" bitsize=3D"32"/>
> +  <reg name=3D"r4" bitsize=3D"32"/>
> +  <reg name=3D"r5" bitsize=3D"32"/>
> +  <reg name=3D"r6" bitsize=3D"32"/>
> +  <reg name=3D"r7" bitsize=3D"32"/>
> +  <reg name=3D"r8" bitsize=3D"32"/>
> +  <reg name=3D"r9" bitsize=3D"32"/>
> +  <reg name=3D"r10" bitsize=3D"32"/>
> +  <reg name=3D"r11" bitsize=3D"32"/>
> +  <reg name=3D"r12" bitsize=3D"32"/>
> +  <reg name=3D"r13" bitsize=3D"32"/>
> +  <reg name=3D"r14" bitsize=3D"32" type=3D"code_ptr"/>
> +  <reg name=3D"r15" bitsize=3D"32" type=3D"code_ptr"/>
> +  <reg name=3D"r16" bitsize=3D"32" type=3D"code_ptr"/>
> +  <reg name=3D"r17" bitsize=3D"32"/>
> +  <reg name=3D"r18" bitsize=3D"32"/>
> +  <reg name=3D"r19" bitsize=3D"32"/>
> +  <reg name=3D"r20" bitsize=3D"32"/>
> +  <reg name=3D"r21" bitsize=3D"32"/>
> +  <reg name=3D"r22" bitsize=3D"32"/>
> +  <reg name=3D"r23" bitsize=3D"32"/>
> +  <reg name=3D"r24" bitsize=3D"32"/>
> +  <reg name=3D"r25" bitsize=3D"32"/>
> +  <reg name=3D"r26" bitsize=3D"32"/>
> +  <reg name=3D"r27" bitsize=3D"32"/>
> +  <reg name=3D"r28" bitsize=3D"32"/>
> +  <reg name=3D"r29" bitsize=3D"32"/>
> +  <reg name=3D"r30" bitsize=3D"32"/>
> +  <reg name=3D"r31" bitsize=3D"32"/>
> +  <reg name=3D"rpc" bitsize=3D"32" type=3D"code_ptr"/>
> +  <reg name=3D"rmsr" bitsize=3D"32"/>
> +  <reg name=3D"rear" bitsize=3D"32"/>
> +  <reg name=3D"resr" bitsize=3D"32"/>
> +  <reg name=3D"rfsr" bitsize=3D"32"/>
> +  <reg name=3D"rbtr" bitsize=3D"32"/>
> +  <reg name=3D"rpvr0" bitsize=3D"32"/>
> +  <reg name=3D"rpvr1" bitsize=3D"32"/>
> +  <reg name=3D"rpvr2" bitsize=3D"32"/>
> +  <reg name=3D"rpvr3" bitsize=3D"32"/>
> +  <reg name=3D"rpvr4" bitsize=3D"32"/>
> +  <reg name=3D"rpvr5" bitsize=3D"32"/>
> +  <reg name=3D"rpvr6" bitsize=3D"32"/>
> +  <reg name=3D"rpvr7" bitsize=3D"32"/>
> +  <reg name=3D"rpvr8" bitsize=3D"32"/>
> +  <reg name=3D"rpvr9" bitsize=3D"32"/>
> +  <reg name=3D"rpvr10" bitsize=3D"32"/>
> +  <reg name=3D"rpvr11" bitsize=3D"32"/>
> +  <reg name=3D"redr" bitsize=3D"32"/>
> +  <reg name=3D"rpid" bitsize=3D"32"/>
> +  <reg name=3D"rzpr" bitsize=3D"32"/>
> +  <reg name=3D"rtlbx" bitsize=3D"32"/>
> +  <reg name=3D"rtlbsx" bitsize=3D"32"/>
> +  <reg name=3D"rtlblo" bitsize=3D"32"/>
> +  <reg name=3D"rtlbhi" bitsize=3D"32"/>
> +  <reg name=3D"rslr" bitsize=3D"32"/>
> +  <reg name=3D"rshr" bitsize=3D"32"/>


This last part doesn't look right.
slr and shr are optional and should only be presented when the core support=
s stack protection.

I think it would be easier if we simply copied both these files from GDB:
https://github.com/bminor/binutils-gdb/blob/master/gdb/features/microblaze-=
core.xml
https://github.com/bminor/binutils-gdb/blob/master/gdb/features/microblaze-=
stack-protect.xml

Add both to gdb_xml_files=3D and register the stack protect XML file with
gdb_register_coprocessor() if stack protection is enabled.

[Joe] Agreed. =20

> +</feature>
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c index=20
> aa99830..41cac1b 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -226,6 +226,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error =
**errp)
>      env->pvr.regs[11] =3D (cpu->cfg.use_mmu ? PVR11_USE_MMU : 0) |
>                          16 << 17;
> =20
> +    mb_gen_dynamic_xml(cpu);
> +
>      mcc->parent_realize(dev, errp);
>  }
> =20
> @@ -330,6 +332,8 @@ static void mb_cpu_class_init(ObjectClass *oc, void *=
data)
>      dc->vmsd =3D &vmstate_mb_cpu;
>      device_class_set_props(dc, mb_properties);
>      cc->gdb_num_core_regs =3D 32 + 5;
> +    cc->gdb_get_dynamic_xml =3D mb_gdb_get_dynamic_xml;
> +    cc->gdb_core_xml_file =3D "microblaze-core.xml";
> =20
>      cc->disas_set_info =3D mb_disas_set_info;
>      cc->tcg_initialize =3D mb_tcg_init; diff --git=20
> a/target/microblaze/cpu.h b/target/microblaze/cpu.h index=20
> a31134b..074a18e 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -25,6 +25,8 @@
>  #include "fpu/softfloat-types.h"
> =20
>  typedef struct CPUMBState CPUMBState;
> +typedef struct DynamicMBGDBXMLInfo DynamicMBGDBXMLInfo;
> +
>  #if !defined(CONFIG_USER_ONLY)
>  #include "mmu.h"
>  #endif
> @@ -272,6 +274,10 @@ struct CPUMBState {
>      } pvr;
>  };
> =20
> +struct DynamicMBGDBXMLInfo {
> +    char *xml;
> +};
> +
>  /**
>   * MicroBlazeCPU:
>   * @env: #CPUMBState
> @@ -286,6 +292,7 @@ struct MicroBlazeCPU {
> =20
>      CPUNegativeOffsetState neg;
>      CPUMBState env;
> +    DynamicMBGDBXMLInfo dyn_xml;
> =20
>      /* Microblaze Configuration Settings */
>      struct {
> @@ -321,6 +328,8 @@ void mb_cpu_dump_state(CPUState *cpu, FILE *f, int=20
> flags);  hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr); =20
> int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg); =20
> int mb_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> +void mb_gen_dynamic_xml(MicroBlazeCPU *cpu); const char=20
> +*mb_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname);
> =20
>  void mb_tcg_init(void);
>  /* you can call this signal handler from your SIGBUS and SIGSEGV diff=20
> --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c=20
> index f41ebf1..cdca434 100644
> --- a/target/microblaze/gdbstub.c
> +++ b/target/microblaze/gdbstub.c
> @@ -54,3 +54,126 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *=
mem_buf, int n)
>      }
>      return 4;
>  }
> +
> +static void mb_gen_xml_reg_tag(const MicroBlazeCPU *cpu, GString *s,
> +                               const char *name, uint8_t bitsize,
> +                               const char *type) {
> +    g_string_append_printf(s, "<reg name=3D\"%s\" bitsize=3D\"%d\"",
> +                           name, bitsize);
> +    if (type) {
> +        g_string_append_printf(s, " type=3D\"%s\"", type);
> +    }
> +    g_string_append_printf(s, "/>\n"); }
> +
> +static uint8_t mb_cpu_sreg_size(const MicroBlazeCPU *cpu, uint8_t=20
> +index) {
> +    /*
> +     * NOTE:  mb-gdb will refuse to connect if we say registers are
> +     * larger then 32-bits.
> +     * For now, say none of our registers are dynamically sized, and are
> +     * therefore only 32-bits.
> +     */
> +
> +    return 32;
> +}
> +
> +static void mb_gen_xml_reg_tags(const MicroBlazeCPU *cpu, GString *s)=20
> +{
> +    uint8_t i;
> +    const char *type;
> +    char reg_name[4];
> +    bool has_hw_exception =3D cpu->cfg.dopb_bus_exception ||
> +                            cpu->cfg.iopb_bus_exception ||
> +                            cpu->cfg.illegal_opcode_exception ||
> +                            cpu->cfg.opcode_0_illegal ||
> +                            cpu->cfg.div_zero_exception ||
> +                            cpu->cfg.unaligned_exceptions;
> +
> +    static const char *reg_types[32] =3D {
> +        [1] =3D "data_ptr",
> +        [14] =3D "code_ptr",
> +        [15] =3D "code_ptr",
> +        [16] =3D "code_ptr",
> +        [17] =3D "code_ptr"
> +    };
> +
> +    for (i =3D 0; i < 32; ++i) {
> +        type =3D reg_types[i];
> +        /* r17 only has a code_ptr tag if we have HW exceptions */
> +        if (i =3D=3D 17 && !has_hw_exception) {
> +            type =3D NULL;
> +        }
> +
> +        sprintf(reg_name, "r%d", i);
> +        mb_gen_xml_reg_tag(cpu, s, reg_name, 32, type);
> +    }
> +}
> +
> +static void mb_gen_xml_sreg_tags(const MicroBlazeCPU *cpu, GString=20
> +*s) {
> +    uint8_t i;
> +
> +    static const char *sreg_names[] =3D {
> +        "rpc",
> +        "rmsr",
> +        "rear",
> +        "resr",
> +        "rfsr",
> +        "rbtr",
> +        "rpvr0",
> +        "rpvr1",
> +        "rpvr2",
> +        "rpvr3",
> +        "rpvr4",
> +        "rpvr5",
> +        "rpvr6",
> +        "rpvr7",
> +        "rpvr8",
> +        "rpvr9",
> +        "rpvr10",
> +        "rpvr11",
> +        "redr",
> +        "rpid",
> +        "rzpr",
> +        "rtlblo",
> +        "rtlbhi",
> +        "rtlbx",
> +        "rtlbsx",

In case we decide to keep this dynamic approach, tlbx and tlbsx should be b=
efore tlblo and tlbhi.


> +        "rslr",
> +        "rshr"

These need to be optional and in a separate XML description with org.gnu.gd=
b.microblaze.stack-protect.


> +    };
> +
> +    static const char *sreg_types[ARRAY_SIZE(sreg_names)] =3D {
> +        [SR_PC] =3D "code_ptr"
> +    };
> +
> +    for (i =3D 0; i < ARRAY_SIZE(sreg_names); ++i) {
> +        mb_gen_xml_reg_tag(cpu, s, sreg_names[i], mb_cpu_sreg_size(cpu, =
i),
> +                           sreg_types[i]);
> +    }
> +}
> +
> +void mb_gen_dynamic_xml(MicroBlazeCPU *cpu) {
> +    GString *s =3D g_string_new(NULL);
> +
> +    g_string_printf(s, "<?xml version=3D\"1.0\"?>\n"
> +                       "<!DOCTYPE feature SYSTEM \"gdb-target.dtd\">\n"
> +                       "<feature=20
> + name=3D\"org.gnu.gdb.microblaze.core\">\n");
> +
> +    mb_gen_xml_reg_tags(cpu, s);
> +    mb_gen_xml_sreg_tags(cpu, s);
> +
> +    g_string_append_printf(s, "</feature>");
> +
> +    cpu->dyn_xml.xml =3D g_string_free(s, false); }
> +
> +const char *mb_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)=20
> +{
> +    MicroBlazeCPU *cpu =3D MICROBLAZE_CPU(cs);
> +
> +    return cpu->dyn_xml.xml;
> +}
> --
> 2.7.4
>=20


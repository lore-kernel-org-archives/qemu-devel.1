Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80B4C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 15:25:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1223A218BA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 15:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="ABoZdXyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1223A218BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzjXD-0007wz-Ul
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 11:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arikalo@wavecomp.com>) id 1hzizM-0007xk-9D
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hzizB-00024r-0Q
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:50:27 -0400
Received: from mail-eopbgr760133.outbound.protection.outlook.com
 ([40.107.76.133]:8005 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hzizA-000248-2i
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:50:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isP958Yb3oNpKWrqcvbxpwUutDudiSLlzBq9X/1KMSZIEuoBtTJWdNA6pMZ47nx6V+FDb7Efk4fhvBgo5XAY913Jq+SU4AxSQPVExh8qNMTsp0lSKKYad16cCWql7pvOdUxtft0ZR62Zs4KGZ1beD3RQc9O6dZjqGi7cH43Nw7IgqLJPtnyXFImrXd2PBUvk3E2laRJFzzGDOs5ShJXXt4SocV1MPIZSI3fANxDASUAr4fiCbaXX1kJM8RHTptPnXpP1d36OiP3Ap8AdMEL7f3WuhjDHHse6q2bhk1Fh0s1vzTMoLa37dgu48rys0cskGbCTaCFkpmbZOhDloV7sRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJNwVKseo1sz8sD/x6cwf/VgnSKgBx36+cXbWnF+1R0=;
 b=nlo047dIu6fv6l+XuKsLDxlz0JwTWRv+CQqPpruKeS7Gcrvjr7kZb6eyP8DkPlNvAUZeXSL8ZrSuIba0Ok8v2FBf+zvQFdYWvxRcTLg62Xuo3Tps1oiDMZMVyEaMmD8jhWfLxOUW3QQ0DpthPKcvAvgJdyygi15OHFrO8RLtL7sodLtQOPzeXFa+PaN2pvb1pciCLetzuODwGHIHBgR8+z7u6lFbnQRlkwtLxc6tgx9iRqMrVW6dzcgazLuSQjaAAazroKBUU7441GAh7IMpr3v03YcpcwozSYx9iguf1jLoXSxAMWaU/P3WWN3IxbNg4kV4BgBL/TRgydIPA6614w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJNwVKseo1sz8sD/x6cwf/VgnSKgBx36+cXbWnF+1R0=;
 b=ABoZdXyUNMs8qfaxjk4ZFlsuck0PnSKAsk5jVobzHCx6x3miYWG8rNlYjw51Puef/54fbmPzTEEa5x1NkimbRxb/DSXvRVpe5dcIkMcaPnCQetZM/0i/F1vlhOEgS6T8uhCOvSPE4nmWsXODyN2FZfq++UeM7vMq4SWVqbS+xpU=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0331.namprd22.prod.outlook.com (10.173.175.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 14:50:09 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197%5]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 14:50:09 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL][PATCH v8 37/37] target/mips: tests/tcg: Fix target
 configurations for MSA tests
Thread-Index: AQHVVoboHG5HEDz/hkeHRsP/73jaU6cCjYFY
Date: Mon, 19 Aug 2019 14:50:09 +0000
Message-ID: <DM5PR22MB1658C7F1422C144592878E38D2A80@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <1566216496-17375-38-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1566216496-17375-38-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 295917b0-71e4-4a5b-15e7-08d724b48871
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM5PR22MB0331; 
x-ms-traffictypediagnostic: DM5PR22MB0331:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR22MB03310130210130E706F2513DD2A80@DM5PR22MB0331.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:337;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39830400003)(189003)(199004)(99286004)(76116006)(66556008)(66476007)(66946007)(91956017)(64756008)(66066001)(6606003)(256004)(14444005)(2906002)(8676002)(81156014)(110136005)(66446008)(52536014)(71200400001)(71190400001)(2501003)(53936002)(3846002)(54906003)(6116002)(316002)(186003)(107886003)(7696005)(478600001)(76176011)(81166006)(8936002)(5660300002)(14454004)(7736002)(19627405001)(33656002)(6246003)(4326008)(486006)(74316002)(25786009)(30864003)(446003)(86362001)(55236004)(53546011)(102836004)(6506007)(55016002)(54896002)(9686003)(229853002)(6436002)(476003)(11346002)(26005)(53946003)(579004)(559001)(569006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0331;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qxr9aSYXtszShFXU7XmjIA0hcF6xBMWnwlVkcITl/upDeqW8+olWpdzyFKi13CPjP2ced+STfNBX48DFMuZ/wm3fmdr7shA7UuGTYKhtBbJNXI+2tEKc5DEGVwfJV4lDhduDO86mLwZzkpIteLVrgPOH3eTIqdji0eYH76qi6M11HH/sxIB/Q1Xj6TC0iIDDROUZGuOuEtbFpX5rsmbRO7A1se30lVcNSqLRzCaHcBnl5ci458SR31c1MlpP+VqnwMRRUuJkajsupJYdw7X51YyIFxde3/IPvFk5nYZMPtOuMYi5UhoT+4jgK9nCdyCKwm1VYVcNu8qep437WNNF4U0lNHq7u/Sk1QVjYMZVUWc/FycjNEcu9njEOaUTm2ssQAiMOTGK7O/kHV7TlUcAWFvOQYIJk57gY0g1sRZRDfc=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295917b0-71e4-4a5b-15e7-08d724b48871
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 14:50:09.7200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zmRZM8Nzv/xZpe/074NuwnvPVYxf24NfztcBvl3cbZUWUErHg6UU5aTQ/wEi3CmNR2DRFumFF+3WJvSGjhhqQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0331
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.76.133
X-Mailman-Approved-At: Mon, 19 Aug 2019 11:24:20 -0400
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [EXTERNAL][PATCH v8 37/37] target/mips: tests/tcg:
 Fix target configurations for MSA tests
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
Cc: "philmd@redhat.com" <philmd@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 19, 2019 2:08 PM
> To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
> Cc: philmd@redhat.com <philmd@redhat.com>; Aleksandar Markovic <amarkovic=
@wavecomp.com>; Aleksandar Rikalo <arikalo@wavecomp.com>
> Subject: [EXTERNAL][PATCH v8 37/37] target/mips: tests/tcg: Fix target co=
nfigurations for MSA tests
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> At this moment, the only MIPS CPUs that are emulated in QEMU and
> support MSA extension are R5600 (mips32r5), and I6400/I6500 (mips64r6).
> Therefore, mips32r5 and mips64r6 are the only ISAs that could support
> MSA in QEMU. This means mips32r6 currently do not make much sense, and
> mips32r5 support for MSA tests is needed, which is done by this patch.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  .../mips/user/ase/msa/test_msa_compile_32r5eb.sh   | 917 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/test_msa_compile_32r5el.sh   | 917 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/test_msa_compile_32r6eb.sh   | 643 ---------------
>  .../mips/user/ase/msa/test_msa_compile_32r6el.sh   | 643 ---------------
>  tests/tcg/mips/user/ase/msa/test_msa_run_32r5eb.sh | 371 +++++++++
>  tests/tcg/mips/user/ase/msa/test_msa_run_32r5el.sh | 371 +++++++++
>  tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh | 371 ---------
>  tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh | 371 ---------
>  8 files changed, 2576 insertions(+), 2028 deletions(-)
>  create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r5eb.s=
h
>  create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r5el.s=
h
>  delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.s=
h
>  delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.s=
h
>  create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_32r5eb.sh
>  create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_32r5el.sh
>  delete mode 100644 tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh
>  delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh
>
> diff --git a/tests/tcg/mips/user/ase/msa/test_msa_compile_32r5eb.sh b/tes=
ts/tcg/mips/user/ase/msa/test_msa_compile_32r5eb.sh
> new file mode 100755
> index 0000000..940cabe
> --- /dev/null
> +++ b/tests/tcg/mips/user/ase/msa/test_msa_compile_32r5eb.sh
> @@ -0,0 +1,917 @@
> +
> +#
> +# Bit Count
> +# ---------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_nloc_b.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_nloc_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_nloc_h.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_nloc_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_nloc_w.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_nloc_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_nloc_d.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_nloc_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_nlzc_b.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_nlzc_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_nlzc_h.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_nlzc_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_nlzc_w.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_nlzc_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_nlzc_d.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_nlzc_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_pcnt_b.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pcnt_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_pcnt_h.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pcnt_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_pcnt_w.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pcnt_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_pcnt_d.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pcnt_d_32r5eb
> +
> +#
> +# Bit move
> +# --------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_binsl_b.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_binsl_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_binsl_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_binsl_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_binsl_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_binsl_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_binsl_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_binsl_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_binsr_b.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_binsr_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_binsr_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_binsr_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_binsr_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_binsr_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_binsr_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_binsr_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_bmnz_v.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bmnz_v_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_bmz_v.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bmz_v_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_bsel_v.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bsel_v_32r5eb
> +
> +#
> +# Bit Set
> +# -------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bclr_b.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bclr_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bclr_h.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bclr_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bclr_w.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bclr_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bclr_d.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bclr_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bneg_b.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bneg_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bneg_h.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bneg_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bneg_w.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bneg_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bneg_d.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bneg_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bset_b.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bset_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bset_h.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bset_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bset_w.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bset_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bset_d.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bset_d_32r5eb
> +
> +#
> +# Fixed Multiply
> +# --------------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_madd_q_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_madd_q_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_madd_q_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_madd_q_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_maddr_q_h.c=
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_maddr_q_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_maddr_q_w.c=
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_maddr_q_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_msub_q_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_msub_q_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_msub_q_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_msub_q_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_msubr_q_h.c=
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_msubr_q_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_msubr_q_w.c=
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_msubr_q_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mul_q_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mul_q_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_mulr_q_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mulr_q_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_mulr_q_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mulr_q_w_32r5eb
> +
> +#
> +# Float Max Min
> +# -------------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc   float-max-min/test_msa_fmax_a_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_fmax_a_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc   float-max-min/test_msa_fmax_a_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_fmax_a_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc   float-max-min/test_msa_fmax_w.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_fmax_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc   float-max-min/test_msa_fmax_d.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_fmax_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc   float-max-min/test_msa_fmin_a_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_fmin_a_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc   float-max-min/test_msa_fmin_a_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_fmin_a_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc   float-max-min/test_msa_fmin_w.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_fmin_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc   float-max-min/test_msa_fmin_d.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_fmin_d_32r5eb
> +
> +#
> +# Int Add
> +# -------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_add_a_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_add_a_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_add_a_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_add_a_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_add_a_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_add_a_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_add_a_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_add_a_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_a_b.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_a_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_a_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_a_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_a_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_a_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_a_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_a_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_s_b.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_s_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_s_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_s_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_s_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_s_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_s_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_s_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_u_b.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_u_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_u_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_u_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_u_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_u_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_u_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_u_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_addv_b.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_addv_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_addv_h.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_addv_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_addv_w.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_addv_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_addv_d.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_addv_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_hadd_s_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hadd_s_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_hadd_s_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hadd_s_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_hadd_s_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hadd_s_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_hadd_u_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hadd_u_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_hadd_u_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hadd_u_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_hadd_u_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hadd_u_d_32r5eb
> +
> +#
> +# Int Average
> +# -----------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_ave_s_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ave_s_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_ave_s_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ave_s_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_ave_s_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ave_s_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_ave_s_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ave_s_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_ave_u_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ave_u_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_ave_u_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ave_u_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_ave_u_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ave_u_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_ave_u_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ave_u_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_aver_s_b.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_aver_s_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_aver_s_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_aver_s_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_aver_s_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_aver_s_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_aver_s_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_aver_s_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_aver_u_b.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_aver_u_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_aver_u_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_aver_u_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_aver_u_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_aver_u_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_aver_u_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_aver_u_d_32r5eb
> +
> +#
> +# Int Compare
> +# -----------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_ceq_b.c    =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ceq_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_ceq_h.c    =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ceq_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_ceq_w.c    =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ceq_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_ceq_d.c    =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ceq_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_cle_s_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_cle_s_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_cle_s_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_cle_s_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_cle_s_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_cle_s_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_cle_s_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_cle_s_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_cle_u_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_cle_u_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_cle_u_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_cle_u_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_cle_u_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_cle_u_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_cle_u_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_cle_u_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_clt_s_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_clt_s_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_clt_s_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_clt_s_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_clt_s_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_clt_s_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_clt_s_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_clt_s_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_clt_u_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_clt_u_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_clt_u_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_clt_u_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_clt_u_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_clt_u_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_clt_u_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_clt_u_d_32r5eb
> +
> +#
> +# Int Divide
> +# ----------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-divide/test_msa_div_s_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_div_s_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-divide/test_msa_div_s_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_div_s_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-divide/test_msa_div_s_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_div_s_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-divide/test_msa_div_s_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_div_s_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-divide/test_msa_div_u_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_div_u_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-divide/test_msa_div_u_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_div_u_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-divide/test_msa_div_u_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_div_u_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-divide/test_msa_div_u_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_div_u_d_32r5eb
> +
> +#
> +# Int Dot Product
> +# ---------------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dotp_s_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dotp_s_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dotp_s_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dotp_s_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dotp_s_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dotp_s_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dotp_u_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dotp_u_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dotp_u_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dotp_u_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dotp_u_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dotp_u_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_h.c=
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpadd_s_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_w.c=
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpadd_s_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_d.c=
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpadd_s_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_h.c=
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpadd_u_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_w.c=
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpadd_u_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_d.c=
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpadd_u_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_h.c=
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpsub_s_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_w.c=
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpsub_s_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_d.c=
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpsub_s_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_h.c=
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpsub_u_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_w.c=
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpsub_u_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_d.c=
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpsub_u_d_32r5eb
> +
> +#
> +# Int Max Min
> +# -----------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_a_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_a_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_a_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_a_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_a_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_a_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_a_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_a_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_s_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_s_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_s_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_s_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_s_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_s_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_s_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_s_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_u_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_u_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_u_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_u_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_u_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_u_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_u_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_u_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_a_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_a_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_a_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_a_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_a_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_a_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_a_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_a_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_s_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_s_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_s_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_s_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_s_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_s_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_s_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_s_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_u_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_u_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_u_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_u_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_u_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_u_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_u_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_u_d_32r5eb
> +
> +#
> +# Int Modulo
> +# ----------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-modulo/test_msa_mod_s_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mod_s_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-modulo/test_msa_mod_s_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mod_s_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-modulo/test_msa_mod_s_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mod_s_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-modulo/test_msa_mod_s_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mod_s_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-modulo/test_msa_mod_u_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mod_u_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-modulo/test_msa_mod_u_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mod_u_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-modulo/test_msa_mod_u_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mod_u_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-modulo/test_msa_mod_u_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mod_u_d_32r5eb
> +
> +#
> +# Int Multiply
> +# ------------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_maddv_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_maddv_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_maddv_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_maddv_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_maddv_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_maddv_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_maddv_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_maddv_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_msubv_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_msubv_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_msubv_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_msubv_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_msubv_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_msubv_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_msubv_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_msubv_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_mulv_b.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mulv_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_mulv_h.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mulv_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_mulv_w.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mulv_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_mulv_d.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mulv_d_32r5eb
> +
> +#
> +# Int Subtract
> +# ------------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_asub_s_b.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_asub_s_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_asub_s_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_asub_s_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_asub_s_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_asub_s_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_asub_s_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_asub_s_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_asub_u_b.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_asub_u_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_asub_u_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_asub_u_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_asub_u_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_asub_u_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_asub_u_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_asub_u_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_hsub_s_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hsub_s_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_hsub_s_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hsub_s_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_hsub_s_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hsub_s_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_hsub_u_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hsub_u_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_hsub_u_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hsub_u_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_hsub_u_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hsub_u_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subs_s_b.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subs_s_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subs_s_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subs_s_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subs_s_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subs_s_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subs_s_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subs_s_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subs_u_b.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subs_u_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subs_u_h.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subs_u_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subs_u_w.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subs_u_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subs_u_d.c =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subs_u_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subsus_u_b.=
c      \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subsus_u_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subsus_u_h.=
c      \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subsus_u_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subsus_u_w.=
c      \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subsus_u_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subsus_u_d.=
c      \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subsus_u_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_b.=
c      \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subsuu_s_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_h.=
c      \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subsuu_s_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_w.=
c      \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subsuu_s_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_d.=
c      \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subsuu_s_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subv_b.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subv_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subv_h.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subv_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subv_w.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subv_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subv_d.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subv_d_32r5eb
> +
> +#
> +# Interleave
> +# ----------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvev_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvev_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvev_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvev_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvev_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvev_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvev_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvev_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvod_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvod_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvod_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvod_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvod_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvod_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvod_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvod_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvl_b.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvl_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvl_h.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvl_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvl_w.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvl_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvl_d.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvl_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvr_b.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvr_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvr_h.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvr_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvr_w.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvr_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvr_d.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvr_d_32r5eb
> +
> +#
> +# Logic
> +# -----
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc           logic/test_msa_and_v.c    =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_and_v_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc           logic/test_msa_nor_v.c    =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_nor_v_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc           logic/test_msa_or_v.c     =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_or_v_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc           logic/test_msa_xor_v.c    =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_xor_v_32r5eb
> +
> +#
> +# Move
> +# ----
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            move/test_msa_move_v.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_move_v_32r5eb
> +
> +#
> +# Pack
> +# ----
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_pckev_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pckev_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_pckev_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pckev_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_pckev_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pckev_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_pckev_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pckev_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_pckod_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pckod_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_pckod_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pckod_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_pckod_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pckod_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_pckod_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pckod_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_vshf_b.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_vshf_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_vshf_h.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_vshf_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_vshf_w.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_vshf_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_vshf_d.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_vshf_d_32r5eb
> +
> +#
> +# Shift
> +# -----
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_sll_b.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_sll_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_sll_h.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_sll_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_sll_w.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_sll_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_sll_d.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_sll_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_sra_b.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_sra_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_sra_h.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_sra_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_sra_w.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_sra_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_sra_d.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_sra_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srar_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srar_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srar_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srar_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srar_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srar_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srar_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srar_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srl_b.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srl_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srl_h.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srl_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srl_w.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srl_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srl_d.c   =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srl_d_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srlr_b.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srlr_b_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srlr_h.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srlr_h_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srlr_w.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srlr_w_32r5eb
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srlr_d.c  =
       \
> +-EB -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srlr_d_32r5eb
> diff --git a/tests/tcg/mips/user/ase/msa/test_msa_compile_32r5el.sh b/tes=
ts/tcg/mips/user/ase/msa/test_msa_compile_32r5el.sh
> new file mode 100755
> index 0000000..048b30b
> --- /dev/null
> +++ b/tests/tcg/mips/user/ase/msa/test_msa_compile_32r5el.sh
> @@ -0,0 +1,917 @@
> +
> +#
> +# Bit Count
> +# ---------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_nloc_b.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_nloc_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_nloc_h.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_nloc_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_nloc_w.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_nloc_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_nloc_d.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_nloc_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_nlzc_b.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_nlzc_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_nlzc_h.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_nlzc_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_nlzc_w.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_nlzc_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_nlzc_d.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_nlzc_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_pcnt_b.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pcnt_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_pcnt_h.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pcnt_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_pcnt_w.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pcnt_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc       bit-count/test_msa_pcnt_d.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pcnt_d_32r5el
> +
> +#
> +# Bit move
> +# --------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_binsl_b.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_binsl_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_binsl_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_binsl_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_binsl_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_binsl_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_binsl_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_binsl_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_binsr_b.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_binsr_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_binsr_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_binsr_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_binsr_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_binsr_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_binsr_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_binsr_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_bmnz_v.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bmnz_v_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_bmz_v.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bmz_v_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-move/test_msa_bsel_v.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bsel_v_32r5el
> +
> +#
> +# Bit Set
> +# -------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bclr_b.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bclr_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bclr_h.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bclr_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bclr_w.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bclr_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bclr_d.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bclr_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bneg_b.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bneg_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bneg_h.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bneg_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bneg_w.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bneg_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bneg_d.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bneg_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bset_b.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bset_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bset_h.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bset_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bset_w.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bset_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         bit-set/test_msa_bset_d.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_bset_d_32r5el
> +
> +#
> +# Fixed Multiply
> +# --------------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_madd_q_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_madd_q_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_madd_q_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_madd_q_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_maddr_q_h.c=
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_maddr_q_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_maddr_q_w.c=
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_maddr_q_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_msub_q_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_msub_q_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_msub_q_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_msub_q_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_msubr_q_h.c=
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_msubr_q_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_msubr_q_w.c=
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_msubr_q_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mul_q_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mul_q_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_mulr_q_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mulr_q_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc  fixed-multiply/test_msa_mulr_q_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mulr_q_w_32r5el
> +
> +#
> +# Float Max Min
> +# -------------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc   float-max-min/test_msa_fmax_a_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_fmax_a_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc   float-max-min/test_msa_fmax_a_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_fmax_a_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc   float-max-min/test_msa_fmax_w.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_fmax_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc   float-max-min/test_msa_fmax_d.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_fmax_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc   float-max-min/test_msa_fmin_a_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_fmin_a_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc   float-max-min/test_msa_fmin_a_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_fmin_a_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc   float-max-min/test_msa_fmin_w.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_fmin_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc   float-max-min/test_msa_fmin_d.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_fmin_d_32r5el
> +
> +#
> +# Int Add
> +# -------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_add_a_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_add_a_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_add_a_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_add_a_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_add_a_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_add_a_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_add_a_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_add_a_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_a_b.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_a_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_a_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_a_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_a_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_a_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_a_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_a_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_s_b.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_s_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_s_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_s_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_s_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_s_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_s_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_s_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_u_b.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_u_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_u_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_u_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_u_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_u_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_adds_u_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_adds_u_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_addv_b.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_addv_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_addv_h.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_addv_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_addv_w.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_addv_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_addv_d.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_addv_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_hadd_s_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hadd_s_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_hadd_s_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hadd_s_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_hadd_s_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hadd_s_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_hadd_u_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hadd_u_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_hadd_u_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hadd_u_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc         int-add/test_msa_hadd_u_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hadd_u_d_32r5el
> +
> +#
> +# Int Average
> +# -----------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_ave_s_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ave_s_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_ave_s_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ave_s_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_ave_s_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ave_s_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_ave_s_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ave_s_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_ave_u_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ave_u_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_ave_u_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ave_u_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_ave_u_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ave_u_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_ave_u_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ave_u_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_aver_s_b.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_aver_s_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_aver_s_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_aver_s_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_aver_s_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_aver_s_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_aver_s_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_aver_s_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_aver_u_b.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_aver_u_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_aver_u_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_aver_u_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_aver_u_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_aver_u_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-average/test_msa_aver_u_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_aver_u_d_32r5el
> +
> +#
> +# Int Compare
> +# -----------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_ceq_b.c    =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ceq_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_ceq_h.c    =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ceq_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_ceq_w.c    =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ceq_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_ceq_d.c    =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ceq_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_cle_s_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_cle_s_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_cle_s_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_cle_s_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_cle_s_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_cle_s_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_cle_s_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_cle_s_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_cle_u_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_cle_u_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_cle_u_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_cle_u_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_cle_u_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_cle_u_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_cle_u_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_cle_u_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_clt_s_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_clt_s_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_clt_s_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_clt_s_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_clt_s_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_clt_s_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_clt_s_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_clt_s_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_clt_u_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_clt_u_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_clt_u_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_clt_u_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_clt_u_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_clt_u_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-compare/test_msa_clt_u_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_clt_u_d_32r5el
> +
> +#
> +# Int Divide
> +# ----------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-divide/test_msa_div_s_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_div_s_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-divide/test_msa_div_s_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_div_s_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-divide/test_msa_div_s_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_div_s_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-divide/test_msa_div_s_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_div_s_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-divide/test_msa_div_u_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_div_u_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-divide/test_msa_div_u_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_div_u_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-divide/test_msa_div_u_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_div_u_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-divide/test_msa_div_u_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_div_u_d_32r5el
> +
> +#
> +# Int Dot Product
> +# ---------------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dotp_s_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dotp_s_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dotp_s_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dotp_s_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dotp_s_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dotp_s_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dotp_u_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dotp_u_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dotp_u_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dotp_u_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dotp_u_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dotp_u_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_h.c=
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpadd_s_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_w.c=
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpadd_s_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_d.c=
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpadd_s_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_h.c=
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpadd_u_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_w.c=
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpadd_u_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_d.c=
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpadd_u_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_h.c=
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpsub_s_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_w.c=
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpsub_s_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_d.c=
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpsub_s_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_h.c=
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpsub_u_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_w.c=
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpsub_u_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_d.c=
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_dpsub_u_d_32r5el
> +
> +#
> +# Int Max Min
> +# -----------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_a_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_a_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_a_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_a_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_a_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_a_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_a_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_a_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_s_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_s_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_s_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_s_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_s_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_s_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_s_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_s_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_u_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_u_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_u_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_u_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_u_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_u_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_max_u_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_max_u_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_a_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_a_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_a_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_a_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_a_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_a_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_a_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_a_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_s_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_s_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_s_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_s_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_s_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_s_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_s_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_s_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_u_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_u_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_u_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_u_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_u_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_u_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc     int-max-min/test_msa_min_u_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_min_u_d_32r5el
> +
> +#
> +# Int Modulo
> +# ----------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-modulo/test_msa_mod_s_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mod_s_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-modulo/test_msa_mod_s_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mod_s_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-modulo/test_msa_mod_s_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mod_s_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-modulo/test_msa_mod_s_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mod_s_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-modulo/test_msa_mod_u_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mod_u_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-modulo/test_msa_mod_u_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mod_u_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-modulo/test_msa_mod_u_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mod_u_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      int-modulo/test_msa_mod_u_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mod_u_d_32r5el
> +
> +#
> +# Int Multiply
> +# ------------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_maddv_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_maddv_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_maddv_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_maddv_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_maddv_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_maddv_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_maddv_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_maddv_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_msubv_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_msubv_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_msubv_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_msubv_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_msubv_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_msubv_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_msubv_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_msubv_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_mulv_b.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mulv_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_mulv_h.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mulv_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_mulv_w.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mulv_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-multiply/test_msa_mulv_d.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_mulv_d_32r5el
> +
> +#
> +# Int Subtract
> +# ------------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_asub_s_b.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_asub_s_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_asub_s_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_asub_s_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_asub_s_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_asub_s_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_asub_s_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_asub_s_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_asub_u_b.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_asub_u_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_asub_u_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_asub_u_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_asub_u_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_asub_u_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_asub_u_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_asub_u_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_hsub_s_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hsub_s_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_hsub_s_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hsub_s_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_hsub_s_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hsub_s_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_hsub_u_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hsub_u_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_hsub_u_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hsub_u_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_hsub_u_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_hsub_u_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subs_s_b.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subs_s_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subs_s_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subs_s_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subs_s_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subs_s_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subs_s_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subs_s_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subs_u_b.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subs_u_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subs_u_h.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subs_u_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subs_u_w.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subs_u_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subs_u_d.c =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subs_u_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subsus_u_b.=
c      \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subsus_u_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subsus_u_h.=
c      \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subsus_u_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subsus_u_w.=
c      \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subsus_u_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subsus_u_d.=
c      \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subsus_u_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_b.=
c      \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subsuu_s_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_h.=
c      \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subsuu_s_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_w.=
c      \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subsuu_s_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_d.=
c      \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subsuu_s_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subv_b.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subv_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subv_h.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subv_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subv_w.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subv_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc    int-subtract/test_msa_subv_d.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_subv_d_32r5el
> +
> +#
> +# Interleave
> +# ----------
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvev_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvev_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvev_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvev_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvev_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvev_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvev_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvev_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvod_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvod_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvod_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvod_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvod_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvod_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvod_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvod_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvl_b.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvl_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvl_h.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvl_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvl_w.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvl_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvl_d.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvl_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvr_b.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvr_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvr_h.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvr_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvr_w.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvr_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc      interleave/test_msa_ilvr_d.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_ilvr_d_32r5el
> +
> +#
> +# Logic
> +# -----
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc           logic/test_msa_and_v.c    =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_and_v_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc           logic/test_msa_nor_v.c    =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_nor_v_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc           logic/test_msa_or_v.c     =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_or_v_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc           logic/test_msa_xor_v.c    =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_xor_v_32r5el
> +
> +#
> +# Move
> +# ----
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            move/test_msa_move_v.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_move_v_32r5el
> +
> +#
> +# Pack
> +# ----
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_pckev_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pckev_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_pckev_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pckev_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_pckev_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pckev_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_pckev_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pckev_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_pckod_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pckod_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_pckod_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pckod_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_pckod_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pckod_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_pckod_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_pckod_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_vshf_b.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_vshf_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_vshf_h.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_vshf_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_vshf_w.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_vshf_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            pack/test_msa_vshf_d.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_vshf_d_32r5el
> +
> +#
> +# Shift
> +# -----
> +#
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_sll_b.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_sll_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_sll_h.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_sll_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_sll_w.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_sll_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_sll_d.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_sll_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_sra_b.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_sra_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_sra_h.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_sra_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_sra_w.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_sra_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_sra_d.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_sra_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srar_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srar_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srar_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srar_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srar_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srar_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srar_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srar_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srl_b.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srl_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srl_h.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srl_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srl_w.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srl_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srl_d.c   =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srl_d_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srlr_b.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srlr_b_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srlr_h.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srlr_h_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srlr_w.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srlr_w_32r5el
> +/opt/mti/bin/mips-mti-linux-gnu-gcc            shift/test_msa_srlr_d.c  =
       \
> +-EL -static -mabi=3D32 -march=3Dmips32r5 -mmsa -mno-odd-spreg -mfp64 -mn=
an=3D2008 -o \
> +      /tmp/test_msa_srlr_d_32r5el
> diff --git a/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.sh b/tes=
ts/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.sh
> deleted file mode 100755
> index 2519213..0000000
> --- a/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.sh
> +++ /dev/null
> @@ -1,643 +0,0 @@
> -
> -#
> -# Bit Count
> -# ---------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_b.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_nloc_b_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_h.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_nloc_h_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_w.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_nloc_w_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_d.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_nloc_d_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_b.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_nlzc_b_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_h.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_nlzc_h_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_w.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_nlzc_w_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_d.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_nlzc_d_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_b.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pcnt_b_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_h.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pcnt_h_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_w.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pcnt_w_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_d.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pcnt_d_=
32r6eb
> -
> -#
> -# Bit move
> -# --------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_b.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_binsl_=
b_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_binsl_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_binsl_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_binsl_=
d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_b.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_binsr_=
b_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_binsr_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_binsr_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_binsr_=
d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_bmnz_v.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_bmnz_v=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_bmz_v.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_bmz_v_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_bsel_v.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_bsel_v=
_32r6eb
> -
> -#
> -# Bit Set
> -# -------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_b.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bclr_b_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_h.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bclr_h_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_w.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bclr_w_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_d.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bclr_d_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_b.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bneg_b_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_h.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bneg_h_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_w.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bneg_w_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_d.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bneg_d_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_b.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bset_b_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_h.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bset_h_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_w.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bset_w_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_d.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bset_d_=
32r6eb
> -
> -#
> -# Fixed Multiply
> -# --------------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_madd_q_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_madd_q_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_madd_q_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_madd_q_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_maddr_q_h.c=
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_maddr_q=
_h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_maddr_q_w.c=
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_maddr_q=
_w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msub_q_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_msub_q_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msub_q_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_msub_q_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msubr_q_h.c=
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_msubr_q=
_h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msubr_q_w.c=
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_msubr_q=
_w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mul_q_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mul_q_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mulr_q_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mulr_q_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mulr_q_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mulr_q_=
w_32r6eb
> -
> -#
> -# Float Max Min
> -# -------------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmax_a_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_fmax_a_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmax_a_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_fmax_a_=
d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmax_w.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_fmax_w_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmax_d.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_fmax_d_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmin_a_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_fmin_a_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmin_a_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_fmin_a_=
d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmin_w.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_fmin_w_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmin_d.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_fmin_d_=
32r6eb
> -
> -#
> -# Int Add
> -# -------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_add_a_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_add_a_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_add_a_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_add_a_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_b.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_a_=
b_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_a_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_a_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_a_=
d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_b.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_s_=
b_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_s_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_s_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_s_=
d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_b.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_u_=
b_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_u_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_u_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_u_=
d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_b.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_addv_b_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_h.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_addv_h_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_w.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_addv_w_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_d.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_addv_d_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_s_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hadd_s_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_s_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hadd_s_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_s_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hadd_s_=
d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_u_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hadd_u_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_u_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hadd_u_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_u_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hadd_u_=
d_32r6eb
> -
> -#
> -# Int Average
> -# -----------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ave_s_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ave_s_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ave_s_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ave_s_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ave_u_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ave_u_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ave_u_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ave_u_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_b.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_aver_s_=
b_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_aver_s_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_aver_s_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_aver_s_=
d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_b.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_aver_u_=
b_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_aver_u_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_aver_u_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_aver_u_=
d_32r6eb
> -
> -#
> -# Int Compare
> -# -----------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_b.c    =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ceq_b_3=
2r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_h.c    =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ceq_h_3=
2r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_w.c    =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ceq_w_3=
2r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_d.c    =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ceq_d_3=
2r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_cle_s_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_cle_s_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_cle_s_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_cle_s_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_cle_u_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_cle_u_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_cle_u_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_cle_u_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_clt_s_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_clt_s_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_clt_s_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_clt_s_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_clt_u_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_clt_u_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_clt_u_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_clt_u_d=
_32r6eb
> -
> -#
> -# Int Divide
> -# ----------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_div_s_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_div_s_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_div_s_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_div_s_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_div_u_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_div_u_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_div_u_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_div_u_d=
_32r6eb
> -
> -#
> -# Int Dot Product
> -# ---------------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_s_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dotp_s_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_s_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dotp_s_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_s_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dotp_s_=
d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_u_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dotp_u_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_u_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dotp_u_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_u_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dotp_u_=
d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_h.c=
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpadd_s=
_h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_w.c=
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpadd_s=
_w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_d.c=
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpadd_s=
_d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_h.c=
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpadd_u=
_h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_w.c=
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpadd_u=
_w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_d.c=
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpadd_u=
_d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_h.c=
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpsub_s=
_h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_w.c=
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpsub_s=
_w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_d.c=
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpsub_s=
_d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_h.c=
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpsub_u=
_h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_w.c=
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpsub_u=
_w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_d.c=
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpsub_u=
_d_32r6eb
> -
> -#
> -# Int Max Min
> -# -----------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_a_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_a_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_a_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_a_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_s_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_s_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_s_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_s_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_u_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_u_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_u_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_u_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_a_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_a_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_a_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_a_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_s_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_s_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_s_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_s_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_u_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_u_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_u_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_u_d=
_32r6eb
> -
> -#
> -# Int Modulo
> -# ----------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mod_s_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mod_s_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mod_s_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mod_s_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mod_u_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mod_u_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mod_u_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mod_u_d=
_32r6eb
> -
> -#
> -# Int Multiply
> -# ------------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_maddv_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_maddv_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_maddv_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_maddv_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_msubv_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_msubv_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_msubv_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_msubv_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_b.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mulv_b_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_h.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mulv_h_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_w.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mulv_w_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_d.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mulv_d_=
32r6eb
> -
> -#
> -# Int Subtract
> -# ------------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_b.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_asub_s_=
b_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_asub_s_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_asub_s_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_asub_s_=
d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_b.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_asub_u_=
b_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_asub_u_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_asub_u_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_asub_u_=
d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_s_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hsub_s_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_s_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hsub_s_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_s_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hsub_s_=
d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_u_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hsub_u_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_u_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hsub_u_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_u_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hsub_u_=
d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_b.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subs_s_=
b_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subs_s_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subs_s_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subs_s_=
d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_b.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subs_u_=
b_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_h.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subs_u_=
h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_w.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subs_u_=
w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_d.c =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subs_u_=
d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_b.=
c      \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subsus_=
u_b_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_h.=
c      \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subsus_=
u_h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_w.=
c      \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subsus_=
u_w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_d.=
c      \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subsus_=
u_d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_b.=
c      \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subsuu_=
s_b_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_h.=
c      \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subsuu_=
s_h_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_w.=
c      \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subsuu_=
s_w_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_d.=
c      \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subsuu_=
s_d_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_b.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subv_b_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_h.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subv_h_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_w.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subv_w_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_d.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subv_d_=
32r6eb
> -
> -#
> -# Interleave
> -# ----------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvev_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvev_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvev_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvev_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvod_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvod_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvod_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvod_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_b.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvl_b_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_h.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvl_h_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_w.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvl_w_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_d.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvl_d_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_b.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvr_b_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_h.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvr_h_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_w.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvr_w_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_d.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvr_d_=
32r6eb
> -
> -#
> -# Logic
> -# -----
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_and_v.c    =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_and_v_3=
2r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_nor_v.c    =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_nor_v_3=
2r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_or_v.c     =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_or_v_32=
r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_xor_v.c    =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_xor_v_3=
2r6eb
> -
> -#
> -# Move
> -# ----
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc            move/test_msa_move_v.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_move_v_=
32r6eb
> -
> -#
> -# Pack
> -# ----
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pckev_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pckev_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pckev_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pckev_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pckod_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pckod_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pckod_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pckod_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_b.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_vshf_b_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_h.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_vshf_h_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_w.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_vshf_w_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_d.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_vshf_d_=
32r6eb
> -
> -#
> -# Shift
> -# -----
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_b.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_sll_b_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_h.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_sll_h_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_w.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_sll_w_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_d.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_sll_d_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_b.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_sra_b_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_h.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_sra_h_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_w.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_sra_w_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_d.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_sra_d_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srar_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srar_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srar_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srar_d=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_b.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srl_b_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_h.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srl_h_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_w.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srl_w_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_d.c   =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srl_d_=
32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_b.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srlr_b=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_h.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srlr_h=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_w.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srlr_w=
_32r6eb
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_d.c  =
       \
> --EB -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srlr_d=
_32r6eb
> diff --git a/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.sh b/tes=
ts/tcg/mips/user/ase/msa/test_msa_compile_32r6el.sh
> deleted file mode 100755
> index 1e10ff7..0000000
> --- a/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.sh
> +++ /dev/null
> @@ -1,643 +0,0 @@
> -
> -#
> -# Bit Count
> -# ---------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_b.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_nloc_b_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_h.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_nloc_h_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_w.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_nloc_w_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nloc_d.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_nloc_d_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_b.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_nlzc_b_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_h.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_nlzc_h_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_w.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_nlzc_w_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_nlzc_d.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_nlzc_d_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_b.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pcnt_b_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_h.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pcnt_h_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_w.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pcnt_w_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc       bit-count/test_msa_pcnt_d.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pcnt_d_=
32r6el
> -
> -#
> -# Bit move
> -# --------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_b.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_binsl_=
b_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_binsl_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_binsl_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_binsl_=
d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_b.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_binsr_=
b_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_binsr_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_binsr_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_binsr_=
d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_bmnz_v.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_bmnz_v=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_bmz_v.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_bmz_v_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_bsel_v.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_bsel_v=
_32r6el
> -
> -#
> -# Bit Set
> -# -------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_b.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bclr_b_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_h.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bclr_h_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_w.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bclr_w_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bclr_d.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bclr_d_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_b.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bneg_b_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_h.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bneg_h_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_w.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bneg_w_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bneg_d.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bneg_d_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_b.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bset_b_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_h.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bset_h_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_w.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bset_w_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         bit-set/test_msa_bset_d.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_bset_d_=
32r6el
> -
> -#
> -# Fixed Multiply
> -# --------------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_madd_q_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_madd_q_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_madd_q_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_madd_q_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_maddr_q_h.c=
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_maddr_q=
_h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_maddr_q_w.c=
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_maddr_q=
_w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msub_q_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_msub_q_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msub_q_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_msub_q_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msubr_q_h.c=
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_msubr_q=
_h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msubr_q_w.c=
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_msubr_q=
_w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mul_q_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mul_q_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mulr_q_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mulr_q_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mulr_q_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mulr_q_=
w_32r6el
> -
> -#
> -# Float Max Min
> -# -------------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmax_a_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_fmax_a_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmax_a_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_fmax_a_=
d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmax_w.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_fmax_w_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmax_d.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_fmax_d_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmin_a_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_fmin_a_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmin_a_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_fmin_a_=
d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmin_w.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_fmin_w_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc   float-max-min/test_msa_fmin_d.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_fmin_d_=
32r6el
> -
> -#
> -# Int Add
> -# -------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_add_a_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_add_a_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_add_a_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_add_a_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_add_a_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_b.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_a_=
b_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_a_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_a_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_a_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_a_=
d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_b.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_s_=
b_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_s_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_s_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_s_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_s_=
d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_b.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_u_=
b_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_u_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_u_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_adds_u_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_adds_u_=
d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_b.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_addv_b_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_h.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_addv_h_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_w.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_addv_w_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_addv_d.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_addv_d_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_s_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hadd_s_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_s_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hadd_s_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_s_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hadd_s_=
d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_u_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hadd_u_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_u_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hadd_u_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc         int-add/test_msa_hadd_u_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hadd_u_=
d_32r6el
> -
> -#
> -# Int Average
> -# -----------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ave_s_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ave_s_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ave_s_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_s_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ave_s_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ave_u_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ave_u_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ave_u_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_ave_u_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ave_u_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_b.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_aver_s_=
b_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_aver_s_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_aver_s_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_s_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_aver_s_=
d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_b.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_aver_u_=
b_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_aver_u_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_aver_u_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-average/test_msa_aver_u_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_aver_u_=
d_32r6el
> -
> -#
> -# Int Compare
> -# -----------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_b.c    =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ceq_b_3=
2r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_h.c    =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ceq_h_3=
2r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_w.c    =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ceq_w_3=
2r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_ceq_d.c    =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ceq_d_3=
2r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_cle_s_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_cle_s_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_cle_s_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_s_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_cle_s_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_cle_u_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_cle_u_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_cle_u_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_cle_u_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_cle_u_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_clt_s_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_clt_s_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_clt_s_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_s_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_clt_s_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_clt_u_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_clt_u_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_clt_u_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-compare/test_msa_clt_u_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_clt_u_d=
_32r6el
> -
> -#
> -# Int Divide
> -# ----------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_div_s_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_div_s_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_div_s_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_s_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_div_s_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_div_u_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_div_u_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_div_u_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-divide/test_msa_div_u_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_div_u_d=
_32r6el
> -
> -#
> -# Int Dot Product
> -# ---------------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_s_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dotp_s_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_s_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dotp_s_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_s_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dotp_s_=
d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_u_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dotp_u_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_u_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dotp_u_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_u_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dotp_u_=
d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_h.c=
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpadd_s=
_h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_w.c=
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpadd_s=
_w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_d.c=
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpadd_s=
_d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_h.c=
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpadd_u=
_h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_w.c=
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpadd_u=
_w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_d.c=
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpadd_u=
_d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_h.c=
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpsub_s=
_h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_w.c=
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpsub_s=
_w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_d.c=
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpsub_s=
_d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_h.c=
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpsub_u=
_h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_w.c=
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpsub_u=
_w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_d.c=
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_dpsub_u=
_d_32r6el
> -
> -#
> -# Int Max Min
> -# -----------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_a_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_a_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_a_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_a_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_a_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_s_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_s_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_s_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_s_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_s_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_u_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_u_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_u_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_max_u_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_max_u_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_a_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_a_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_a_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_a_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_a_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_s_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_s_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_s_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_s_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_s_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_u_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_u_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_u_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc     int-max-min/test_msa_min_u_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_min_u_d=
_32r6el
> -
> -#
> -# Int Modulo
> -# ----------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mod_s_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mod_s_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mod_s_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_s_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mod_s_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mod_u_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mod_u_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mod_u_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      int-modulo/test_msa_mod_u_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mod_u_d=
_32r6el
> -
> -#
> -# Int Multiply
> -# ------------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_maddv_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_maddv_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_maddv_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_maddv_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_msubv_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_msubv_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_msubv_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_msubv_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_b.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mulv_b_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_h.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mulv_h_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_w.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mulv_w_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_d.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_mulv_d_=
32r6el
> -
> -#
> -# Int Subtract
> -# ------------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_b.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_asub_s_=
b_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_asub_s_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_asub_s_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_s_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_asub_s_=
d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_b.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_asub_u_=
b_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_asub_u_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_asub_u_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_asub_u_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_asub_u_=
d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_s_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hsub_s_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_s_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hsub_s_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_s_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hsub_s_=
d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_u_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hsub_u_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_u_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hsub_u_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_hsub_u_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_hsub_u_=
d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_b.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subs_s_=
b_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subs_s_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subs_s_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_s_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subs_s_=
d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_b.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subs_u_=
b_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_h.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subs_u_=
h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_w.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subs_u_=
w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subs_u_d.c =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subs_u_=
d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_b.=
c      \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subsus_=
u_b_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_h.=
c      \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subsus_=
u_h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_w.=
c      \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subsus_=
u_w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsus_u_d.=
c      \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subsus_=
u_d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_b.=
c      \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subsuu_=
s_b_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_h.=
c      \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subsuu_=
s_h_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_w.=
c      \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subsuu_=
s_w_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subsuu_s_d.=
c      \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subsuu_=
s_d_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_b.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subv_b_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_h.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subv_h_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_w.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subv_w_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc    int-subtract/test_msa_subv_d.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_subv_d_=
32r6el
> -
> -#
> -# Interleave
> -# ----------
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvev_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvev_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvev_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvev_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvev_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvod_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvod_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvod_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvod_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvod_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_b.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvl_b_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_h.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvl_h_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_w.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvl_w_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvl_d.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvl_d_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_b.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvr_b_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_h.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvr_h_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_w.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvr_w_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc      interleave/test_msa_ilvr_d.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_ilvr_d_=
32r6el
> -
> -#
> -# Logic
> -# -----
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_and_v.c    =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_and_v_3=
2r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_nor_v.c    =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_nor_v_3=
2r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_or_v.c     =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_or_v_32=
r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc           logic/test_msa_xor_v.c    =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_xor_v_3=
2r6el
> -
> -#
> -# Move
> -# ----
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc            move/test_msa_move_v.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_move_v_=
32r6el
> -
> -#
> -# Pack
> -# ----
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pckev_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pckev_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pckev_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckev_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pckev_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pckod_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pckod_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pckod_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_pckod_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_pckod_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_b.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_vshf_b_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_h.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_vshf_h_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_w.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_vshf_w_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            pack/test_msa_vshf_d.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o  /tmp/test_msa_vshf_d_=
32r6el
> -
> -#
> -# Shift
> -# -----
> -#
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_b.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_sll_b_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_h.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_sll_h_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_w.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_sll_w_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sll_d.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_sll_d_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_b.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_sra_b_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_h.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_sra_h_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_w.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_sra_w_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_sra_d.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_sra_d_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srar_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srar_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srar_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srar_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srar_d=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_b.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srl_b_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_h.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srl_h_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_w.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srl_w_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srl_d.c   =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srl_d_=
32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_b.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srlr_b=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_h.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srlr_h=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_w.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srlr_w=
_32r6el
> -/opt/img/bin/mips-img-linux-gnu-gcc            shift/test_msa_srlr_d.c  =
       \
> --EL -static -mabi=3D32 -march=3Dmips32r6 -mmsa -o   /tmp/test_msa_srlr_d=
_32r6el
> diff --git a/tests/tcg/mips/user/ase/msa/test_msa_run_32r5eb.sh b/tests/t=
cg/mips/user/ase/msa/test_msa_run_32r5eb.sh
> new file mode 100755
> index 0000000..32dbf31
> --- /dev/null
> +++ b/tests/tcg/mips/user/ase/msa/test_msa_run_32r5eb.sh
> @@ -0,0 +1,371 @@
> +PATH_TO_QEMU=3D"../../../../../../mips-linux-user/qemu-mips"
> +
> +
> +#
> +# Bit Count
> +# ---------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_nloc_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_nloc_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_nloc_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_nloc_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_nlzc_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_nlzc_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_nlzc_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_nlzc_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pcnt_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pcnt_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pcnt_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pcnt_d_32r5eb
> +
> +#
> +# Bit move
> +# --------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_binsl_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_binsl_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_binsl_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_binsl_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_binsr_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_binsr_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_binsr_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_binsr_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bmnz_v_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bmz_v_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bsel_v_32r5eb
> +
> +#
> +# Bit Set
> +# -------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bclr_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bclr_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bclr_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bclr_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bneg_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bneg_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bneg_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bneg_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bset_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bset_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bset_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bset_d_32r5eb
> +
> +#
> +# Fixed Multiply
> +# --------------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_madd_q_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_madd_q_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_maddr_q_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_maddr_q_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_msub_q_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_msub_q_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_msubr_q_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_msubr_q_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mul_q_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mul_q_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mulr_q_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mulr_q_w_32r5eb
> +
> +#
> +# Float Max Min
> +# -------------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_fmax_a_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_fmax_a_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_fmax_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_fmax_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_fmin_a_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_fmin_a_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_fmin_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_fmin_d_32r5eb
> +
> +#
> +# Int Add
> +# -------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_add_a_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_add_a_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_add_a_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_add_a_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_a_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_a_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_a_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_a_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_s_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_s_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_s_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_s_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_u_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_u_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_u_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_u_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_addv_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_addv_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_addv_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_addv_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hadd_s_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hadd_s_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hadd_s_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hadd_u_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hadd_u_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hadd_u_d_32r5eb
> +
> +#
> +# Int Average
> +# -----------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ave_s_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ave_s_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ave_s_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ave_s_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ave_u_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ave_u_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ave_u_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ave_u_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_aver_s_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_aver_s_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_aver_s_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_aver_s_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_aver_u_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_aver_u_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_aver_u_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_aver_u_d_32r5eb
> +
> +#
> +# Int Compare
> +# -----------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ceq_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ceq_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ceq_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ceq_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_cle_s_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_cle_s_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_cle_s_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_cle_s_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_cle_u_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_cle_u_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_cle_u_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_cle_u_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_clt_s_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_clt_s_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_clt_s_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_clt_s_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_clt_u_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_clt_u_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_clt_u_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_clt_u_d_32r5eb
> +
> +#
> +# Int Divide
> +# ----------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_div_s_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_div_s_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_div_s_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_div_s_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_div_u_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_div_u_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_div_u_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_div_u_d_32r5eb
> +
> +#
> +# Int Dot Product
> +# ---------------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dotp_s_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dotp_s_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dotp_s_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dotp_u_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dotp_u_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dotp_u_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpadd_s_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpadd_s_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpadd_s_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpadd_u_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpadd_u_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpadd_u_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpsub_s_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpsub_s_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpsub_s_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpsub_u_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpsub_u_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpsub_u_d_32r5eb
> +
> +#
> +# Int Max Min
> +# -----------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_a_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_a_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_a_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_a_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_s_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_s_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_s_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_s_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_u_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_u_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_u_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_u_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_a_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_a_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_a_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_a_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_s_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_s_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_s_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_s_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_u_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_u_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_u_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_u_d_32r5eb
> +
> +#
> +# Int Modulo
> +# ----------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mod_s_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mod_s_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mod_s_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mod_s_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mod_u_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mod_u_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mod_u_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mod_u_d_32r5eb
> +
> +#
> +# Int Multiply
> +# ------------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_maddv_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_maddv_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_maddv_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_maddv_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_msubv_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_msubv_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_msubv_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_msubv_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mulv_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mulv_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mulv_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mulv_d_32r5eb
> +
> +#
> +# Int Subtract
> +# ------------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_asub_s_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_asub_s_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_asub_s_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_asub_s_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_asub_u_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_asub_u_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_asub_u_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_asub_u_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hsub_s_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hsub_s_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hsub_s_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hsub_u_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hsub_u_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hsub_u_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subs_s_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subs_s_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subs_s_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subs_s_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subs_u_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subs_u_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subs_u_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subs_u_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subsus_u_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subsus_u_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subsus_u_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subsus_u_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subsuu_s_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subsuu_s_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subsuu_s_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subsuu_s_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subv_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subv_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subv_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subv_d_32r5eb
> +
> +#
> +# Interleave
> +# ----------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvev_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvev_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvev_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvev_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvod_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvod_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvod_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvod_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvl_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvl_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvl_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvl_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvr_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvr_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvr_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvr_d_32r5eb
> +
> +#
> +# Logic
> +# -----
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_and_v_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_nor_v_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_or_v_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_xor_v_32r5eb
> +
> +#
> +# Move
> +# ----
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_move_v_32r5eb
> +
> +#
> +# Pack
> +# ----
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pckev_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pckev_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pckev_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pckev_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pckod_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pckod_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pckod_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pckod_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_vshf_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_vshf_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_vshf_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_vshf_d_32r5eb
> +
> +#
> +# Shift
> +# -----
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_sll_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_sll_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_sll_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_sll_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_sra_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_sra_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_sra_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_sra_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srar_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srar_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srar_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srar_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srl_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srl_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srl_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srl_d_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srlr_b_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srlr_h_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srlr_w_32r5eb
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srlr_d_32r5eb
> diff --git a/tests/tcg/mips/user/ase/msa/test_msa_run_32r5el.sh b/tests/t=
cg/mips/user/ase/msa/test_msa_run_32r5el.sh
> new file mode 100755
> index 0000000..a2e6092
> --- /dev/null
> +++ b/tests/tcg/mips/user/ase/msa/test_msa_run_32r5el.sh
> @@ -0,0 +1,371 @@
> +PATH_TO_QEMU=3D"../../../../../../mipsel-linux-user/qemu-mipsel"
> +
> +
> +#
> +# Bit Count
> +# ---------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_nloc_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_nloc_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_nloc_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_nloc_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_nlzc_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_nlzc_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_nlzc_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_nlzc_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pcnt_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pcnt_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pcnt_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pcnt_d_32r5el
> +
> +#
> +# Bit move
> +# --------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_binsl_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_binsl_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_binsl_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_binsl_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_binsr_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_binsr_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_binsr_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_binsr_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bmnz_v_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bmz_v_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bsel_v_32r5el
> +
> +#
> +# Bit Set
> +# -------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bclr_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bclr_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bclr_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bclr_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bneg_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bneg_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bneg_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bneg_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bset_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bset_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bset_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_bset_d_32r5el
> +
> +#
> +# Fixed Multiply
> +# --------------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_madd_q_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_madd_q_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_maddr_q_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_maddr_q_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_msub_q_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_msub_q_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_msubr_q_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_msubr_q_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mul_q_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mul_q_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mulr_q_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mulr_q_w_32r5el
> +
> +#
> +# Float Max Min
> +# -------------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_fmax_a_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_fmax_a_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_fmax_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_fmax_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_fmin_a_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_fmin_a_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_fmin_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_fmin_d_32r5el
> +
> +#
> +# Int Add
> +# -------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_add_a_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_add_a_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_add_a_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_add_a_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_a_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_a_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_a_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_a_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_s_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_s_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_s_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_s_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_u_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_u_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_u_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_adds_u_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_addv_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_addv_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_addv_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_addv_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hadd_s_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hadd_s_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hadd_s_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hadd_u_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hadd_u_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hadd_u_d_32r5el
> +
> +#
> +# Int Average
> +# -----------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ave_s_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ave_s_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ave_s_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ave_s_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ave_u_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ave_u_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ave_u_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ave_u_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_aver_s_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_aver_s_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_aver_s_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_aver_s_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_aver_u_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_aver_u_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_aver_u_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_aver_u_d_32r5el
> +
> +#
> +# Int Compare
> +# -----------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ceq_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ceq_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ceq_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ceq_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_cle_s_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_cle_s_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_cle_s_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_cle_s_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_cle_u_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_cle_u_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_cle_u_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_cle_u_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_clt_s_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_clt_s_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_clt_s_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_clt_s_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_clt_u_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_clt_u_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_clt_u_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_clt_u_d_32r5el
> +
> +#
> +# Int Divide
> +# ----------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_div_s_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_div_s_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_div_s_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_div_s_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_div_u_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_div_u_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_div_u_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_div_u_d_32r5el
> +
> +#
> +# Int Dot Product
> +# ---------------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dotp_s_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dotp_s_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dotp_s_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dotp_u_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dotp_u_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dotp_u_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpadd_s_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpadd_s_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpadd_s_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpadd_u_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpadd_u_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpadd_u_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpsub_s_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpsub_s_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpsub_s_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpsub_u_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpsub_u_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_dpsub_u_d_32r5el
> +
> +#
> +# Int Max Min
> +# -----------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_a_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_a_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_a_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_a_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_s_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_s_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_s_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_s_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_u_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_u_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_u_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_max_u_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_a_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_a_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_a_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_a_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_s_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_s_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_s_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_s_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_u_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_u_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_u_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_min_u_d_32r5el
> +
> +#
> +# Int Modulo
> +# ----------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mod_s_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mod_s_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mod_s_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mod_s_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mod_u_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mod_u_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mod_u_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mod_u_d_32r5el
> +
> +#
> +# Int Multiply
> +# ------------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_maddv_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_maddv_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_maddv_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_maddv_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_msubv_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_msubv_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_msubv_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_msubv_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mulv_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mulv_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mulv_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_mulv_d_32r5el
> +
> +#
> +# Int Subtract
> +# ------------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_asub_s_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_asub_s_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_asub_s_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_asub_s_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_asub_u_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_asub_u_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_asub_u_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_asub_u_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hsub_s_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hsub_s_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hsub_s_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hsub_u_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hsub_u_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_hsub_u_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subs_s_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subs_s_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subs_s_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subs_s_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subs_u_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subs_u_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subs_u_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subs_u_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subsus_u_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subsus_u_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subsus_u_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subsus_u_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subsuu_s_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subsuu_s_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subsuu_s_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subsuu_s_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subv_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subv_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subv_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_subv_d_32r5el
> +
> +#
> +# Interleave
> +# ----------
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvev_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvev_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvev_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvev_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvod_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvod_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvod_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvod_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvl_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvl_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvl_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvl_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvr_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvr_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvr_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_ilvr_d_32r5el
> +
> +#
> +# Logic
> +# -----
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_and_v_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_nor_v_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_or_v_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_xor_v_32r5el
> +
> +#
> +# Move
> +# ----
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_move_v_32r5el
> +
> +#
> +# Pack
> +# ----
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pckev_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pckev_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pckev_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pckev_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pckod_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pckod_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pckod_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_pckod_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_vshf_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_vshf_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_vshf_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_vshf_d_32r5el
> +
> +#
> +# Shift
> +# -----
> +#
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_sll_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_sll_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_sll_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_sll_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_sra_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_sra_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_sra_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_sra_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srar_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srar_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srar_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srar_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srl_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srl_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srl_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srl_d_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srlr_b_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srlr_h_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srlr_w_32r5el
> +$PATH_TO_QEMU -cpu P5600  /tmp/test_msa_srlr_d_32r5el
> diff --git a/tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh b/tests/t=
cg/mips/user/ase/msa/test_msa_run_32r6eb.sh
> deleted file mode 100644
> index 6c95e45..0000000
> --- a/tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh
> +++ /dev/null
> @@ -1,371 +0,0 @@
> -PATH_TO_QEMU=3D"../../../../../../mips64-linux-user/qemu-mips64"
> -
> -
> -#
> -# Bit Count
> -# ---------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_d_32r6eb
> -
> -#
> -# Bit move
> -# --------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bmnz_v_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bmz_v_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bsel_v_32r6eb
> -
> -#
> -# Bit Set
> -# -------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_d_32r6eb
> -
> -#
> -# Fixed Multiply
> -# --------------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_madd_q_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_madd_q_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddr_q_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddr_q_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msub_q_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msub_q_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubr_q_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubr_q_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mul_q_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mul_q_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulr_q_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulr_q_w_32r6eb
> -
> -#
> -# Float Max Min
> -# -------------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_a_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_a_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_a_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_a_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_d_32r6eb
> -
> -#
> -# Int Add
> -# -------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_s_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_s_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_s_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_u_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_u_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_u_d_32r6eb
> -
> -#
> -# Int Average
> -# -----------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_d_32r6eb
> -
> -#
> -# Int Compare
> -# -----------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_d_32r6eb
> -
> -#
> -# Int Divide
> -# ----------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_d_32r6eb
> -
> -#
> -# Int Dot Product
> -# ---------------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_s_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_s_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_s_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_u_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_u_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_u_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_s_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_s_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_s_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_u_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_u_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_u_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_s_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_s_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_s_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_u_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_u_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_u_d_32r6eb
> -
> -#
> -# Int Max Min
> -# -----------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_d_32r6eb
> -
> -#
> -# Int Modulo
> -# ----------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_d_32r6eb
> -
> -#
> -# Int Multiply
> -# ------------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddv_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddv_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddv_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddv_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubv_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubv_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubv_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubv_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_d_32r6eb
> -
> -#
> -# Int Subtract
> -# ------------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_s_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_s_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_s_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_u_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_u_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_u_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_d_32r6eb
> -
> -#
> -# Interleave
> -# ----------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_d_32r6eb
> -
> -#
> -# Logic
> -# -----
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_and_v_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nor_v_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_or_v_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_xor_v_32r6eb
> -
> -#
> -# Move
> -# ----
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_move_v_32r6eb
> -
> -#
> -# Pack
> -# ----
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_d_32r6eb
> -
> -#
> -# Shift
> -# -----
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_d_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_b_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_h_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_w_32r6eb
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_d_32r6eb
> diff --git a/tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh b/tests/t=
cg/mips/user/ase/msa/test_msa_run_32r6el.sh
> deleted file mode 100755
> index d4945da..0000000
> --- a/tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh
> +++ /dev/null
> @@ -1,371 +0,0 @@
> -PATH_TO_QEMU=3D"../../../../../../mips64el-linux-user/qemu-mips64el"
> -
> -
> -#
> -# Bit Count
> -# ---------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nloc_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nlzc_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_d_32r6el
> -
> -#
> -# Bit move
> -# --------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bmnz_v_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bmz_v_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bsel_v_32r6el
> -
> -#
> -# Bit Set
> -# -------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bclr_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bneg_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_d_32r6el
> -
> -#
> -# Fixed Multiply
> -# --------------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_madd_q_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_madd_q_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddr_q_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddr_q_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msub_q_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msub_q_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubr_q_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubr_q_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mul_q_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mul_q_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulr_q_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulr_q_w_32r6el
> -
> -#
> -# Float Max Min
> -# -------------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_a_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_a_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmax_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_a_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_a_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_fmin_d_32r6el
> -
> -#
> -# Int Add
> -# -------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_add_a_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_a_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_s_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_adds_u_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_addv_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_s_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_s_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_s_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_u_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_u_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hadd_u_d_32r6el
> -
> -#
> -# Int Average
> -# -----------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_s_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ave_u_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_s_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_aver_u_d_32r6el
> -
> -#
> -# Int Compare
> -# -----------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ceq_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_s_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_cle_u_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_s_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_clt_u_d_32r6el
> -
> -#
> -# Int Divide
> -# ----------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_s_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_div_u_d_32r6el
> -
> -#
> -# Int Dot Product
> -# ---------------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_s_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_s_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_s_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_u_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_u_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_u_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_s_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_s_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_s_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_u_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_u_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_u_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_s_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_s_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_s_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_u_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_u_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_u_d_32r6el
> -
> -#
> -# Int Max Min
> -# -----------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_a_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_s_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_max_u_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_a_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_s_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_min_u_d_32r6el
> -
> -#
> -# Int Modulo
> -# ----------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_s_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mod_u_d_32r6el
> -
> -#
> -# Int Multiply
> -# ------------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddv_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddv_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddv_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddv_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubv_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubv_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubv_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubv_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulv_d_32r6el
> -
> -#
> -# Int Subtract
> -# ------------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_s_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_asub_u_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_s_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_s_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_s_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_u_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_u_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_hsub_u_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_s_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subs_u_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsus_u_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subsuu_s_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_subv_d_32r6el
> -
> -#
> -# Interleave
> -# ----------
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvev_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvod_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvl_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_ilvr_d_32r6el
> -
> -#
> -# Logic
> -# -----
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_and_v_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_nor_v_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_or_v_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_xor_v_32r6el
> -
> -#
> -# Move
> -# ----
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_move_v_32r6el
> -
> -#
> -# Pack
> -# ----
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckev_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pckod_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_vshf_d_32r6el
> -
> -#
> -# Shift
> -# -----
> -#
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sll_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_sra_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srar_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srl_d_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_b_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_h_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_w_32r6el
> -$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_srlr_d_32r6el
> --
> 2.7.4

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>


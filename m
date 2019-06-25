Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484F3C48BD6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B6C20656
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="q9m+xZ1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B6C20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60962 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfmdm-0001bW-78
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 10:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47549)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <arikalo@wavecomp.com>) id 1hfmZg-0007qS-2x
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hfmZd-0006Fr-7p
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:37:31 -0400
Received: from mail-eopbgr790115.outbound.protection.outlook.com
 ([40.107.79.115]:64512 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hfmZc-0006Ec-SE
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmVRmOEdXgun+DKFjtVk9jVfTPUpbfvSgKv93PHYUsc=;
 b=q9m+xZ1fNLT4uX1NSUjb/m49CZuhMMop9nzmQzXlnAjhAZCRQQ1f9lsenEJjCRkwTVcvDMObYJkbBCC/6my2j7K4N1JcX5x4qvQiXlDTdZEtd28fkcpb3xnL50h9OMwW6pU2eYGXgXYjU0ozpm3rkWtEsLwLm7b0Br+vohDiVL0=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0155.namprd22.prod.outlook.com (10.168.176.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 14:37:25 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::3579:1b6c:1f31:c6b9]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::3579:1b6c:1f31:c6b9%7]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 14:37:25 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v5 0/6] target/mips: Improve MSA TCG tests
Thread-Index: AQHVK1Xyx/M13KWR80GuGfVEFx2Hnqasb6em
Date: Tue, 25 Jun 2019 14:37:25 +0000
Message-ID: <DM5PR22MB16588683F62D607C5BA67669D2E30@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1561467605-31065-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1561467605-31065-1-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b902ac29-6bfa-4ed7-b846-08d6f97aa462
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM5PR22MB0155; 
x-ms-traffictypediagnostic: DM5PR22MB0155:
x-microsoft-antispam-prvs: <DM5PR22MB0155E7E25A38A26AF8447F1FD2E30@DM5PR22MB0155.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:82;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(396003)(39850400004)(136003)(376002)(199004)(189003)(256004)(478600001)(7696005)(66446008)(66066001)(8676002)(81166006)(8936002)(81156014)(110136005)(86362001)(5660300002)(6436002)(52536014)(316002)(76176011)(2906002)(33656002)(107886003)(6116002)(3846002)(6246003)(66946007)(91956017)(14444005)(53936002)(486006)(102836004)(73956011)(76116006)(6606003)(4326008)(71190400001)(71200400001)(6506007)(186003)(2501003)(53546011)(74316002)(66476007)(26005)(55236004)(99286004)(446003)(229853002)(11346002)(7736002)(55016002)(54896002)(476003)(66556008)(14454004)(9686003)(19627405001)(25786009)(68736007)(64756008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0155;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xIU30ejnneXyh2oBleXiZtSxCBQ3en9kJ69iCSjGOMU4arvdlFiI7v5zUtGNlrcBAQ6fEFIdXWPjyJRauUf6cC1iwyKwhPHYZphim3xHggkXiQ3PGQ11GKzWDasUi2qNW3lYQT8ypM2mG28EiuijUTbwgGabZTP3ekloPDh8lEjmp1wYocJXrwet5swcO4M3KAQaTRIk7Rslf0JcmpZWjXbu1hKenwhMLIDFHHQPB9FDyoZuieWdXrzdfR1nHfsURzGLWqsrlnQIEBT4k5GtGDzK5ugQL1VygMd09C+ydSzF7EIdEtjQT2KDlRJSXd+qoSWrDLsOouaXpn7pnRfb8XOeDXK5hGxrtGHS8kqmnYOept3XXZWCqtWNkzpc7dFPu+IFuc3JlBFvtqMzLuo+LSp2RsayhHWOSSEnjFbwhCg=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b902ac29-6bfa-4ed7-b846-08d6f97aa462
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 14:37:25.7524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0155
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.115
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v5 0/6] target/mips: Improve MSA TCG tests
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Tuesday, June 25, 2019 2:59 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; Aleksandar Rikalo
> Subject: [PATCH v5 0/6] target/mips: Improve MSA TCG tests
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> This series contains various improvements and additions of MSA ASE
> TCG tests.
>
> v4->v5:
>
>   - added patch on MIPS32R6 support
>   - amended other patches
>
> v3->v4:
>
>   - patches 1 and 2 from v3 got reviewed and integrated into upstream,
>     so they are now removed in v4
>   - added tests for MSA int multiply instructions
>   - added support for MSA big-endian target testings
>   - amend4ed remainign patches
>   - rebased to the latest code
>
> v2->v3:
>
>   - added some tests from move group
>   - added some tests from int dot product group
>   - completed tests from bit move group
>
> v1->v2:
>
>   - added some tests from bit move group
>   - improved and updated commit messages
>
>
>
> Aleksandar Markovic (6):
>   tests/tcg: target/mips: Add tests for MSA bit move instructions
>   tests/tcg: target/mips: Add tests for MSA move instructions
>   tests/tcg: target/mips: Amend tests for MSA int dot product
>     instructions
>   tests/tcg: target/mips: Amend tests for MSA int multiply instructions
>   tests/tcg: target/mips: Add support for MSA big-endian target testings
>   tests/tcg: target/mips: Add support for MSA MIPS32R6 testings
>
>  tests/tcg/mips/include/wrappers_msa.h              |  96 +++-
>  .../mips/user/ase/msa/bit-move/test_msa_binsl_b.c  | 214 +++++++
>  .../mips/user/ase/msa/bit-move/test_msa_binsl_d.c  | 214 +++++++
>  .../mips/user/ase/msa/bit-move/test_msa_binsl_h.c  | 214 +++++++
>  .../mips/user/ase/msa/bit-move/test_msa_binsl_w.c  | 214 +++++++
>  .../mips/user/ase/msa/bit-move/test_msa_binsr_b.c  | 214 +++++++
>  .../mips/user/ase/msa/bit-move/test_msa_binsr_d.c  | 214 +++++++
>  .../mips/user/ase/msa/bit-move/test_msa_binsr_h.c  | 214 +++++++
>  .../mips/user/ase/msa/bit-move/test_msa_binsr_w.c  | 214 +++++++
>  .../mips/user/ase/msa/bit-move/test_msa_bmnz_v.c   | 214 +++++++
>  .../mips/user/ase/msa/bit-move/test_msa_bmz_v.c    | 214 +++++++
>  .../mips/user/ase/msa/bit-move/test_msa_bsel_v.c   | 214 +++++++
>  .../ase/msa/int-dot-product/test_msa_dpadd_s_d.c   | 214 +++++++
>  .../ase/msa/int-dot-product/test_msa_dpadd_s_h.c   | 214 +++++++
>  .../ase/msa/int-dot-product/test_msa_dpadd_s_w.c   | 214 +++++++
>  .../ase/msa/int-dot-product/test_msa_dpadd_u_d.c   | 214 +++++++
>  .../ase/msa/int-dot-product/test_msa_dpadd_u_h.c   | 214 +++++++
>  .../ase/msa/int-dot-product/test_msa_dpadd_u_w.c   | 214 +++++++
>  .../ase/msa/int-dot-product/test_msa_dpsub_s_d.c   | 214 +++++++
>  .../ase/msa/int-dot-product/test_msa_dpsub_s_h.c   | 214 +++++++
>  .../ase/msa/int-dot-product/test_msa_dpsub_s_w.c   | 214 +++++++
>  .../ase/msa/int-dot-product/test_msa_dpsub_u_d.c   | 214 +++++++
>  .../ase/msa/int-dot-product/test_msa_dpsub_u_h.c   | 214 +++++++
>  .../ase/msa/int-dot-product/test_msa_dpsub_u_w.c   | 214 +++++++
>  .../user/ase/msa/int-multiply/test_msa_maddv_b.c   | 214 +++++++
>  .../user/ase/msa/int-multiply/test_msa_maddv_d.c   | 214 +++++++
>  .../user/ase/msa/int-multiply/test_msa_maddv_h.c   | 214 +++++++
>  .../user/ase/msa/int-multiply/test_msa_maddv_w.c   | 214 +++++++
>  .../user/ase/msa/int-multiply/test_msa_msubv_b.c   | 214 +++++++
>  .../user/ase/msa/int-multiply/test_msa_msubv_d.c   | 214 +++++++
>  .../user/ase/msa/int-multiply/test_msa_msubv_h.c   | 214 +++++++
>  .../user/ase/msa/int-multiply/test_msa_msubv_w.c   | 214 +++++++
>  tests/tcg/mips/user/ase/msa/move/test_msa_move_v.c | 149 +++++
>  .../mips/user/ase/msa/test_msa_compile_32r6eb.sh   | 627 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/test_msa_compile_32r6el.sh   | 627 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/test_msa_compile_64r6eb.sh   | 627 +++++++++++++++=
++++++
>  ...t_msa_compile.sh =3D> test_msa_compile_64r6el.sh} | 561 ++++++++++---=
-----
>  tests/tcg/mips/user/ase/msa/test_msa_run.sh        | 326 -----------
>  tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh | 363 ++++++++++++
>  tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh | 363 ++++++++++++
>  tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh | 363 ++++++++++++
>  tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh | 363 ++++++++++++
>  42 files changed, 10523 insertions(+), 576 deletions(-)
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_b=
.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_d=
.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_h=
.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_w=
.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_b=
.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_d=
.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_h=
.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_w=
.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmnz_v.=
c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmz_v.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_bsel_v.=
c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpadd_s_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpadd_s_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpadd_s_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpadd_u_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpadd_u_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpadd_u_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpsub_s_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpsub_s_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpsub_s_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpsub_u_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpsub_u_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpsub_u_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mad=
dv_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mad=
dv_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mad=
dv_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mad=
dv_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msu=
bv_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msu=
bv_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msu=
bv_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msu=
bv_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/move/test_msa_move_v.c
>  create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.s=
h
>  create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.s=
h
>  create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_64r6eb.s=
h
>  rename tests/tcg/mips/user/ase/msa/{test_msa_compile.sh =3D> test_msa_co=
mpile_64r6el.sh} (77%)
>  delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run.sh
>  create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh
>  create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh
>  create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh
>  create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh
>
> --
> 2.7.4

It's time to think of activating all MSA tests via "make check-tcg".
Otherwise, for the whole series:

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>


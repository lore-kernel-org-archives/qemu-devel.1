Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B4AC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D35206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="F3Xeqhgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D35206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhuQG-0003sX-Lv
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44324)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <arikalo@wavecomp.com>) id 1hhuNX-0001KV-Vn
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hhuNV-0003xm-Il
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:21:47 -0400
Received: from mail-eopbgr680105.outbound.protection.outlook.com
 ([40.107.68.105]:6393 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hhuNT-0003r2-Fe
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:21:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=HiS8+qO1V4C1pDEG+ZgWd0tSeQqjWSjHdJFs5lkQV5smOBmaOD6eaWHIlwsMQ86Jo1MdDG7bFKUZC3hM8J8ZGWqxt2xA+k4mFvQKKGM8m+1q6lKQV4Ol+qr/5wPLTTzHoAmxNIC2zRwyyK5gZU/AYLgp0c/Ns+C4yAtO3jqvn+E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uyy4XRXXrkERjZzj03/2OCXlOI8WfW1gO2+Iefdf75Q=;
 b=eOVs4RH9k5z22vUOi3NXRZLNofBo2R0PdHgLD13EfCH6HDJ/75WCOUHHBNq2sB9FvfElLdnx9HlVsNsRwjGTIW9CaDd54mpPvAYrf842O+JjKYhW+IoRn7bUpb0y4gRleYOU6wiiDtc8rNBlKYQQxGtJpW3q949tnDc9XGbpnZU=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uyy4XRXXrkERjZzj03/2OCXlOI8WfW1gO2+Iefdf75Q=;
 b=F3XeqhgmDoUekTaE+XAGTFgEHJxXDB+RJZPkMXwGUBroFgkD41fh6I/fXAqRcegGlqGC8NoCXtQKQbs88akebAFytKeBdkMx/KhJ7+ydKyJbib7GKq61/tN+PAfLQIQv7NeznQDZeCnw+rd8jeDY2o6D46trxiZNatnyJo4KjsY=
Received: from BN6PR22MB1649.namprd22.prod.outlook.com (10.161.157.39) by
 BN6PR22MB0980.namprd22.prod.outlook.com (10.171.180.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 1 Jul 2019 11:21:37 +0000
Received: from BN6PR22MB1649.namprd22.prod.outlook.com
 ([fe80::906f:605c:2ab:b05b]) by BN6PR22MB1649.namprd22.prod.outlook.com
 ([fe80::906f:605c:2ab:b05b%3]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 11:21:37 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 0/7] target/mips: Mips improvements for 4.1
Thread-Index: AQHVL/zRwkRdqoJnC06+hM4vTyQpQaa1naNp
Date: Mon, 1 Jul 2019 11:21:36 +0000
Message-ID: <BN6PR22MB1649A8F1EA43D27DAD062B21D2F90@BN6PR22MB1649.namprd22.prod.outlook.com>
References: <1561979080-26195-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1561979080-26195-1-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 526a8c2c-6b56-48f6-4acc-08d6fe164833
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR22MB0980; 
x-ms-traffictypediagnostic: BN6PR22MB0980:
x-microsoft-antispam-prvs: <BN6PR22MB098015ADC0C39CBDC524869CD2F90@BN6PR22MB0980.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(39840400004)(346002)(366004)(376002)(199004)(189003)(229853002)(3846002)(73956011)(66446008)(66556008)(66476007)(91956017)(64756008)(66946007)(76116006)(2906002)(2501003)(6116002)(14444005)(86362001)(256004)(9686003)(5660300002)(446003)(11346002)(476003)(19627405001)(55016002)(54896002)(6436002)(478600001)(74316002)(52536014)(7736002)(68736007)(25786009)(53546011)(55236004)(186003)(26005)(6606003)(6506007)(8936002)(71200400001)(14454004)(71190400001)(4326008)(53936002)(316002)(99286004)(33656002)(6246003)(102836004)(8676002)(110136005)(81166006)(66066001)(76176011)(107886003)(486006)(7696005)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR22MB0980;
 H:BN6PR22MB1649.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5HEzziNKQ/TOlBlWLMR7EQ0+4N2rL4uEwnX1uRgyYcNFX96bQc69UUV0/4mmIelEFFbD6v9gPaLTV5nahPLVLOiPIfGcB1SR0OkFPB+t0sj8IAzCCeefJG1DCLIyw/ZL7YHVUdKMfHRMQjbGKVep7qV7GZdqGszKZPaf5JxwkZS/35Aa3V4RWb3U6JrxlGo5avUpnPOTQpTicKfw+JF45St00skSEodkysBYDY9lXtdgn/qD1f0U9DETc+1NuVbpiDFq0UHeK62BRGVWmBRJ6+OifE2DE2SMFKRKTp12dz//b7oGkyWb559DIHe+6CCg3CclUx5d2IxbRXnPEeTy20fM8DygcKBUK4xXy++Gqin3HG40ksUHwJXLzSUog9gp2oX0qJlXlSfybDg0E8ydVh/DtI4O8gPxNKVdHmmJ1z4=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526a8c2c-6b56-48f6-4acc-08d6fe164833
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 11:21:37.0032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR22MB0980
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.105
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 0/7] target/mips: Mips improvements for 4.1
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
> Sent: Monday, July 1, 2019 1:04 PM
> To: qemu-devel@nongnu.org; Aleksandar Rikalo
> Cc: Aleksandar Markovic
> Subject: [PATCH 0/7] target/mips: Mips improvements for 4.1
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> A collection of misc MIPS improvements that would be nice to be
> integrated into 4.1.
>
> Aleksandar Markovic (7):
>   tcg/tests: target/mips: Amend MSA fixed point multiply tests
>   tcg/tests: target/mips: Amend MSA integer multiply tests
>   target/mips: Correct comments in msa_helper.c
>   target/mips: Correct comments in translate.c
>   tcg/tests: target/mips: Correct MSA test compilation and execution
>     order
>   target/mips: Unroll loops for MSA float max/min instructions
>   target/mips: Correct helper for MSA FCLASS.<W|D> instructions
>
>  target/mips/msa_helper.c                           | 244 ++++++++++-----
>  target/mips/translate.c                            | 347 +++++++++++++--=
------
>  tests/tcg/mips/include/wrappers_msa.h              |  16 +
>  .../ase/msa/fixed-multiply/test_msa_madd_q_h.c     | 216 +++++++++++++
>  .../ase/msa/fixed-multiply/test_msa_madd_q_w.c     | 216 +++++++++++++
>  .../ase/msa/fixed-multiply/test_msa_maddr_q_h.c    | 216 +++++++++++++
>  .../ase/msa/fixed-multiply/test_msa_maddr_q_w.c    | 216 +++++++++++++
>  .../ase/msa/fixed-multiply/test_msa_msub_q_h.c     | 216 +++++++++++++
>  .../ase/msa/fixed-multiply/test_msa_msub_q_w.c     | 216 +++++++++++++
>  .../ase/msa/fixed-multiply/test_msa_msubr_q_h.c    | 216 +++++++++++++
>  .../ase/msa/fixed-multiply/test_msa_msubr_q_w.c    | 216 +++++++++++++
>  .../user/ase/msa/int-multiply/test_msa_maddv_b.c   | 224 ++++++-------
>  .../user/ase/msa/int-multiply/test_msa_maddv_d.c   | 214 ++++++-------
>  .../user/ase/msa/int-multiply/test_msa_maddv_h.c   | 224 ++++++-------
>  .../user/ase/msa/int-multiply/test_msa_maddv_w.c   | 224 ++++++-------
>  .../user/ase/msa/int-multiply/test_msa_msubv_b.c   | 224 ++++++-------
>  .../user/ase/msa/int-multiply/test_msa_msubv_d.c   | 224 ++++++-------
>  .../user/ase/msa/int-multiply/test_msa_msubv_h.c   | 224 ++++++-------
>  .../user/ase/msa/int-multiply/test_msa_msubv_w.c   | 224 ++++++-------
>  .../mips/user/ase/msa/test_msa_compile_32r6eb.sh   |  32 +-
>  .../mips/user/ase/msa/test_msa_compile_32r6el.sh   |  32 +-
>  .../mips/user/ase/msa/test_msa_compile_64r6eb.sh   |  32 +-
>  .../mips/user/ase/msa/test_msa_compile_64r6el.sh   |  32 +-
>  tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh |  16 +-
>  tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh |  16 +-
>  tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh |  16 +-
>  tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh |  16 +-
>  27 files changed, 3165 insertions(+), 1144 deletions(-)
>  create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_m=
add_q_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_m=
add_q_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_m=
addr_q_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_m=
addr_q_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_m=
sub_q_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_m=
sub_q_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_m=
subr_q_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_m=
subr_q_w.c
>
> --
> 2.7.4

In patch on translate.c it would be nice to fix all comment-related warning=
s.

Anyway:

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>


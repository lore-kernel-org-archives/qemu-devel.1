Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA9CC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:45:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE7026ADA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="qiSe0BLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE7026ADA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44695 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWin0-00075e-Vw
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:45:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1hWilw-0006a6-2K
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1hWilu-0001h4-Ku
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:44:44 -0400
Received: from mail-eopbgr810124.outbound.protection.outlook.com
	([40.107.81.124]:41774
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
	id 1hWils-0001cJ-U4
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=jT3AuSsamRZeYHs1jyyNk7WWBlKjK5x6B0AKctMUF4I=;
	b=qiSe0BLi21cWEQPy/ykiNKEwyDDWAnLN3uT6RYGgOo/GsVY7czNooNHjZc+b1gStT3t9iNLU1KHfYfgr/llA77s0qCTDSyK01Qu+T5ENPuSIvJrQzJksU8rEyE112DlMWAbUdq37MMQzbwa1aMyH3K1gs2VeVLLRuZiuExiSrDA=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
	DM5SPR00MB238.namprd22.prod.outlook.com (10.173.136.23) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.20; Fri, 31 May 2019 14:44:37 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
	([fe80::1037:fb85:b06:6dba]) by DM5PR22MB1658.namprd22.prod.outlook.com
	([fe80::1037:fb85:b06:6dba%7]) with mapi id 15.20.1922.021;
	Fri, 31 May 2019 14:44:37 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 4/5] tests/tcg: target/mips: Add tests for MSA bit set
	instructions
Thread-Index: AQHU9t8MItdkYEjU6EqeHUuEbWB0/KaFkMS3
Date: Fri, 31 May 2019 14:44:37 +0000
Message-ID: <DM5PR22MB165896490590DB7B9E005D74D2190@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1555699081-24577-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1555699081-24577-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1555699081-24577-5-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b476345b-ebcc-4cfe-cf85-08d6e5d68131
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:DM5SPR00MB238; 
x-ms-traffictypediagnostic: DM5SPR00MB238:
x-microsoft-antispam-prvs: <DM5SPR00MB238A112B666D5BC44183FE2D2190@DM5SPR00MB238.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(39840400004)(346002)(396003)(136003)(366004)(189003)(199004)(316002)(6606003)(53546011)(6506007)(91956017)(76176011)(7696005)(54906003)(66066001)(186003)(26005)(54896002)(68736007)(6436002)(9686003)(76116006)(2501003)(4326008)(6246003)(8936002)(107886003)(71200400001)(66476007)(66556008)(64756008)(66446008)(71190400001)(99286004)(73956011)(66946007)(86362001)(8676002)(81166006)(81156014)(478600001)(5660300002)(486006)(19627405001)(53936002)(25786009)(7736002)(52536014)(2906002)(33656002)(55016002)(102836004)(256004)(110136005)(55236004)(229853002)(446003)(11346002)(476003)(14454004)(3846002)(6116002)(74316002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM5SPR00MB238;
	H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /MYoUXk3LI83Rjylqdfb8VFb2NTxmHNKC9UELiGB82yl7WSEWQX78hVw8izU8U7lj7Mm94bqpShX9P28/0/SpQge2ufyyhT+7U3SwfQAG00yKhAPwzoTmnSSSPQ5PLCEaR5ngboBe4lmq2oDIg0q1DyRG4DTmHOIPe4Eznzph/xeuse1S2CsqREBKDCdJtXjnY66XwANhc4i4c/2QIdH364IkwXZOeuJXEPLSpgzRBOjGcjqcRLvBcyr0DSUyXPhrkfCtMPB895icgHQdu1fltQ5No/to20mVIbV0IBT0832jcQb5RujLoPiAUXTCxMlc3wDpWq26cgoJ872eFwArJ5waJL2RrGCB56epm9W9btUjY2IOHQa3atpR4lG2LLzC04gZbrwuTYq5IrEqx5elbspSqKaHsZwgGJc/wJmKd8=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b476345b-ebcc-4cfe-cf85-08d6e5d68131
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 14:44:37.1451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5SPR00MB238
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.124
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 4/5] tests/tcg: target/mips: Add tests for
 MSA bit set instructions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
	"aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Friday, April 19, 2019 8:38 PM
> To: qemu-devel@nongnu.org
> Cc: aurelien@aurel32.net; Aleksandar Markovic; Aleksandar Rikalo
> Subject: [PATCH 4/5] tests/tcg: target/mips: Add tests for MSA bit set in=
structions
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add tests for MSA bit set instructions. This includes following
> instructions:
>
>   * BCLR.B - clear bit (bytes)
>   * BCLR.H - clear bit (halfwords)
>   * BCLR.W - clear bit (words)
>   * BCLR.D - clear bit (doublewords)
>   * BNEG.B - negate bit (bytes)
>   * BNEG.H - negate bit (halfwords)
>   * BNEG.W - negate bit (words)
>   * BNEG.D - negate bit (doublewords)
>   * BSET.B - set bit (bytes)
>   * BSET.H - set bit (halfwords)
>   * BSET.W - set bit (words)
>   * BSET.D - set bit (doublewords)
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

>  .../mips/user/ase/msa/bit-set/test_msa_bclr_b.c    | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/bit-set/test_msa_bclr_d.c    | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/bit-set/test_msa_bclr_h.c    | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/bit-set/test_msa_bclr_w.c    | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/bit-set/test_msa_bneg_b.c    | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/bit-set/test_msa_bneg_d.c    | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/bit-set/test_msa_bneg_h.c    | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/bit-set/test_msa_bneg_w.c    | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/bit-set/test_msa_bset_b.c    | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/bit-set/test_msa_bset_d.c    | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/bit-set/test_msa_bset_h.c    | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/bit-set/test_msa_bset_w.c    | 153 +++++++++++++++=
++++++
>  12 files changed, 1836 insertions(+)
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c
>
>

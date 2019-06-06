Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE79EC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D26220868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="RT5kOOJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D26220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59958 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYrjQ-0001Mz-PC
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 08:43:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1hYriK-0000mn-Fd
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1hYriE-00028h-RD
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:41:50 -0400
Received: from mail-eopbgr820098.outbound.protection.outlook.com
	([40.107.82.98]:37593
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
	id 1hYriA-0001i2-ML
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=apQLAu9dBIxivdoLMjVjgYWEkCgiP6013xqvbXo3mes=;
	b=RT5kOOJHH6FILV0eMwJwUZsVIz4jlg6KjGAW7bjwGpi3hbdvWwtL4HR+lOaY0TfMFEvTXZvVl7yrQX/BUexzEbE18ML7/YNlfFfPhbMkbysVdzlOmA8s5rHXjg0x7raqBtMGjysiyPvYao+HoYkMh0tV23ZsswCFQli7ee1T7xg=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
	DM5PR22MB0490.namprd22.prod.outlook.com (10.173.171.10) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1965.12; Thu, 6 Jun 2019 12:41:39 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
	([fe80::1037:fb85:b06:6dba]) by DM5PR22MB1658.namprd22.prod.outlook.com
	([fe80::1037:fb85:b06:6dba%7]) with mapi id 15.20.1943.018;
	Thu, 6 Jun 2019 12:41:39 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 10/10] tests/tcg: target/mips: Add tests for MSA FP
	max/min instructions
Thread-Index: AQHVHGLi52uMtYvDy0qrOXfNGH750aaOkXsg
Date: Thu, 6 Jun 2019 12:41:39 +0000
Message-ID: <DM5PR22MB165893F9B0F709C12D42DB8AD2170@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1559823880-29103-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1559823880-29103-11-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1559823880-29103-11-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3c7a275-d23d-41f2-8a47-08d6ea7c526f
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:DM5PR22MB0490; 
x-ms-traffictypediagnostic: DM5PR22MB0490:
x-microsoft-antispam-prvs: <DM5PR22MB04908B60C2BF44ABC74D8C0FD2170@DM5PR22MB0490.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:454;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(396003)(346002)(39840400004)(376002)(366004)(199004)(189003)(110136005)(76176011)(86362001)(2906002)(53936002)(3846002)(6246003)(6116002)(478600001)(107886003)(316002)(229853002)(55016002)(6606003)(6436002)(68736007)(71200400001)(66066001)(71190400001)(25786009)(33656002)(9686003)(54896002)(7696005)(74316002)(19627405001)(5660300002)(81166006)(99286004)(8936002)(26005)(55236004)(66446008)(81156014)(66476007)(66556008)(102836004)(64756008)(53546011)(6506007)(8676002)(2501003)(186003)(4326008)(476003)(486006)(11346002)(446003)(52536014)(256004)(66946007)(7736002)(76116006)(73956011)(14454004)(91956017);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0490;
	H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nffgk8WRsDjA0iLV+yLn7Njl0u8zTMHsxJSyMBcIbKkFpr05xtewyMp+Up7G/2sW7/V5KtfKyiY8Wq8bs0CLvu/MKyIaV9JD1RO9QfpAJtbqgYv9EWysTK3aiRp0APHabjdRMOIJ1jWYjMMhP/NjzLa00+ITSsh2bsb8n4i32JWanmYXTGi9jW9Tfl6zEEfzi2xflfn3Y7EHOlgMi1WCrBwOlneNHhPv9fd9489HQ/CDjQqq5VLIWbkd0UItPymjxoongDeS1CYals7suOrdVgOE06uI0uYZe8scHHTgbh9uNrccKKU8dDXoTsvlSPn4J/lKDc9KVMzcbrr6g/qTCwy7gb/bHMFflzcYvAIYEs/Tavkd+g1g2I6zk6bnnoi5D0mI9JzYU3glcGY0FL55a36OJD8Fbaoqq4v/45VumAQ=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c7a275-d23d-41f2-8a47-08d6ea7c526f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 12:41:39.8100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0490
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.98
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 10/10] tests/tcg: target/mips: Add tests
 for MSA FP max/min instructions
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Thursday, June 6, 2019 2:24 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; Aleksandar Rikalo
> Subject: [PATCH v2 10/10] tests/tcg: target/mips: Add tests for MSA FP ma=
x/min instructions
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add tests for MSA FP max/min instructions. This includes following
> instructions:
>
>   * FMAX.W - float maximum (words)
>   * FMAX.D - float maximum (doublewords)
>   * FMAX_A.W - float maximum absolute (words)
>   * FMAX_A.D - float maximum absolute (doublewords)
>   * FMIN.W - float minimum (words)
>   * FMIN.D - float minimum (doublewords)
>   * FMIN_A.W - float minimum absolute (words)
>   * FMIN_A.D - float minimum absolute (doublewords)
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  .../user/ase/msa/float-max-min/test_msa_fmax_a_d.c | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/float-max-min/test_msa_fmax_a_w.c | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/float-max-min/test_msa_fmax_d.c   | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/float-max-min/test_msa_fmax_w.c   | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/float-max-min/test_msa_fmin_a_d.c | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/float-max-min/test_msa_fmin_a_w.c | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/float-max-min/test_msa_fmin_d.c   | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/float-max-min/test_msa_fmin_w.c   | 155 +++++++++++++++=
++++++
>  8 files changed, 1240 insertions(+)
>  create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fm=
ax_a_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fm=
ax_a_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fm=
ax_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fm=
ax_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fm=
in_a_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fm=
in_a_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fm=
in_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fm=
in_w.c

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>


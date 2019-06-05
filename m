Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8ACC46470
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9972D2083E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="R/cP/LpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9972D2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44946 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYK4-0006bl-75
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 11:59:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1hYYIs-0005zX-Og
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1hYYIo-0002F1-DV
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:58:18 -0400
Received: from mail-eopbgr790133.outbound.protection.outlook.com
	([40.107.79.133]:13748
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
	id 1hYYIl-0001qL-Qx
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=wq+vzHdC+t18xObFrM6KZ6bWGk0AwDJ/GKpzaJ7M1rY=;
	b=R/cP/LpBqaVfYzTfOLx5LxoRH05LqjZxxDyY0HmR9Jln4mcBNB6C5WRskM6tDXeeJRbvxMn8hdC1tzq6J4BtJMYzHffO6DNQ7wul9WNqfhyrzYwqIOveEStECZZoWJoJzS/EazE7Yl+/uJedIGk/8YOit/s7LvsEp7MnLX/EgLc=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
	DM5PR22MB0348.namprd22.prod.outlook.com (10.173.170.145) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.21; Wed, 5 Jun 2019 15:58:03 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
	([fe80::1037:fb85:b06:6dba]) by DM5PR22MB1658.namprd22.prod.outlook.com
	([fe80::1037:fb85:b06:6dba%7]) with mapi id 15.20.1943.018;
	Wed, 5 Jun 2019 15:58:03 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 0/6] target/mips: Amend and clean up MSA support
Thread-Index: AQHVG6vsl5qolxCuKECfZv9mJUH8+KaNN1aC
Date: Wed, 5 Jun 2019 15:58:02 +0000
Message-ID: <DM5PR22MB16586C03DC3129A3CEE63D36D2160@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1559745316-1454-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1559745316-1454-1-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fbce560-5ed6-4116-c68d-08d6e9ce9748
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:DM5PR22MB0348; 
x-ms-traffictypediagnostic: DM5PR22MB0348:
x-microsoft-antispam-prvs: <DM5PR22MB034808B6DA8324D9293B52DFD2160@DM5PR22MB0348.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(346002)(136003)(396003)(39840400004)(376002)(189003)(199004)(99286004)(7736002)(316002)(446003)(102836004)(107886003)(33656002)(66066001)(55236004)(6246003)(6506007)(53546011)(53936002)(110136005)(6606003)(8936002)(8676002)(476003)(54896002)(5660300002)(55016002)(25786009)(11346002)(19627405001)(9686003)(7696005)(256004)(81166006)(66446008)(66476007)(73956011)(81156014)(14454004)(76176011)(64756008)(66556008)(486006)(2906002)(26005)(6436002)(186003)(229853002)(66946007)(68736007)(4326008)(71190400001)(74316002)(71200400001)(86362001)(52536014)(2501003)(6116002)(3846002)(478600001)(76116006)(91956017);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0348;
	H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dB+IM0q/hjLAGj8OZMvIkznk/6jv7eFUbvjZPsucqCk00YLRAgUmUMzeMJSDs11SMGgwAfbwxfiEtvNlLnWRA2kVzatQMDpKOPRBCsTXUX42X4AfitjSmzDwyPjl/uBFXv3t8oHfqM/QjybV32qWQ4VDIhIF9kJtQ1fj9HvMH2B8KQp3scuwP7qELnFZEdYP9urCqre+H2PuLygcU8kHsm3IfUfJhbdvmvM+50brGSSHgA1KMcMf8KpHsMePXvjkxXqLRTEstlefWTmarqZhZLttxbnZ4l0UXTTyJhyesF/O/US2A5fMjOm34jLMyLnribPQXqi44I4qegqLOt81B+EurUoShUiCXLwmHhMFFu/adaDjzzguGLjazY+u8QReDCaKaR6ihh+eYhPvNyDTTgfV0VdTIvzldtDZNaS6kSk=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbce560-5ed6-4116-c68d-08d6e9ce9748
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 15:58:02.9608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0348
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.133
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 0/6] target/mips: Amend and clean up MSA
 support
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
> Sent: Wednesday, June 5, 2019 4:35 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; Aleksandar Rikalo
> Subject: [PATCH 0/6] target/mips: Amend and clean up MSA support
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> This series contains various refactorings and cleanups of MSA
> support.
>
> Improve support for logic instructions, add tests for shift
> instructions, improve code style, outline future organization.
>
> Aleksandar Markovic (6):
>   target/mips: Fix space-related format issues im msa_helper.c
>   target/mips: Fix block-comment-related issues im msa_helper.c
>   target/mips: Unroll loops in helpers for MSA logic instructions
>   tests/tcg: target/mips: Add tests for MSA shift instructions
>   tests/tcg: target/mips: Amend and rearrange MSA wrappers
>   target/mips: Outline places for future MSA helpers
>

For the whole series:

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>


>  target/mips/msa_helper.c                           | 252 +++++++++++--
>  tests/tcg/mips/include/wrappers_msa.h              | 402 ++++++++++++++-=
------
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c | 153 ++++++++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c | 153 ++++++++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c | 153 ++++++++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c | 153 ++++++++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c | 153 ++++++++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c | 153 ++++++++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c | 153 ++++++++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c | 153 ++++++++
>  .../tcg/mips/user/ase/msa/shift/test_msa_srar_b.c  | 153 ++++++++
>  .../tcg/mips/user/ase/msa/shift/test_msa_srar_d.c  | 153 ++++++++
>  .../tcg/mips/user/ase/msa/shift/test_msa_srar_h.c  | 153 ++++++++
>  .../tcg/mips/user/ase/msa/shift/test_msa_srar_w.c  | 153 ++++++++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c | 153 ++++++++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c | 153 ++++++++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c | 153 ++++++++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c | 153 ++++++++
>  .../tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c  | 153 ++++++++
>  .../tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c  | 153 ++++++++
>  .../tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c  | 153 ++++++++
>  .../tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c  | 153 ++++++++
>  22 files changed, 3544 insertions(+), 170 deletions(-)
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c
>
> --
> 2.7.4


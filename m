Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C32C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA2E26AD5
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="pTB8FYAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA2E26AD5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44652 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWili-0006PT-Gg
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:44:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1hWikw-00066k-98
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1hWikt-0000bK-4u
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:43:42 -0400
Received: from mail-eopbgr810130.outbound.protection.outlook.com
	([40.107.81.130]:31821
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
	id 1hWikp-0000XC-TX
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=bdxNg1jBFfRFh4Qj/ydnxGyuHnzlkrILvLftX+stFpg=;
	b=pTB8FYAI3SCYc6cix+RD8Hit7SuiC8RWjmz/0+ocV+Z0/8mL2fPvyPJAtJly+2Eix5EGiRFiv5wGzeHC4w+9nHozY45DTZXbi2+zlB4IadQgikhg2ZhsRlpTtgdMr/7B6hJqloOkaHE0SxDZzxM1f1AF+qSMCxE+nynCOhP6g8c=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
	DM5SPR00MB238.namprd22.prod.outlook.com (10.173.136.23) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.20; Fri, 31 May 2019 14:43:33 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
	([fe80::1037:fb85:b06:6dba]) by DM5PR22MB1658.namprd22.prod.outlook.com
	([fe80::1037:fb85:b06:6dba%7]) with mapi id 15.20.1922.021;
	Fri, 31 May 2019 14:43:33 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 3/5] target/mips: Amend and cleanup MSA TCG tests
Thread-Index: AQHU9t8Ml5aV+QXio0+MPfhg5dNr/qaFkHSw
Date: Fri, 31 May 2019 14:43:32 +0000
Message-ID: <DM5PR22MB16586EA71E29B2B3C60A3100D2190@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1555699081-24577-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1555699081-24577-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1555699081-24577-4-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62a813cf-fe28-4daa-bce6-08d6e5d65aee
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:DM5SPR00MB238; 
x-ms-traffictypediagnostic: DM5SPR00MB238:
x-microsoft-antispam-prvs: <DM5SPR00MB238680F68D7B38D7B5C8C49D2190@DM5SPR00MB238.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:94;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(346002)(136003)(366004)(189003)(199004)(6606003)(53546011)(6506007)(91956017)(76176011)(7696005)(54906003)(66066001)(186003)(26005)(54896002)(68736007)(6436002)(9686003)(76116006)(2501003)(4326008)(6246003)(8936002)(107886003)(71200400001)(66476007)(66556008)(64756008)(66446008)(71190400001)(99286004)(73956011)(66946007)(86362001)(8676002)(81166006)(81156014)(508600001)(5660300002)(486006)(19627405001)(53936002)(25786009)(7736002)(52536014)(30864003)(2906002)(33656002)(55016002)(102836004)(256004)(110136005)(55236004)(229853002)(446003)(11346002)(476003)(14454004)(3846002)(6116002)(74316002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM5SPR00MB238;
	H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vvaeHnR/kvNgc0XOZJOJOPZWIs/UCeD4v/gsYK8xFDDlD0eFrxiA8BkeucIYYnSIXYPCofttiWiFWdGBw+uQhePiRwG6y3YC8vnI8mpURUri8gKmjS/WYRjOCJ/EFuRvb5EINEWxWvE4PbccIADYPHkFwbMdHyoKuTejha4HWbdhn0VnrQ8yVtyP7waz5xYIkJXR4NOQTuDesFUwaNo/fSnhq53jNDMbBc9ccXDIKSKsXJBm1xghZYHrw5Ebdt6Sk2HTA/WjOmqFWciZKB6+0jRWTtZ0+jGkDPJbwqV14I99zMtZx5w0E+wocuPX9qiowo26CsZ5+wEDUBA/7aGTqiUHDRATNNclDxT/a8gfLrqZU+ppWPeb2I9Tzk4YPrx7jGs2w/QVWKojD1KWzKsxINhCIWwmVe6oGfjGP6tMHeY=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a813cf-fe28-4daa-bce6-08d6e5d65aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 14:43:32.8682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5SPR00MB238
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.130
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 3/5] target/mips: Amend and cleanup MSA TCG
 tests
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
> Sent: Friday, April 19, 2019 8:37 PM
> To: qemu-devel@nongnu.org
> Cc: aurelien@aurel32.net; Aleksandar Markovic; Aleksandar Rikalo
> Subject: [PATCH 3/5] target/mips: Amend and cleanup MSA TCG tests
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add missing bits and peaces of the tests of the emulation of certain
> MSA (non-immediate variants): some tests were missing two last cases;
> some instructions were missing wrappers; some test included wrong
> headers; some tests were missing altogether; updated some copywright
> preambles; do several other minor cleanups.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

>  tests/tcg/mips/include/test_utils_128.h            |   2 +-
>  tests/tcg/mips/include/wrappers_msa.h              | 147 +++++++++++++++=
+++-
>  .../mips/user/ase/msa/int-add/test_msa_add_a_b.c   |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_add_a_d.c   |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_add_a_h.c   |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_add_a_w.c   |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_adds_a_b.c  |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_adds_a_d.c  |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_adds_a_h.c  |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_adds_a_w.c  |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_adds_s_b.c  |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_adds_s_d.c  |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_adds_s_h.c  |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_adds_s_w.c  |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_adds_u_b.c  |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_adds_u_d.c  |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_adds_u_h.c  |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_adds_u_w.c  |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_addv_b.c    |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_addv_d.c    |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_addv_h.c    |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_addv_w.c    |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_hadd_s_d.c  |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_hadd_s_h.c  |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_hadd_s_w.c  |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_hadd_u_d.c  |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_hadd_u_h.c  |   4 +
>  .../mips/user/ase/msa/int-add/test_msa_hadd_u_w.c  |   4 +
>  .../user/ase/msa/int-average/test_msa_ave_s_b.c    |  12 +-
>  .../user/ase/msa/int-average/test_msa_ave_s_d.c    |  12 +-
>  .../user/ase/msa/int-average/test_msa_ave_s_h.c    |  12 +-
>  .../user/ase/msa/int-average/test_msa_ave_s_w.c    |  12 +-
>  .../user/ase/msa/int-average/test_msa_ave_u_b.c    |  12 +-
>  .../user/ase/msa/int-average/test_msa_ave_u_d.c    |  12 +-
>  .../user/ase/msa/int-average/test_msa_ave_u_h.c    |  12 +-
>  .../user/ase/msa/int-average/test_msa_ave_u_w.c    |  12 +-
>  .../user/ase/msa/int-average/test_msa_aver_s_b.c   |  12 +-
>  .../user/ase/msa/int-average/test_msa_aver_s_d.c   |  12 +-
>  .../user/ase/msa/int-average/test_msa_aver_s_h.c   |  12 +-
>  .../user/ase/msa/int-average/test_msa_aver_s_w.c   |  12 +-
>  .../user/ase/msa/int-average/test_msa_aver_u_b.c   |  12 +-
>  .../user/ase/msa/int-average/test_msa_aver_u_d.c   |  12 +-
>  .../user/ase/msa/int-average/test_msa_aver_u_h.c   |  12 +-
>  .../user/ase/msa/int-average/test_msa_aver_u_w.c   |  12 +-
>  .../mips/user/ase/msa/int-compare/test_msa_ceq_b.c |   2 +
>  .../mips/user/ase/msa/int-compare/test_msa_ceq_d.c |   2 +
>  .../mips/user/ase/msa/int-compare/test_msa_ceq_h.c |   2 +
>  .../mips/user/ase/msa/int-compare/test_msa_ceq_w.c |   2 +
>  .../user/ase/msa/int-compare/test_msa_cle_s_b.c    |   2 +
>  .../user/ase/msa/int-compare/test_msa_cle_s_d.c    |   2 +
>  .../user/ase/msa/int-compare/test_msa_cle_s_h.c    |   2 +
>  .../user/ase/msa/int-compare/test_msa_cle_s_w.c    |   2 +
>  .../user/ase/msa/int-compare/test_msa_cle_u_b.c    |   2 +
>  .../user/ase/msa/int-compare/test_msa_cle_u_d.c    |   2 +
>  .../user/ase/msa/int-compare/test_msa_cle_u_h.c    |   2 +
>  .../user/ase/msa/int-compare/test_msa_cle_u_w.c    |   2 +
>  .../user/ase/msa/int-compare/test_msa_clt_s_b.c    |   2 +
>  .../user/ase/msa/int-compare/test_msa_clt_s_d.c    |   2 +
>  .../user/ase/msa/int-compare/test_msa_clt_s_h.c    |   2 +
>  .../user/ase/msa/int-compare/test_msa_clt_s_w.c    |   2 +
>  .../user/ase/msa/int-compare/test_msa_clt_u_b.c    |   2 +
>  .../user/ase/msa/int-compare/test_msa_clt_u_d.c    |   2 +
>  .../user/ase/msa/int-compare/test_msa_clt_u_h.c    |   2 +
>  .../user/ase/msa/int-compare/test_msa_clt_u_w.c    |   2 +
>  .../user/ase/msa/int-divide/test_msa_div_s_b.c     |  12 +-
>  .../user/ase/msa/int-divide/test_msa_div_s_d.c     |  12 +-
>  .../user/ase/msa/int-divide/test_msa_div_s_h.c     |  12 +-
>  .../user/ase/msa/int-divide/test_msa_div_s_w.c     |  12 +-
>  .../user/ase/msa/int-divide/test_msa_div_u_b.c     |  12 +-
>  .../user/ase/msa/int-divide/test_msa_div_u_d.c     |  12 +-
>  .../user/ase/msa/int-divide/test_msa_div_u_h.c     |  12 +-
>  .../user/ase/msa/int-divide/test_msa_div_u_w.c     |  12 +-
>  .../ase/msa/int-dot-product/test_msa_dotp_s_d.c    |  12 +-
>  .../ase/msa/int-dot-product/test_msa_dotp_s_h.c    |  12 +-
>  .../ase/msa/int-dot-product/test_msa_dotp_s_w.c    |  12 +-
>  .../ase/msa/int-dot-product/test_msa_dotp_u_d.c    |  12 +-
>  .../ase/msa/int-dot-product/test_msa_dotp_u_h.c    |  12 +-
>  .../ase/msa/int-dot-product/test_msa_dotp_u_w.c    |  12 +-
>  .../user/ase/msa/int-max-min/test_msa_max_a_b.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_max_a_d.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_max_a_h.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_max_a_w.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_max_s_b.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_max_s_d.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_max_s_h.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_max_s_w.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_max_u_b.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_max_u_d.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_max_u_h.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_max_u_w.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_min_a_b.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_min_a_d.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_min_a_h.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_min_a_w.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_min_s_b.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_min_s_d.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_min_s_h.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_min_s_w.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_min_u_b.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_min_u_d.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_min_u_h.c    |   2 +
>  .../user/ase/msa/int-max-min/test_msa_min_u_w.c    |   2 +
>  .../user/ase/msa/int-modulo/test_msa_mod_s_b.c     | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-modulo/test_msa_mod_s_d.c     | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-modulo/test_msa_mod_s_h.c     | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-modulo/test_msa_mod_s_w.c     | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-modulo/test_msa_mod_u_b.c     | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-modulo/test_msa_mod_u_d.c     | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-modulo/test_msa_mod_u_h.c     | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-modulo/test_msa_mod_u_w.c     | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-multiply/test_msa_mul_q_h.c   |  12 +-
>  .../user/ase/msa/int-multiply/test_msa_mul_q_w.c   |  12 +-
>  .../user/ase/msa/int-multiply/test_msa_mulr_q_h.c  |  12 +-
>  .../user/ase/msa/int-multiply/test_msa_mulr_q_w.c  |  12 +-
>  .../user/ase/msa/int-multiply/test_msa_mulv_b.c    |  12 +-
>  .../user/ase/msa/int-multiply/test_msa_mulv_d.c    |  12 +-
>  .../user/ase/msa/int-multiply/test_msa_mulv_h.c    |  12 +-
>  .../user/ase/msa/int-multiply/test_msa_mulv_w.c    |  12 +-
>  .../user/ase/msa/int-subtract/test_msa_asub_s_b.c  | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-subtract/test_msa_asub_s_d.c  | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-subtract/test_msa_asub_s_h.c  | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-subtract/test_msa_asub_s_w.c  | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-subtract/test_msa_asub_u_b.c  | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-subtract/test_msa_asub_u_d.c  | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-subtract/test_msa_asub_u_h.c  | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-subtract/test_msa_asub_u_w.c  | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-subtract/test_msa_hsub_s_d.c  | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-subtract/test_msa_hsub_s_h.c  | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-subtract/test_msa_hsub_s_w.c  | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-subtract/test_msa_hsub_u_d.c  | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-subtract/test_msa_hsub_u_h.c  | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-subtract/test_msa_hsub_u_w.c  | 155 +++++++++++++++=
++++++
>  .../user/ase/msa/int-subtract/test_msa_subs_s_b.c  |  12 +-
>  .../user/ase/msa/int-subtract/test_msa_subs_s_d.c  |  12 +-
>  .../user/ase/msa/int-subtract/test_msa_subs_s_h.c  |  12 +-
>  .../user/ase/msa/int-subtract/test_msa_subs_s_w.c  |  12 +-
>  .../user/ase/msa/int-subtract/test_msa_subs_u_b.c  |  12 +-
>  .../user/ase/msa/int-subtract/test_msa_subs_u_d.c  |  12 +-
>  .../user/ase/msa/int-subtract/test_msa_subs_u_h.c  |  12 +-
>  .../user/ase/msa/int-subtract/test_msa_subs_u_w.c  |  12 +-
>  .../ase/msa/int-subtract/test_msa_subsus_u_b.c     |  12 +-
>  .../ase/msa/int-subtract/test_msa_subsus_u_d.c     |  12 +-
>  .../ase/msa/int-subtract/test_msa_subsus_u_h.c     |  12 +-
>  .../ase/msa/int-subtract/test_msa_subsus_u_w.c     |  12 +-
>  .../ase/msa/int-subtract/test_msa_subsuu_s_b.c     |  12 +-
>  .../ase/msa/int-subtract/test_msa_subsuu_s_d.c     |  12 +-
>  .../ase/msa/int-subtract/test_msa_subsuu_s_h.c     |  12 +-
>  .../ase/msa/int-subtract/test_msa_subsuu_s_w.c     |  12 +-
>  .../user/ase/msa/int-subtract/test_msa_subv_b.c    |  12 +-
>  .../user/ase/msa/int-subtract/test_msa_subv_d.c    |  12 +-
>  .../user/ase/msa/int-subtract/test_msa_subv_h.c    |  12 +-
>  .../user/ase/msa/int-subtract/test_msa_subv_w.c    |  10 +-
>  .../user/ase/msa/interleave/test_msa_ilvev_b.c     |   2 +-
>  .../user/ase/msa/interleave/test_msa_ilvev_d.c     |   2 +-
>  .../user/ase/msa/interleave/test_msa_ilvev_h.c     |   2 +-
>  155 files changed, 4211 insertions(+), 240 deletions(-)
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s=
_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s=
_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s=
_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s=
_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u=
_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u=
_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u=
_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u=
_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asu=
b_s_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asu=
b_s_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asu=
b_s_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asu=
b_s_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asu=
b_u_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asu=
b_u_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asu=
b_u_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asu=
b_u_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsu=
b_s_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsu=
b_s_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsu=
b_s_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsu=
b_u_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsu=
b_u_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsu=
b_u_w.c
>


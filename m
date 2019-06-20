Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432FAC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 10:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021CD2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 10:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="BWllm0bs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021CD2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46044 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hduhD-0004bM-73
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 06:53:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45442)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <arikalo@wavecomp.com>) id 1hduel-0002G7-6v
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hduZa-00073M-Vm
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:45:47 -0400
Received: from mail-eopbgr810124.outbound.protection.outlook.com
 ([40.107.81.124]:52521 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hduJ3-0000Zg-VM
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOyeGzOJw2U4CbvOMFfdgn+VOLha5pC/1OAAlnAMd2E=;
 b=BWllm0bs4Ln0bOsEOshvczn3krzg+y/GScASsR1I9yfcFYR66RUjcarYsnMPAnYyGFZNmKzrvBqcTO/HQGEV4gIOfZ88kiUvKOoM7tx6rwsVKVfY/uhuvEjr3gCn7Uj7P6yXLJU1CVUCcjfl99DJ34UJbXXI/LFw0tdYIMh3rMQ=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0795.namprd22.prod.outlook.com (10.171.158.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 20 Jun 2019 10:28:35 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::3579:1b6c:1f31:c6b9]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::3579:1b6c:1f31:c6b9%7]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 10:28:35 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 0/2] target/mips: Improve MSA tests
Thread-Index: AQHVJs2ZPkm5eCenjkqMMkvdePkftaakV2hP
Date: Thu, 20 Jun 2019 10:28:34 +0000
Message-ID: <DM5PR22MB165876BB806F06EB4D51AD6ED2E40@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1560969232-23283-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1560969232-23283-1-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1a34644-e8fa-481c-8677-08d6f56a0ce2
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM5PR22MB0795; 
x-ms-traffictypediagnostic: DM5PR22MB0795:
x-microsoft-antispam-prvs: <DM5PR22MB07956C5C4B9D25E96B1C7B00D2E40@DM5PR22MB0795.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:81;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39850400004)(136003)(346002)(376002)(396003)(189003)(199004)(6246003)(52536014)(71190400001)(71200400001)(107886003)(4326008)(66066001)(53546011)(53936002)(2906002)(6506007)(5660300002)(229853002)(478600001)(66446008)(64756008)(66556008)(66476007)(8936002)(91956017)(76116006)(66946007)(73956011)(2501003)(68736007)(256004)(316002)(110136005)(14454004)(30864003)(86362001)(6606003)(99286004)(74316002)(486006)(76176011)(7696005)(476003)(19627405001)(55016002)(7736002)(54896002)(26005)(3846002)(6116002)(102836004)(446003)(55236004)(186003)(25786009)(33656002)(81156014)(81166006)(11346002)(8676002)(9686003)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0795;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ABZge1UZW/kQ37BXdIkbiIL0B/7zdIGv315yA6syIiy/WvHwP4mcvmrb4wM6Axl/HehAF/iuB6YWGQTfrVvK4mCggdpEtbfFdoME/64T2sQN5vql8p10bfq1T1pFnDrK+NUrqXL0sVGYb+4Vh6SKXKd4gLV1w0tGfGaAvwzQsD+GQ0Rm4R0DydwphVUosQGKSKrprhBA5ZHX7Jyc9xw0UasvyqkevFzRLbBZzkebyvIsSG+KfpO/CFjmZkmNQe2IyWHOD69n9hfG6iYAg0Hgk1fN7d1aDO7I1/dwMopiUGOxRdRcM0TD/JEqO980kiSZzlfIJeFdcINsxThRY4smSaK9IpBd0At1NAiZ8fNIFKbXd96bfKvKa/AOVi2oW4SHNE6nnkq+o6iKCrZp0QiqfaFO/w7/Qw5ZfrPDXFk1oxw=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a34644-e8fa-481c-8677-08d6f56a0ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 10:28:34.9645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0795
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.124
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 0/2] target/mips: Improve MSA tests
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
> Sent: Wednesday, June 19, 2019 8:33 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; Aleksandar Rikalo
> Subject: [PATCH 0/2] target/mips: Improve MSA tests
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> This series contains various improvements and additions of MSA ASE
> TCG tests.
>
> Aleksandar Markovic (2):
>   tests/tcg: target/mips: Introduce isa/ase name and group name
>   tests/tcg: target/mips: Amend tests for MSA pack instructions
>
>  tests/tcg/mips/include/test_utils_128.h            | 17 +++---
>  tests/tcg/mips/include/test_utils_64.h             |  9 ++-
>  tests/tcg/mips/include/wrappers_msa.h              | 24 ++++++++
>  .../mips/user/ase/msa/bit-count/test_msa_nloc_b.c  |  9 ++-
>  .../mips/user/ase/msa/bit-count/test_msa_nloc_d.c  |  9 ++-
>  .../mips/user/ase/msa/bit-count/test_msa_nloc_h.c  |  9 ++-
>  .../mips/user/ase/msa/bit-count/test_msa_nloc_w.c  |  9 ++-
>  .../mips/user/ase/msa/bit-count/test_msa_nlzc_b.c  |  9 ++-
>  .../mips/user/ase/msa/bit-count/test_msa_nlzc_d.c  |  9 ++-
>  .../mips/user/ase/msa/bit-count/test_msa_nlzc_h.c  |  9 ++-
>  .../mips/user/ase/msa/bit-count/test_msa_nlzc_w.c  |  9 ++-
>  .../mips/user/ase/msa/bit-count/test_msa_pcnt_b.c  |  9 ++-
>  .../mips/user/ase/msa/bit-count/test_msa_pcnt_d.c  |  9 ++-
>  .../mips/user/ase/msa/bit-count/test_msa_pcnt_h.c  |  9 ++-
>  .../mips/user/ase/msa/bit-count/test_msa_pcnt_w.c  |  9 ++-
>  .../mips/user/ase/msa/bit-set/test_msa_bclr_b.c    |  9 ++-
>  .../mips/user/ase/msa/bit-set/test_msa_bclr_d.c    |  9 ++-
>  .../mips/user/ase/msa/bit-set/test_msa_bclr_h.c    |  9 ++-
>  .../mips/user/ase/msa/bit-set/test_msa_bclr_w.c    |  9 ++-
>  .../mips/user/ase/msa/bit-set/test_msa_bneg_b.c    |  9 ++-
>  .../mips/user/ase/msa/bit-set/test_msa_bneg_d.c    |  9 ++-
>  .../mips/user/ase/msa/bit-set/test_msa_bneg_h.c    |  9 ++-
>  .../mips/user/ase/msa/bit-set/test_msa_bneg_w.c    |  9 ++-
>  .../mips/user/ase/msa/bit-set/test_msa_bset_b.c    |  9 ++-
>  .../mips/user/ase/msa/bit-set/test_msa_bset_d.c    |  9 ++-
>  .../mips/user/ase/msa/bit-set/test_msa_bset_h.c    |  9 ++-
>  .../mips/user/ase/msa/bit-set/test_msa_bset_w.c    |  9 ++-
>  .../user/ase/msa/fixed-multiply/test_msa_mul_q_h.c |  9 ++-
>  .../user/ase/msa/fixed-multiply/test_msa_mul_q_w.c |  9 ++-
>  .../ase/msa/fixed-multiply/test_msa_mulr_q_h.c     |  9 ++-
>  .../ase/msa/fixed-multiply/test_msa_mulr_q_w.c     |  9 ++-
>  .../user/ase/msa/float-max-min/test_msa_fmax_a_d.c |  9 ++-
>  .../user/ase/msa/float-max-min/test_msa_fmax_a_w.c |  9 ++-
>  .../user/ase/msa/float-max-min/test_msa_fmax_d.c   |  9 ++-
>  .../user/ase/msa/float-max-min/test_msa_fmax_w.c   |  9 ++-
>  .../user/ase/msa/float-max-min/test_msa_fmin_a_d.c |  9 ++-
>  .../user/ase/msa/float-max-min/test_msa_fmin_a_w.c |  9 ++-
>  .../user/ase/msa/float-max-min/test_msa_fmin_d.c   |  9 ++-
>  .../user/ase/msa/float-max-min/test_msa_fmin_w.c   |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_add_a_b.c   |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_add_a_d.c   |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_add_a_h.c   |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_add_a_w.c   |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_adds_a_b.c  |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_adds_a_d.c  |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_adds_a_h.c  |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_adds_a_w.c  |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_adds_s_b.c  |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_adds_s_d.c  |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_adds_s_h.c  |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_adds_s_w.c  |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_adds_u_b.c  |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_adds_u_d.c  |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_adds_u_h.c  |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_adds_u_w.c  |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_addv_b.c    |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_addv_d.c    |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_addv_h.c    |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_addv_w.c    |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_hadd_s_d.c  |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_hadd_s_h.c  |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_hadd_s_w.c  |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_hadd_u_d.c  |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_hadd_u_h.c  |  9 ++-
>  .../mips/user/ase/msa/int-add/test_msa_hadd_u_w.c  |  9 ++-
>  .../user/ase/msa/int-average/test_msa_ave_s_b.c    |  9 ++-
>  .../user/ase/msa/int-average/test_msa_ave_s_d.c    |  9 ++-
>  .../user/ase/msa/int-average/test_msa_ave_s_h.c    |  9 ++-
>  .../user/ase/msa/int-average/test_msa_ave_s_w.c    |  9 ++-
>  .../user/ase/msa/int-average/test_msa_ave_u_b.c    |  9 ++-
>  .../user/ase/msa/int-average/test_msa_ave_u_d.c    |  9 ++-
>  .../user/ase/msa/int-average/test_msa_ave_u_h.c    |  9 ++-
>  .../user/ase/msa/int-average/test_msa_ave_u_w.c    |  9 ++-
>  .../user/ase/msa/int-average/test_msa_aver_s_b.c   |  9 ++-
>  .../user/ase/msa/int-average/test_msa_aver_s_d.c   |  9 ++-
>  .../user/ase/msa/int-average/test_msa_aver_s_h.c   |  9 ++-
>  .../user/ase/msa/int-average/test_msa_aver_s_w.c   |  9 ++-
>  .../user/ase/msa/int-average/test_msa_aver_u_b.c   |  9 ++-
>  .../user/ase/msa/int-average/test_msa_aver_u_d.c   |  9 ++-
>  .../user/ase/msa/int-average/test_msa_aver_u_h.c   |  9 ++-
>  .../user/ase/msa/int-average/test_msa_aver_u_w.c   |  9 ++-
>  .../mips/user/ase/msa/int-compare/test_msa_ceq_b.c |  9 ++-
>  .../mips/user/ase/msa/int-compare/test_msa_ceq_d.c |  9 ++-
>  .../mips/user/ase/msa/int-compare/test_msa_ceq_h.c |  9 ++-
>  .../mips/user/ase/msa/int-compare/test_msa_ceq_w.c |  9 ++-
>  .../user/ase/msa/int-compare/test_msa_cle_s_b.c    |  9 ++-
>  .../user/ase/msa/int-compare/test_msa_cle_s_d.c    |  9 ++-
>  .../user/ase/msa/int-compare/test_msa_cle_s_h.c    |  9 ++-
>  .../user/ase/msa/int-compare/test_msa_cle_s_w.c    |  9 ++-
>  .../user/ase/msa/int-compare/test_msa_cle_u_b.c    |  9 ++-
>  .../user/ase/msa/int-compare/test_msa_cle_u_d.c    |  9 ++-
>  .../user/ase/msa/int-compare/test_msa_cle_u_h.c    |  9 ++-
>  .../user/ase/msa/int-compare/test_msa_cle_u_w.c    |  9 ++-
>  .../user/ase/msa/int-compare/test_msa_clt_s_b.c    |  9 ++-
>  .../user/ase/msa/int-compare/test_msa_clt_s_d.c    |  9 ++-
>  .../user/ase/msa/int-compare/test_msa_clt_s_h.c    |  9 ++-
>  .../user/ase/msa/int-compare/test_msa_clt_s_w.c    |  9 ++-
>  .../user/ase/msa/int-compare/test_msa_clt_u_b.c    |  9 ++-
>  .../user/ase/msa/int-compare/test_msa_clt_u_d.c    |  9 ++-
>  .../user/ase/msa/int-compare/test_msa_clt_u_h.c    |  9 ++-
>  .../user/ase/msa/int-compare/test_msa_clt_u_w.c    |  9 ++-
>  .../user/ase/msa/int-divide/test_msa_div_s_b.c     |  9 ++-
>  .../user/ase/msa/int-divide/test_msa_div_s_d.c     |  9 ++-
>  .../user/ase/msa/int-divide/test_msa_div_s_h.c     |  9 ++-
>  .../user/ase/msa/int-divide/test_msa_div_s_w.c     |  9 ++-
>  .../user/ase/msa/int-divide/test_msa_div_u_b.c     |  9 ++-
>  .../user/ase/msa/int-divide/test_msa_div_u_d.c     |  9 ++-
>  .../user/ase/msa/int-divide/test_msa_div_u_h.c     |  9 ++-
>  .../user/ase/msa/int-divide/test_msa_div_u_w.c     |  9 ++-
>  .../ase/msa/int-dot-product/test_msa_dotp_s_d.c    |  9 ++-
>  .../ase/msa/int-dot-product/test_msa_dotp_s_h.c    |  9 ++-
>  .../ase/msa/int-dot-product/test_msa_dotp_s_w.c    |  9 ++-
>  .../ase/msa/int-dot-product/test_msa_dotp_u_d.c    |  9 ++-
>  .../ase/msa/int-dot-product/test_msa_dotp_u_h.c    |  9 ++-
>  .../ase/msa/int-dot-product/test_msa_dotp_u_w.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_max_a_b.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_max_a_d.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_max_a_h.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_max_a_w.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_max_s_b.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_max_s_d.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_max_s_h.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_max_s_w.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_max_u_b.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_max_u_d.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_max_u_h.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_max_u_w.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_min_a_b.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_min_a_d.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_min_a_h.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_min_a_w.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_min_s_b.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_min_s_d.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_min_s_h.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_min_s_w.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_min_u_b.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_min_u_d.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_min_u_h.c    |  9 ++-
>  .../user/ase/msa/int-max-min/test_msa_min_u_w.c    |  9 ++-
>  .../user/ase/msa/int-modulo/test_msa_mod_s_b.c     |  9 ++-
>  .../user/ase/msa/int-modulo/test_msa_mod_s_d.c     |  9 ++-
>  .../user/ase/msa/int-modulo/test_msa_mod_s_h.c     |  9 ++-
>  .../user/ase/msa/int-modulo/test_msa_mod_s_w.c     |  9 ++-
>  .../user/ase/msa/int-modulo/test_msa_mod_u_b.c     |  9 ++-
>  .../user/ase/msa/int-modulo/test_msa_mod_u_d.c     |  9 ++-
>  .../user/ase/msa/int-modulo/test_msa_mod_u_h.c     |  9 ++-
>  .../user/ase/msa/int-modulo/test_msa_mod_u_w.c     |  9 ++-
>  .../user/ase/msa/int-multiply/test_msa_mulv_b.c    |  9 ++-
>  .../user/ase/msa/int-multiply/test_msa_mulv_d.c    |  9 ++-
>  .../user/ase/msa/int-multiply/test_msa_mulv_h.c    |  9 ++-
>  .../user/ase/msa/int-multiply/test_msa_mulv_w.c    |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_asub_s_b.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_asub_s_d.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_asub_s_h.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_asub_s_w.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_asub_u_b.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_asub_u_d.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_asub_u_h.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_asub_u_w.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_hsub_s_d.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_hsub_s_h.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_hsub_s_w.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_hsub_u_d.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_hsub_u_h.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_hsub_u_w.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_subs_s_b.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_subs_s_d.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_subs_s_h.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_subs_s_w.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_subs_u_b.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_subs_u_d.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_subs_u_h.c  |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_subs_u_w.c  |  9 ++-
>  .../ase/msa/int-subtract/test_msa_subsus_u_b.c     |  9 ++-
>  .../ase/msa/int-subtract/test_msa_subsus_u_d.c     |  9 ++-
>  .../ase/msa/int-subtract/test_msa_subsus_u_h.c     |  9 ++-
>  .../ase/msa/int-subtract/test_msa_subsus_u_w.c     |  9 ++-
>  .../ase/msa/int-subtract/test_msa_subsuu_s_b.c     |  9 ++-
>  .../ase/msa/int-subtract/test_msa_subsuu_s_d.c     |  9 ++-
>  .../ase/msa/int-subtract/test_msa_subsuu_s_h.c     |  9 ++-
>  .../ase/msa/int-subtract/test_msa_subsuu_s_w.c     |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_subv_b.c    |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_subv_d.c    |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_subv_h.c    |  9 ++-
>  .../user/ase/msa/int-subtract/test_msa_subv_w.c    |  9 ++-
>  .../user/ase/msa/interleave/test_msa_ilvev_b.c     |  9 ++-
>  .../user/ase/msa/interleave/test_msa_ilvev_d.c     |  9 ++-
>  .../user/ase/msa/interleave/test_msa_ilvev_h.c     |  9 ++-
>  .../user/ase/msa/interleave/test_msa_ilvev_w.c     |  9 ++-
>  .../mips/user/ase/msa/interleave/test_msa_ilvl_b.c |  9 ++-
>  .../mips/user/ase/msa/interleave/test_msa_ilvl_d.c |  9 ++-
>  .../mips/user/ase/msa/interleave/test_msa_ilvl_h.c |  9 ++-
>  .../mips/user/ase/msa/interleave/test_msa_ilvl_w.c |  9 ++-
>  .../user/ase/msa/interleave/test_msa_ilvod_b.c     |  9 ++-
>  .../user/ase/msa/interleave/test_msa_ilvod_d.c     |  9 ++-
>  .../user/ase/msa/interleave/test_msa_ilvod_h.c     |  9 ++-
>  .../user/ase/msa/interleave/test_msa_ilvod_w.c     |  9 ++-
>  .../mips/user/ase/msa/interleave/test_msa_ilvr_b.c |  9 ++-
>  .../mips/user/ase/msa/interleave/test_msa_ilvr_d.c |  9 ++-
>  .../mips/user/ase/msa/interleave/test_msa_ilvr_h.c |  9 ++-
>  .../mips/user/ase/msa/interleave/test_msa_ilvr_w.c |  9 ++-
>  tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c |  9 ++-
>  tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c |  9 ++-
>  tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c  |  9 ++-
>  tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c |  9 ++-
>  .../tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c  | 67 ++++++++++++++++=
++++--
>  .../tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c  | 67 ++++++++++++++++=
++++--
>  .../tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c  | 67 ++++++++++++++++=
++++--
>  .../tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c  | 67 ++++++++++++++++=
++++--
>  .../tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c  | 67 ++++++++++++++++=
++++--
>  .../tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c  | 67 ++++++++++++++++=
++++--
>  .../tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c  | 67 ++++++++++++++++=
++++--
>  .../tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c  | 67 ++++++++++++++++=
++++--
>  tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c | 67 ++++++++++++++++=
++++--
>  tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c | 67 ++++++++++++++++=
++++--
>  tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c | 67 ++++++++++++++++=
++++--
>  tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c | 67 ++++++++++++++++=
++++--
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c |  9 ++-
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c |  9 ++-
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c |  9 ++-
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c |  9 ++-
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c |  9 ++-
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c |  9 ++-
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c |  9 ++-
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c |  9 ++-
>  .../tcg/mips/user/ase/msa/shift/test_msa_srar_b.c  |  9 ++-
>  .../tcg/mips/user/ase/msa/shift/test_msa_srar_d.c  |  9 ++-
>  .../tcg/mips/user/ase/msa/shift/test_msa_srar_h.c  |  9 ++-
>  .../tcg/mips/user/ase/msa/shift/test_msa_srar_w.c  |  9 ++-
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c |  9 ++-
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c |  9 ++-
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c |  9 ++-
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c |  9 ++-
>  .../tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c  |  9 ++-
>  .../tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c  |  9 ++-
>  .../tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c  |  9 ++-
>  .../tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c  |  9 ++-
>  .../isa/mips64r6/bit-count/test_mips64r6_clo.c     |  4 +-
>  .../isa/mips64r6/bit-count/test_mips64r6_clz.c     |  4 +-
>  .../isa/mips64r6/bit-count/test_mips64r6_dclo.c    |  4 +-
>  .../isa/mips64r6/bit-count/test_mips64r6_dclz.c    |  4 +-
>  .../isa/mips64r6/bit-swap/test_mips64r6_bitswap.c  |  4 +-
>  .../isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c |  4 +-
>  .../isa/mips64r6/int-multiply/test_mips64r6_dmuh.c |  4 +-
>  .../mips64r6/int-multiply/test_mips64r6_dmuhu.c    |  4 +-
>  .../isa/mips64r6/int-multiply/test_mips64r6_dmul.c |  4 +-
>  .../mips64r6/int-multiply/test_mips64r6_dmulu.c    |  4 +-
>  .../isa/mips64r6/int-multiply/test_mips64r6_muh.c  |  4 +-
>  .../isa/mips64r6/int-multiply/test_mips64r6_muhu.c |  4 +-
>  .../isa/mips64r6/int-multiply/test_mips64r6_mul.c  |  4 +-
>  .../isa/mips64r6/int-multiply/test_mips64r6_mulu.c |  4 +-
>  .../user/isa/mips64r6/logic/test_mips64r6_and.c    |  4 +-
>  .../user/isa/mips64r6/logic/test_mips64r6_nor.c    |  4 +-
>  .../user/isa/mips64r6/logic/test_mips64r6_or.c     |  4 +-
>  .../user/isa/mips64r6/logic/test_mips64r6_xor.c    |  4 +-
>  .../user/isa/mips64r6/shift/test_mips64r6_dsllv.c  |  4 +-
>  .../user/isa/mips64r6/shift/test_mips64r6_dsrav.c  |  4 +-
>  .../user/isa/mips64r6/shift/test_mips64r6_dsrlv.c  |  4 +-
>  .../user/isa/mips64r6/shift/test_mips64r6_sllv.c   |  4 +-
>  .../user/isa/mips64r6/shift/test_mips64r6_srav.c   |  4 +-
>  .../user/isa/mips64r6/shift/test_mips64r6_srlv.c   |  4 +-
>  261 files changed, 2200 insertions(+), 748 deletions(-)
>
> --
> 2.7.4

It would be also nice to add instructions how to build tests for
mips32r5 for example, since this architecture can also support MSA.

For the whole series.
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>


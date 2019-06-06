Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C95C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFAB520866
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="h4/bNURe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAB520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59956 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYrih-0000qg-3y
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 08:42:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1hYrhY-0000AY-Pf
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1hYrhU-0007b8-Ov
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:41:04 -0400
Received: from mail-eopbgr730102.outbound.protection.outlook.com
	([40.107.73.102]:63840
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
	id 1hYrhU-0007Ys-Ew
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=8Gwcr+Ho3+JCeO0kugIZ3HP4kRU6Hn72ZqoVHBQkJw0=;
	b=h4/bNUReZ4Is8IKyHtoQHFmjMARt0wD6SdjCyyAizPqQJ8lX3ui7m+FNtd3/1EfYW5PME/UaKY/WuwghCTz46F69jcuM9LxVOVoz11Yugb4ZFQG9kWxgaZPOnGqP0pRcUUXC1J+QdOhvGbTfn0+SlzRVD5XWqSD21wn73uYieiM=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
	DM5PR22MB0490.namprd22.prod.outlook.com (10.173.171.10) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1965.12; Thu, 6 Jun 2019 12:40:58 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
	([fe80::1037:fb85:b06:6dba]) by DM5PR22MB1658.namprd22.prod.outlook.com
	([fe80::1037:fb85:b06:6dba%7]) with mapi id 15.20.1943.018;
	Thu, 6 Jun 2019 12:40:58 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 08/10] tests/tcg: target/mips: Add utility function
	reset_msa_registers()
Thread-Index: AQHVHGLuA5AyD146XECGm3UDPKnkEaaOkTY+
Date: Thu, 6 Jun 2019 12:40:58 +0000
Message-ID: <DM5PR22MB16580CCE24C760603E7313C2D2170@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1559823880-29103-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1559823880-29103-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1559823880-29103-9-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 992982ac-48ec-4083-5e1f-08d6ea7c39a1
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:DM5PR22MB0490; 
x-ms-traffictypediagnostic: DM5PR22MB0490:
x-microsoft-antispam-prvs: <DM5PR22MB0490042C9673A2B11067A627D2170@DM5PR22MB0490.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:318;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(396003)(346002)(39840400004)(376002)(366004)(199004)(189003)(110136005)(76176011)(86362001)(2906002)(53936002)(3846002)(6246003)(6116002)(30864003)(478600001)(107886003)(316002)(229853002)(55016002)(6606003)(6436002)(68736007)(71200400001)(53946003)(66066001)(71190400001)(25786009)(33656002)(9686003)(54896002)(7696005)(74316002)(19627405001)(5660300002)(81166006)(99286004)(8936002)(26005)(55236004)(66446008)(81156014)(66476007)(66556008)(102836004)(64756008)(53546011)(6506007)(8676002)(2501003)(186003)(4326008)(476003)(486006)(11346002)(446003)(52536014)(256004)(66946007)(7736002)(76116006)(73956011)(14454004)(91956017);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0490;
	H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RNe7OycAjY4PAC9lgZQoQsOCb2DkpUDhKwFeAV4nqQ3QJ1HRQ1vT4clE9j3RDPcBTLtAiWucP1w7n1YaX+CsoOQkVNaTdw72nHAPVneMDlY56Z4bgMgKRsRM9DvTStGxxYlzWMu4pjIZujJur22SE2KVFxRPjIbe1m0Qq1glX82sZ27zq/f/rVJ8GDGFcniqEYrdWOE7K2bN+2JQoecSq7OWbeiDd/mgxYJC6fiwvXBvcM8GZg3S9ZxnXmLo9V5g2Cc3AGphFJ6osuuAmr19C2Jq9226XjjmjNP9pZqhpto/ZwcI5eA1DlZSqCZJkvjPakSRQzLSZaLok0mWkfmZh5PWi9N90cRI5FC6aJmKQZeZFb+0Uigk3PsRlBEEelqHuf9NY5NIzmbGNmi0e9NCM3dlokZpA6ACik72AHsylXI=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992982ac-48ec-4083-5e1f-08d6ea7c39a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 12:40:58.2395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0490
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.73.102
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 08/10] tests/tcg: target/mips: Add
 utility function reset_msa_registers()
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
> Subject: [PATCH v2 08/10] tests/tcg: target/mips: Add utility function re=
set_msa_registers()
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add function reset_msa_registers() and utilize it in each MSA test.
> This is needed to ensure independency of test results on the state of
> MSA registers before test execution.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---

I don't see the reason why reset_msa_registers() should be nop for now.
It should be implemented right away. Otherwise:

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

>  tests/tcg/mips/include/wrappers_msa.h                           | 6 ++++=
++
>  tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c           | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c           | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c           | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c           | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c           | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c           | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c           | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c           | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c           | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c           | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c           | 2 ++
>  tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c           | 2 ++
>  tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c   | 2 ++
>  tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c   | 2 ++
>  tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c  | 2 ++
>  tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c  | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c          | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c          | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c          | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c          | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c           | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c           | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c           | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c           | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c         | 2 ++
>  tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c     | 2 ++
>  tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c     | 2 ++
>  tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c     | 2 ++
>  tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c     | 2 ++
>  tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c     | 2 ++
>  tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c     | 2 ++
>  tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c     | 2 ++
>  tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c     | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c        | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c        | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c        | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c        | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c | 2 ++
>  tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c | 2 ++
>  tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c | 2 ++
>  tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c | 2 ++
>  tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c | 2 ++
>  tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c    | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c  | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c  | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c  | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c  | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c  | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c  | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c  | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c  | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c      | 2 ++
>  tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c        | 2 ++
>  tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c        | 2 ++
>  tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c        | 2 ++
>  tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c        | 2 ++
>  tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c       | 2 ++
>  tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c        | 2 ++
>  tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c        | 2 ++
>  tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c        | 2 ++
>  tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c        | 2 ++
>  tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c               | 2 ++
>  tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c             | 2 ++
>  tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c             | 2 ++
>  tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c             | 2 ++
>  tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c             | 2 ++
>  tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c             | 2 ++
>  tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c             | 2 ++
>  tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c             | 2 ++
>  tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c             | 2 ++
>  tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c             | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c             | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c             | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c             | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c              | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c             | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c             | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c             | 2 ++
>  tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c             | 2 ++
>  227 files changed, 458 insertions(+)
>
> diff --git a/tests/tcg/mips/include/wrappers_msa.h b/tests/tcg/mips/inclu=
de/wrappers_msa.h
> index 2dc89e4..147dcd0 100644
> --- a/tests/tcg/mips/include/wrappers_msa.h
> +++ b/tests/tcg/mips/include/wrappers_msa.h
> @@ -23,6 +23,12 @@
>  #define WRAPPERS_MSA_H
>
>
> +static inline void reset_msa_registers()
> +{
> +   ; /* nop for now */
> +}
> +
> +
>  #define DO_MSA__WD__WS(suffix, mnemonic)                               \
>  static inline void do_msa_##suffix(const void *input,                  \
>                                     const void *output)                 \


Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860CCC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:40:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E9320866
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="WxPfwwRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E9320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59946 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYrhR-0008QO-66
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 08:40:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1hYrgf-000837-6q
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:40:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1hYrgd-0004Rn-TL
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:40:09 -0400
Received: from mail-eopbgr820102.outbound.protection.outlook.com
	([40.107.82.102]:21297
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
	id 1hYrgd-0004KM-G2
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Nv6OXvA/9+hxqZzs12eEQbAw4oxbNP/mTzyZb+gAk9E=;
	b=WxPfwwRLT3NSQQrYfAnozrAI2l4JDH+9lOXbUvtifQkJFLMn44ekzu8N/c7D8YnoGjLxmCC3LXTj8AN+AnB37WsaV3f6X0jXP0K/myoFbmg6T5QUD4XhsudEtngYuAbGt5EyH9FuxDZ8O/MvF30vfW28yvnf8Vkov6/zVeg5Yuw=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
	DM5PR22MB0490.namprd22.prod.outlook.com (10.173.171.10) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1965.12; Thu, 6 Jun 2019 12:40:04 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
	([fe80::1037:fb85:b06:6dba]) by DM5PR22MB1658.namprd22.prod.outlook.com
	([fe80::1037:fb85:b06:6dba%7]) with mapi id 15.20.1943.018;
	Thu, 6 Jun 2019 12:40:04 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 07/10] tests/tcg: target/mips: Move four tests to a
	better location
Thread-Index: AQHVHGLimuoUCf/YuU6jVCnpHk7/K6aOkQQz
Date: Thu, 6 Jun 2019 12:40:04 +0000
Message-ID: <DM5PR22MB165855550BC934938E726A4ED2170@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1559823880-29103-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1559823880-29103-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1559823880-29103-8-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60cdd447-d908-4535-b922-08d6ea7c1997
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:DM5PR22MB0490; 
x-ms-traffictypediagnostic: DM5PR22MB0490:
x-microsoft-antispam-prvs: <DM5PR22MB0490489303F0A6F6D035DD32D2170@DM5PR22MB0490.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(396003)(346002)(39840400004)(376002)(366004)(199004)(189003)(110136005)(76176011)(86362001)(2906002)(53936002)(3846002)(6246003)(6116002)(478600001)(107886003)(316002)(229853002)(55016002)(6606003)(6436002)(68736007)(71200400001)(66066001)(71190400001)(25786009)(33656002)(9686003)(54896002)(7696005)(74316002)(19627405001)(5660300002)(81166006)(99286004)(8936002)(26005)(55236004)(66446008)(81156014)(66476007)(66556008)(102836004)(64756008)(53546011)(6506007)(8676002)(2501003)(186003)(4326008)(476003)(486006)(11346002)(446003)(52536014)(256004)(66946007)(7736002)(76116006)(73956011)(14454004)(91956017);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0490;
	H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rtRmZ31+Qt4fXTv0FQ9xpYAOMvv75o3KTmbVOFtJBfuynpi9DFj6N0dsd70CeUkKXWs2gaMBx2MY05Kjoj/Sn7OjRxS1jfktGbF8tGZs9KjX+FHnS02XhEyqBogY10FN+wYuiKVLLQ+RrSqptRVHL8LixfatkPtidfsbUsVRwZRT4uQ4LigCtQlqI4E7VFV/g1az5hjaR8E0djmz719ri9YqB9A8nDgjnRL/NDBEkehzPpzgmIK6gvCzup4rM/Fmt7NZB7VYvoJ1UnU6xHPbTPa5dGyU6dRUWYkuaOXA46sPXAz6ZVuMmgOl0BA1TAXY40Sz4tgtj/nzSnMFwwD2XAbSss/LnrTgEtOD7MkO0JDtrjNeykOqsbZ4BGI+wPW51rOZ1ECTcicyeEBHrWC++kavnxgmvEcfnuYrkM+lY8I=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cdd447-d908-4535-b922-08d6ea7c1997
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 12:40:04.4672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0490
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.102
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 07/10] tests/tcg: target/mips: Move four
 tests to a better location
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
> Subject: [PATCH v2 07/10] tests/tcg: target/mips: Move four tests to a be=
tter location
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Move tests for <MUL|MULR>_Q.<H|B> from "integer multiply" directory
> to "fixed-point multiply" directory, since they do not operate on
> integers, but on fixed point numbers.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

>  .../mips/user/ase/msa/{int-multiply =3D> fixed-multiply}/test_msa_mul_q_=
h.c | 0
>  .../mips/user/ase/msa/{int-multiply =3D> fixed-multiply}/test_msa_mul_q_=
w.c | 0
>  .../user/ase/msa/{int-multiply =3D> fixed-multiply}/test_msa_mulr_q_h.c =
    | 0
>  .../user/ase/msa/{int-multiply =3D> fixed-multiply}/test_msa_mulr_q_w.c =
    | 0
>  4 files changed, 0 insertions(+), 0 deletions(-)
>  rename tests/tcg/mips/user/ase/msa/{int-multiply =3D> fixed-multiply}/te=
st_msa_mul_q_h.c (100%)
>  rename tests/tcg/mips/user/ase/msa/{int-multiply =3D> fixed-multiply}/te=
st_msa_mul_q_w.c (100%)
>  rename tests/tcg/mips/user/ase/msa/{int-multiply =3D> fixed-multiply}/te=
st_msa_mulr_q_h.c (100%)
>  rename tests/tcg/mips/user/ase/msa/{int-multiply =3D> fixed-multiply}/te=
st_msa_mulr_q_w.c (100%)
>
> diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_h.c =
b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c
> similarity index 100%
> rename from tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_h.c
> rename to tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c
> diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_w.c =
b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c
> similarity index 100%
> rename from tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_w.c
> rename to tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c
> diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_h.c=
 b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c
> similarity index 100%
> rename from tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_h.c
> rename to tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c
> diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_w.c=
 b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c
> similarity index 100%
> rename from tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_w.c
> rename to tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c
> --
> 2.7.4
>
>


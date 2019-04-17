Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CF5C282DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 16:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1769720835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 16:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="VrFgah3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1769720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56477 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGndz-00075Z-Ab
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 12:42:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hGnd4-0006iv-QN
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hGnd3-0000Df-Eo
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:41:46 -0400
Received: from mail-eopbgr710133.outbound.protection.outlook.com
	([40.107.71.133]:51296
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hGnd2-0000CM-Vn
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=SXe+G5sM8Pvmpza/Z70ks+3rJHv9blpHAuzlVZKfCcI=;
	b=VrFgah3JrQCnCi0OWSXRGvJ+dC/TxhrNbzjU1008q0C1arJ6sG3LLtvQPpRzB6/0hGnO+8DSKDWGQnRkNAXdEWjFaOF+dAJNYb7LkCArvWIWWurtf582YCGhAvtnHWGHOWd+3HNA0Mp9SVfXtpYCoz7dTuKYreb5BRGnzg6eNl0=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1154.namprd22.prod.outlook.com (10.174.90.16) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.12; Wed, 17 Apr 2019 16:41:40 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::3c70:1ca4:2aa:9e81]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::3c70:1ca4:2aa:9e81%2]) with mapi id 15.20.1813.011;
	Wed, 17 Apr 2019 16:41:40 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [PATCH] target/mips: Amend tests for MSA binary integer
	operations
Thread-Index: AQHU9Pya4W8sjyOEjUq6twmw2Q2Ub6ZAjgU6
Date: Wed, 17 Apr 2019 16:41:39 +0000
Message-ID:
 <BN6PR2201MB1251516C13CAE873ADDA73DBC6250@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1555491867-5922-1-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1555491867-5922-1-git-send-email-mateja.marjanovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e54b7f10-17ca-4f98-5731-08d6c3539120
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1154; 
x-ms-traffictypediagnostic: BN6PR2201MB1154:
x-microsoft-antispam-prvs: <BN6PR2201MB11541638AC0B7AF6490F1AD1C6250@BN6PR2201MB1154.namprd22.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(39850400004)(366004)(396003)(346002)(376002)(199004)(189003)(81166006)(86362001)(186003)(9686003)(14454004)(102836004)(14444005)(68736007)(81156014)(486006)(11346002)(8676002)(2906002)(26005)(106356001)(74316002)(97736004)(476003)(256004)(6506007)(446003)(8936002)(5660300002)(2501003)(7736002)(55236004)(105586002)(305945005)(478600001)(33656002)(99286004)(25786009)(71200400001)(6246003)(71190400001)(229853002)(52536014)(107886003)(54906003)(6116002)(3846002)(76176011)(53936002)(7696005)(55016002)(4326008)(66066001)(316002)(110136005)(6436002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1154;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RjZJ7cekSX71V5CrX2/3LAeB3bm9fgfPltUIcyHpZ6HlaNmwiNqDzGI47lre+/EusqDKWXs6sS0cDyejgobVjztxEuVnNFCwoWhCOIDSxX7xzDLa5efEuoWitLkX6sRb6rgJ9ugaGmnF1SHweD/8ChWdCAYBJPXIjl3iBmWAR0js7phfXhUEQ48nbkGoukV8aoHiuKsDNfwks+UofNuQ0GXnXtRN2dTnEdFMcF4aRERBRCJXfgUxwH9a83Z+2XA97KD3Ww9Q6LZ0XxLE5dR6+JOps0mXW/NE1FUc77QpOVeT6BFTmKlS0jO0hoyp3tz5N+UrZOpNZlHagJKwMBl1f1uLRoGYzhdjsLXwimWAVphyAqLzPHGvAR3BfVMYgEcxsa8R2AIphrhwbsUUEazmOgpQegzd7CrgwBFfi8tV2Bk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54b7f10-17ca-4f98-5731-08d6c3539120
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 16:41:40.0078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1154
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.133
Subject: Re: [Qemu-devel] [PATCH] target/mips: Amend tests for MSA binary
 integer operations
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	"aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417164139.Uo9ym4mhQE5jLNRzUNy1oxS2aF9XdUPrsF4-dsvlKbk@z>

> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> Subject: [PATCH] target/mips: Amend tests for MSA binary integer operatio=
ns
>
> Amend tests for certain MSA binary integer instructions
> (for example DIV_S.B) by appending two missing test cases
> to complete standard battery of 80 test cases for each
> such instruction. Expected values were pulled from the
> results of the MIPS64r6 machine that executed those
> instruction, and QEMU emulation should produce the same
> results.
>=20
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---

I'm afraid your patch doesn't apply to the tip of the source tree:

$ git am target-mips-Amend-tests-for-MSA-binary-integer-operations.patch Ap=
plying: target/mips: Amend tests for MSA binary integer operations
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c=
:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c: patch does n=
ot apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c=
:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c: patch does n=
ot apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c=
:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c: patch does n=
ot apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c=
:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c: patch does n=
ot apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c:=
2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c: patch does no=
t apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c:=
2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c: patch does no=
t apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c:=
2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c: patch does no=
t apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c:=
2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c: patch does no=
t apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c: patch does =
not apply
Patch failed at 0001 target/mips: Amend tests for MSA binary integer operat=
ions
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Please update/rebase your tree before sending patches in future.

Thanks,
Aleksandar=


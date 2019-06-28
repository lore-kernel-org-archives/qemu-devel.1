Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1EBC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 07:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4A82086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 07:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="dOwdQ8cy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4A82086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hglju-0001b6-FC
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 03:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53949)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1hglit-000135-Sc
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 03:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1hglis-00079s-EW
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 03:55:07 -0400
Received: from mail-eopbgr800130.outbound.protection.outlook.com
 ([40.107.80.130]:1341 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1hglis-00078A-3y
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 03:55:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=EyrySgGlmGUQXk2ITrVsepOVp53C9wehf6S0xZxGtNMG+VzJ/6pCDE135eOCyh5toKbdgk6m8VyB9xFxwI+33mSmpmMOElY4CPhoUwbakGMiHHxBTk+PTCQQ9V0ymnkKWXsZy7dFyXmbq+Wz5XTX/tk4SZYYRMtF9E2P2jY/ysM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeLgRjRxS4teau8iJjPaxsSUwkX3YP1zr0JjtoMCUDY=;
 b=OCdO3PgiKaW51NDCTghS5tIIFBrBZIxJmD8qiOhejUL7iublfl7m8IEJVgmAv01mKWlClefk338F9fHRHcboaiS5ip5h9kxleb0F8bg1sUD/vYN+bYfuNG+k4YSCx2wvTfdVHnFvl0huehJ0+A0UARu1Bf6RbEP/A0rJJesQiCI=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeLgRjRxS4teau8iJjPaxsSUwkX3YP1zr0JjtoMCUDY=;
 b=dOwdQ8cy4+piL8b58+rb+NqUX7NQAV5otMaQL7SZJ3tv5yL4Pixm2QZBP0bdCeN0EX5hRu9gN0AVUV8vxyVJ+k+6rBq0vo0gGfI6b5EaNNNrTCCzDzm50/hf0fI7kCOcPT2BzLq6JjvWLTctPrvZkDLSJPzt+kLyO1sOp6pRwqY=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1139.namprd22.prod.outlook.com (10.174.85.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 07:55:01 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::b0c5:c059:f809:fc07]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::b0c5:c059:f809:fc07%2]) with mapi id 15.20.2008.018; Fri, 28 Jun 2019
 07:55:01 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "aleksandar.markovic@rt-rk.com"
 <aleksandar.markovic@rt-rk.com>
Thread-Topic: [Qemu-devel] [PATCH v13 0/5] linux-user: A set of miscellaneous
 patches
Thread-Index: AQHVLPqt1oJQLlOmV0mvki9B6RRRNaav4sgAgADHeACAAAMOhoAABTC9
Date: Fri, 28 Jun 2019 07:55:01 +0000
Message-ID: <BN6PR2201MB125124059D62C8EA65DB46A7C6FC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <156166365360.6332.12789669195894130027@c4a48874b076>,
 <735eb279-4f0f-b033-6ee9-eac0262a099d@vivier.eu>,
 <BN6PR2201MB1251D7AD0E7630773C962012C6FC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB1251D7AD0E7630773C962012C6FC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4830446b-9cae-4391-8d91-08d6fb9dec7b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1139; 
x-ms-traffictypediagnostic: BN6PR2201MB1139:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR2201MB1139520BF167A9FC389C7999C6FC0@BN6PR2201MB1139.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(366004)(346002)(39850400004)(136003)(376002)(396003)(199004)(189003)(66574012)(102836004)(3846002)(6116002)(478600001)(26005)(14454004)(5660300002)(186003)(55016002)(2906002)(66066001)(53936002)(81156014)(81166006)(8936002)(66446008)(71190400001)(71200400001)(966005)(110136005)(74316002)(2201001)(66476007)(8676002)(66556008)(64756008)(76116006)(486006)(91956017)(73956011)(66946007)(25786009)(305945005)(55236004)(86362001)(446003)(2501003)(11346002)(68736007)(229853002)(476003)(7696005)(6306002)(76176011)(9686003)(52536014)(6506007)(33656002)(6436002)(316002)(256004)(53546011)(6246003)(7736002)(99286004)(2940100002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1139;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TYIuXMh+kBxgbBpeJHFF43G44u3m/bM3H1A4EK3LuTWMyS3TUt3camX2383RBocMH0fdSjx1WmPCgfgLfMqkdjWdCTHHoOO3LF5Fm9jE24dh2q5DmSrYC5zJQ12qynOKV/NmQrsqJuLvmtpw0KJYH9bNwTSegs14PFAvhYpwKsISL/C+vL+sn1r/tMRSK+Fz2sHdSTTdLnQkRDEKK83suodZXS3ThZZD16WLc3ZaH0FCeBJdl/66GcQX259qQmzlHqQmQyA5b1WUg5fjbRzFm73C3SWls2F4lKOoI6TIFQFKYutdmPOu0tAl+3jVgZZPxMnyc6zzG12B+ahhMLjhpB/mx/cSHrnBlCJG9S+ehBtkp9a5aONjxzTHZts019qpWwa9MULw04tvOQOxr5pWeJ7Sg/hQtXK4/ASl67Ubbq0=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4830446b-9cae-4391-8d91-08d6fb9dec7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 07:55:01.3419 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1139
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.130
Subject: Re: [Qemu-devel] [PATCH v13 0/5] linux-user: A set of miscellaneous
 patches
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic
> Sent: Friday, June 28, 2019 9:46 AM
> To: Laurent Vivier; qemu-devel@nongnu.org; aleksandar.markovic@rt-rk.com
> Subject: Re: [Qemu-devel] [PATCH v13 0/5] linux-user: A set of miscellane=
ous patches
>=20
> > From: Laurent Vivier <laurent@vivier.eu>
> > Sent: Friday, June 28, 2019 9:21 AM
> > To: qemu-devel@nongnu.org; aleksandar.markovic@rt-rk.com
> > Cc: Aleksandar Markovic
> > Subject: Re: [Qemu-devel] [PATCH v13 0/5] linux-user: A set of miscella=
neous patches
> >
> > Le 27/06/2019 =E0 21:27, no-reply@patchew.org a =E9crit :
> > > Patchew URL: https://patchew.org/> > QEMU/1561648298-18100-1-git-send=
-email-aleksandar.markovic@rt-rk.com/
> > >   CC      i386-linux-user/linux-user/uname.o
> > >   CCAS    i386-linux-user/linux-user/safe-syscall.o
> > >   CC      i386-linux-user/linux-user/i386/signal.o
> > > /var/tmp/patchew-tester-tmp-zqhqa95y/src/linux-user/syscall.c:323:16:=
 error: > > conflicting types for =91statx=92
> > >   323 | _syscall5(int, statx, int, dirfd, const char *, pathname, int=
, flags,
> > >       |                ^~~~~
> > > /var/tmp/patchew-tester-tmp-zqhqa95y/src/linux-user/syscall.c:214:13:=
 note: in > > definition of macro =91_syscall5=92
> > >
> >
> > This is a real error. To avoid this you can rename it to "sys_statx"
> > (see sys_gettid() for instance).
> >
>=20
> Ok, Laurent. But the root cause is a little deeper, I would say - the err=
or appears > because <sys/stat.h> is superfluously included, and glibc defi=
nes statx() basically in > that header (in fact, in a headed that is always=
 included by stat.h) - hence the error, > I guess only for build systems wi=
th glibc >=3D 2.28.
>=20
> I am going to remove #include <sys/stat.h> too from the patch, is that OK=
, in your > opinion? (and, honestly, I am almost positive this line removal=
 is sufficient for > removing build error without any name changes etc.)
>=20

Let me ask you more precisely, Laurent - would this addition to the patch b=
e fine, or you think something else would be better?

@@ -43,7 +43,7 @@
 #include <sys/times.h>
 #include <sys/shm.h>
 #include <sys/sem.h>
-#include <sys/stat.h>
+//#include <sys/stat.h>
 #include <sys/statfs.h>
 #include <utime.h>
 #include <sys/sysinfo.h>
@@ -320,7 +320,7 @@ _syscall5(int, kcmp, pid_t, pid1, pid_t, pid2, int, typ=
e,
  * It is assumed that struct statx is architecture independent.
  */
 #if defined(TARGET_NR_statx) && defined(__NR_statx)
-_syscall5(int, statx, int, dirfd, const char *, pathname, int, flags,
+_syscall5(int, sys_statx, int, dirfd, const char *, pathname, int, flags,
           unsigned int, mask, struct target_statx *, statxbuf)
 #endif
=20
@@ -10194,7 +10194,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
                 struct target_statx host_stx;
                 int mask =3D arg4;
=20
-                ret =3D get_errno(statx(dirfd, p, flags, mask, &host_stx))=
;
+                ret =3D get_errno(sys_statx(dirfd, p, flags, mask, &host_s=
tx));
                 if (!is_error(ret)) {
                     if (host_to_target_statx(&host_stx, arg5) !=3D 0) {
                         unlock_user(p, arg2, 0);



> Yours,
> Aleksandar
>=20
> > Thanks,
> > Laurent



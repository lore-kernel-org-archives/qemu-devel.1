Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A71ECA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C3720650
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="hUN3+Is0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C3720650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNFFA-0001xy-9r
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iNF3e-000145-A2
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iNF3a-0008Cz-L0
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:44:05 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:14644)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1iNF3a-00089E-9W
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:44:02 -0400
IronPort-SDR: TYJ+zYxi/jKSdmoXGgS6D7aFtTjS/yJauXnnDF1LzJn8+KC6MShPwVBNN0Dv05t4ParhI8+YQb
 EBHYHlOc9agzUULQJ1lGgzD8N5fLiM0iwXcN816rI+UtANADKRr8vEYRkq2BGeJJXtY+1TyvEf
 ZLop/nBHa91kHvx0BMqSg0WO3a50kMJwK2LQhBPBm6VQSeSua1gcBH4TweqJwYeJXsMz0RcTLr
 01OZbq9iGyQEb9VJS9RECC32BC2z+DlL4olnQfL3yjPH5CbYeVUGROP/3+sQ4JZKOhwLApbt4w
 drE=
X-IronPort-AV: E=McAfee;i="6000,8403,9418"; a="7091165"
X-IronPort-AV: E=Sophos;i="5.68,220,1569250800"; 
   d="scan'208";a="7091165"
Received: from mail-os2jpn01lp2057.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.57])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384;
 23 Oct 2019 20:43:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rv0DM6sKLjVhNhEfw2LBMYPwVwF3JWBzpoFvOAkHu4yQ60r4Iblz0SAKi5FYKsgT9JmcGHhTM+P4mHH1+PgQ7VonqXm2haCI6/ocxJ0irNvM8Warg50ZfhDYeqxcAWLNcsCFyPd3R0Ns5bo0d48RrHoWCoJ7CTySJTr6sLjZMkkfkDSu0Y+lEGIaqG2w1SzuAzJCuTEJJdwfWu9PPdvlom+ER6rrgnWfAdV8T++M93zzPQF65AyCbtUo5atOpzGZ6yjR35NC2/C0PDvNrucBzZmDDOMcwnyfDt8XlEY1lGv79TmyL3zdztxRVPgKxu+wUF77v7kSLIgqqseR3BPBGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkdtDYnCWFFdvrP76EmuKgOMcDDsmTMenLe+xeYtECc=;
 b=NVE2ShwgZb1AIMamjyAOiMRH2UWh8F55EG5FOmMVDXfjGXkAaJksL0XGP/TxlLJGKp5Fv4jYEv8yTjx6/KHqeFXxHxn8tM/nKAfm2TPBd/mPcE+zkphhelS9oIm3E1FGvazD8FRJvs2LkpoJAoRrmSXcvC3xSc3jvHdsqilFYS82R2QRk20s5ft2PHGS7YtI7Qlmp/I1RQmtiNOMB3CbaQqW1P+uNsYExJ9NpAVtazHAraqwYh844bp9o4Gu/gbfKoBTYzJ++5UWXJYF1mMw+NXir+YF4LUD5lCf9+Nerp44+dBI6jLblcyZ9RsGmm7zYnvDQjHyssHyEOv2LkgzjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkdtDYnCWFFdvrP76EmuKgOMcDDsmTMenLe+xeYtECc=;
 b=hUN3+Is0WXl/BPGq+nRVlDB2Xz0pF3Vo1aDL3RnENtJb3sUHDFXzD7FSK8Pn1mrVr1tgQnooILyjafI4tlnf/iwxC6OUbWgisHU/VMn18nguskq4dA+3oqoEoL7/LV/sqBaJcgfYBnoxUi3G4GBk78SQWhmTyfYePHbmFXW22OI=
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com (20.178.96.203) by
 OSBPR01MB3174.jpnprd01.prod.outlook.com (20.176.240.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Wed, 23 Oct 2019 11:43:52 +0000
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::4cef:c2a5:21f3:9f3c]) by OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::4cef:c2a5:21f3:9f3c%5]) with mapi id 15.20.2387.021; Wed, 23 Oct 2019
 11:43:52 +0000
From: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To: 'Stefan Hajnoczi' <stefanha@redhat.com>
Subject: RE: [Virtio-fs] [PATCH 0/2] virtiofsd: Two fix for xattr operation
Thread-Topic: [Virtio-fs] [PATCH 0/2] virtiofsd: Two fix for xattr operation
Thread-Index: AQHVhAzKQZ3C+LAwOU6GUtVH7zwjF6denLQAgAAV7YCAAE/kgIAACs2AgADyiACAAAqG4IAE1MGAgANEtgA=
Date: Wed, 23 Oct 2019 11:42:50 +0000
Deferred-Delivery: Wed, 23 Oct 2019 11:43:49 +0000
Message-ID: <OSBPR01MB3783A810FEC4C2F3AE7248BAE56B0@OSBPR01MB3783.jpnprd01.prod.outlook.com>
References: <20191016103754.2047-1-misono.tomohiro@jp.fujitsu.com>
 <20191017100528.GA24790@stefanha-x1.localdomain>
 <CAOssrKfR=sfE1RzOXzvPbdQg-g7i5-f8W9y8bWFnO=gyJ2VMsg@mail.gmail.com>
 <20191017160953.GC1266@stefanha-x1.localdomain>
 <CAOssrKejcfVWXw6Nu1owyEeofTdVp6BNx4bL91ma2g7bg9-nmg@mail.gmail.com>
 <CAOssrKdbAT5s=CYG6PBtE6OYdqgwG8vp9T6QMJpwZ7X3tKjPmg@mail.gmail.com>
 <OSBPR01MB37835DC3A2F179AFD3A9074BE56C0@OSBPR01MB3783.jpnprd01.prod.outlook.com>
 <20191021094047.GF22659@stefanha-x1.localdomain>
In-Reply-To: <20191021094047.GF22659@stefanha-x1.localdomain>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 994fdbf2fcd14141a39037c7a7e4a919
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=misono.tomohiro@fujitsu.com; 
x-originating-ip: [114.160.30.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76a1f8fe-122c-46ca-d609-08d757ae474a
x-ms-traffictypediagnostic: OSBPR01MB3174:
x-microsoft-antispam-prvs: <OSBPR01MB3174A4F5E2F53C45B786F53EE56B0@OSBPR01MB3174.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(13464003)(199004)(189003)(6916009)(7696005)(476003)(11346002)(71190400001)(86362001)(6246003)(446003)(9686003)(64756008)(66556008)(66476007)(66946007)(486006)(66066001)(186003)(5660300002)(26005)(76176011)(71200400001)(6116002)(76116006)(6506007)(3846002)(55016002)(25786009)(2906002)(53546011)(66446008)(102836004)(81166006)(8676002)(99286004)(14444005)(54906003)(478600001)(229853002)(81156014)(85182001)(8936002)(7736002)(14454004)(4326008)(52536014)(316002)(6436002)(305945005)(33656002)(74316002)(256004)(777600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:OSBPR01MB3174;
 H:OSBPR01MB3783.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M/3Mm+YZsx1D947jX+/cyDINp1MgtCxjSBq2b9xDX813CqpBPxbRjJxar8n1dKi7gzrZ722xszI3yU1V3/JeKlo0NuEZ22GHUWFYLmh/8LJc1jBB4NFBQbLequxHUKEc42kG0c5sNjh42IRw1RlrCnLI+emN7Dj9kAoFdplnIEyOSh26cpIPSVeS58hiLLp8rEcJ3wMAxNO6bWdd1b6RDT6YFWPfKtn4GqRycaXOf91Wb5pLCeqoi8OWEYAkgqbVHNNKqRoRX/jezeL3BEStfuZe/UgqjorMK/NVQI5xJM58qEX7vi4X5slomdCtD27Bi1S3+AqktYFgYPWQ/I6g2TrwhgBQGfJsWA7BdqT4sYNel+ZHKU6Q6nLALu5TTgBvUBcrnz/XDjFDa1GEro8U+hkFB1Z5YO6KXTOLyDLR/ig0I6K01/MZ8YS+jnzQu5GL
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a1f8fe-122c-46ca-d609-08d757ae474a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 11:43:52.7447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pc0xm30p5cg8ds5iKReHfJbwe/TIHyQ+KQxbelYCXIdexhO0XB5YwdNSUMjajblvGBsa0aSG2sseVe0gLylPA5szOy7KykB6i3BJt35Skow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3174
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.159.88
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
Cc: "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 'Miklos Szeredi' <mszeredi@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> Sent: Monday, October 21, 2019 6:41 PM
> To: Misono, Tomohiro/=1B$BL#A>Ln=1B(B =1B$BCRNi=1B(B <misono.tomohiro@fuj=
itsu.com>
> Cc: 'Miklos Szeredi' <mszeredi@redhat.com>; virtio-fs@redhat.com; qemu-de=
vel@nongnu.org
> Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: Two fix for xattr operati=
on
>=20
> On Fri, Oct 18, 2019 at 08:51:20AM +0000, misono.tomohiro@fujitsu.com wro=
te:
> > > Doing unshare(CLONE_FS) after thread startup seems safe, though must
> > > be careful to change the working directory to the root of the mount
> > > *before* starting any threads.
> >
> > I think working directry is changed in setup_sandbox() -> setup_mount_n=
amespace() -> setup_pivot_root().
> > So, can we just add unshare(CLONE_FS) in fv_queue_worker()?
>=20
> fv_queue_worker() is the thread pool worker function that is called for e=
ach request.  Calling unshare(CLONE_FS) for each request
> is not necessary and will reduce performance.
>=20
> A thread-local variable can be used to avoid repeated calls to
> unshare(CLONE_FS) from the same worker thread:
>=20
>   static __thread bool clone_fs_called;
>=20
>   static void fv_queue_worker(gpointer data, gpointer user_data)
>   {
>       ...
>       if (!clone_fs_called) {
>           int ret;
>=20
> 	  ret =3D unshare(CLONE_FS);
> 	  assert(ret =3D=3D 0); /* errors not expected according to man page */
>=20
> 	  clone_fs_called =3D true;
>       }
>=20
> Another issue is the seccomp policy.  Since worker threads are spawned at=
 runtime it is necessary to add the unshare(2) syscall
> to the seccomp whitelist in contrib/virtiofsd/seccomp.c.
>=20

Thanks for suggesting.

I tried above code with fchdir() + ...xattr() + fchdir() in lo_...xattr
and it solves all the problem about xattr I see.

However, it seems the fix causes some performance issue in stress test
as ACL check issues getxattr() and a lot of fchdir() happens. So, I may
try to combine the old method for regular file and this method for special
files.

Thanks,
Misono



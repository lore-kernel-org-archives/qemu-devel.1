Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C14C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 13:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 611EA2084B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 13:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="F0nrl2F/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611EA2084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgUJl-0005f6-KE
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 09:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60905)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1hgUIN-0004yP-G5
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 09:18:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1hgUIM-00079b-48
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 09:18:35 -0400
Received: from mail-eopbgr750125.outbound.protection.outlook.com
 ([40.107.75.125]:55975 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1hgUIL-00077t-OV
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 09:18:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=IHRq/AT1XatGqw8IviLj9jc/gEjb2IX5pkkzxP16QMcqfvfMx2Ej8f46XshXrAnhZ5KXxA5C//5BvYcH7Y6tCLFhsikcr9vu6QT1KkFLd4WmHhMYYRjA2cZZqNqmw4kwxHuIIb3UcGzyaMCkVIk0Ag5/oLZR67TXjtvrj1Mb2RE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Whd0gAmnHNscJKaH49vizkLmdUPoQo1xsQkk0plTypA=;
 b=KRbIu6XJEi4wD5S/Y6ZI36iS3SyXIeht9DDarSN283PLHXd9Bn/qUSoJ8y1YAHCsEhLk1JIibkdR2wWCKtrG0gWrrv+oy+7BZRP0xn/nokimqGp8Pob9xPuZIPHPyNAcZjMetA9hIDn5VgayF7hmMZEnDdsq9L7/4ROOAIZCi0c=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Whd0gAmnHNscJKaH49vizkLmdUPoQo1xsQkk0plTypA=;
 b=F0nrl2F/uAuHzDjVUucDPaLU25qVvFUUs36UVUPDRfL0BdaV8QAwyw4VRgLDzENbObrBrgy38Bp5pEzzAqjl5suK6rpV2ohUeTTFb7jeJ6nfr5A5bvsD3OrWkw42Op+h9Mn3feSy2s5oK3W3J5tFFhGzS+04Q8MX3nq2OmIvcCI=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1299.namprd22.prod.outlook.com (10.174.81.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 13:18:30 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::b0c5:c059:f809:fc07]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::b0c5:c059:f809:fc07%2]) with mapi id 15.20.2008.018; Thu, 27 Jun 2019
 13:18:30 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Laurent Vivier <laurent@vivier.eu>, Aleksandar Markovic
 <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v12 3/5] linux-user: Add support for translation of
 statx() syscall
Thread-Index: AQHVJqnHJliPslndKUSx0eJJlBU5M6ajJhKAgAxdSRk=
Date: Thu, 27 Jun 2019 13:18:30 +0000
Message-ID: <BN6PR2201MB12510D08346C1EBF5BACB709C6FD0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1560953834-29584-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1560953834-29584-4-git-send-email-aleksandar.markovic@rt-rk.com>,
 <75367706-a29d-605e-a3b4-0aa483b521c4@vivier.eu>
In-Reply-To: <75367706-a29d-605e-a3b4-0aa483b521c4@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a354a8c3-eccb-4e1f-767d-08d6fb01f29c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1299; 
x-ms-traffictypediagnostic: BN6PR2201MB1299:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BN6PR2201MB1299A2A6979A135D26ADDD69C6FD0@BN6PR2201MB1299.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(136003)(346002)(396003)(39840400004)(189003)(199004)(81156014)(71190400001)(305945005)(8936002)(71200400001)(8676002)(478600001)(6506007)(55236004)(66066001)(2501003)(76176011)(26005)(6436002)(256004)(9686003)(52536014)(86362001)(74316002)(7696005)(14454004)(14444005)(186003)(6306002)(476003)(110136005)(4326008)(99286004)(7736002)(33656002)(53936002)(64756008)(54906003)(76116006)(73956011)(91956017)(68736007)(25786009)(6246003)(53376002)(66946007)(2906002)(6116002)(3846002)(229853002)(55016002)(102836004)(446003)(11346002)(81166006)(66556008)(486006)(316002)(66446008)(66476007)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1299;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6jOpd1vShhDixCfkwwGgJE37nZhunthe4hSclYt9mKdDS+SKb52Z9MzS9CHj61Ku3CP/b8qqhVazLC7cteWeIQvUpNF7cCSAPCS6UBpFmIsKoDy2Fi93oYqrE0TMgGJcF9H2Abeli1PPQu/HR00obKM1N4KKMDUCbAcFtm1nZMC7qNAb6NL78/yInNF7PwW8CC/wQ0S4k4q07Io6TazW1eLLvcpX28YtBFLGbeja2Tc0jROE0ZEdjKjsSF4vJKkeCjSH3WEIuGhhaWg7pj9HkyRlUBt3SyQUqc3bmmAiLYRbS4NXZIm79WRaDeNGD6kzj9PcSatHVGDYRyolZr9BfQ6t/P26/iyM+OsFH3dHZ+UNI2yWYp5afu30zB8HjItXDs4Xa8GQL/Hm6O80bZp16QuRGXwAwjgYTNOpUpwzFQE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a354a8c3-eccb-4e1f-767d-08d6fb01f29c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 13:18:30.1781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1299
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.125
Subject: Re: [Qemu-devel] [PATCH v12 3/5] linux-user: Add support for
 translation of statx() syscall
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Jim Wilson <jimw@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Laurent Vivier <laurent@vivier.eu>
>=20
> > @@ -10173,6 +10225,88 @@ static abi_long do_syscall1(void *cpu_env, int=
 num, abi_long > arg1,
> >              ret =3D host_to_target_stat64(cpu_env, arg3, &st);
> >          return ret;
> >  #endif
> > +#if defined(TARGET_NR_statx)
> > +    case TARGET_NR_statx:
> > +        {
> > +            struct target_statx *target_stx;
> > +            int dirfd =3D arg1;
> > +            int flags =3D arg3;
> > +
> > +            p =3D lock_user_string(arg2);
> > +            if (p =3D=3D NULL) {
> > +                return -TARGET_EFAULT;
> > +            }
> > +#if defined(__NR_statx)
> > +            {
> > +                /*
> > +                 * It is assumed that struct statx is architecture ind=
ependent.
> > +                 */
> > +                struct target_statx host_stx;
> > +                int mask =3D arg4;
> > +
> > +                ret =3D get_errno(statx(dirfd, p, flags, mask, &host_s=
tx));
> > +                if (!is_error(ret)) {
> > +                    if (host_to_target_statx(&host_stx, arg5) !=3D 0) =
{
> > +                        unlock_user(p, arg2, 0);
> > +                        return -TARGET_EFAULT;
> > +                    }
> > +                }
> > +
> > +                if (ret !=3D -TARGET_ENOSYS) {
> > +                    unlock_user(p, arg2, 0);
> > +                    return ret;
> > +                }
> > +            }
> > +#endif
> > +            if (*((char *)p) =3D=3D 0) {
> > +                /*
> > +                 * By file descriptor
> > +                 */
> > +                if (flags & AT_EMPTY_PATH) {
> > +                    unlock_user(p, arg2, 0);
> > +                    return -TARGET_ENOENT;
> > +                }
> > +                ret =3D get_errno(fstat(dirfd, &st));
> > +            } else if (*((char *)p) =3D=3D '/') {
> > +                /*
> > +                 * By absolute pathname
> > +                 */
> > +                ret =3D get_errno(stat(path(p), &st));
> > +            } else {
> > +                /*
> > +                 * By pathname relative to the current working directo=
ry
> > +                 * (if 'dirfd' is AT_FDCWD) or relative to the directo=
ry
> > +                 * referred to by the file descriptor 'dirfd'.
> > +                 */
> > +                 ret =3D get_errno(fstatat(dirfd, path(p), &st, flags)=
);
> > +            }
> > +            unlock_user(p, arg2, 0);
>=20
> Could you explain why we can't use fstatat() for the two previous cases
> "(*((char *)p) =3D=3D 0)" and "(*((char *)p) =3D=3D '/')"?
>=20

Man page on fstatat (http://man7.org/linux/man-pages/man2/stat.2.html)
says:

   AT_EMPTY_PATH (since Linux 2.6.39)
          If pathname is an empty string, operate on the file referred
          to by dirfd (which may have been obtained using the open(2)
          O_PATH flag).  In this case, dirfd can refer to any type of
          file, not just a directory, and the behavior of fstatat() is
          similar to that of fstat().  If dirfd is AT_FDCWD, the call
          operates on the current working directory.  This flag is
          Linux-specific; define _GNU_SOURCE to obtain its definition.

So it looks the branch "if (*((char *)p) =3D=3D 0)" can be handled by
fstatat().

Also, the man page says:

   If pathname is absolute, then dirfd is ignored.

So, it looks the case "else if (*((char *)p) =3D=3D '/')" can also be
handled by fstatat().

Very similar descriptions of the cases above can be found in
the man page for statx
(http://man7.org/linux/man-pages/man2/statx.2.html).

The whole string of if statements after "#endif" above should be now,
in my opinion:

        ret =3D get_errno(fstatat(dirfd, path(p), &st, flags));
        unlock_user(p, arg2, 0);

... and I will submit the patch with such code, if noone objects.

Yours,
Aleksandar Markovic

> Thanks,
> Laurent



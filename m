Received: from eggs.gnu.org ([2001:4830:134:3::10]:46203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gXNk6-0006Nw-2I
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gXNjy-0004ZK-Ty
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:57:13 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:43027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gXNjv-0004Qg-S5
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:57:09 -0500
Received: by mail-io1-xd43.google.com with SMTP id l3so1084106ioc.10
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 01:57:02 -0800 (PST)
MIME-Version: 1.0
References: <1544666977-4816-1-git-send-email-liq3ea@gmail.com>
	<154468427058.9757.15261216341451632615@02a1dbf831e2>
	<CAFEAcA_=Xn3KBhKwXG0_=iGtEZ56dK3TyLMcSnPafPZ8nL1zZg@mail.gmail.com>
In-Reply-To: <CAFEAcA_=Xn3KBhKwXG0_=iGtEZ56dK3TyLMcSnPafPZ8nL1zZg@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 13 Dec 2018 17:56:24 +0800
Message-ID: <CAKXe6SJdkTuBGD1x3Q3xa411KM=9MPB+-SB_yis3jD9u4nHbbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] util: check the return value of fcntl in
 qemu_set_{block, noblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu Developers <qemu-devel@nongnu.org>, fam@euphon.net, marcandre lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2018=E5=B9=B412=E6=9C=881=
3=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:31=E5=86=99=E9=81=93=EF=BC=
=9A

> On Thu, 13 Dec 2018 at 06:58, <no-reply@patchew.org> wrote:
> >
> > Patchew URL:
> https://patchew.org/QEMU/1544666977-4816-1-git-send-email-liq3ea@gmail.co=
m/
> >
> >
> >
> > Hi,
> >
> > This series failed the docker-quick@centos7 build test. Please find the
> testing commands and
> > their output below. If you have Docker installed, you can probably
> reproduce it
> > locally.
> >
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #!/bin/bash
> > time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D8
> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >
> > libpmem support   no
> > libudev           no
> >
> > WARNING: Use of SDL 1.2 is deprecated and will be removed in
> > WARNING: future releases. Please switch to using SDL 2.0
> >
> > NOTE: cross-compilers enabled:  'cc'
> >   GEN     x86_64-softmmu/config-devices.mak.tmp
> >
> >
> > The full log is available at
> >
> http://patchew.org/logs/1544666977-4816-1-git-send-email-liq3ea@gmail.com=
/testing.docker-quick@centos7/?type=3Dmessage
> .
>
> Patchew's attempt to limit the log to only the section with
> the errors/warnings seems to have misfired here -- it looks
> like it's picked the first bit of the log with a warning/error
> rather than extracting all of them, which in this case happens
> to be the harmless complaint that this build setup doesn't
> have SDL2 installed.
>
> The actual cause of the failure is much lower down:
>
>
Indeed.


>   GTESTER check-qtest-aarch64
> vhost-user-test: /tmp/qemu-test/src/util/oslib-posix.c:245:
> qemu_set_nonblock: Assertion `f !=3D -1' failed.
>

So here means the fcntl call returns '-1'.
Seems this test have some bugs?

Thanks,
Li Qiang


> Broken pipe
> GTester: last random seed: R02S61a1e35369394d7efb0a0e96d8af615d
>   GTESTER tests/test-qht-par
> vhost-user-test: /tmp/qemu-test/src/util/oslib-posix.c:245:
> qemu_set_nonblock: Assertion `f !=3D -1' failed.
> Broken pipe
> GTester: last random seed: R02Sbf8c21ef5f216840e073ff3e487dedbc
> vhost-user-test: /tmp/qemu-test/src/util/oslib-posix.c:245:
> qemu_set_nonblock: Assertion `f !=3D -1' failed.
> Broken pipe
> GTester: last random seed: R02Sfe8cd276fddf3a92891cf274bf88e888
> vhost-user-test: /tmp/qemu-test/src/util/oslib-posix.c:245:
> qemu_set_nonblock: Assertion `f !=3D -1' failed.
> Broken pipe
> GTester: last random seed: R02S7487fc065e22541ba4c78c0db6c61d3c
> Could not access KVM kernel module: No such file or directory
>
> thanks
> -- PMM
>

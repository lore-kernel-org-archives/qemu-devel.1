Received: from eggs.gnu.org ([2001:4830:134:3::10]:48703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gUrOY-0001pk-Cq
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gUrOU-0005GE-D6
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:00:38 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:40932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gUrOU-0005Fp-6y
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:00:34 -0500
Received: by mail-io1-xd42.google.com with SMTP id n9so4429ioh.7
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 03:00:33 -0800 (PST)
MIME-Version: 1.0
References: <20181206084816.30485-1-ppandit@redhat.com>
	<BN6PR18MB1220A0A33454573CA39058659FA90@BN6PR18MB1220.namprd18.prod.outlook.com>
	<CAFEAcA_B3FNQXLP4YnL70EPoFUbM89Dh1eFdZSVzpkJrgt+j_g@mail.gmail.com>
	<BN6PR18MB12207477BC1FC04674F98A2E9FA90@BN6PR18MB1220.namprd18.prod.outlook.com>
	<CAFEAcA_jT-KzFUmRRPNt-kUDMFAaBzT7Li_ESyuzMUTWdTVZeQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_jT-KzFUmRRPNt-kUDMFAaBzT7Li_ESyuzMUTWdTVZeQ@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 6 Dec 2018 18:59:56 +0800
Message-ID: <CAKXe6S+N_TDs6b=TqWM2POQyOHuWw=CaJOtteaVfYONkYbjc3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] i2c: pm_smbus: check smb_index before
 block transfer write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: liq3ea@outlook.com, P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, public@hansmi.ch, pjp@fedoraproject.org, mst@redhat.com, =?UTF-8?B?5p2O5by6?= <liq3ea@163.com>

Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2018=E5=B9=B412=E6=9C=886=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:46=E5=86=99=E9=81=93=EF=BC=
=9A

> On Thu, 6 Dec 2018 at 10:34, li qiang <liq3ea@outlook.com> wrote:
> >
> >
> > =E5=9C=A8 2018/12/6 18:16, Peter Maydell =E5=86=99=E9=81=93:
> > > On Thu, 6 Dec 2018 at 09:10, li qiang<liq3ea@outlook.com>  wrote:
> > >> Oh... Finally another one find this.....
> > >>
> > >> I've already found this. This is very a serious security issue.
> > > If you find a security issue, we would appreciate it if
> > > you let us know, rather than just waiting to see if
> > > anybody else notices it...
> >
> > I'm sorry for that.
> >
> > To be perfect, I'm currently trying to write an exp for i440fx.
> >
> > I intend report it after completing it.
>
> Is that an exploit for this bug, or for some other bug?


Just for this. But for now still no exp for i440fx.


> It's OK (and we recommend) reporting security issues as
> "I think this is probably exploitable"; we don't require
> a proof-of-concept for security bugs.
>

Yes, I know that, but as this issue is so good to write a perfect exploit
so I want to do more.

I know the qemu planing and know this issue doesn't affect anyone.
I want to do a perfect work.



Thanks,
Li Qiang


>
> thanks
> -- PMM
>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUrAq-00022t-If
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:46:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUrAm-0002Hl-1u
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:46:28 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:45811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUrAl-0002HX-R2
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:46:23 -0500
Received: by mail-ot1-x330.google.com with SMTP id 32so21541168ota.12
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 02:46:23 -0800 (PST)
MIME-Version: 1.0
References: <20181206084816.30485-1-ppandit@redhat.com>
	<BN6PR18MB1220A0A33454573CA39058659FA90@BN6PR18MB1220.namprd18.prod.outlook.com>
	<CAFEAcA_B3FNQXLP4YnL70EPoFUbM89Dh1eFdZSVzpkJrgt+j_g@mail.gmail.com>
	<BN6PR18MB12207477BC1FC04674F98A2E9FA90@BN6PR18MB1220.namprd18.prod.outlook.com>
In-Reply-To: <BN6PR18MB12207477BC1FC04674F98A2E9FA90@BN6PR18MB1220.namprd18.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 10:46:12 +0000
Message-ID: <CAFEAcA_jT-KzFUmRRPNt-kUDMFAaBzT7Li_ESyuzMUTWdTVZeQ@mail.gmail.com>
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
To: li qiang <liq3ea@outlook.com>
Cc: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, public@hansmi.ch, Prasad J Pandit <pjp@fedoraproject.org>, "Michael S. Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@163.com>, Li Qiang <liq3ea@gmail.com>

On Thu, 6 Dec 2018 at 10:34, li qiang <liq3ea@outlook.com> wrote:
>
>
> =E5=9C=A8 2018/12/6 18:16, Peter Maydell =E5=86=99=E9=81=93:
> > On Thu, 6 Dec 2018 at 09:10, li qiang<liq3ea@outlook.com>  wrote:
> >> Oh... Finally another one find this.....
> >>
> >> I've already found this. This is very a serious security issue.
> > If you find a security issue, we would appreciate it if
> > you let us know, rather than just waiting to see if
> > anybody else notices it...
>
> I'm sorry for that.
>
> To be perfect, I'm currently trying to write an exp for i440fx.
>
> I intend report it after completing it.

Is that an exploit for this bug, or for some other bug?
It's OK (and we recommend) reporting security issues as
"I think this is probably exploitable"; we don't require
a proof-of-concept for security bugs.

thanks
-- PMM

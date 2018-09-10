Received: from eggs.gnu.org ([2001:4830:134:3::10]:55047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fzAv4-0004Yf-Oy
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 21:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fzAv2-00038t-Nw
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 21:23:14 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:45663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1fzAv2-00038Q-IX
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 21:23:12 -0400
Received: by mail-qt0-x22a.google.com with SMTP id g44-v6so22376914qtb.12
	for <qemu-devel@nongnu.org>; Sun, 09 Sep 2018 18:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAKXe6S+5ucQuyA4Ru5J4_WLJWMy4znnmnPAJcPX3+j+uSiSW4Q@mail.gmail.com>
	<cfe362e5-fae3-1dc0-37c7-55633c1d236b@redhat.com>
In-Reply-To: <cfe362e5-fae3-1dc0-37c7-55633c1d236b@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 10 Sep 2018 09:22:34 +0800
Message-ID: <CAKXe6S+L-ahojWokhyuNeZtMd3gg7t=1mmyo04gYAoBRoXWJKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Question] Question about the i440FX device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, mst@redhat.com, liqiang02@corp.netease.com

Thanks Paolo,

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2018=E5=B9=B49=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=887:11=E5=86=99=E9=81=93=EF=BC=9A

> On 07/09/2018 08:32, Li Qiang wrote:
> > Hello all,
> >
> > I want to know why the i440FX in the following 'info qtree' information
> is
> > laid under the pci.0 bus.  In the chip spec here:
> > -->https://wiki.qemu.org/images/b/bb/29054901.pdf
> > I don't see this device.
> >
> > Can anyone give me some hints?
>
> Hi,
>
> the device implements what is in "3.2. PCI Configuration Space Mapped
> Registers" in the i440FX spec.
>
>
Indeed, also I find the comments in 'i440fx_class_init' is useful.
As I got the 'PCII440FXState' is for the "PCI-facing part of the host
bridge"
and 'I440FXState' is for the "host-facing part".

Thanks,
Li Qiang



> Paolo
>

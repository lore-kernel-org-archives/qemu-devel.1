Received: from eggs.gnu.org ([2001:4830:134:3::10]:53150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gAASI-000730-SA
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 05:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gAASI-0004Uk-1P
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 05:06:58 -0400
Received: from mail-it1-x130.google.com ([2607:f8b0:4864:20::130]:50241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gAASH-0004UY-S9
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 05:06:57 -0400
Received: by mail-it1-x130.google.com with SMTP id k206-v6so847236ite.0
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 02:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAKXe6SJVhc6Nyz+kUVk5NK9nfN=PN2pTB-bZyOeVY2SP+POtqw@mail.gmail.com>
	<20181010083700.za5zdwpxpvefalbn@sirius.home.kraxel.org>
In-Reply-To: <20181010083700.za5zdwpxpvefalbn@sirius.home.kraxel.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 10 Oct 2018 17:06:21 +0800
Message-ID: <CAKXe6SLQxzEaVcROJZoqUreq6P-meXgAEiGCnkn5V5MnoDGKbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Strange behavior abount bootindex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, arei.gonglei@huawei.com, Qemu Developers <qemu-devel@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2018=E5=B9=B410=E6=9C=8810=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:37=E5=86=99=E9=81=93=EF=BC=9A

>   Hi,
>
> > However, when I launch a VM with two virtio-blck-pci device:
> > disk1.test, bootindex=3D1
> > disk1, bootindex=3D2
> >
> > I see the above picture alternately. Sometimes the hostname is
> "localhost",
> > sometimes the hostname is "nimlite-test". Seems the bootindex has no
> effect.
>
> I'd bet the root filesystem identity (uuid or lvm volume) is the same on
> both disk images.  So whe linux looks for the root filesystem it may
> pick the one or the other depending on which is initialized first.
>
>
Indeed, the uuid is the same. Thank you so much Gerd.

Li Qiang


> cheers,
>   Gerd
>
>

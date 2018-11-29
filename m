Received: from eggs.gnu.org ([2001:4830:134:3::10]:49379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gSEMC-0006jC-EY
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gSEM8-0001n5-GQ
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:55:18 -0500
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:39359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gSEM4-0001jD-Nx
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:55:14 -0500
Received: by mail-it1-x143.google.com with SMTP id a6so1659730itl.4
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 20:55:11 -0800 (PST)
MIME-Version: 1.0
References: <1543312923-3074-1-git-send-email-liq3ea@gmail.com>
	<1543312923-3074-3-git-send-email-liq3ea@gmail.com>
	<20181127102736.q2322bc6uw4wvvif@starbug-mbp.local>
	<87a7lur8z8.fsf@dusky.pond.sub.org>
In-Reply-To: <87a7lur8z8.fsf@dusky.pond.sub.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 29 Nov 2018 12:54:33 +0800
Message-ID: <CAKXe6SLN2Av95SONvaT3C4sV5zvsxi8HFHXojWT0VQDwt8nCTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw: vmmouse: drop DEFINE_PROP_PTR()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Qemu Developers <qemu-devel@nongnu.org>

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=8827=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=888:38=E5=86=99=E9=81=93=EF=BC=
=9A

> Darren Kenny <darren.kenny@oracle.com> writes:
>
> > Hi Li Qiang,
> >
> > This is only a suggestion, I'm sure someone else might also correct
> > me, but I'm not sure the subject above really describes what is
> > happening in the commit as a whole.
> >
> > It seems to miss the point that the main change here is to use a
> > link type property, so maybe it might be better written as something
> > along the lines of:
> >
> >  Subject: [PATCH v2 2/2] hw: vmmouse: use link property instead of
> pointer
> >  Drop DEFINE_PROP_PTR() and replace with a link pointer via an
> >  instance init function (vmmouse_instance_initfn).
>
> Yes, that's better.  Or take inspiration from recent similar work, such
> as commit a8299ec1b24, and say something like
>
>     vmmouse: Use link instead of pointer property
>
>     According to qdev-properties.h, properties of pointer type should
>     be avoided.  Turn "ps2_mouse" into a link.
>
> Preferably with the commit message improved along these lines:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>


Hi Darren and Markus,

Thanks so much for your advice.
A new revision has been sent out.


Thanks,
Li Qiang


>
> [...]
>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gClYI-0004AW-S3
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gClYB-0002TT-Ph
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:07:54 -0400
MIME-Version: 1.0
References: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
	<f47b81dbce734e9806f9516eba8ca588e6321c2f.1539764043.git.artem.k.pisarenko@gmail.com>
	<20181017091204.GC22755@stefanha-x1.localdomain>
	<5a83aab6-1277-cc0e-7913-964a8fea5265@redhat.com>
	<CANzW0mvPxvDsCURzXjOdjR-8uLjXpyAouH80ik6asb0awwX+VA@mail.gmail.com>
	<c9cfbdff-f713-b49d-4ac8-33ed79b08502@redhat.com>
In-Reply-To: <c9cfbdff-f713-b49d-4ac8-33ed79b08502@redhat.com>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Wed, 17 Oct 2018 19:07:33 +0600
Message-ID: <CANzW0msXvjLESn2o559dOybWZvkRpFDuihSMGu6eZDBFOt_bFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/4] Introduce attributes
 to qemu timer subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, "open list:Block I/O path" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Yes, but without words ..."when they fire" in attributes comments.

=D1=81=D1=80, 17 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 17:24, Paolo Bonzi=
ni <pbonzini@redhat.com>:

> On 17/10/2018 12:57, Artem Pisarenko wrote:
> >> Further down in this patch the notation is QEMU_TIMER_ATTR_<id>, which=
 I
> >> think is clearer because QEMU_TIMER_ATTR(id) looks like a (non-existen=
t)
> >> macro.  Please use the QEMU_TIMER_ATTR_<id> notation consistently.
> >
> > Yes, I've just forgot to update comments after previous patch version,
> > where it actually was macro.
> >
> >> What is the purpose of this bit?  I guess it's just here as a
> >> placeholder because no real bits have been defined yet.  Hopefully the
> >> next patch removes it (/* This placeholder is removed in the next patc=
h
> >> */ would be a nice way to document this for reviewers).
> >
> > It's just to prevent compilation errors, as required by
> > https://wiki.qemu.org/Contribute/SubmitAPatch#Split_up_long_patches
> >
> >> The enum isn't needed and makes debugging harder since the bit number =
is
> >> implicit in the enum ordering.  This alternative is clearer and more
> >> concise:
> >>
> >>   #define QEMU_TIMER_ATTR_foo BIT(n)
> >
> > Agree.
>
> Like this?
>
> ...
>
> --

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=
=D0=BA=D0=BE

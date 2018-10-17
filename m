Received: from eggs.gnu.org ([2001:4830:134:3::10]:53476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCmw8-0001gV-Kj
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCmw2-00083I-9p
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:36:36 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:46658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gCmvy-00080b-Ep
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:36:28 -0400
Received: by mail-ot1-x329.google.com with SMTP id o21so26360455otb.13
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 07:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539778764.git.artem.k.pisarenko@gmail.com>
	<cf52eb15927d5517f9d525f6541b366a5b898af3.1539778764.git.artem.k.pisarenko@gmail.com>
	<d7c6680b-558b-a2a7-fff1-d0bef7338cb3@redhat.com>
In-Reply-To: <d7c6680b-558b-a2a7-fff1-d0bef7338cb3@redhat.com>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Wed, 17 Oct 2018 20:36:12 +0600
Message-ID: <CANzW0mug0bWY_f3iwmtvrgr-5cFCBbyO4Qr3+GRZn31QM21ezg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/4] vl,
 qapi: offset value calculation in RTC_CHANGE event reverted to
 match behavior before #1797033 bugfix and documented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

I fixed them and ready to submit v3.
Anything else ?

=D1=81=D1=80, 17 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 20:01, Eric Blake =
<eblake@redhat.com>:

> On 10/17/18 7:23 AM, Artem Pisarenko wrote:
> > Return value of qemu_timedate_diff(), used for calculation offset in
> QAPI 'RTC_CHANGE' event restored to keep compatibility, although it isn't
> documented that difference is relative to host clock advancement.
> > Added important note to 'RTC_CHANGE' event description to highlight
> established implementation specifics.
> >
>
> Hmm, I just replied to v1 before seeing that you sent v2; my comments
> about long lines and a typo still apply.
>
> > Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
> > ---
> >   qapi/misc.json |  3 ++-
> >   vl.c           | 10 +++++-----
> >   2 files changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index ada9af5..ed866f2 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -3070,7 +3070,8 @@
> >   # Emitted when the guest changes the RTC time.
> >   #
> >   # @offset: offset between base RTC clock (as specified by -rtc base),
> and
> > -#          new RTC clock value
> > +#          new RTC clock value. Note that value will be different
> depending
> > +#          on clock choosen to drive RTC (specified by -rtc clock).
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266 <(919)%20301-3266>
> Virtualization:  qemu.org | libvirt.org
>
--=20

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=
=D0=BA=D0=BE

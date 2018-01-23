Received: from eggs.gnu.org ([2001:4830:134:3::10]:58219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ee21G-0002r8-8U
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 12:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ee21B-0006tN-W4
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 12:05:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ee21B-0006sy-Pa
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 12:05:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC3E42576A
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 17:05:52 +0000 (UTC)
Date: Tue, 23 Jan 2018 17:05:43 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180123170543.GU490@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
	<1516112253-14480-11-git-send-email-pbonzini@redhat.com>
	<20180123153842.GT490@redhat.com>
	<CAMxuvawOjy-gwmCcc8TYHbNNbpmAs8aMPw6dfri8tOg15Kk=SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvawOjy-gwmCcc8TYHbNNbpmAs8aMPw6dfri8tOg15Kk=SA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 10/51] build-sys: silence make by default or
 V=0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc-Andre Lureau <mlureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Tue, Jan 23, 2018 at 05:08:08PM +0100, Marc-Andre Lureau wrote:
> Hi
>=20
> On Tue, Jan 23, 2018 at 4:38 PM, Daniel P. Berrange <berrange@redhat.co=
m> wrote:
> > On Tue, Jan 16, 2018 at 03:16:52PM +0100, Paolo Bonzini wrote:
> >> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>
> >> Move generic make flags in MAKEFLAGS (SUBDIR_MAKEFLAGS is more qemu =
specific).
> >>
> >> Use --quiet to silence make 'is up to date' message.
> >>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> Tested-by: Eric Blake <eblake@redhat.com>
> >> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> >> Message-Id: <20180104160523.22995-3-marcandre.lureau@redhat.com>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>  Makefile  | 2 +-
> >>  rules.mak | 2 ++
> >>  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > After applying it when you run 'make install' absolutely nothing is
> > displayed, but it none the less does work. This is very misleading
> > to devs who thing nothing is being installed...
>=20
> Right, you would need V=3D1 now
>=20
> > Either this needs reverting, or we need to re-write the 'install' tar=
get
> > so that it generates messages of whats being installed. Perhaps somet=
hing
> > like this
> >
>=20
> Make sense to me, could you send a former patch for review?

When I looked at this more, I became concerned that I would inevitably mi=
ss
places which need updating, as our makefiles as huge & have many targets
potentially affected by this. So I took the former approach, with a small
tweak to silence "is up to date" messages


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

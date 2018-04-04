Received: from eggs.gnu.org ([2001:4830:134:3::10]:33568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f3jrd-0006dh-IG
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f3jrZ-0004Fg-NI
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:58:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53894 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f3jrZ-0004FI-Hx
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:58:13 -0400
Date: Wed, 4 Apr 2018 15:58:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180404145803.GJ3186@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <mailman.35816.1522678020.27992.qemu-devel@nongnu.org>
	<B4011235-0338-474D-90E4-ABDF3DC8CCB7@gmail.com>
	<eeb9a3c8-e7ee-742b-fd6a-41c364d971c4@redhat.com>
	<57D8CDA1-C9D1-4CD7-99A1-203B570BF4D3@gmail.com>
	<20180404143859.GI3186@redhat.com>
	<e283ef1f-a1cd-c21a-9058-c68c76182486@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e283ef1f-a1cd-c21a-9058-c68c76182486@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] download: Add instructions for
 MacPorts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Programmingkid <programmingkidx@gmail.com>, Rainer M?ller <raimue@macports.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>

On Wed, Apr 04, 2018 at 04:45:48PM +0200, Paolo Bonzini wrote:
> On 04/04/2018 16:38, Daniel P. Berrang=C3=A9 wrote:
> >>> Actually I believe we should remove those links.  I don't think hos=
ting
> >>> QEMU binaries on mediafire is a good idea.
> >>>
> >>> Paolo
> >> Why not?
> > The source/quality of those binaries is completely opaque. We've no i=
dea who
> > built them, nor what build options were used, nor what/where the corr=
esponding
> > source is (required for GPL compliance), nor any checksum / signature=
 to
> > validate the binary isn't compromised since build, etc, etc.
> >=20
> > Pointing users to those binaries makes it appear QEMU project is bles=
sing
> > them, and so any issues with them directly reflect on QEMU's reputati=
on.
> >=20
> > If we're going to link to binaries telling users to download them, we=
 need
> > to be hosting them on qemu.org and have a clearly documented formal p=
rocess
> > around building & distributing them.
> >=20
> > Since both Homebrew & Macports are providing formal bulds though, it =
looks
> > simpler to just entirely delegate the problem to them, as we do for L=
inux
> > where we delegate to distro vendors to build & distribute binaries.
>=20
> Note that, to some extent, the same issues do apply to Win32 binaries
> (in particular, they are distributed under http and there are no
> signatures).  However, the situation is better in that they are hosted
> on an identifiable person's website, and of course Windows doesn't have
> something akin to Homebrew and Macports so there is no alternative to
> volunteers building and hosting the binaries.

It would be desirable & practical to address that for Win32, by building
the Win32 binaries at time of cutting the release, using the Mingw toolch=
ain
via one of our formal Docker environments. Would need buy-in of our relea=
se
manager to accept the extra work for making releases though...

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

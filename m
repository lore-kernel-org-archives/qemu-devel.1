Received: from eggs.gnu.org ([2001:4830:134:3::10]:38213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHSh1-0007ns-VT
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:51:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHSgx-0000DT-1w
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:51:16 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:32857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cHSgw-0000DC-RA
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:51:10 -0500
Received: by mail-wj0-f196.google.com with SMTP id kp2so8778764wjc.0
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 01:51:10 -0800 (PST)
Date: Thu, 15 Dec 2016 09:50:08 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161215095008.GB2762@stefanha-x1.localdomain>
References: <20161214142518.10504-1-stefanha@redhat.com>
	<20161215004752-mutt-send-email-mst@kernel.org>
	<20161215084738.GA5484@noname.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <20161215084738.GA5484@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.8] ui/gtk: fix "Copy" menu item
 segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 15, 2016 at 09:47:38AM +0100, Kevin Wolf wrote:
> Am 14.12.2016 um 23:49 hat Michael S. Tsirkin geschrieben:
> > On Wed, Dec 14, 2016 at 02:25:18PM +0000, Stefan Hajnoczi wrote:
> > > The "Copy" menu item copies VTE terminal text to the clipboard.  This
> > > only works with VTE terminals, not with graphics consoles.
> > >=20
> > > Disable the menu item when the current notebook page isn't a VTE
> > > terminal.
> > >=20
> > > This patch fixes a segfault.  Reproducer: Start QEMU and click the Co=
py
> > > menu item when the guest display is visible.
> > >=20
> > > Reported-by: Kevin Wolf <kwolf@redhat.com>
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > I don't think it's 2.8 personally, patch just disables an
> > illegal action. Similar to the hotplug crash fix I
> > have queued. Just document this as a known issue.
>=20
> This is an immediate crash for selecting a menu entry in the default
> view (which means killing a VM accidentally), we know the patch to fix
> it, and it is really small. Why would we not merge something like this?
> Are we making intentionally shitty releases these days?
>=20
> I don't know your hotplug problem, but if it's a crash that isn't a
> real corner case, that suggests that it should have been fixed. I mean,
> fixing bugs is exactly what the freeze is for.

A lot of patches are queued waiting for the 2.9 development cycle,
including bug fixes.  The reason these bug fixes aren't merged for 2.8
is because they are not release blockers and they risk introducing new
regressions.

A line must be drawn somewhere since we cannot keep delaying the release
another week while possibly introducing new regressions.

I have asked everyone, including Michael, to send only clear release
blockers (i.e. regressions, build failures, critical bugs) even if they
wanted to include more bug fixes.  I can understand that he's now
wondering why I merged this patch in -rc4.

Is this patch a regression fix?  No
Is it a build fix? No
Is it a critical bug?  Probably not since no one noticed it in 2.7.

I merged it because I misinterpreted git log output and thought it was a
regression :).

In any case, we've reached the point where nothing more goes into the
tree so that QEMU 2.8.0 can be released.

Stefan

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYUmdQAAoJEJykq7OBq3PIZI4IAIB4TSihuumXP3iUWwAZZnju
S5la9cdEfNWeZHH6IhvHCZhIuPOjl3ag4LXrzrg/pQBYWdQvFdTnxVuQdPKUJ6gG
yjPIvyNoyw8st2j/ZzqcO7THzHj9sGc64WQF2+8GEuhS3JaHGZZdcBAL4/wJvozC
q2qvOsJXAtZBxIjEwZFxdsl2o4JSNKJiPsKHUdztN/LzZXFH7swIBTPT2KquE7P+
W249k6JmOKeGF0swlXzfe2SOaNyA1AmCbEn1ZmnKUdLiojjkVo4o7RpBJOE6WzHx
HrXx5YAfOhrRW7YUU6prwoQgBj079sB2w38zGaT+cZNE2w+x+VdiJUx77GMw/Tg=
=YooN
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--

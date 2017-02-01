Received: from eggs.gnu.org ([2001:4830:134:3::10]:58160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYxkh-0001pu-J2
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 11:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYxkd-0003Vp-F3
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 11:27:23 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cYxkd-0003Vi-8N
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 11:27:19 -0500
Received: by mail-wm0-x242.google.com with SMTP id v77so6687959wmv.0
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 08:27:19 -0800 (PST)
Date: Wed, 1 Feb 2017 16:27:15 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170201162715.GC12283@stefanha-x1.localdomain>
References: <1485436265-12573-1-git-send-email-thuth@redhat.com>
	<1485436265-12573-2-git-send-email-thuth@redhat.com>
	<20170130141246.GE2118@stefanha-x1.localdomain>
	<7fdeebbe-984a-d536-3d8f-4d6a485439ca@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
In-Reply-To: <7fdeebbe-984a-d536-3d8f-4d6a485439ca@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/5] checkpatch: add a check for utf-8
 in commit logs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2017 at 04:57:53PM +0100, Thomas Huth wrote:
> On 30.01.2017 15:12, Stefan Hajnoczi wrote:
> > On Thu, Jan 26, 2017 at 02:11:01PM +0100, Thomas Huth wrote:
> >> This patch is a port of the following commit from the Linux kernel:
> >>
> >> commit 15662b3e8644905032c2e26808401a487d4e90c1
> >> Author: Joe Perches <joe@perches.com>
> >> Date:   Mon Oct 31 17:13:12 2011 -0700
> >>
> >>     checkpatch: add a --strict check for utf-8 in commit logs
> >>
> >>     Some find using utf-8 in commit logs inappropriate.
> >>
> >>     Some patch commit logs contain unintended utf-8 characters when do=
ing
> >>     things like copy/pasting compilation output.
> >>
> >>     Look for the start of any commit log by skipping initial lines tha=
t look
> >>     like email headers and "From: " lines.
> >>
> >>     Stop looking for utf-8 at the first signature line.
> >>
> >>     Signed-off-by: Joe Perches <joe@perches.com>
> >>     Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> >>     Cc: Andy Whitcroft <apw@shadowen.org>
> >>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  scripts/checkpatch.pl | 30 ++++++++++++++++++++++++++----
> >>  1 file changed, 26 insertions(+), 4 deletions(-)
> >=20
> > This patch prevents including names with non-ASCII characters in the
> > commit description.  Some people care about the proper spelling of their
> > names.
> >=20
> > Allowing UTF-8 in Signed-off-by and other headers isn't enough.
>=20
> Right, and I guess the folks from the kernel checkpatch noticed this,
> too. That's likely why the next patch restricts this check to only
> happen if the patch is from a mail with non-UTF-8 content type, but
> still contains UTF-8 characters, i.e. there is really something fishy
> with the character set of the patch description. Maybe I should squash
> the two patches together, so that it is more obvious what is going on her=
e?

In that case I'm okay with this patch :).  There's no need to squash it.

Sorry, I didn't make the connection with the next patch.  I thought that
was simply for checking that the byte stream is valid according to the
claimed charset.

Stefan

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkgxjAAoJEJykq7OBq3PIV20H/RpQb8J26o2qA7+YlOX/Vg12
Xdb4ht+LPorZO5vcsWnZZA5Zek1LYO5ukcr45KmucgW+4tw/JbFNsN+9XhRr1AnZ
IWbFN/QVI4DBxy0mCt6v7fwmJCUy1TvOZyy4tCX9bXAWL0LwOuod4piogYmWx6eW
UUWKtNFbL9juHNm5pa+m690v/kAKNUbuTzF06glwaLyJ9ms4jC0Xo28jY3IhnZzS
3YioPnVVO81qXjztDFIojMJmR60CwbFxqsLeTxI3IEnQntUza2PZC1rT2woGR7wD
7Qw8YCX/pjKXXgR92SAsqsIt7jPOJA6+PVwdxA6jFfWURHgvHlIoztDFNJnbrc0=
=tyhA
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--

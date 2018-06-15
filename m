Received: from eggs.gnu.org ([2001:4830:134:3::10]:56665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fTsYI-0004v9-LY
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fTsYF-0001NP-DN
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:30:22 -0400
Date: Fri, 15 Jun 2018 18:30:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180615173013.GH12972@stefanha-x1.localdomain>
References: <1528859749-25286-1-git-send-email-baiyaowei@cmss.chinamobile.com>
	<20180613035030.GB25430@flamenco>
	<23a38716-196f-53a0-0a3d-61f269b1dab4@redhat.com>
	<20180613141510.GA672@byw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cW+P/jduATWpL925"
Content-Disposition: inline
In-Reply-To: <20180613141510.GA672@byw>
Subject: Re: [Qemu-devel] [PATCH] tracing.txt: add missing '-' for trace
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, qemu-trivial@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>


--cW+P/jduATWpL925
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 10:15:10AM -0400, Yaowei Bai wrote:
> On Wed, Jun 13, 2018 at 06:27:49AM -0500, Eric Blake wrote:
> > On 06/12/2018 10:50 PM, Emilio G. Cota wrote:
> > >On Tue, Jun 12, 2018 at 23:15:49 -0400, Yaowei Bai wrote:
> > >>Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> > >>---
> > >>  docs/devel/tracing.txt | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >>diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
> > >>index 07abbb3..6ab32cc 100644
> > >>--- a/docs/devel/tracing.txt
> > >>+++ b/docs/devel/tracing.txt
> > >>@@ -18,7 +18,7 @@ for debugging, profiling, and observing execution.
> > >>  3. Run the virtual machine to produce a trace file:
> > >>-    qemu -trace events=3D/tmp/events ... # your normal QEMU invocati=
on
> > >>+    qemu --trace events=3D/tmp/events ... # your normal QEMU invocat=
ion
> > >
> > >The second dash is not missing; both '-args' and '--args' work.
> > >
> > >'-args' seems to be favoured though; see `qemu -h' or `qemu --h' :-)
> >=20
> > Actually, we're trying to fix that:
> > https://wiki.qemu.org/BiteSizedTasks#Consistent_option_usage_in_documen=
tation
> >=20
> > The one-vs-two dash usage is only supported in qemu, not in qemu-nbd
> > or qemu-img (that is, qemu acts as if it uses getopt_long_only(),
> > while the others use getopt_long() - except that we hand-rolled the
> > parser in qemu, meaning you might find quirks where it sometimes
> > doesn't even match getopt_long_only()).
> >=20
> > At any rate, since --trace is an option that is supported across
> > multiple binaries, we SHOULD favor the double-dash spelling in our
> > documentation, so that you can consistently reuse the same --trace
> > invocation without worrying whether the binary parses its arguments
>=20
> Yes, this patch is inspired by this situation when translating DPRINT into
> trace for a new qemu utility (much like qemu-nbd) following docs/devel/tr=
acing.txt.
> The utility complains it don't support -trace option. So i sent this
> patch after confirming this with qemu-nbd,qemu-io utilities.
>=20
> > with getopt_long() (where double is required) or like
> > getopt_long_only() (where the double is optional but supported).
> >=20
> > So I'm in favor of this patch, although it may need more of a commit
> > message summarizing the justification I've just pointed you to.
>=20
> Thanks for your nice explaination. If this patch could be merged i will
> send V2 with a commit message.

Please update the remaining occurrences of the -trace option syntax in
v2:

  $ git grep -- -trace docs/devel/tracing.txt

Stefan

--cW+P/jduATWpL925
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbI/elAAoJEJykq7OBq3PIDEcH/3tjlc9aVPiS7+IQoouv1ytk
bEDQFIeW6fp2RJy4l+e4k9M95cjeVu0t3tl3j1mxy7hYny75sZFoXGUcIkwGx2Dp
jz+VZDc3iAFSOtITib9gTzPquyh8m8jCKXo8k0ZUsuW5jQmqB+heY4+C7eFdNqOp
CqlmH2JF20bH0fymLSg+1Vr0z4FS6SBVmbDQCd2mP5tXAfJph7dAJaiGtTDUT08s
l5z0uM5MVmk3anBWs0e7BK5yxNXUBTP3sLWadVbcNfmK9uRZxU8DXzVELqHWiY5J
Ra1y1MLLurX9fzNe4AICwn/5uyR6FuahznxtUpziSfl0VMoFOwXvqpxIT223i78=
=ygn1
-----END PGP SIGNATURE-----

--cW+P/jduATWpL925--

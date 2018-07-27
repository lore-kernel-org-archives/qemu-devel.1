Received: from eggs.gnu.org ([2001:4830:134:3::10]:42199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fj2Oz-0007J2-5x
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fj2Ou-0001fS-H9
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:03:25 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:54299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fj2Ou-0001ec-8W
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:03:20 -0400
Received: by mail-wm0-x22c.google.com with SMTP id c14-v6so5188303wmb.4
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 06:03:20 -0700 (PDT)
Date: Fri, 27 Jul 2018 14:03:17 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180727130317.GE28555@stefanha-x1.localdomain>
References: <20180717195028.GA6691@localhost.localdomain>
	<CAFEAcA-pPsvfn7ARu_pn0HH03rZh05fLP=wr+p=hx5douSf7vA@mail.gmail.com>
	<87a7qnk9qa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y2zxS2PfCDLh6JVG"
Content-Disposition: inline
In-Reply-To: <87a7qnk9qa.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Why do we typedef every struct on QEMU?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


--y2zxS2PfCDLh6JVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 19, 2018 at 08:42:05AM +0200, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
> > On 17 July 2018 at 20:50, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Instead, we've repeatedly wasted time on debating which kind of ugly we
> hate less, and all we can show for our troubles is CODING_STYLE.  Which
> leaves a whole lot more questions open than it answers, so we can keep
> enjoying style debates.
>=20
> That the code shows anything resembling consistency at all is a
> testament to humanity's yearning for order within a chaotic world.

Going back to something concrete after this nice philosophical musing:

The coding style checker (checkpatch.pl) seems like a huge success to
me.  Without it, achieving consistency is futile.

checkpatch.pl defines the true coding style of QEMU - the subset that
can be automatically checked by patchew.  If we want to follow a coding
style, implementing the rules in checkpatch.pl is important.

(Though I'll be the first to admit that checkpatch.pl has many
limitations.)

Stefan

--y2zxS2PfCDLh6JVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbWxgVAAoJEJykq7OBq3PIK0EH/RfPZXhRxYp+hcdFuk/TyQc9
1K71XACxVDFGR71+uOvEXq8OO1OJJ9jViqEYHJ+eg08xIfiKl2R1xJRsm/TwtZSJ
1aQbE6Wv+RZEencIM//3CDszcAGDn6fiFNcVEeMiYjuMdbbdHNP4VEVhykl5t+WW
X1PrYb/gvLtfpXiKIyIPlEiQASYPvwhmB+zXpQWmcCfgZ38V3YPnrsIGgerTwL55
LH3exqI2omM7iQPFDIPnlE6NzjQpXtKBngXS6oVDp2yGVDJADdjC/4MddnJW6Pzh
oKaGSB5qweuvlAOHTRiSEskCEE+NWVhijLMXWjifBmPvJ6BELBQgJZ5Upx/yG5c=
=rmwH
-----END PGP SIGNATURE-----

--y2zxS2PfCDLh6JVG--

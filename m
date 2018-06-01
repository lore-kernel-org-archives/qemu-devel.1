Received: from eggs.gnu.org ([2001:4830:134:3::10]:39435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOjLO-0004cF-TC
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOjLL-0004xe-QN
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:39:46 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:46140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fOjLL-0004wu-Hb
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:39:43 -0400
Received: by mail-wr0-x244.google.com with SMTP id v13-v6so24527766wrp.13
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 05:39:43 -0700 (PDT)
Date: Fri, 1 Jun 2018 13:39:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180601123940.GQ8687@stefanha-x1.localdomain>
References: <20180521084249.10640-1-peterx@redhat.com>
	<8ef2c984-7817-a54f-ebae-a1f14e453b6a@redhat.com>
	<20180522033954.GC17282@xz-mi> <87y3g9a5th.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/YnR2r17TIEndSCI"
Content-Disposition: inline
In-Reply-To: <87y3g9a5th.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC] monitor: turn on Out-Of-Band by default again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--/YnR2r17TIEndSCI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 24, 2018 at 09:08:58AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
>=20
> > On Mon, May 21, 2018 at 09:13:06AM -0500, Eric Blake wrote:
> >> On 05/21/2018 03:42 AM, Peter Xu wrote:
> >> > We turned Out-Of-Band feature of monitors off for 2.12 release.  Now=
 we
> >> > try to turn that on again.
> >>=20
> >> "try to turn" sounds weak, like you aren't sure of this patch.  If you
> >> aren't sure, then why should we feel safe in applying it?  This text is
> >> going in the permanent git history, so sound bold, rather than hesitan=
t!
> >
> > Yeah I am not really strong at turn that on by default, that's why I
> > marked the patch as RFC.  I wanted to hear from your opinions.  For
> > now IMHO even with x-oob, postcopy can start to work with network
> > recovery, then the requirement from my part is done.  However I'm
> > thinking maybe we should still turn that on for all the people.  One
> > reason is that we already have the QMP capability negotiation so it
> > seems redundant (as you mentioned before), meanwhile exposing it to
> > broader users can let broader users to leverage this new bits directly
> > (meanwhile easier to expose potential issues for OOB too).
> >
> > Meanwhile I'm not confident too on that there can be other test cases
> > that has not yet been run with Out-Of-Band, so even if we solved all
> > existing problems I can't be sure that no further test will broke.
> > However I don't see it a problem for merging, since AFAIU I can't
> > really know what will break again (if there is) unless we apply that
> > to master again... :)
>=20
> The time to switch it on is now.  I don't think we can find remaining
> issues (if any) unless we do.
>=20
> The time for doubts is the day before rc0 ;)

I agree with Markus, let's enable OOB by default now.

The path to OOB has been long.  It's an invasive monitor change that
solves the postcopy recovery problem.  There have been lots of
complications but Peter has resolved them.

I personally don't think OOB is suitable for much else beyond postcopy
recovery (real-time code is a pain to write!), but we should switch to
this new code path and make sure it's solid for QEMU 3.0.

Stefan

--/YnR2r17TIEndSCI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbET6MAAoJEJykq7OBq3PI4EMIAMYWNy70E6yDKY++tYLc36LM
7vwAD1u/UdUa3XiOYqlVdlTB6DmAdLdqfS9tRlBz/sKGEGDBW6sGPSfZ8Y/rG07v
Hw/jATRnqQvHb9niLHJdI/LfVdQ2BE9REMdrbyih8/b41N0pJWdS2E7FgGr7nNcE
GIQYHZznDJRh/Zta8HyvETgyPtWLiWS8lWcue/VhyMVTv1Cb7iBcas4//fbNtan8
IUUKl2Px9HQEluFp/TRih5EcIQuHI3RPOFfSGHPWsMD05c8os4G/TLC0iTG1yeS3
G1p3zfmI5wdXZH3ibzgj6XERFrz95s8nxIdvKNMkJcEe2M45egDKaeFvXGxpZD8=
=TtI4
-----END PGP SIGNATURE-----

--/YnR2r17TIEndSCI--

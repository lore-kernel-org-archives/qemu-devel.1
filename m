Received: from eggs.gnu.org ([2001:4830:134:3::10]:51198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ctAwL-0002wQ-A9
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 06:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ctAwI-0000ou-33
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 06:34:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ctAwH-0000op-RZ
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 06:34:54 -0400
Date: Wed, 29 Mar 2017 11:34:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170329103449.GC10462@stefanha-x1.localdomain>
References: <CAFEAcA_Dwky8Jr+y3JACdK5MVM82syrvzuVktnJF0cyZ-FjY0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Dwky8Jr+y3JACdK5MVM82syrvzuVktnJF0cyZ-FjY0A@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu-devel mailing list vs DMARC and
 microsoft.com's p=reject policy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 06:35:55PM +0100, Peter Maydell wrote:
> Hi; it's been pointed out to me that we have a problem with qemu-devel
> unsubscribing people because of DMARC. Specifically:
>  * microsoft.com publishes a DMARC policy that has p=3Dreject
>  * some subscribers use mail systems that honour this and send bounces
>    for non-verifying emails from those domains
>  * the mailing list software (mailman) modifies emails that pass through
>    it, among other things adding the "[qemu-devel]" subject tag, in
>    a way that means that signatures no longer verify
>  * bounces back to mailman as a result of mailing list postings from
>    microsoft.com people can then cause people to be unintentionally
>    unsubscribed
>=20
> This is kind of painful. https://wiki.list.org/DEV/DMARC has the
> Mailman wiki information on the subject. In an ideal world nobody
> would use p=3Dreject because it breaks mailing lists. In the actual
> world we have a few choices:
>=20
>  (1) I could set dmarc_moderation_action=3DReject
>    * this means nobody can subscribe if they've set their dmarc policy
>      to reject (the "if you don't believe in mailing lists we don't
>      believe in you" policy).
>    * there is a certain purity to this option, in that it is pushing
>      the costs of this unhelpful mail config back on the organisations
>      which have chosen it; on the other hand I'm reluctant to make
>      life harder for people who are contributing to the project
>      and who typically don't have much say over corporate email config.
>  (2) I could reconfigure mailman to try to not rewrite anything that
>      we think is likely to be signed (in particular not the body or the
>      subject)
>    * this means dropping the [qemu-devel] tag from the subject, which I'm
>      a bit reluctant to do (it seems likely at least some readers are
>      filtering on it, and personally I quite like it)
>    * if anybody DKIM-signs the Sender: header we're stuck anyway
>  (3) I could set dmarc_moderation_action to Munge From, which means that
>      those senders who have a p=3Dreject policy will get their mails
>      rewritten to have a From=3D"Whoever (via the list) <qemu-devel@...>"
>      and their actual email in the Reply-to:
>    * if anybody's mail client doesn't honour Reply-to: then what they
>      think is a personal reply will go to the list by accident

Option 3 sounds good given that Option 2 is unlikely to be reliable
(e.g. DKIM-signing).

>  (4) I could do nothing, and hope that we don't get so many of these
>      that they actually result in unsubscriptions
>    * in any case emails won't end up going through to some recipients,
>      so this isn't much of an option anyway
>  (5) I could set the bounce processing config to be (much) less aggressive
>    * this seems like a bad idea
>    * in any case people whose systems honour DMARC still wouldn't get
>      mails from the p=3Dreject senders
>=20
> I don't really like any of these choices.
>=20
> For the moment I have picked option (3), but I'm open to argument
> that we should pick something else.
>=20
> thanks
> -- PMM

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY243JAAoJEJykq7OBq3PI14gIAJ1rBhirMfSv1sYtXC0nFwfi
WaDKVAyCiy1+fhTBCrHQUHPP2xp9r5wYLUqB+/YIaBXjnC1ijmGg1iij8l8WA1y0
XUXDy5LaQZxnF1+tHTPpZ3r3ntRk7ICW4T5CVfdhJusgvLb33LUKD0+0YQgHvSeJ
TY6QvQx0JjNKf716meGFrWPgFrp15kXfRJyW48kPgNmKP6pgjcvI599MTBdiJ7Bf
LFIvglu30WUIib80n5Tq//Rk2ErvOlde1QRuUfAf+lP794nxYXjl9h5ZbbjOe3Cx
EMyB8T61m84v2okLn2ELA5sdoDw6q8YnsrjCSKEPkiX0C04MKPOQBRnehUmA0SE=
=xn92
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--

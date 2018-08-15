Received: from eggs.gnu.org ([2001:4830:134:3::10]:43107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fpx2I-0002Fl-Qa
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fpx2F-0000WX-7g
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:44:33 -0400
Date: Wed, 15 Aug 2018 16:44:18 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180815144418.GG2158@andariel.pipo.sk>
References: <20180807043349.27196-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TmwHKJoIRFM7Mu/A"
Content-Disposition: inline
In-Reply-To: <20180807043349.27196-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 00/21] jobs: defer graph
 changes until finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jtc@redhat.com, Max Reitz <mreitz@redhat.com>


--TmwHKJoIRFM7Mu/A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 07, 2018 at 00:33:28 -0400, John Snow wrote:
> This series forces all jobs to use the "finalize" semantics that were
> introduced previously, but only exposed via the backup jobs.
> This series looks huge, but it's mostly mechanical changes broken out
> into a series of much smaller commits so that the changes are easier
> to follow at each step.

Please note that due to the semantics of the commands 'block-job-cancel'
and 'block-job-complete' at least in case of the drive/blockdev-mirror
job are technically blockjobs of it's own since they may fail or finish
in an unbounded amount of time and the actual return value on the
monitor does not reflect the result of the operation itself.

It would be very helpful if qemu treas them as such.

--TmwHKJoIRFM7Mu/A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlt0PEAACgkQHGwCByjY
1Goe2g//ejt93EI6yeZs/ONnchuQQzBTt9KJoCB8XDyH/H9bFXzh4GuCjgO9qSj2
l80NTltVqYEqac5fvlNvezLFl6khfq8qN4yUFk3KAHYQIIDPg1u107AJTTWfzhMO
wP2+mjaFD/l+oxYemUOoGXAE6PSuLTy8fTgMm++4GaGtc55cd+7d85QGztMYdIa2
JjMt9SKLYmefbyf4SKMaWUyW8VNaPhcCJ+RfdgS9OqYwvtv08/JzilDeL+3UEsTm
EUEZB64O9nOyVpXxDm8+BGQcKamBSgb+G78xzeHvlm+Fk0yACgMPohWDVeL2G2t1
p+RHCx+IYg8tf+gggwzHLDL9+Au8yIz0g8eWiS5HGrMDM4Q90GS/YK9EtI4tKWV4
vwVJIY1xYwNTXQifbTQTUNJdSuI7d+NzhfzUvMYNKbgzMJcYKW7lwKwT6lMl8yZL
kv/o+suSF5ElORzdL75T23zOZaowWc+P3KYExMe/L8Yv6KxnXvt+g1R2LGivsg94
74kNT0p2PHqae59VionHFGhoCTcIBhOzy8jKXQlpxCI9obmnDcDPl6B+r1FoOtrJ
P1aRJTHTJNo8e8F8kDaFwDDAzATY6etHxtjPoqJkGfZgTGwZmQAY/j6cMt3ctP/N
m+tYhQbUC3j/PsFc2IW1HOWADQ9dQ7yz5EZde7DctwGKuJAwKFU=
=J/+n
-----END PGP SIGNATURE-----

--TmwHKJoIRFM7Mu/A--

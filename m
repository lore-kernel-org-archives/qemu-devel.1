Received: from eggs.gnu.org ([2001:4830:134:3::10]:56369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drwR8-0007GZ-Sf
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 21:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drwR7-0002Fx-SN
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 21:25:54 -0400
Date: Wed, 13 Sep 2017 10:35:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170913003519.GC7550@umbus.fritz.box>
References: <150524208504.32496.18214181791773634133.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline
In-Reply-To: <150524208504.32496.18214181791773634133.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH] spapr_events: use QTAILQ_FOREACH_SAFE() in
 spapr_clear_pending_events()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2017 at 08:48:05PM +0200, Greg Kurz wrote:
> QTAILQ_FOREACH_SAFE() must be used when removing the current element
> inside the loop block.
>=20
> This fixes a user-after-free error introduced by commit 56258174238eb
> and reported by Coverity (CID 1381017).
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.

> ---
>  hw/ppc/spapr_events.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 66b8164f30be..e377fc7ddea2 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -702,9 +702,9 @@ static void event_scan(PowerPCCPU *cpu, sPAPRMachineS=
tate *spapr,
> =20
>  void spapr_clear_pending_events(sPAPRMachineState *spapr)
>  {
> -    sPAPREventLogEntry *entry =3D NULL;
> +    sPAPREventLogEntry *entry =3D NULL, *next_entry;
> =20
> -    QTAILQ_FOREACH(entry, &spapr->pending_events, next) {
> +    QTAILQ_FOREACH_SAFE(entry, &spapr->pending_events, next, next_entry)=
 {
>          QTAILQ_REMOVE(&spapr->pending_events, entry, next);
>          g_free(entry->extended_log);
>          g_free(entry);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm4fUUACgkQbDjKyiDZ
s5KsphAA4GN84p3hQzEtSgLUCLszkLPQf9vrd49qNWsMo12nmAmKAOdX55kOzM1Y
0sUwROmezSDtbu/Sn9B5+23QggquOMi1smU/eexZvtmEvlj3vAKlJpNkTKnT8OtU
VTXW/Zwu8BB0bMSa/K06WUrfbCCeA9k5yGp7Pfnrjc2n0qV/uOwdlBSzZisJHtLF
YDT5FcT1tpxX1oSqQSD0RSwNXa+p8iNRWufnWaTHxOpPgspR8aeZiFWFvpTTG7x7
eutEOGxE8eIYLKEwee2Ymo5TmKoqHzpVGdsckbRJXp3GOi20xb81vHtqj20IdjUs
A0+5S8njJ60gRbvU+2fc6MH0Gw6d6DoD90nfNYB8VCmku7yvwRlMYgpqhFc6dpYx
2BOv4yuplylU1n0DnQgQxHpFME9xSuQNMZ25aEHyRY1lD4JnXAWQpKsJ3D9AHgYz
rR/GcZ1lfMM9cb6iRoSpxZrV9qRr5euE3oeSb219K3MqjOgS5NoqH/U0awedmZQB
v2wVwaDqAZX4fD/WoUuAdAY0Q2m65EpMxkvgRB8ImyGhl6wGo8iB815V/oYlXHPb
hHDQmlfvcPTj4AlWiNjx8DHvfG/wtivNX7CnDNBubkz9cRJqjfiYTbsj2njtbyfx
5hTYHmvnsEk0hNi8r3KOYr8YUj5esmXlJwziVcsXRLAuOmsX6TE=
=B0NG
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--

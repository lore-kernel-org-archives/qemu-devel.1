Received: from eggs.gnu.org ([2001:4830:134:3::10]:53517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d7vWl-0002Fz-49
	for qemu-devel@nongnu.org; Mon, 08 May 2017 23:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d7vWh-0007UX-3L
	for qemu-devel@nongnu.org; Mon, 08 May 2017 23:09:31 -0400
Date: Tue, 9 May 2017 12:43:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170509024317.GK25748@umbus.fritz.box>
References: <20170508205735.23444-1-ehabkost@redhat.com>
	<20170508205735.23444-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5dNcufZ4prhark0F"
Content-Disposition: inline
In-Reply-To: <20170508205735.23444-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/3] audio: Rename audio_init() to
 soundhw_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, hpoussin@reactos.org, Gerd Hoffmann <kraxel@redhat.com>, agraf@suse.de


--5dNcufZ4prhark0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 05:57:34PM -0300, Eduardo Habkost wrote:
> To make it consistent with the remaining soundhw.c functions and
> avoid confusion with the audio_init() function in audio/audio.c,
> rename audio_init() to soundhw_init().
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes v2 -> v3:
> * Update hw/ppc/prep.c audio_init() call too
>=20
> Changes v1 -> v2:
> * Rebase to latest qemu.git master
> ---
>  include/hw/audio/audio.h | 2 +-
>  hw/audio/soundhw.c       | 2 +-
>  hw/ppc/prep.c            | 2 +-
>  vl.c                     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/audio/audio.h b/include/hw/audio/audio.h
> index 259bb2cf96..119f7d78d5 100644
> --- a/include/hw/audio/audio.h
> +++ b/include/hw/audio/audio.h
> @@ -7,7 +7,7 @@ void isa_register_soundhw(const char *name, const char *d=
escr,
>  void pci_register_soundhw(const char *name, const char *descr,
>                            int (*init_pci)(PCIBus *bus));
> =20
> -void audio_init(void);
> +void soundhw_init(void);
>  void select_soundhw(const char *optarg);
> =20
>  #endif
> diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
> index 5e96b73c81..29565da93d 100644
> --- a/hw/audio/soundhw.c
> +++ b/hw/audio/soundhw.c
> @@ -129,7 +129,7 @@ void select_soundhw(const char *optarg)
>      }
>  }
> =20
> -void audio_init(void)
> +void soundhw_init(void)
>  {
>      struct soundhw *c;
>      ISABus *isa_bus =3D (ISABus *) object_resolve_path_type("", TYPE_ISA=
_BUS, NULL);
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 96a4813b3f..4a7d2cfbe0 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -783,7 +783,7 @@ static void ibm_40p_init(MachineState *machine)
>                         &cmos_checksum);
> =20
>      /* initialize audio subsystem */
> -    audio_init();
> +    soundhw_init();
> =20
>      /* add some more devices */
>      if (defaults_enabled()) {
> diff --git a/vl.c b/vl.c
> index a2400e1ab6..42fd66ac0d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4569,7 +4569,7 @@ int main(int argc, char **argv, char **envp)
> =20
>      realtime_init();
> =20
> -    audio_init();
> +    soundhw_init();
> =20
>      if (hax_enabled()) {
>          hax_sync_vcpus();

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5dNcufZ4prhark0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZESzFAAoJEGw4ysog2bOSDnAP/iT5g4KH8i8I9N35M2jsQUiH
2HwsjGhpYpfB7W8fdU3TORXS9HtsjImfHQF2v4F9uE1f3WVwCUK0bc+qcuazSfQA
/MHBRlleWTovhBJ95pK68hd9v/lmJd1D+tXwXeFiPmdHTA699KS317VIkB6clP8D
sig/DoKX3DsX0UlIK8F/X7/iPCxzWDBTffCPQkycTA75pinjoPG52LBA0I5PW+uu
X+YM3+LRlxscaCo6Ln9v4yGA2J9QwG2H9pIJHx261WFqTouVUsJOofQf48a9mb9M
9/vY94R0jjjaaiBKRlwGRZNlRr4Uw8fZcR1+3hHNr55ZtVn1BYvLNRL1esS5btBp
4adeG77Kjh+S5Fyf66hYKixpewy6tqw7ziLe2NuchIDzkOcnBaP78v/EHoSdnUos
7sETBtFD+iISoQN+uU6H9eO711a3EN2pHR16oA8RRtXA6cqX0nME9gAshQVtA9Zs
QZxaX98MC65nhqHw1XT0WtnehoEXGsyYjEcxehW6BljMLHVB/An7tnqpryS3D+yC
+/t24m5UnplKyTJjO2ngS5RVxh2L6+ZEhdnZws00QRBTcCqsXvq+aX1BF9xGx3WB
BFCoH97NnBpoml+QjYX5HtWyjheUI9FUT3+xOnDIH5PpPtzSIbkp0sHDLuI+HdF+
WMrMzo9YQea4UQDr7vsA
=Kj0o
-----END PGP SIGNATURE-----

--5dNcufZ4prhark0F--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gICiq-0000n1-E2
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 09:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gICbJ-00012G-Sl
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 09:01:37 -0400
Date: Thu, 1 Nov 2018 13:01:22 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181101130122.GU24946@stefanha-x1.localdomain>
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-13-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O0IT7rLmWuveAsNR"
Content-Disposition: inline
In-Reply-To: <20181031002526.14262-13-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v3 12/13] arm: Instantiate NRF51 Timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, "open list:NRF51" <qemu-arm@nongnu.org>


--O0IT7rLmWuveAsNR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 08:25:26PM -0400, Steffen G=F6rtz wrote:
> +    /* TIMER */
> +    for (i =3D 0; i < NRF51_NUM_TIMERS; i++) {
> +        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized",=
 &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +
> +        base_addr =3D NRF51_TIMER_BASE + i * 0x1000;

s/0x1000/NRF51_TIMER_SIZE/

Aside from that:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--O0IT7rLmWuveAsNR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb2vkiAAoJEJykq7OBq3PIjxgIAKMKLURqfIuRb0WhlyTP0De9
3daFThkTffbXOOL/yvYA4XAfEErsRuev1F69NBviuyMXJ/qd12B8RVqiJ3zzNp9r
o4sG99xu67LOWbV2WPp2F7H684HOItODgMc3YoM37D8WiSI/3uuC08WfNi1Udbws
ktDPnTvVyO8vdd/EaQll45ehn8ADZqWlNPPnAyVP9bUXH/WAzBLtqkF0xfU02dBn
qe9PvMws0AgqW5PBdakTHsEoIWG1wgmRehkWiZtadqoWiWSaH8//VLmyOacGTyVt
uSBJT8bMGEzK5es9HfxylExKxlkWYuGEUdog92RBQmsEMntW+cL+DYD9W4OQCQM=
=SBS4
-----END PGP SIGNATURE-----

--O0IT7rLmWuveAsNR--

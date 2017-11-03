Received: from eggs.gnu.org ([2001:4830:134:3::10]:49956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAcyt-0001dC-6J
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAcys-0005sa-E9
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:29:59 -0400
Date: Fri, 3 Nov 2017 14:29:49 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171103142949.GP5078@stefanha-x1.localdomain>
References: <CAPuOgO3vuhZ8Dgk5GZrDFCrCV-a-1-Jq+eERma_vysh1PQohSg@mail.gmail.com>
	<20171024120602.GC18756@stefanha-x1.localdomain>
	<CAPuOgO2UT2G4YOOp_yT6esN-yA6hiyv=JA=wBqiC+poMOG-C3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bd2KlmcTHfsQFEJ+"
Content-Disposition: inline
In-Reply-To: <CAPuOgO2UT2G4YOOp_yT6esN-yA6hiyv=JA=wBqiC+poMOG-C3w@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] Question regarding qemuimg check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ala Hino <ahino@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-discuss@nongnu.org, Nir Soffer <nsoffer@redhat.com>


--Bd2KlmcTHfsQFEJ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 24, 2017 at 03:31:30PM +0300, Ala Hino wrote:
> Can we always run qemu-img check with -r leaks option, even if there are no
> leaks?

Running "qemu-img check -r leaks" opens the file in read/write mode.  It
must only be used when the disk image is writable and the VM is not
accessing it.  If thoses conditions are met then you can use it.

Stefan

--Bd2KlmcTHfsQFEJ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZ/H1dAAoJEJykq7OBq3PIlSIH/1MUiM3kydr/HAVcEBc1R1oD
T0OJzbkgrH08TEEk5/92M1dV7ON0GQF+PY2YeSX1VsJeit5oNN7kwy/L6QWkpqzs
wY0dt+zoHDc/cYbjYY3lG/EJV1tmXBtUmczwIAeEPb5gqVFIzwVwMHnKTyh5xEqA
2R1p+S5akezTuzkYWRAviAJtqFFL9BuIySdHP0TLjaw18ukBqv634B/O77qRs5xW
sdPxmlypQX2Uyh+amaZkbwPmMFP2LH1upf7J6/3WqLbN90Gmy9FMAhhSr9eUWPd8
hyf347ytwoKw2LxTlKZdZKrHbth4uxsdNhh/5DssMm52NPZtYg/BVADKp0Ukpac=
=1uJl
-----END PGP SIGNATURE-----

--Bd2KlmcTHfsQFEJ+--

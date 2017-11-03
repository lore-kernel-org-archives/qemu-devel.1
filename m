Received: from eggs.gnu.org ([2001:4830:134:3::10]:60583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAYTs-0002ly-Fv
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAYTp-0005RJ-AR
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:41:40 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:54837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eAYTp-0005R3-4I
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:41:37 -0400
Received: by mail-wr0-x242.google.com with SMTP id o44so1941281wrf.11
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 02:41:36 -0700 (PDT)
Date: Fri, 3 Nov 2017 09:41:33 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171103094133.GB5078@stefanha-x1.localdomain>
References: <20171102180310.24760-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <20171102180310.24760-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ioapic/tracing: Remove last DPRINTFs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, peterx@redhat.com


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2017 at 06:03:10PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Remove the last few DPRINTFs from hw/intc/ioapic.c and turn
> them into tracing.  In one case it's a new trace, in the others
> it's just adding a parameter to the existing traces.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/intc/ioapic.c     | 17 +++--------------
>  hw/intc/trace-events |  5 +++--
>  2 files changed, 6 insertions(+), 16 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZ/DnNAAoJEJykq7OBq3PIR6QIALEg9YaNXy/c4R3lkVmUUivX
yRTwC/6hG4N5niYtvX9+fnm028D9ngLWTu4IAFr3zc8KIVb4R1eXTkxoC/tbUfoc
oXYX6GW/EnUi+igARbDTbISKEexn0DR2qxrpZMpgCnPbGH1KQFlS1zMYsD4iTSpi
9sr3y3+Gk2v26KIczGNLn6chP4vD1Ojq3OPdy4KAnJCyGk25ZGU3RAybgmr6HbZ8
Mr2CwsFcH/GiAGTyFZ5SFwtN6pwihzGBngCli9dMIVPE7bxObSA4SoKPlHsF4yZe
11wnUpyDRP8HgdH18YQ1FwxKY/RNrC/oj8arvAMtwE7rcdEzT0aNyH3Bl/2+qEw=
=TREk
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQALY-0004Mw-VH
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQALX-0007Rx-CE
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:41:52 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fQALX-0007Rg-4Q
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:41:51 -0400
Received: by mail-wm0-x242.google.com with SMTP id j15-v6so4509182wme.0
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 04:41:50 -0700 (PDT)
Date: Tue, 5 Jun 2018 12:41:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180605114148.GD11888@stefanha-x1.localdomain>
References: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
	<1527840629-18648-5-git-send-email-junyan.he@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline
In-Reply-To: <1527840629-18648-5-git-send-email-junyan.he@gmx.com>
Subject: Re: [Qemu-devel] [PATCH V6 4/7] configure: add libpmem support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com
Cc: qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, dgilbert@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 04:10:26PM +0800, junyan.he@gmx.com wrote:
> From: Junyan He <junyan.he@intel.com>
>=20
> Add a pair of configure options --{enable,disable}-libpmem to control
> whether QEMU is compiled with PMDK libpmem [1].
>=20
> QEMU may write to the host persistent memory (e.g. in vNVDIMM label
> emulation and live migration), so it must take the proper operations
> to ensure the persistence of its own writes. Depending on the CPU
> models and available instructions, the optimal operation can vary [2].
> PMDK libpmem have already implemented those operations on multiple CPU
> models (x86 and ARM) and the logic to select the optimal ones, so QEMU
> can just use libpmem rather than re-implement them.
>=20
> [1] PMDK (formerly known as NMVL), https://github.com/pmem/pmdk/
> [2] https://github.com/pmem/pmdk/blob/38bfa652721a37fd94c0130ce0e3f5d8baa=
3ed40/src/libpmem/pmem.c#L33
>=20
> Signed-off-by: Junyan He <junyan.he@intel.com>
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  configure | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbFnb8AAoJEJykq7OBq3PIZ4gH/j3iwYvM2mL2QcoW2sVBIAY9
BjoOFCJyIwANO7WttDXM4CiBHfoFodzNqh44nELAFuDxPkFz1Zj2JCw53cTonu/y
s4l9Iz9ktCR4Hx2S4o5LEI6W95nKZZMAH5Ynr3uxFXyyHg4h/1bpULSxk3WkGPZk
MO6oYmXlkXmBtCdeqNcAfTeqF+JAhwJdVkaYoLaNxQ0V6irUs8637l25dCt8WCnP
bLzcOFwp487xkV3i713BlL9T1NVa/QMOqpZUF1B4SJoqUcKuxyJo4nIXeU0Sm1/L
zwO8tAtY2T1JFAFBiKSRro0Y/1zafzZIZVIwgoqQh33PYRIw81/ieH3aXVB3Mug=
=6exv
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--

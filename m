Received: from eggs.gnu.org ([2001:4830:134:3::10]:44355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cwUDy-0004lu-OA
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cwUDt-0002kB-PA
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:46:50 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cwUDt-0002hV-Ig
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:46:45 -0400
Received: by mail-wr0-x243.google.com with SMTP id g19so20300966wrb.0
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 06:46:45 -0700 (PDT)
Date: Fri, 7 Apr 2017 14:46:41 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170407134641.GH16146@stefanha-x1.localdomain>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170331084147.32716-2-haozhong.zhang@intel.com>
	<20170406102416.GA21895@stefanha-x1.localdomain>
	<20170406104649.jh263v7zijdxsywl@hz-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CEUtFxTsmBsHRLs3"
Content-Disposition: inline
In-Reply-To: <20170406104649.jh263v7zijdxsywl@hz-desktop>
Subject: Re: [Qemu-devel] [RFC PATCH 1/4] pc-dimm: add 'reserved-size' to
 reserve address range after the ending address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dan.j.williams@intel.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--CEUtFxTsmBsHRLs3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2017 at 06:46:49PM +0800, Haozhong Zhang wrote:
> On 04/06/17 11:24 +0100, Stefan Hajnoczi wrote:
> > On Fri, Mar 31, 2017 at 04:41:44PM +0800, Haozhong Zhang wrote:
> > > If option 'reserved-size=3DRSVD' is present, QEMU will reserve an
> > > address range of size 'RSVD' after the ending address of pc-dimm
> > > device.
> > >=20
> > > For the following example,
> > >     -object memory-backend-file,id=3Dmem0,size=3D4G,...
> > >     -device nvdimm,id=3Ddimm0,memdev=3Dmem0,reserved-size=3D4K,...
> >=20
> > "reserved-size" is not a clear name.  I suggest calling the property
> > "num-flush-hints" (default 0).  QEMU can calculate the actual size in
> > bytes.
> >=20
> >   -device nvdimm,num-flush-hints=3D1
> >=20
> > QEMU will use one flush hint and reserve enough space (e.g. 1 page) for
> > the MMIO region.
> >
>=20
> Each flush hint can be as small as one cache line size which is also
> the size used in this patch series.
>=20
> We need to calculate the size of all flush hints in pc_dimm_memory_plug(),
> because when building the flush hint address structure we need to know
> the address of flush hints.
>=20
> IIUC, pc_dimm_memory_plug() is not specific to x86, so it's better
> take a general way to get the vcpu cache line size in pc_dimm_memory_plug=
(),
> which seemingly lacks in QEMU (though I believe it should be doable).
>=20
> To make things simple, I leave the size decision to users, and check
> whether it's large enough when building the flush hint address
> structures in patch 4.

Do you see my concern that "reserved-size" is not a good property?

 * How does the user choose a sensible value?

 * Why is it called "reserved-size" instead of "flush-hints-size"?

Stefan

--CEUtFxTsmBsHRLs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY55hBAAoJEJykq7OBq3PIu1wIAKu7X4UvcJ2ToZJikn4kgTLl
yEz9kNjQu9M/+XKSnfYMOTaaqQsUW7OoXRJ2iVckP1Yw33a7LyDUlISO633rpidb
p2HAx9kLyEyqJtSICEnCRRN5uSpR4uwVtJvipY6mEerUrZjOtQER1eXanQycOJVp
Etpfh0RtBpQyiuDLpmNtAMYCdMS/Mdt+CaisS241+Pkk8UyCStj3VO8aIj6Wtpww
Tg5U4mdVGoqwrVoMfhDouIW3GflMAcC0WsaQkpgCeg8n/ryyre8oCpwnX4+ZlXQD
e19ZK0s11ph47g19mCfMeLEauIRZefgYl+BzRDSJ+PEi6mh1mWL2yx+fhPzfoW0=
=0PnD
-----END PGP SIGNATURE-----

--CEUtFxTsmBsHRLs3--

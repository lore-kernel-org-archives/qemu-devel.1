Received: from eggs.gnu.org ([2001:4830:134:3::10]:35900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dJGJw-0007Nb-4u
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dJGJr-0001hd-A7
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:35:08 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dJGJr-0001gN-3T
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:35:03 -0400
Received: by mail-wm0-x244.google.com with SMTP id 70so10865315wme.1
	for <qemu-devel@nongnu.org>; Fri, 09 Jun 2017 02:35:02 -0700 (PDT)
Date: Fri, 9 Jun 2017 10:34:51 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170609093451.GC26144@stefanha-x1.localdomain>
References: <20170606072229.9302-1-haozhong.zhang@intel.com>
	<20170606072229.9302-4-haozhong.zhang@intel.com>
	<20170608155249-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Content-Disposition: inline
In-Reply-To: <20170608155249-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] nvdimm: add a boolean option
 "restrict"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Dan Williams <dan.j.williams@intel.com>


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 03:56:42PM +0300, Michael S. Tsirkin wrote:
> On Tue, Jun 06, 2017 at 03:22:28PM +0800, Haozhong Zhang wrote:
> > If a vNVDIMM device is not backed by a DAX device and its "restrict"
> > option is enabled, bit 3 of state flags in its region mapping
> > structure will be set, in order to notify the guest of the lack of
> > write persistence guarantee. Once this bit is set, the guest OS may
> > mark the vNVDIMM device as read-only.
> >=20
> > This option is disabled by default for backwards compatibility. It's
> > recommended to enable for the formal usage.
> >=20
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
>=20
> Seems wrong to me. E.g. it won't work in a nested
> virt setup. What if backend is dax but is not armed?
> Can't the armed bit of the backing device be tested?
> Name "restrict" is also confusing. Can we reuse cache=3D
> options? E.g. cache=3Dunsafe etc.

The -drive cache=3D options (writeback, writethrough, none, directsync,
unsafe) are confusing and considered legacy options.  The new options
are -drive
cache.writeback=3Don|off,cache.direct=3Don|off,cache.no-flush=3Don|off.

I suggested to call the option -device nvdimm,armed=3Dauto|on|off in
another email.  "Armed" is the term used by the NVDIMM/NFIT
specification and it has an NVDIMM-specific meaning.

Stefan

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOmu6AAoJEJykq7OBq3PIUYEIAJ47uyg7nM52FToaj7CL9of6
rjVXeXvqeyavvlhmlrwjCPoLDVrKa13n32Jb+MIvrqIEklj8Pk+gfx9aorYvxoSo
ZjjEbvoC8cG1WdEuR0dn51UConBihiB5gvRMSjsP3iZCYpz+ZmVFC8ixqj3MMCFf
R3k5Ts8hBG8wsDns+udrKwuBrV8N1RaLwSUPCwNKSIeI6Y6y75kkxjIuoUKv5zwM
IGKOS0eyugF2XTFiFB2F+Tu5WkzHT0KoR7bnOAoGKfKDl+I0gFFRuqZtFdQ1Fc3W
FHiYCDchhNOV6lGGwDZPLYuhAFdRXdWdJ921sm5QPXZCbvOWYOfvq3YdbUFekVI=
=no2q
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cwV4x-0005TI-MO
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cwV4t-00072d-GJ
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:41:35 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:33318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cwV4t-00072Y-9p
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:41:31 -0400
Received: by mail-wm0-x236.google.com with SMTP id y18so72729wmh.0
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 07:41:31 -0700 (PDT)
Date: Fri, 7 Apr 2017 15:41:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170407144128.GK16146@stefanha-x1.localdomain>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170331084147.32716-5-haozhong.zhang@intel.com>
	<20170406101356.GC21261@stefanha-x1.localdomain>
	<20170406105309.4yqkqo3itlhkuy5o@hz-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MHXEHrrXKLGx71o"
Content-Disposition: inline
In-Reply-To: <20170406105309.4yqkqo3itlhkuy5o@hz-desktop>
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] nvdimm acpi: build flush hint
 address structure if required
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, dan.j.williams@intel.com, Richard Henderson <rth@twiddle.net>


--3MHXEHrrXKLGx71o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2017 at 06:53:09PM +0800, Haozhong Zhang wrote:
> On 04/06/17 11:13 +0100, Stefan Hajnoczi wrote:
> > On Fri, Mar 31, 2017 at 04:41:47PM +0800, Haozhong Zhang wrote:
> > >=20
> > > Add an boolean option 'flush-hint' to device 'nvdimm'. If it's on, a
> > > flush hint address structure will be constructed for each nvdimm
> > > device.
> >=20
> > Users should not need to set the flush hint option.  NVDIMM
> > configurations that persist data properly without Flush Hint Addresses
> > shouldn't use them (for best performance).  Configurations that rely on
> > flush hints *must* use them to guarantee data integrity.
>=20
> It's for backwards compatibility, i.e. migrating a VM on QEMU w/o
> flush hint support to another one w/ flush hint support. By using a
> flush-hint option and making it disabled by default, users can ensure
> both QEMU provide the same VM configuration.

I think QEMU should play a role in deciding whether to use Address Flush
Hints or not.

We should not require the user to set a sensible value.  If they get it
wrong then they may suffer data loss!

Stefan

--3MHXEHrrXKLGx71o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY56UYAAoJEJykq7OBq3PIy74H/iG5NtXVqym24/Kq3uQ9I8Zd
/OG6MglUw8K10j/nb+m56cAWQA2HUnkuB6gXCKLomWdnzll8roYU43fbrTs4zHb/
/vYSxpX1uAJAL74T5yLcYTBQaQ7hiXgki/D3ONBgM4pCddaKR4SUalF0Vp92u+cw
zpzH/oYDd1Vb/9gcqk4WeylWaqtolYMitgliCh6muCJ9dzZR280XseJa3SBoki8Y
fXmW4WxZLNtCijoH+K8ZnhNurhEnLsWSV5338fJcivkfvtVhIRw0lkNiunPx5GAF
7eFRWAlJrAVH+FHsZheFwSjkuGgbq3RvJxLqhoq0SpkCRvt6b6TeP09Sp8OCFAI=
=WzBD
-----END PGP SIGNATURE-----

--3MHXEHrrXKLGx71o--

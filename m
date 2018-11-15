Received: from eggs.gnu.org ([2001:4830:134:3::10]:57214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNF4C-00031J-Re
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:40:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNF48-0008Up-O1
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:40:08 -0500
Date: Thu, 15 Nov 2018 10:39:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181115103955.GK10900@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181115035659.85245-1-aik@ozlabs.ru>
	<20181115101112.GF10900@redhat.com>
	<20181115103308.GI2547@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181115103308.GI2547@umbus.fritz.box>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu] configure/fdt: Use more strict test
 for libfdt version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Thu, Nov 15, 2018 at 09:33:08PM +1100, David Gibson wrote:
> On Thu, Nov 15, 2018 at 10:11:12AM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > On Thu, Nov 15, 2018 at 02:56:59PM +1100, Alexey Kardashevskiy wrote:
> > > The libfdt installed in the system is preferred to the dtc submodul=
e by
> > > default. The recent libfdt update added a new symbol - fdt_check_fu=
ll -
> > > and this breaks compile if there is an older libfdt installed in
> > > the system.
> >=20
> > Unless I'm missing something, QEMU doesn't use the fdt_check_full sym=
bol,
> > so why would the lack of this symbol cause a compile failure.=20
> >=20
> > It should be fine if the dtc submodule contains a newer libfdt than t=
he
> > host system. As long as QEMU doesn't actually need any of the APIs in
> > the newer libfdt we should be able to continue using the older system
> > version if it is present.
> >=20
> > Could you elaborate on what build problems you are having.
> >=20
> > > This changes the test to force ./configure into using newer libfdt.
> >=20
> > I'm not convinced we want todo that.
>=20
> So I think the point here is that Alexey has some other outstanding
> patches that will use fdt_check_full().  The commit message needs to
> make that clear though.  Or else include this patch in that series.

If they're not merged yet, this patch should be squashed into whichever
of those patches first introduces the need for fdt_check_full(), so that
series remains fully  git bisectable.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

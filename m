Received: from eggs.gnu.org ([2001:4830:134:3::10]:38718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3ezA-0002Mh-8C
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3ez7-000167-3u
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:45:44 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f3ez6-00015z-Pj
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:45:41 -0400
Received: by mail-wm0-x229.google.com with SMTP id x82so40685018wmg.1
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 02:45:40 -0700 (PDT)
Date: Wed, 4 Apr 2018 10:45:37 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180404094537.GI4467@stefanha-x1.localdomain>
References: <22f7f184-c295-4e18-c186-3fd9fdcce213@linux.intel.com>
	<20180323160252.GA27131@stefanha-x1.localdomain>
	<1e0e5f9b-18b4-7f0f-dbd1-696ef1f7039c@linux.intel.com>
	<e638d7a3-5c38-7a10-cef9-d1791e5b8fc7@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/8E7gjuj425jZz9t"
Content-Disposition: inline
In-Reply-To: <e638d7a3-5c38-7a10-cef9-d1791e5b8fc7@linux.intel.com>
Subject: Re: [Qemu-devel] [Consult] nfs-vsocks support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Jing2" <jing2.liu@linux.intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, yang.zhong@intel.com, qemu-devel <qemu-devel@nongnu.org>


--/8E7gjuj425jZz9t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28, 2018 at 07:25:21PM +0800, Liu, Jing2 wrote:
> On 3/26/2018 6:12 PM, Liu, Jing2 wrote:
> > Hi Stefan,
> >=20
> > Thank you very much for the response! It truly gave me much help.
> >=20
> > On 3/24/2018 12:02 AM, Stefan Hajnoczi wrote:
> [...]
> > > > Could you give me some help and thanks in advance!
> > >=20
> > > Here is a script that launches nfsd and runs a guest:
> > > https://github.com/stefanha/linux/commit/38cbc15661a6dd44b69c4f318091=
f2047d707035#diff-05f3fe8941076453942a8c059b409009
> > >=20
>=20
> Using the script, I met some problems making the
> initramfs.gz. It confused me a lot... I don't have busybox under
> /usr/bin or /usr/sbin. Where to get it?

It may be easier to use a full guest disk image instead of the disk
image generation in my go.sh script.  The initramfs is very specific to
the development machine I was using at the time.  The main thing to look
at the in the go.sh script is how the NFS services are launched on the
host.

Busybox is a package that is available on most Linux distributions.

Before you spend more time on this, NFS over AF_VSOCK is only suitable
for developers right now.  It is not ready for production and I am not
supporting it for end users.  So if you want to hack on NFS, please go
ahead, but otherwise it's probably not what you want.

Stefan

> (host)$./go.sh nfs_tcp
>=20
> File /usr/sbin/busybox could not be opened for reading
>  line 55
> File /lib64/libtirpc.so.3 could not be opened for reading
>  line 306
> File nc-vsock could not be opened for reading
>  line 321
> File ../netperf-2.7.0/src/netserver could not be opened for reading
>  line 325
>=20
> It results in guest kernel_panic when gdb launches the guest:
>=20
> [    0.425738] Failed to execute /init (error -2)
> [    0.426074] Kernel panic - not syncing: No working init found.  Try
> passing .
> [    0.427077] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.13.0+ #3
> [    0.427507] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-4
> [    0.428354] Call Trace:
> [    0.428538]  dump_stack+0x63/0x89
> [    0.428774]  ? rest_init+0x60/0xc0
> [    0.429017]  panic+0xeb/0x245
> [    0.429225]  ? putname+0x53/0x60
> [    0.429455]  ? rest_init+0xc0/0xc0
> [    0.429722]  kernel_init+0xf1/0x104
> [    0.430017]  ret_from_fork+0x25/0x30
>=20
> Looking forward to the kind reply.
> BTW, for the following questions that I sent two days ago, I have some
> ideas in mind and it could be ignored now.
>=20
> Jing
>=20
> > I have updated both host and guest kernel with vsock-nfsd repo and
> > installed nfs-utils in both host and guest successfully.
> >=20
> > There're two different manuals in
> > https://www.spinics.net/lists/linux-nfs/msg64563.html(Quickstart 3~7)
> > and nfs-utils (README step 3 DAEMON STARTUP ORDER).
> > Which one should be the best usage?
> >=20
> > For the first quickstart manual step 7-Mount the export from the guest,
> > two questions as follows.
> > 1. why hypervisor's CID is 2? I didn't notice when it is specified?
> > 2. Though I did step 3~7 successfully, I can't see the synchronistical
> > changing on host folder /export/ and guest /mnt? So how to test the
> > communcation between host and guest on the folder?
> >=20
> > Thanks again!
> >=20
> > Jing
> [...]
> > >=20
> > > Stefan
> > >=20
> >=20
>=20

--/8E7gjuj425jZz9t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxJ7BAAoJEJykq7OBq3PIlv0IALJsssDoFk38adYEdNPtN+z2
3e2tKwsnmhIOEBPb9eHb8QwRoL8IUEoaMgIA0al4JXkcFVQkkGNJN64jMfeFIVdj
G3s+03f1SSkdrPP5fugS+iqnjvrJpUiN8MnTz2XBlJchksp6oJm/cGQVy7qlGXYX
Lkp9LEl/osFh/1pY+uP1/dOO8aCZlC+Ad0QH9UCBonz5L8CZouLOZo0paOzhi0c5
dFLC+oKj+95u0eIdNs4Fb4iZVyBJJ3K9hLd6yO8KI04P+9KRzqgc6ED3OkoYahRO
bfM1vL/qxvGvRlnWzhh76jOqVu/8eDSD74ySVLX1a4TlsEoXcpo8JpIw1a20mvk=
=t19r
-----END PGP SIGNATURE-----

--/8E7gjuj425jZz9t--

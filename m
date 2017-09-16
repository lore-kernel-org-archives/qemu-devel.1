Received: from eggs.gnu.org ([2001:4830:134:3::10]:40852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtDge-0005Fy-Ku
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 10:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtDgd-0000ar-LU
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 10:03:12 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170914154221.GD7370@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ff9cac4f-5dba-666c-fc0d-8c1e3f23e6c9@redhat.com>
Date: Sat, 16 Sep 2017 16:02:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170914154221.GD7370@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UIFLOJWKsSLTLNsTKqXVTGf47TMWAsK7a"
Subject: Re: [Qemu-devel] [PATCH 00/18] block/mirror: Add active-sync
 mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UIFLOJWKsSLTLNsTKqXVTGf47TMWAsK7a
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng
 <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <ff9cac4f-5dba-666c-fc0d-8c1e3f23e6c9@redhat.com>
Subject: Re: [PATCH 00/18] block/mirror: Add active-sync mirroring
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170914154221.GD7370@stefanha-x1.localdomain>
In-Reply-To: <20170914154221.GD7370@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-14 17:42, Stefan Hajnoczi wrote:
> On Wed, Sep 13, 2017 at 08:18:52PM +0200, Max Reitz wrote:
>> There may be a couple of things to do on top of this series:
>> - Allow switching between active and passive mode at runtime: This
>>   should not be too difficult to implement, the main question is how t=
o
>>   expose it to the user.
>>   (I seem to recall we wanted some form of block-job-set-option
>>   command...?)
>>
>> - Implement an asynchronous active mode: May be detrimental when it
>>   comes to convergence, but it might be nice to have anyway.  May or m=
ay
>>   not be complicated to implement.
>=20
> Ideally the user doesn't have to know about async vs sync.  It's an
> implementation detail.
>=20
> Async makes sense during the bulk copy phase (e.g. sync=3Dfull) because=

> guest read/write latencies are mostly unaffected.  Once the entire
> device has been copied there are probably still dirty blocks left
> because the guest touched them while the mirror job was running.  At
> that point it definitely makes sense to switch to synchronous mirroring=

> in order to converge.

Makes sense, but I'm not sure whether it really is just an
implementation detail.  If you're in the bulk copy phase in active/async
mode and you have enough write requests with the target being slow
enough, I suspect you might still not get convergence then (because the
writes to the target yield for a long time while ever more write
requests pile up) -- so then you'd just shift the dirty tracking from
the bitmap to a list of requests in progress.

And I think we do want the bulk copy phase to guarantee convergence,
too, usually (when active/foreground/synchronous mode is selected).  If
we don't, then that's a policy decision and would be up to libvirt, as I
see it.

Max


--UIFLOJWKsSLTLNsTKqXVTGf47TMWAsK7a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlm9LwUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AAG4H/R4Wqw9NyEty87fP+DP/L1OnBw0eqJh/
d2FxqNYXkyeNY66xKac2+f6FKwSBd3u+CvKL7sYktuLYcLKWNrYW7z3M7J8eTfGQ
ciuz19eqq12vzJzMnUYvxR7HNd/HbKk0Kr4iYFiMXRe/Y1/Ach10YMtBLtxgpvFI
umfGvqv76f7ZAwI35k5zqDoNghGwFKVE8JJerB8dHFdoDEoYSjKhyGOniTSlJOvw
0sHD+Ys/FLzfCozZ5NMeOsuqS3qTM/9Q1/zHaU4hoVNBWFmPUH1yEYF4Hm/BWVcg
k0ogGrb9wApLXPzKEHcUlDH8Sb+pDSSCegj0lXq/sSr28WxreGO7Y3s=
=XzJI
-----END PGP SIGNATURE-----

--UIFLOJWKsSLTLNsTKqXVTGf47TMWAsK7a--

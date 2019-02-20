Received: from eggs.gnu.org ([209.51.188.92]:53183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwW4U-0001bp-57
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwW4S-000869-8C
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:54:14 -0500
References: <VI1PR1001MB13731EF256C1E7380E1D657AB7D90@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<VI1PR0602MB324559765BFE372F75D52E57A4910@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190201054849.GH23131@stefanha-x1.localdomain>
	<VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190204060636.GF29758@stefanha-x1.localdomain>
	<AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlook.com>
	<AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlo>
	<VI1PR0602MB3245FD0A939EC3E28CA0F740A46F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190211031725.GB18083@stefanha-x1.localdomain>
	<VI1PR0602MB3245424120D151F29884A7E2A4630@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190220165839.GJ30403@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f168e72e-89fe-cf9b-89ff-3eb820f8a5cf@redhat.com>
Date: Wed, 20 Feb 2019 18:53:54 +0100
MIME-Version: 1.0
In-Reply-To: <20190220165839.GJ30403@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0nGNQysxonmi8EYIbw94ZQwiDT44g7Blf"
Subject: Re: [Qemu-devel] [Qemu-block] Guest unresponsive after Virtqueue
 size exceeded error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, =?UTF-8?Q?Fernando_Casas_Sch=c3=b6ssow?= <casasfernando@outlook.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0nGNQysxonmi8EYIbw94ZQwiDT44g7Blf
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 =?UTF-8?Q?Fernando_Casas_Sch=c3=b6ssow?= <casasfernando@outlook.com>
Message-ID: <f168e72e-89fe-cf9b-89ff-3eb820f8a5cf@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] Guest unresponsive after Virtqueue size
 exceeded error
References: <VI1PR1001MB13731EF256C1E7380E1D657AB7D90@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
 <VI1PR0602MB324559765BFE372F75D52E57A4910@VI1PR0602MB3245.eurprd06.prod.outlook.com>
 <20190201054849.GH23131@stefanha-x1.localdomain>
 <VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
 <20190204060636.GF29758@stefanha-x1.localdomain>
 <AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlook.com>
 <AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlo>
 <VI1PR0602MB3245FD0A939EC3E28CA0F740A46F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
 <20190211031725.GB18083@stefanha-x1.localdomain>
 <VI1PR0602MB3245424120D151F29884A7E2A4630@VI1PR0602MB3245.eurprd06.prod.outlook.com>
 <20190220165839.GJ30403@stefanha-x1.localdomain>
In-Reply-To: <20190220165839.GJ30403@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20/02/19 17:58, Stefan Hajnoczi wrote:
> On Mon, Feb 18, 2019 at 07:21:25AM +0000, Fernando Casas Sch=F6ssow wro=
te:
>> It took a few days but last night the problem was reproduced.
>> This is the information from the log:
>>
>> vdev 0x55f261d940f0 ("virtio-blk")
>> vq 0x55f261d9ee40 (idx 0)
>> inuse 128 vring.num 128
>> old_shadow_avail_idx 58874 last_avail_idx 58625 avail_idx 58874
>> avail 0x3d87a800 avail_idx (cache bypassed) 58625
>=20
> Hi Paolo,
> Are you aware of any recent MemoryRegionCache issues?  The avail_idx
> value 58874 was read via the cache while a non-cached read produces
> 58625!
>=20
> I suspect that 58625 is correct since the vring is already full and the=

> driver wouldn't bump avail_idx any further until requests complete.
>=20
> Fernando also hits this issue with virtio-scsi so it's not a
> virtio_blk.ko driver bug or a virtio-blk device emulation issue.

No, I am not aware of any issues.

How can I get the core dump (and the corresponding executable to get the
symbols)?  Alternatively, it should be enough to print the
vq->vring.caches->avail.mrs from the debugger.

Also, one possibility is to add in vring_avail_idx an assertion like

   assert(vq->shadow_availa_idx =3D=3D virtio_lduw_phys(vdev,
vq->vring.avail + offsetof(VRingAvail, idx)));

and try to catch the error earlier.

Paolo

> A QEMU core dump is available for debugging.
>=20
> Here is the patch that produced this debug output:
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index a1ff647a66..28d89fcbcb 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -866,6 +866,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
>          return NULL;
>      }
>      rcu_read_lock();
> +    uint16_t old_shadow_avail_idx =3D vq->shadow_avail_idx;
>      if (virtio_queue_empty_rcu(vq)) {
>          goto done;
>      }
> @@ -879,6 +880,12 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
>      max =3D vq->vring.num;
>=20
>      if (vq->inuse >=3D vq->vring.num) {
> +        fprintf(stderr, "vdev %p (\"%s\")\n", vdev, vdev->name);
> +        fprintf(stderr, "vq %p (idx %u)\n", vq, (unsigned int)(vq - vd=
ev->vq));
> +        fprintf(stderr, "inuse %u vring.num %u\n", vq->inuse, vq->vrin=
g.num);
> +        fprintf(stderr, "old_shadow_avail_idx %u last_avail_idx %u ava=
il_idx %u\n", old_shadow_avail_idx, vq->last_avail_idx, vq->shadow_avail_=
idx);
> +        fprintf(stderr, "avail %#" HWADDR_PRIx " avail_idx (cache bypa=
ssed) %u\n", vq->vring.avail, virtio_lduw_phys(vdev, vq->vring.avail + of=
fsetof(VRingAvail, idx)));
> +        fprintf(stderr, "used_idx %u\n", vq->used_idx);
> +        abort(); /* <--- core dump! */
>          virtio_error(vdev, "Virtqueue size exceeded");
>          goto done;
>      }
>=20
> Stefan
>=20
>> used_idx 58497
>> 2019-02-18 03:20:08.605+0000: shutting down, reason=3Dcrashed
>>
>> The dump file, including guest memory, was generated successfully (aft=
er gzip the file is around 492MB).
>> I switched the guest now to virtio-scsi to get the information and dum=
p with this setup as well.
>>
>> How should we proceed?
>>
>> Thanks.
>>
>> On lun, feb 11, 2019 at 4:17 AM, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>> Thanks for collecting the data! The fact that both virtio-blk and virt=
io-scsi failed suggests it's not a virtqueue element leak in the virtio-b=
lk or virtio-scsi device emulation code. The hung task error messages fro=
m inside the guest are a consequence of QEMU hitting the "Virtqueue size =
exceeded" error. QEMU refuses to process further requests after the error=
, causing tasks inside the guest to get stuck on I/O. I don't have a good=
 theory regarding the root cause. Two ideas: 1. The guest is corrupting t=
he vring or submitting more requests than will fit into the ring. Somewha=
t unlikely because it happens with both Windows and Linux guests. 2. QEMU=
's virtqueue code is buggy, maybe the memory region cache which is used f=
or fast guest RAM accesses. Here is an expanded version of the debug patc=
h which might help identify which of these scenarios is likely. Sorry, it=
 requires running the guest again! This time let's make QEMU dump core so=
 both QEMU state and guest RAM are captured for further debugging. That w=
ay it will be possible to extract more information using gdb without reru=
nning. Stefan --- diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c in=
dex a1ff647a66..28d89fcbcb 100644 --- a/hw/virtio/virtio.c +++ b/hw/virti=
o/virtio.c @@ -866,6 +866,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t =
sz) return NULL; } rcu_read_lock(); + uint16_t old_shadow_avail_idx =3D v=
q->shadow_avail_idx; if (virtio_queue_empty_rcu(vq)) { goto done; } @@ -8=
79,6 +880,12 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz) max =3D vq-=
>vring.num; if (vq->inuse >=3D vq->vring.num) { + fprintf(stderr, "vdev %=
p (\"%s\")\n", vdev, vdev->name); + fprintf(stderr, "vq %p (idx %u)\n", v=
q, (unsigned int)(vq - vdev->vq)); + fprintf(stderr, "inuse %u vring.num =
%u\n", vq->inuse, vq->vring.num); + fprintf(stderr, "old_shadow_avail_idx=
 %u last_avail_idx %u avail_idx %u\n", old_shadow_avail_idx, vq->last_ava=
il_idx, vq->shadow_avail_idx); + fprintf(stderr, "avail %#" HWADDR_PRIx "=
 avail_idx (cache bypassed) %u\n", vq->vring.avail, virtio_lduw_phys(vdev=
, vq->vring.avail + offsetof(VRingAvail, idx))); + fprintf(stderr, "used_=
idx %u\n", vq->used_idx); + abort(); /* <--- core dump! */ virtio_error(v=
dev, "Virtqueue size exceeded"); goto done; }
>>
>>



--0nGNQysxonmi8EYIbw94ZQwiDT44g7Blf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlxtlDIACgkQv/vSX3jH
roPs2wf/fY12SqZ+lqCv8lnjbVq8uJiUYqSWqzVV8PEUIfGCXkxVSdxaSm8Lvm5l
3j+6Fn7UPw/dJ23tm8LR2jg6hKHSS9g9xyrCB4bvhDElNoSwLzhiAVJwDO9pquWR
HwEnZuyOJ9uHpkiCbQ8J2qn22/WFkizTwX1sQBTcMstDaRAkePRBooZapOf1c6Et
/Px7bL/CsDvmOqOPp+TIEnaz82JU+gR0+DVnlmaAyApZ/pDoqc4xlnsLKNddCP0y
AOP4cl7r+McWUVI59LICZXiNxG8JASRHqth6Z+eJlJuuco1W72Y0KT0zRqLkYhWK
rCiP9WusD8ZFbNWxUE8vmCsEWL+Bvg==
=iqTB
-----END PGP SIGNATURE-----

--0nGNQysxonmi8EYIbw94ZQwiDT44g7Blf--

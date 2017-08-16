Received: from eggs.gnu.org ([2001:4830:134:3::10]:43147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhuAj-00007W-61
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 04:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhuAf-0006Bx-74
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 04:59:29 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dhuAe-0006Bc-TJ
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 04:59:25 -0400
Received: by mail-wm0-x235.google.com with SMTP id i66so28270228wmg.0
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 01:59:24 -0700 (PDT)
Date: Wed, 16 Aug 2017 09:59:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170816085921.GD3180@stefanha-x1.localdomain>
References: <CAC0nwAR8tCfVU518a3p8Qmd8Y84mLeb6j2yTrErnnK8_AUnpWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
In-Reply-To: <CAC0nwAR8tCfVU518a3p8Qmd8Y84mLeb6j2yTrErnnK8_AUnpWg@mail.gmail.com>
Subject: Re: [Qemu-devel] ask a question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?55qu5pm6?= <pizhi0616@gmail.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2017 at 02:25:19PM +0800, =E7=9A=AE=E6=99=BA wrote:
> Hi=EF=BC=8CI meet a problem with vm, my environment is qemu-kvm-2.3,
> virtio-win-0.1.126, host(centos7.2), guest(windows10).
>=20
> libvirt xml has four virtio-serial channel as follows:

CCing the libvirt mailing list.  This may be a libvirt issue.

>     <channel type=3D'spicevmc'>
>       <target type=3D'virtio' name=3D'com.redhat.spice.0' state=3D'connec=
ted'/>
>       <alias name=3D'channel0'/>
>       <address type=3D'virtio-serial' controller=3D'0' bus=3D'0' port=3D'=
1'/>
>     </channel>
>     <channel type=3D'unix'>
>       <source mode=3D'bind'
> path=3D'/var/lib/libvirt/qemu/e597eab9-95db-46e9-96f0-12a84c692569'/>
>       <target type=3D'virtio' name=3D'pv-mon' state=3D'connected'/>
>       <alias name=3D'channel1'/>
>       <address type=3D'virtio-serial' controller=3D'0' bus=3D'0' port=3D'=
2'/>
>     </channel>
>     <channel type=3D'unix'>
>       <source mode=3D'bind'
> path=3D'/var/lib/libvirt/qemu/e597eab9-95db-46e9-96f0-12a84c692569-qga'/>
>       <target type=3D'virtio' name=3D'org.qemu.guest_agent.0'
> state=3D'connected'/>
>       <alias name=3D'channel2'/>
>       <address type=3D'virtio-serial' controller=3D'0' bus=3D'0' port=3D'=
3'/>
>     </channel>
>     <channel type=3D'unix'>
>       <source mode=3D'bind'
> path=3D'/var/lib/libvirt/qemu/e597eab9-95db-46e9-96f0-12a84c692569-report=
'/>
>       <target type=3D'virtio' name=3D'qga-active-report' state=3D'connect=
ed'/>
>       <alias name=3D'channel3'/>
>       <address type=3D'virtio-serial' controller=3D'0' bus=3D'0' port=3D'=
4'/>
>     </channel>
>=20
> If I hard reboot the vm, it may happen as follows:
>=20
> 2017-08-14T07:51:18.401008Z qemu-kvm: virtio-serial-bus: Unexpected port =
id
> 1122983520 for device virtio-serial0.0
> 2017-08-14T07:51:18.956482Z qemu-kvm: virtio-serial-bus: Guest failure in
> adding device virtio-serial0.0
> 2017-08-14T07:51:29.176795Z qemu-kvm: virtio-serial-bus: Guest failure in
> adding device virtio-serial0.0
> 2017-08-14T07:51:34.454819Z qemu-kvm: virtio-serial-bus: Unexpected port =
id
> 2042451128 for device virtio-serial0.0
> 2017-08-14T07:51:44.655068Z qemu-kvm: virtio-serial-bus: Guest failure in
> adding device virtio-serial0.0
> 2017-08-14T07:51:49.764201Z qemu-kvm: virtio-serial-bus: Unexpected port =
id
> 1122983520 for device virtio-serial0.0
> 2017-08-14T07:51:59.969836Z qemu-kvm: virtio-serial-bus: Guest failure in
> adding device virtio-serial0.0
> 2017-08-14T07:52:21.564461Z qemu-kvm: virtio-serial-bus: Unexpected port =
id
> 1122983520 for device virtio-serial0.0
> 2017-08-14T07:52:47.059452Z qemu-kvm: virtio-serial-bus: Guest failure in
> adding device virtio-serial0.0
> 2017-08-14T07:53:22.710677Z qemu-kvm: virtio-serial-bus: Unexpected port =
id
> 1122983520 for device virtio-serial0.0
> 2017-08-14T07:53:32.781204Z qemu-kvm: virtio-serial-bus: Guest failure in
> adding device virtio-serial0.0
> 2017-08-14T07:53:48.040513Z qemu-kvm: virtio-serial-bus: Unexpected port =
id
> 3179968584 for device virtio-serial0.0
> 2017-08-14T07:54:23.547393Z qemu-kvm: virtio-serial-bus: Unexpected port =
id
> 1122983520 for device virtio-serial0.0
> 2017-08-14T07:55:54.350754Z qemu-kvm: virtio-serial-bus: Unexpected port =
id
> 1122983520 for device virtio-serial0.0
> 2017-08-14T07:56:09.393056Z qemu-kvm: virtio-serial-bus: Unexpected port =
id
> 1122983520 for device virtio-serial0.0
> 2017-08-14T07:57:39.670850Z qemu-kvm: virtio-serial-bus: Unexpected port =
id
> 1122983520 for device virtio-serial0.0
> 2017-08-14T07:58:09.867650Z qemu-kvm: virtio-serial-bus: Unexpected port =
id
> 1185792 for device virtio-serial0.0
> 2017-08-14T07:59:10.053208Z qemu-kvm: virtio-serial-bus: Unexpected port =
id
> 1122983520 for device virtio-serial0.0
> 2017-08-14T08:00:20.235162Z qemu-kvm: virtio-serial-bus: Guest failure in
> adding device virtio-serial0.0
> 2017-08-14T08:01:20.394196Z qemu-kvm: virtio-serial-bus: Guest failure in
> adding device virtio-serial0.0
>=20
> So, the virtio-serial port will not be available, it cause my program
> doesn't start in guest(windows10).
> Can you give me some advices ?
>=20
> Looking forward to your reply.

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZlAlpAAoJEJykq7OBq3PIOSUIAK4igQLohQsLX+tZL1WWV9a0
joNGNruMvO2yxVUzRpGtP/XSs0QkcZ+s47GTfFUgBVTXSpoYXTbumBhF+povyGCV
0Q0owB3kyYHuXd4F/H9STyqnrigONz3f9SO2smkhxQNgwwSwVurq9QnqAJsEtQTY
HAjPJPeWRsPF2A7cAhRW16/lTD4ulJh9fTgHvFLW5ibcawRJSPcMkUklEMW2qIiN
vbl8uc2JiK5m32m92OcTZxVzVsn3wVWfJxyQzLfX+ZHBHxlJ47rwjOsQjlyqDxLD
OjMA8vHeSsu5sS1c+yd+Rcec9D7r7etI2kg5vdzUGgyvnW8M/LykwUjort9XhNM=
=aCeC
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--

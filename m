Received: from eggs.gnu.org ([2001:4830:134:3::10]:41320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1diIWt-00058v-En
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1diIWo-0004Zb-JW
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:59:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1diIWo-0004ZN-AW
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:59:54 -0400
Date: Thu, 17 Aug 2017 11:59:49 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170817105949.GB2235@work-vm>
References: <CAC0nwASy5UA4u05G0hnJg=w_aOAGupWYfM91X8Yz41WSRS098g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC0nwASy5UA4u05G0hnJg=w_aOAGupWYfM91X8Yz41WSRS098g@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?q?Guest_init_virtio-serial_port_failed_rand?=
 =?utf-8?q?omly=EF=BC=8C_qemu-kvm_report_error_about_guest_failure_in_addi?=
 =?utf-8?q?ng_device_virtio-serial0=2E0?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?55qu5pm6?= <pizhi0616@gmail.com>
Cc: qemu-devel@nongnu.org, vrozenfe@redhat.com

* =E7=9A=AE=E6=99=BA (pizhi0616@gmail.com) wrote:
> Hi=EF=BC=8CI meet a problem with vm(windows10), my environment is qemu-=
kvm-2.3,
> virtio-win-0.1.126, host(centos7.2), guest(windows10).
> I add four virtio-serial port to vm, if I hard reboot the vm(windows10)=
, it
> may happen as follows randomly:

I'm not too sure how virtio-win version numbering works; but:
https://bugzilla.redhat.com/show_bug.cgi?id=3D819412

looks like the same symptom, and says it was fixed in ~2013.

Dave

>=20
> 2017-08-14T07:51:18.401008Z qemu-kvm: virtio-serial-bus: Unexpected por=
t id
> 1122983520 for device virtio-serial0.0
> 2017-08-14T07:51:18.956482Z qemu-kvm: virtio-serial-bus: Guest failure =
in
> adding device virtio-serial0.0
> 2017-08-14T07:51:29.176795Z qemu-kvm: virtio-serial-bus: Guest failure =
in
> adding device virtio-serial0.0
> 2017-08-14T07:51:34.454819Z qemu-kvm: virtio-serial-bus: Unexpected por=
t id
> 2042451128 for device virtio-serial0.0
> 2017-08-14T07:51:44.655068Z qemu-kvm: virtio-serial-bus: Guest failure =
in
> adding device virtio-serial0.0
> 2017-08-14T07:51:49.764201Z qemu-kvm: virtio-serial-bus: Unexpected por=
t id
> 1122983520 for device virtio-serial0.0
> 2017-08-14T07:51:59.969836Z qemu-kvm: virtio-serial-bus: Guest failure =
in
> adding device virtio-serial0.0
> 2017-08-14T07:52:21.564461Z qemu-kvm: virtio-serial-bus: Unexpected por=
t id
> 1122983520 for device virtio-serial0.0
> 2017-08-14T07:52:47.059452Z qemu-kvm: virtio-serial-bus: Guest failure =
in
> adding device virtio-serial0.0
> 2017-08-14T07:53:22.710677Z qemu-kvm: virtio-serial-bus: Unexpected por=
t id
> 1122983520 for device virtio-serial0.0
> 2017-08-14T07:53:32.781204Z qemu-kvm: virtio-serial-bus: Guest failure =
in
> adding device virtio-serial0.0
> 2017-08-14T07:53:48.040513Z qemu-kvm: virtio-serial-bus: Unexpected por=
t id
> 3179968584 for device virtio-serial0.0
> 2017-08-14T07:54:23.547393Z qemu-kvm: virtio-serial-bus: Unexpected por=
t id
> 1122983520 for device virtio-serial0.0
> 2017-08-14T07:55:54.350754Z qemu-kvm: virtio-serial-bus: Unexpected por=
t id
> 1122983520 for device virtio-serial0.0
> 2017-08-14T07:56:09.393056Z qemu-kvm: virtio-serial-bus: Unexpected por=
t id
> 1122983520 for device virtio-serial0.0
> 2017-08-14T07:57:39.670850Z qemu-kvm: virtio-serial-bus: Unexpected por=
t id
> 1122983520 for device virtio-serial0.0
> 2017-08-14T07:58:09.867650Z qemu-kvm: virtio-serial-bus: Unexpected por=
t id
> 1185792 for device virtio-serial0.0
> 2017-08-14T07:59:10.053208Z qemu-kvm: virtio-serial-bus: Unexpected por=
t id
> 1122983520 for device virtio-serial0.0
> 2017-08-14T08:00:20.235162Z qemu-kvm: virtio-serial-bus: Guest failure =
in
> adding device virtio-serial0.0
> 2017-08-14T08:01:20.394196Z qemu-kvm: virtio-serial-bus: Guest failure =
in
> adding device virtio-serial0.0
>=20
> If qemu-kvm report upper error, it will cause guest failed to init
> virtio-serial port.
> Thanks.
>=20
> Looking forward to your reply.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

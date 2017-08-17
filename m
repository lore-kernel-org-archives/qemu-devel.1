Received: from eggs.gnu.org ([2001:4830:134:3::10]:42749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pizhi0616@gmail.com>) id 1diEVi-0001CC-Bq
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pizhi0616@gmail.com>) id 1diEVh-000865-6k
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:42:30 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pizhi0616@gmail.com>) id 1diEVg-00084S-TY
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:42:29 -0400
Received: by mail-wr0-x229.google.com with SMTP id y96so31397153wrc.1
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 23:42:25 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?55qu5pm6?= <pizhi0616@gmail.com>
Date: Thu, 17 Aug 2017 14:42:24 +0800
Message-ID: <CAC0nwASy5UA4u05G0hnJg=w_aOAGupWYfM91X8Yz41WSRS098g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?q?Guest_init_virtio-serial_port_failed_rando?=
	=?utf-8?q?mly=EF=BC=8C_qemu-kvm_report_error_about_guest_failure_i?=
	=?utf-8?q?n_adding_device_virtio-serial0=2E0?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi=EF=BC=8CI meet a problem with vm(windows10), my environment is qemu-kvm-=
2.3,
virtio-win-0.1.126, host(centos7.2), guest(windows10).
I add four virtio-serial port to vm, if I hard reboot the vm(windows10), it
may happen as follows randomly:

2017-08-14T07:51:18.401008Z qemu-kvm: virtio-serial-bus: Unexpected port id
1122983520 for device virtio-serial0.0
2017-08-14T07:51:18.956482Z qemu-kvm: virtio-serial-bus: Guest failure in
adding device virtio-serial0.0
2017-08-14T07:51:29.176795Z qemu-kvm: virtio-serial-bus: Guest failure in
adding device virtio-serial0.0
2017-08-14T07:51:34.454819Z qemu-kvm: virtio-serial-bus: Unexpected port id
2042451128 for device virtio-serial0.0
2017-08-14T07:51:44.655068Z qemu-kvm: virtio-serial-bus: Guest failure in
adding device virtio-serial0.0
2017-08-14T07:51:49.764201Z qemu-kvm: virtio-serial-bus: Unexpected port id
1122983520 for device virtio-serial0.0
2017-08-14T07:51:59.969836Z qemu-kvm: virtio-serial-bus: Guest failure in
adding device virtio-serial0.0
2017-08-14T07:52:21.564461Z qemu-kvm: virtio-serial-bus: Unexpected port id
1122983520 for device virtio-serial0.0
2017-08-14T07:52:47.059452Z qemu-kvm: virtio-serial-bus: Guest failure in
adding device virtio-serial0.0
2017-08-14T07:53:22.710677Z qemu-kvm: virtio-serial-bus: Unexpected port id
1122983520 for device virtio-serial0.0
2017-08-14T07:53:32.781204Z qemu-kvm: virtio-serial-bus: Guest failure in
adding device virtio-serial0.0
2017-08-14T07:53:48.040513Z qemu-kvm: virtio-serial-bus: Unexpected port id
3179968584 for device virtio-serial0.0
2017-08-14T07:54:23.547393Z qemu-kvm: virtio-serial-bus: Unexpected port id
1122983520 for device virtio-serial0.0
2017-08-14T07:55:54.350754Z qemu-kvm: virtio-serial-bus: Unexpected port id
1122983520 for device virtio-serial0.0
2017-08-14T07:56:09.393056Z qemu-kvm: virtio-serial-bus: Unexpected port id
1122983520 for device virtio-serial0.0
2017-08-14T07:57:39.670850Z qemu-kvm: virtio-serial-bus: Unexpected port id
1122983520 for device virtio-serial0.0
2017-08-14T07:58:09.867650Z qemu-kvm: virtio-serial-bus: Unexpected port id
1185792 for device virtio-serial0.0
2017-08-14T07:59:10.053208Z qemu-kvm: virtio-serial-bus: Unexpected port id
1122983520 for device virtio-serial0.0
2017-08-14T08:00:20.235162Z qemu-kvm: virtio-serial-bus: Guest failure in
adding device virtio-serial0.0
2017-08-14T08:01:20.394196Z qemu-kvm: virtio-serial-bus: Guest failure in
adding device virtio-serial0.0

If qemu-kvm report upper error, it will cause guest failed to init
virtio-serial port.
Thanks.

Looking forward to your reply.

Received: from eggs.gnu.org ([209.51.188.92]:44002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gtOmk-0007yk-81
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 22:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gtOmg-0004os-3k
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 22:31:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:55128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gtOmf-0004gq-Ow
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 22:30:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gtOmO-0005Mr-14
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 03:30:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0363E2E80C7
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 03:30:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Feb 2019 03:24:53 -0000
From: Stefan Hajnoczi <1815413@bugs.launchpad.net>
Reply-To: Bug 1815413 <1815413@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154986850905.20717.3804977668202648875.malonedeb@wampee.canonical.com>
Message-Id: <154994189374.22167.15600911659348098830.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1815413] Re: compile with vhost-vsock support on
 osx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

vhost devices are not available on macOS hosts, they are a Linux
feature.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815413

Title:
  compile with vhost-vsock support on osx

Status in QEMU:
  Invalid

Bug description:
  compiling latest (3.1.0) on osx 10.14.3 with --enable-vhost-vsock and
  target =3D x86_64-softmmu results in compile errors:

  Undefined symbols for architecture x86_64:
    "_vhost_dev_cleanup", referenced from:
        _vhost_vsock_device_realize in vhost-vsock.o
        _vhost_vsock_device_unrealize in vhost-vsock.o
    "_vhost_dev_disable_notifiers", referenced from:
        _vhost_vsock_set_status in vhost-vsock.o
    "_vhost_dev_enable_notifiers", referenced from:
        _vhost_vsock_set_status in vhost-vsock.o
    "_vhost_dev_init", referenced from:
        _vhost_vsock_device_realize in vhost-vsock.o
    "_vhost_dev_start", referenced from:
        _vhost_vsock_set_status in vhost-vsock.o
    "_vhost_dev_stop", referenced from:
        _vhost_vsock_set_status in vhost-vsock.o
    "_vhost_virtqueue_mask", referenced from:
        _vhost_vsock_set_status in vhost-vsock.o
        _vhost_vsock_guest_notifier_mask in vhost-vsock.o
       (maybe you meant: _cryptodev_vhost_virtqueue_mask)
    "_vhost_virtqueue_pending", referenced from:
        _vhost_vsock_guest_notifier_pending in vhost-vsock.o
       (maybe you meant: _cryptodev_vhost_virtqueue_pending)
  ld: symbol(s) not found for architecture x86_64
  clang: error: linker command failed with exit code 1 (use -v to see invoc=
ation)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1815413/+subscriptions

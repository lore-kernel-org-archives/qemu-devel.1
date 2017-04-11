Received: from eggs.gnu.org ([2001:4830:134:3::10]:52002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1cy35z-0006JJ-Qr
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 17:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1cy35w-00089Y-8S
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 17:13:03 -0400
Received: from mail-db5eur01on0138.outbound.protection.outlook.com
	([104.47.2.138]:22068
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1cy35v-000893-M6
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 17:13:00 -0400
Date: Tue, 11 Apr 2017 23:58:16 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170411205813.GA4006@rkaganip.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Subject: [Qemu-devel] vmbus bridge: machine property or device?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>

While hammering out the VMBus / storage series, we've been struggling to
figure out the best practices solution to the following problem:

VMBus is provided by a vmbus bridge; it appears the most natural to have
it subclassed from SysBusDevice.  There can only be one VMBus in the
VM.

Now the question is how to add it to the system:

1) with a boolean machine property "vmbus" that would trigger the
   creation of the VMBus bridge; its class would have
   ->cannot_instantiate_with_device_add_yet = true


2) with a regular -device option; this would require setting
   ->has_dynamic_sysbus = true for i440fx machines (q35 already have it)


3) anything else


So far we went with 1) but since it's essentially the API the management
layer would have to use we'd like to get it right from the beginning.

Thanks,
Roman.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT8Ti-0006kt-DR
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT8Tc-0004d9-B3
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:18:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55240 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fT8Tc-0004bb-47
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:18:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3B0B40201BF
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 16:18:27 +0000 (UTC)
References: <20180531195119.22021-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fed332fd-84de-3749-2a67-29d0c89bf505@redhat.com>
Date: Wed, 13 Jun 2018 18:18:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180531195119.22021-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Fix usb-ccid hotplug regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: spopovyc@redhat.com, kraxel@redhat.com

On 31/05/2018 21:51, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> The following series fixes the usb-ccid hotplug regression introduced
> by commit 675f22c6d3b0: the plugged device is not completely removed
> on device_del anymore, due to an extra reference added when doing
> set_link(). It turns out the memory management of qdev bus/child is a
> bit weird, this is my attempt to improve the situation and fix the
> regression.

It's my fault for not reviewing this promptly, but can patches 1 and 3
please be reverted?  Thanks,

Paolo

> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1556678
>=20
> Marc-Andr=C3=A9 Lureau (4):
>   bus: do not unref the added child bus on realize
>   object: fix OBJ_PROP_LINK_UNREF_ON_RELEASE ambivalence
>   usb-ccid: fix bus leak
>   usb-hcd-xhci-test: add a test for ccid hotplug
>=20
>  include/qom/object.h          | 12 +++++++++---
>  hw/core/bus.c                 |  1 -
>  hw/core/qdev-properties.c     |  2 +-
>  hw/core/qdev.c                |  2 +-
>  hw/display/xlnx_dp.c          |  2 +-
>  hw/dma/xilinx_axidma.c        |  4 ++--
>  hw/dma/xlnx-zdma.c            |  2 +-
>  hw/i386/pc.c                  |  2 +-
>  hw/i386/pc_piix.c             |  2 +-
>  hw/i386/pc_q35.c              |  2 +-
>  hw/ipmi/ipmi.c                |  2 +-
>  hw/net/xilinx_axienet.c       |  4 ++--
>  hw/ssi/xilinx_spips.c         |  2 +-
>  hw/usb/dev-smartcard-reader.c |  1 +
>  net/can/can_host.c            |  2 +-
>  net/colo-compare.c            |  2 +-
>  qom/object.c                  |  8 +++++---
>  target/arm/cpu.c              |  4 ++--
>  tests/usb-hcd-xhci-test.c     | 10 ++++++++++
>  ui/console.c                  |  2 +-
>  20 files changed, 43 insertions(+), 25 deletions(-)
>=20
>=20
> base-commit: c181ddaa176856b3cd2dfd12bbcf25fa9c884a97
>=20

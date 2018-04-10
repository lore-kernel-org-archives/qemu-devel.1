Received: from eggs.gnu.org ([2001:4830:134:3::10]:39968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5uAG-0006U1-83
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5uAB-0006n0-AL
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:22:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39690 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f5uAB-0006mO-57
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:22:23 -0400
Date: Tue, 10 Apr 2018 16:22:12 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180410142212.f3mudidizexxvnys@sirius.home.kraxel.org>
References: <20180313154826.20436-1-kraxel@redhat.com>
	<20180313161035.GL4788@phenom.ffwll.local>
	<20180314080301.366zycak3whqvvqx@sirius.home.kraxel.org>
	<CAPj87rPKtuQ4SZePYDUesWY9VSSGR=1p-LO=yByY_6Q8=BfoyA@mail.gmail.com>
	<20180406105422.6tewkkciwerud3tm@sirius.home.kraxel.org>
	<20180409080051.GD31310@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409080051.GD31310@phenom.ffwll.local>
Subject: Re: [Qemu-devel] [RfC PATCH] Add udmabuf misc device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Stone <daniel@fooishbar.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, qemu-devel@nongnu.org, dri-devel <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>

  Hi,

> Generally we try to cache mappings as much as possible. And wrt finding a
> slot: Create a sufficiently sized BAR on the virgl device, just for that?

Well.  virtio has no concept of "bars" ...

The most common virtio transport layer happens to be pci, which actually
has bars.  But we also have virtio-mmio (largely unused since arm got
pci) and virtio-ccw (used on s390x).

In any case it would be a layering violation.

Figured meanwhile qemu got memfd support recently, i.e. it can be
configured to back guest memory with memfd.  Which makes the memfd route
quite attractive.  Guess I try switch udmabuf to require memfd storage
as proof-of-concept.

cheers,
  Gerd

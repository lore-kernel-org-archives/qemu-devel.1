Received: from eggs.gnu.org ([2001:4830:134:3::10]:55765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fqYpb-0001hD-Dc
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 03:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fqYpW-00054w-Af
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 03:05:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fqYpW-00054e-6Z
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 03:05:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C5A97A7EE
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 07:05:53 +0000 (UTC)
Date: Fri, 17 Aug 2018 09:05:48 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180817070548.ngr5xz57akii27k6@sirius.home.kraxel.org>
References: <68a98c1b-e6dd-f2df-1499-17c2b8b583be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68a98c1b-e6dd-f2df-1499-17c2b8b583be@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] clean/simple Q35 support in libvirt+QEMU
 for guest OSes that don't support virtio-1.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laine Stump <laine@redhat.com>
Cc: Libvirt <libvir-list@redhat.com>, qemu list <qemu-devel@nongnu.org>

  Hi,

> b) Rather than a "legacy-only" model for virtio-0.9, it would be more
> useful to have "transitional". This way the config would work for older
> OSes that don't support virtio-1.0, and when/if the OS was upgraded such
> that it supported virtio-1.0, that would be automatically used without
> needing to change the config.

Having a legacy-only (instead of transitional) model could be useful for
regression-testing (i.e. whenever virtio-0.9 mode still works properly
in guests with virtio-1.0 support).

But that is pretty much the only reason I can think of to prefer the
virtio-0.9 devices being legacy-only instead of transitional.

> A) libosinfo starts telling consumers that the preferred virtio device
> model for the relevant OSes is "virtio-0.9", and leaves the
> recommendation for other OSes as "virtio".
> 
> B) libvirt adds a "virtio-0.9" model for all virtio devices that
> actually have virtio-0.9 support (a couple of devices never existed
> prior to virtio-1.0 (rng and ???) so virtio-0.9 would be nonsensical for
> them).

input, gpu are 1.0 only too.

> C) inside libvirt, the implementation of the "virtio-0.9" model is
> identical to "virtio", except that the VIR_PCI_CONNECT_TYPE flags for
> these devices contain VIR_PCI_CONNECT_TYPE_PCI rather than
> VIR_PCI_CONNECT_TYPE_PCIE, resulting in those devices being assigned to
> a legacy PCI slot, and thus they would be transitional mode by default.

Looks good to me.

cheers,
  Gerd

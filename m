Received: from eggs.gnu.org ([2001:4830:134:3::10]:38994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g0lg9-0002tb-Fj
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 06:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g0lg8-0004TZ-Nv
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 06:50:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g0lg8-0004Rt-Fe
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 06:50:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A55B2300186A
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 10:50:20 +0000 (UTC)
Date: Fri, 14 Sep 2018 12:50:09 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180914105009.uemha46ml2m74civ@sirius.home.kraxel.org>
References: <20180910064340.30745-1-kraxel@redhat.com>
	<20180910064340.30745-3-kraxel@redhat.com>
	<20180910125409.2b49be3b@t450s.home>
	<20180911043843.egzz6pqe5ouzju3g@sirius.home.kraxel.org>
	<20180912111354.4163d9ce@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912111354.4163d9ce@t450s.home>
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/vfio/display: add ramfb support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, libvir-list@redhat.com

  Hi,

> > Also libvirt manages hotpluggability per device *class*, not per device
> > *instance*.  So a device being hotpluggable or not depending on some
> > device property is a problem for libvirt ...
> > 
> > I'm open to suggestions how to handle this better, as long as the
> > libvirt people are on board with the approach.
> 
> Ok, so we need a new class to handle making a device non-hotpluggable,
> but I'm still not sure whether we should make:
> 
>  -device vfio-pci-ramfb
> 
> or
> 
>  -device vfio-pci-nohotplug,ramfb=on
> 
> Where ramfb would be a property only available on the nohotplug class
> variant.

I'm fine with the latter.

> The latter seems to provide a lot more flexibility, but which
> is more practical for libvirt?

Any comment from the libvirt camp?

thanks,
  Gerd

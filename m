Received: from eggs.gnu.org ([2001:4830:134:3::10]:50154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLNb7-00011l-Em
	for qemu-devel@nongnu.org; Wed, 23 May 2018 02:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLNb4-0000F1-Da
	for qemu-devel@nongnu.org; Wed, 23 May 2018 02:50:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53596 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fLNb4-0000Ev-9G
	for qemu-devel@nongnu.org; Wed, 23 May 2018 02:50:06 -0400
Date: Wed, 23 May 2018 08:50:01 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180523065001.h7r6o6h6a6cg3lbs@sirius.home.kraxel.org>
References: <20180522165058.15404-1-kraxel@redhat.com>
	<20180522165058.15404-6-kraxel@redhat.com>
	<efdfa65b-2375-834b-b102-e650c1047d38@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efdfa65b-2375-834b-b102-e650c1047d38@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 5/6] bochs-display: add pcie support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

  Hi,

> > +    if (pci_bus_is_express(pci_get_bus(dev))) {
> > +        dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
> > +        ret = pcie_endpoint_cap_init(dev, 0x80);
> > +        assert(ret > 0);
> 
> Maybe error_setg(errp, ...) && return?

No.  It really should not trigger, and if it does it is a bug in qemu
and not the user doing something wrong.

cheers,
  Gerd

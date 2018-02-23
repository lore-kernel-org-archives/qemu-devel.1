Received: from eggs.gnu.org ([2001:4830:134:3::10]:48067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ep9IR-0000wF-8T
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 04:05:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ep9IN-0000gY-9u
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 04:05:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49248 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ep9IN-0000eg-2h
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 04:05:35 -0500
Date: Fri, 23 Feb 2018 10:05:17 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180223090517.beti6t5grnxxhlwq@sirius.home.kraxel.org>
References: <20180219111458.25983-1-kraxel@redhat.com>
	<20180219151649.13a197f9@w520.home>
	<20180220102814.rtcvsrsdtdndcfez@sirius.home.kraxel.org>
	<20180222092811.0a705b9e@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222092811.0a705b9e@w520.home>
Subject: Re: [Qemu-devel] [PATCH v4 0/7] vfio: add display support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>

> Hi Gerd,
> 
> It's a little bit concerning that the only way we can test the
> region-based display support is with proprietary drivers that nobody
> but NVIDIA has at this point.  Have you considered adding region-based
> display support to the mdev sample tty driver?  I know it sounds
> ridiculous for a serial device to have a display, but the vfio display
> region support isn't really tied to the functionality of the base mdev
> device.  We could have it simply display a static test pattern, just so
> we can test the end to end code path without a dependency on a closed
> vendor driver.

Hmm, have to think about that.  Some way to change the display content
would be nice as you can see whenever display updates are working then.

Maybe the fbcon text rendering code can be used to send the serial
console output from the guest to the display ...

cheers,
  Gerd

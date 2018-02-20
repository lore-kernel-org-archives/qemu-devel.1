Received: from eggs.gnu.org ([2001:4830:134:3::10]:35814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoBLL-0003IQ-M8
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoBLG-0001an-Sb
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:04:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41290 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoBLG-0001a3-Ov
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:04:34 -0500
Date: Tue, 20 Feb 2018 18:04:17 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180220170417.p7hkqbong5euul7p@sirius.home.kraxel.org>
References: <20180219111458.25983-1-kraxel@redhat.com>
	<20180219151649.13a197f9@w520.home>
	<20180220102814.rtcvsrsdtdndcfez@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220102814.rtcvsrsdtdndcfez@sirius.home.kraxel.org>
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
Cc: Kirti Wankhede <kwankhede@nvidia.com>, intel-gvt-dev@lists.freedesktop.org, qemu-devel@nongnu.org, Tina Zhang <tina.zhang@intel.com>

  Hi,

> Sneak preview at https://www.kraxel.org/cgit/qemu/log/?h=work/intel-vgpu
> Note: branch is a moving target ;)
> 
> State:
>   spice: Partly working (no mouse ptr yet).

Working now, in case anyone wants play.

Must turn on opengl and use a unix socket, i.e. this:

  qemu -spice disable-ticketing,gl=on,unix,addr=/tmp/spice-vgpu

and this:

  remote-viewer spice+unix:////tmp/spice-vgpu

Host needs a 4.16-rc kernel.

Guest can be older, most of the time I'm testing with the Fedora 27 live
iso (4.13) which works ok.

cheers,
  Gerd

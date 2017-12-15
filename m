Received: from eggs.gnu.org ([2001:4830:134:3::10]:48776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ePp3P-0007Z2-0d
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:25:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ePp3L-0004Vl-0N
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:25:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ePp3K-0004Tu-IJ
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:25:22 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1CC7AC070E31
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 12:25:21 +0000 (UTC)
Date: Fri, 15 Dec 2017 13:25:19 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171215122519.ov4alinnlqrlvio7@sirius.home.kraxel.org>
References: <20171212202040.GA2458@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171212202040.GA2458@work-vm>
Subject: Re: [Qemu-devel] No uhd (3840x2160) guest res?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Dec 12, 2017 at 08:20:41PM +0000, Dr. David Alan Gilbert wrote:
> My guests don't seem to offer the standard uhd resolution of 3840x2160
> - what should be providing that?
> 
> I'm running an f27 gnome (X or wayland) guest with:
> 
> ./x86_64-softmmu/qemu-system-x86_64 -device virtio-vga --enable-kvm -m 2G /home/vmimages/fedora27.qcow2
> 
> and the guest lists:
> 4096x2160
> 2480x1680
> 2560x1600
> 1920x1440
> 1856x1392
> 1792x1344
> 2048x1152
> 1920x1200
> 1920x1080
> (and smaller)
> 
> given that it can offer 4096x2160, I assume it's not running out of RAM.
> 
> I couldn't find anywhere with those higher resolutions listed
> in seabios to consider changing.

linux kernel has a list of standard vesa resolutions in drm somewhere,
iirc all virt drm drivers just use that for the mode list.

> 
> Dave
> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

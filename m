Received: from eggs.gnu.org ([2001:4830:134:3::10]:42206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1chBR3-0000By-AJ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 03:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1chBR0-0002h2-7p
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 03:41:05 -0500
Received: from chuckie.co.uk ([82.165.15.123]:57696
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1chBR0-0002ef-1I
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 03:41:02 -0500
References: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <983a4a64-728c-621b-96c8-e3a129a78566@ilande.co.uk>
Date: Fri, 24 Feb 2017 08:40:37 +0000
MIME-Version: 1.0
In-Reply-To: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/9] wire up -g <width>x<height> switch for
 virtio and qxl.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 21/02/17 22:14, Gerd Hoffmann wrote:

>   Hi,
> 
> Made a nice patch series out of it, first cleaning up graphics_* variables,
> then adding support for -g to virtio (just works), qxl (needs guest driver
> fixes) and stdvga (needs virtual hardware update, and therefore also an
> guest driver update for obvious reasons).
> 
> linux kernel patches to test qxl and stdvga are here:
>   https://www.kraxel.org/cgit/linux/log/?h=qxl-display-size
> 
> please review & test,
>   Gerd

Interestingly enough, there have been recent discussions from the guys
over at emaculation as to whether it would be possible to pass in valid
resolutions from the host graphics driver for full-screen MacOS 9
emulation in QEMU.

With this patchset I believe Ben's OS 9 VGA driver could read the
suggested resolution from the command line via the QEMU extended VGA
registers, so I'm wondering if it would make sense to have a similar
mechanism for passing in a range of resolutions from the local video
driver that could be offered by the guest driver? Or is the normal guest
driver behaviour to just offer the standard set of *GA resolutions plus
whatever custom resolution is supplied via -g?


ATB,

Mark.

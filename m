Received: from eggs.gnu.org ([2001:4830:134:3::10]:57970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1chFxa-0005Jb-Gh
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1chFxY-0005Qc-0G
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:30:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:65165)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1chFxX-0005QO-QQ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:30:55 -0500
Message-ID: <1487943051.18529.13.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 24 Feb 2017 14:30:51 +0100
In-Reply-To: <983a4a64-728c-621b-96c8-e3a129a78566@ilande.co.uk>
References: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
	<983a4a64-728c-621b-96c8-e3a129a78566@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org

  Hi,

> With this patchset I believe Ben's OS 9 VGA driver could read the
> suggested resolution from the command line via the QEMU extended VGA
> registers,

Yes.

> so I'm wondering if it would make sense to have a similar
> mechanism for passing in a range of resolutions from the local video
> driver that could be offered by the guest driver? Or is the normal guest
> driver behaviour to just offer the standard set of *GA resolutions plus
> whatever custom resolution is supplied via -g?

The linux kms drivers simply use the kernel's mode database, to provide
a list of standard resolutions.  Additionally you also can define your
own resolutions, using xrandr --newmode & --addmode).

If we want go beyond passing a simple "please use <width>y<height>" we
probably should generate a edid block and pass that to the guest, but I
don't see a strong reason to do so.

cheers,
  Gerd

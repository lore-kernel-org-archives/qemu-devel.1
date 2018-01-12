Received: from eggs.gnu.org ([2001:4830:134:3::10]:56253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZz7s-0008I7-UC
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:12:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZz7n-0000ad-7A
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:12:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZz7n-0000ZU-14
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:11:59 -0500
Date: Fri, 12 Jan 2018 14:11:52 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180112131152.57yle3ct42fyqnr4@sirius.home.kraxel.org>
References: <1515519171-20315-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515519171-20315-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] usb: Remove legacy -usbdevice options
 (host, serial, disk and net)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

  Hi,

> The option have been marked as deprecated since QEMU 2.10, and so far
> nobody complained that the host, serial, disk and net options are urgently
> required anymore. So let's now get rid at least of this legacy pile, to
> simplify the usb code quite a bit.
> 
> This patch removes the usbdevices host, serial, disk and net. These devices
> use their own complicated parameter parsing mechanisms, so they are just
> ugly to maintain, without real benefit for the users (the users can use the
> corresponding "-device" parameters instead which have the same complexity
> as the "-usbdevice" devices here).

Queued up, thanks.

cheers,
  Gerd

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMC2d-0003Q7-VG
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:14:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMC2a-0007lL-Qg
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:14:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gMC2a-0007kk-KQ
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:14:08 -0500
Date: Mon, 12 Nov 2018 14:14:02 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181112131402.kxoi724a2iw6kwsj@sirius.home.kraxel.org>
References: <1542016830-19189-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542016830-19189-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] bt: Mark the bluetooth subsystem as
 deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Andrzej Zaborowski <andrew.zaborowski@intel.com>

On Mon, Nov 12, 2018 at 11:00:30AM +0100, Thomas Huth wrote:
> It has been unmaintained since years, and there were only trivial or
> tree-wide changes to the related files since many years, so the
> code is likely very bitrotten and broken. For example the following
> segfaults as soon as as you press a key:
> 
>  qemu-system-x86_64 -usb -device usb-bt-dongle -bt hci -bt device:keyboard
> 
> Since we are not aware of anybody using bluetooth with the current
> version of QEMU, let's mark the subsystem as deprecated, with a special
> request for the users to write to the qemu-devel mailing list in case
> they still use it (so we could revert the deprecation status in that
> case).

I think that settles the bluetooth debate for now.  We deprecate it,
wait for feedback, possibly un-deprecate (parts of) the code.  Next
year we'll actually remove the unused code.

Patch queued for 3.1.

thanks,
  Gerd

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH5Hi-0003Mu-D6
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH5Hc-0001ko-7s
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:00:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gH5HY-0001S9-9A
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:00:30 -0400
Date: Mon, 29 Oct 2018 12:00:12 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181029110012.3bw4t5juygnnex36@sirius.home.kraxel.org>
References: <9179e8bc-1b89-1ed3-687a-467fc45797e0@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9179e8bc-1b89-1ed3-687a-467fc45797e0@physik.fu-berlin.de>
Subject: Re: [Qemu-devel] bochs-display and the future of VGA support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Sun, Oct 28, 2018 at 01:40:29PM +0100, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> I just happened to read Gerd Hoffmann's post on the bochs-display [1] driver
> and was wondering what the future plans for VGA support are.
> 
> Phoronix makes it sound like [2] that VGA support for guests is supposed to
> be removed which I find hard to believe.

No plans to remove vga support.

> Since once VGA support is gone, QEMU would no longer be able to run
> older operating systems which is one of the key features of an
> emulator in my opinion.
> 
> Can anyone tell me what the plans are?

Well, the plan is to be able to run guests which wouldn't use the VGA
anyway without the rather complex VGA emulation enabled.

cheers,
  Gerd

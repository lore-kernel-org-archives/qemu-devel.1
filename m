Received: from eggs.gnu.org ([2001:4830:134:3::10]:33108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fBy5Z-0003Tl-BR
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fBy5W-0000QN-Ai
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:46:41 -0400
Date: Fri, 27 Apr 2018 09:46:31 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180427074631.3l6f3hghcuni6lpd@sirius.home.kraxel.org>
References: <20180420183219.20722-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420183219.20722-1-jandryuk@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] ccid: Fix dwProtocols advertisement of T=0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: alevy@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org

On Fri, Apr 20, 2018 at 02:32:19PM -0400, Jason Andryuk wrote:
> Commit d7d218ef02d87c637d20d64da8f575d434ff6f78 attempted to change
> dwProtocols to only advertise support for T=0 and not T=1.  The change
> was incorrect as it changed 0x00000003 to 0x00010000.
> 
> lsusb -v in a linux guest shows:
> "dwProtocols         65536  (Invalid values detected)", though the
> smart card could still be accessed.  Windows 7 does not detect inserted
> smart cards and logs the the following Error in the Event Logs:
> 
>     Source: Smart Card Service
>     Event ID: 610
>     Smart Card Reader 'QEMU QEMU USB CCID 0' rejected IOCTL SET_PROTOCOL:
>     Incorrect function. If this error persists, your smart card or reader
>     may not be functioning correctly
> 
>     Command Header: 03 00 00 00
> 
> Setting to 0x00000001 fixes the Windows issue.

Added to usb queue.

thanks,
  Gerd

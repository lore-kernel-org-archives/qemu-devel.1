Received: from eggs.gnu.org ([2001:4830:134:3::10]:53968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWMae-0004HP-Hw
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWMaY-0003Nr-Ku
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:31:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gWMaY-0003Nd-EL
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:31:14 -0500
Date: Mon, 10 Dec 2018 15:31:12 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181210143112.ea24zv6klorfkwad@sirius.home.kraxel.org>
References: <20181122170309.4856-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122170309.4856-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-4.0] ui/console: Remove
 qemu_create_display_surface_guestmem()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org

On Thu, Nov 22, 2018 at 05:03:09PM +0000, Peter Maydell wrote:
> The qemu_create_display_surface_guestmem() function was added in
> commit a77549b3ffcc24c32ee4e but apparently never used. Remove it.
> 
> (The API of this function is in any case awkward as a generic
> function: it assumes that a physical address uniquely identifies
> a piece of memory in the system, which is mostly but not
> always true.)

Added to ui queue.

thanks,
  Gerd

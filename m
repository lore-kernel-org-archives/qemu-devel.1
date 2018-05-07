Received: from eggs.gnu.org ([2001:4830:134:3::10]:58854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFhPT-0003jc-BD
	for qemu-devel@nongnu.org; Mon, 07 May 2018 10:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFhPQ-0008VO-7F
	for qemu-devel@nongnu.org; Mon, 07 May 2018 10:46:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36246 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fFhPQ-0008Uw-2P
	for qemu-devel@nongnu.org; Mon, 07 May 2018 10:46:36 -0400
Date: Mon, 7 May 2018 16:46:26 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180507144626.kqywdikvkcinskbm@sirius.home.kraxel.org>
References: <20180507131759.A3F8F381908@moya.office.hostfission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507131759.A3F8F381908@moya.office.hostfission.com>
Subject: Re: [Qemu-devel] [PATCHv2 1/2] ps2: Clear the PS/2 queue and obey
 disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geoffrey McRae <geoff@hostfission.com>
Cc: qemu-devel@nongnu.org

  Hi,

> This allows guest's to correctly reinitialize and identify the mouse
> should the guest decide to re-scan or reset during mouse input events.
> 
> When the guest sends the "Identify" command, due to the PC's hardware
> architecutre it is impossible to reliably determine the response from
> the command amongst other streaming data, such as mouse or keyboard
> events. Standard practice is for the guest to disable the device and
> then issue the identify command, so this must be obeyed.
> 
> Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
> ---
>  hw/input/ps2.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index 06f5d2ac4a..f84a8f5179 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -232,6 +232,9 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
>      uint16_t keycode = 0;
>      int mod;
>  
> +    if (!s->scan_enabled)
> +        return;

qemu code style wants braces here.
See CODING_STYLE.
You can use scripts/checkpatch.pl for codestyle checks.

Code looks fine (both patches) now.

cheers,
  Gerd

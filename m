Received: from eggs.gnu.org ([2001:4830:134:3::10]:51046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVHU7-000531-Nf
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVHU3-0005My-OH
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:15:19 -0400
References: <1499862868-102130-1-git-send-email-agraf@suse.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b08f6c95-9189-e052-98f6-e643ccc16a54@redhat.com>
Date: Wed, 12 Jul 2017 15:15:09 +0200
MIME-Version: 1.0
In-Reply-To: <1499862868-102130-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] PPC: E500: Update u-boot to v2017.07
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On 12.07.2017 14:34, Alexander Graf wrote:
> Quite a while has passed since we last updated U-Boot for e500. This patch
> bumps it to the last released version 2017.07 to make sure users don't feel
> like they're using out of date software.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  pc-bios/u-boot.e500 | Bin 347788 -> 388672 bytes
>  roms/u-boot         |   2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)

I've checked that the U-Boot prompt still shows up correctly, and prints
the correct version information, so if that counts, feel free to add my:

Tested-by: Thomas Huth <thuth@redhat.com>

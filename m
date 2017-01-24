Received: from eggs.gnu.org ([2001:4830:134:3::10]:38942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVvkV-00085P-Ha
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:42:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVvkS-0004Tp-EX
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:42:39 -0500
References: <1484927639-3841-1-git-send-email-thuth@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <0c562336-31a8-5347-1123-810543563fd5@msgid.tls.msk.ru>
Date: Tue, 24 Jan 2017 10:42:27 +0300
MIME-Version: 1.0
In-Reply-To: <1484927639-3841-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/isa/isa-bus: Set category of the
 "isabus-bridge" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

20.01.2017 18:53, Thomas Huth wrote:
> It has "bridge" in its name, so it should be in the category
> DEVICE_CATEGORY_BRIDGE.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/isa/isa-bus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
> index 9d07b11..0ffbc8d 100644
> --- a/hw/isa/isa-bus.c
> +++ b/hw/isa/isa-bus.c
> @@ -219,6 +219,7 @@ static void isabus_bridge_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->fw_name = "isa";
>  }

Does it have any effect on the guest?
ISA is an old thing...

Thanks,

/mjt

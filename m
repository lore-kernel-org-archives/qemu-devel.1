Received: from eggs.gnu.org ([209.51.188.92]:36233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1guZA7-0003Z8-PQ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 03:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1guZA6-0008Ee-TR
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 03:47:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:52909)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1guZA5-00082q-7S
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 03:47:58 -0500
Date: Fri, 15 Feb 2019 16:47:19 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190215084719.GB5456@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190214201939.494-1-philmd@redhat.com>
	<20190214201939.494-4-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190214201939.494-4-philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/9] ccid-card-passthru: Assert on a
 stricter expression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Prasad J Pandit <pjp@fedoraproject.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Would it be better to have some description?

On Thu, Feb 14, 2019 at 09:19:33PM +0100, Philippe Mathieu-Daudé wrote:
>Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>---
> hw/usb/ccid-card-passthru.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
>index 1676b5fc05..0c44b38fc2 100644
>--- a/hw/usb/ccid-card-passthru.c
>+++ b/hw/usb/ccid-card-passthru.c
>@@ -270,7 +270,7 @@ static void ccid_card_vscard_read(void *opaque, const uint8_t *buf, int size)
>     VSCMsgHeader *hdr;
> 
>     assert(size <= VSCARD_IN_SIZE - card->vscard_in_pos);
>-    assert(card->vscard_in_hdr < VSCARD_IN_SIZE);
>+    assert(card->vscard_in_hdr < card->vscard_in_pos);
>     memcpy(card->vscard_in_data + card->vscard_in_pos, buf, size);
>     card->vscard_in_pos += size;
>     hdr = (VSCMsgHeader *)(card->vscard_in_data + card->vscard_in_hdr);
>-- 
>2.20.1
>

-- 
Wei Yang
Help you, Help me

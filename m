Received: from eggs.gnu.org ([2001:4830:134:3::10]:41332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsXRL-0003Vh-2d
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsXRF-0003dJ-AG
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:56:35 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:32803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsXRF-0003ca-5q
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:56:29 -0400
Received: by mail-qk0-x242.google.com with SMTP id g128so2329157qke.0
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 09:56:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <59B80A35020000780017A344@prv-mh.provo.novell.com>
	<59B80A35020000780017A344@prv-mh.provo.novell.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bddb449f-c160-5f6d-8afe-3af59a77dbce@amsat.org>
Date: Thu, 14 Sep 2017 13:56:24 -0300
MIME-Version: 1.0
In-Reply-To: <59B80A35020000780017A344@prv-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] xen_disk: avoid use of g_malloc0_n()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Beulich <JBeulich@suse.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: xen-devel <xen-devel@lists.xenproject.org>, Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>

Marc-André can you queue this patch in your gnew series?

On 09/12/2017 11:24 AM, Jan Beulich wrote:
> Prefer g_new() / g_new0() to be farther backwards compatible with older
> glib versions. As there's no point in zeroing the allocation here (the
> loop right afterwards fully initializes the memory), use the former.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> --- a/hw/block/xen_disk.c
> +++ b/hw/block/xen_disk.c
> @@ -1232,7 +1232,7 @@ static int blk_connect(struct XenDevice
>           return -1;
>       }
>   
> -    domids = g_malloc0_n(blkdev->nr_ring_ref, sizeof(uint32_t));
> +    domids = g_new(uint32_t, blkdev->nr_ring_ref);
>       for (i = 0; i < blkdev->nr_ring_ref; i++) {
>           domids[i] = blkdev->xendev.dom;
>       }

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fsN7K-0001fb-1x
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 02:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fsN7F-0000Tu-01
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 02:59:45 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:54740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fsN7E-0000ST-If
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 02:59:40 -0400
Received: by mail-wm0-x242.google.com with SMTP id c14-v6so992586wmb.4
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 23:59:39 -0700 (PDT)
References: <1534943694-42729-1-git-send-email-peng.hao2@zte.com.cn>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <ed253820-d021-7998-b7f8-6901355577ee@gmail.com>
Date: Wed, 22 Aug 2018 09:59:36 +0300
MIME-Version: 1.0
In-Reply-To: <1534943694-42729-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] pci-bridge/dec: remove unused code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>, mst@redhat.com, agraf@suse.de
Cc: qemu-devel@nongnu.org



On 08/22/2018 04:14 PM, Peng Hao wrote:
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>   hw/pci-bridge/dec.c | 10 ----------
>   1 file changed, 10 deletions(-)
>
> diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
> index 84492d5..ab39185 100644
> --- a/hw/pci-bridge/dec.c
> +++ b/hw/pci-bridge/dec.c
> @@ -31,16 +31,6 @@
>   #include "hw/pci/pci_bridge.h"
>   #include "hw/pci/pci_bus.h"
>   
> -/* debug DEC */
> -//#define DEBUG_DEC
> -
> -#ifdef DEBUG_DEC
> -#define DEC_DPRINTF(fmt, ...)                               \
> -    do { printf("DEC: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DEC_DPRINTF(fmt, ...)
> -#endif
> -
>   #define DEC_21154(obj) OBJECT_CHECK(DECState, (obj), TYPE_DEC_21154)
>   
>   typedef struct DECState {

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>


Thanks,
Marcel

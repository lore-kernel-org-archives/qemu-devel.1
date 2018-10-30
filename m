Received: from eggs.gnu.org ([2001:4830:134:3::10]:58200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHX8H-0005W0-Cu
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHX8C-0008Tu-I5
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:44:45 -0400
References: <20181030151637.37207-1-liq3ea@163.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9b666a59-bfd2-ddc7-e851-495fbb39386a@vivier.eu>
Date: Tue, 30 Oct 2018 17:44:14 +0100
MIME-Version: 1.0
In-Reply-To: <20181030151637.37207-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw: qdev: fix error in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, f4bug@amsat.org, armbru@redhat.com
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Le 30/10/2018 à 16:16, Li Qiang a écrit :
> Cc: qemu-trivial@nongnu.org
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  include/hw/qdev-core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index a24d0dd566..92851e55df 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -197,7 +197,7 @@ typedef struct BusChild {
>  
>  /**
>   * BusState:
> - * @hotplug_device: link to a hotplug device associated with bus.
> + * @hotplug_handler: link to a hotplug handler associated with bus.
>   */
>  struct BusState {
>      Object obj;
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Fixes: 0ee4de6ce1d403b3d8017b340cec772c3c5c106f
       (qdev: add to BusState "hotplug-handler" link)

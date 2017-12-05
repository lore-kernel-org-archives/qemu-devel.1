Received: from eggs.gnu.org ([2001:4830:134:3::10]:53455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eM22k-0005ag-W4
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 20:29:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eM22k-0008KK-8h
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 20:29:06 -0500
References: <1512069154-16814-1-git-send-email-thuth@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0f19f53c-cab9-f7d1-e411-04e38e21fba1@redhat.com>
Date: Mon, 4 Dec 2017 20:29:02 -0500
MIME-Version: 1.0
In-Reply-To: <1512069154-16814-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] hw/ide: Remove duplicated
 definitions from ahci_internal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-block@nongnu.org



On 11/30/2017 02:12 PM, Thomas Huth wrote:
> The same definitions can also be found in include/hw/ide/ahci.h
> so let's remove these #defines from ahci_internal.h.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/ide/ahci_internal.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
> index ce2e818..1080a34 100644
> --- a/hw/ide/ahci_internal.h
> +++ b/hw/ide/ahci_internal.h
> @@ -375,11 +375,4 @@ void ahci_uninit(AHCIState *s);
>  
>  void ahci_reset(AHCIState *s);
>  
> -#define TYPE_SYSBUS_AHCI "sysbus-ahci"
> -#define SYSBUS_AHCI(obj) OBJECT_CHECK(SysbusAHCIState, (obj), TYPE_SYSBUS_AHCI)
> -
> -#define TYPE_ALLWINNER_AHCI "allwinner-ahci"
> -#define ALLWINNER_AHCI(obj) OBJECT_CHECK(AllwinnerAHCIState, (obj), \
> -                       TYPE_ALLWINNER_AHCI)
> -
>  #endif /* HW_IDE_AHCI_H */
> 

Whoops, looks like I got a little carried away with my split and didn't
quite finish the job :(

Sadly, TYPE_ICH9_AHCI is also duplicated ... and used outside of the
core layer. Would you like to do v2 or shall I?

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cJaKR-0001eI-Tr
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 01:24:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cJaKO-00046y-Ps
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 01:24:43 -0500
References: <1478833296-25853-1-git-send-email-caoj.fnst@cn.fujitsu.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <585A213C.4090706@cn.fujitsu.com>
Date: Wed, 21 Dec 2016 14:29:16 +0800
MIME-Version: 1.0
In-Reply-To: <1478833296-25853-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] vfio: remove a duplicated word in
 comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: alex.williamson@redhat.com

ping

On 11/11/2016 11:01 AM, Cao jin wrote:
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  hw/vfio/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 31aaecb..c94987c 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1881,8 +1881,8 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>       * 0 is reserved for this since absence of capabilities is indicated by
>       * 0 for the ID, version, AND next pointer.  However, pcie_add_capability()
>       * uses ID 0 as reserved for list management and will incorrectly match and
> -     * assert if we attempt to pre-load the head of the chain with with this
> -     * ID.  Use ID 0xFFFF temporarily since it is also seems to be reserved in
> +     * assert if we attempt to pre-load the head of the chain with this ID.
> +     * Use ID 0xFFFF temporarily since it is also seems to be reserved in
>       * part for identifying absence of capabilities in a root complex register
>       * block.  If the ID still exists after adding capabilities, switch back to
>       * zero.  We'll mark this entire first dword as emulated for this purpose.
> 

-- 
Sincerely,
Cao jin

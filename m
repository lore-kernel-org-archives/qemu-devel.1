Received: from eggs.gnu.org ([2001:4830:134:3::10]:43680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkTHG-0002W4-5p
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 07:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkTHF-0008RQ-Ag
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 07:57:22 -0400
References: <20180731025231.17482-1-programmingkidx@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cdfa1c40-b618-52e8-41b8-a58a67acef66@redhat.com>
Date: Tue, 31 Jul 2018 06:57:14 -0500
MIME-Version: 1.0
In-Reply-To: <20180731025231.17482-1-programmingkidx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-img-cmds.hx: Add example usage for
 create command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org

On 07/30/2018 09:52 PM, John Arbuckle wrote:
> Add an example on how to use the create command. I believe this will make qemu-img easier to use.
> 
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>   qemu-img-cmds.hx | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index 69758fb6e8..92f7437944 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -50,7 +50,7 @@ STEXI
>   ETEXI
>   
>   DEF("create", img_create,
> -    "create [--object objectdef] [-q] [-f fmt] [-b backing_file] [-F backing_fmt] [-u] [-o options] filename [size]")
> +    "create [--object objectdef] [-q] [-f fmt] [-b backing_file] [-F backing_fmt] [-u] [-o options] filename [size]\nExample: qemu-img create -f qcow2 WindowsXP.qcow2 10G")

Making a long line longer. It would be worth using C string 
concatenation and splitting this over two lines, at the \n.

Using the name WindowsXP.qcow2 as the guest is somewhat misleading (that 
OS is proprietary, and quickly reaching the point of obsolescence from 
its vendor - furthermore, qemu-img doesn't actually install an OS, but 
rather creates a blank image for a later install process to utilize); 
better would be a generic name that won't go out of date, such 
'image.qcow2'.


>   STEXI
>   @item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-u] [-o @var{options}] @var{filename} [@var{size}]
>   ETEXI
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

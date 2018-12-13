Received: from eggs.gnu.org ([2001:4830:134:3::10]:49949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXYS2-0001pE-Ja
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXYRz-0005I6-Bm
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:23:22 -0500
References: <20181213173113.11211-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1443f6a6-4d31-8e5c-0ec3-3f906b102e04@redhat.com>
Date: Thu, 13 Dec 2018 15:23:16 -0600
MIME-Version: 1.0
In-Reply-To: <20181213173113.11211-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] error: Remove NULL checks on
 error_propagate() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 12/13/18 11:31 AM, Markus Armbruster wrote:
> Patch created mechanically by rerunning:
> 
>    $  spatch --sp-file scripts/coccinelle/error_propagate_null.cocci \
>              --macro-file scripts/cocci-macro-file.h \
>              --dir . --in-place
> 
> Whitespace tidied up manually.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   blockdev.c              | 4 +---
>   hw/s390x/s390-pci-bus.c | 4 +---
>   qga/commands-posix.c    | 7 ++-----
>   3 files changed, 4 insertions(+), 11 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

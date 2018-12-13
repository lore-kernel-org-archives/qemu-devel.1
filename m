Received: from eggs.gnu.org ([2001:4830:134:3::10]:51641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXYXB-0004Vm-4Y
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXYX5-0007vr-Bz
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:28:41 -0500
References: <20181213175807.12039-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9e685aeb-29f1-a755-cca1-b3b51da82472@redhat.com>
Date: Thu, 13 Dec 2018 15:28:31 -0600
MIME-Version: 1.0
In-Reply-To: <20181213175807.12039-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vl: Use error_fatal to simplify obvious
 fatal errors (again)
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

On 12/13/18 11:58 AM, Markus Armbruster wrote:
> Patch created mechanically by rerunning:
> 
>      $ spatch --in-place --sp-file scripts/coccinelle/use-error_fatal.cocci \
>               --macro-file scripts/cocci-macro-file.h vl.c
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   vl.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

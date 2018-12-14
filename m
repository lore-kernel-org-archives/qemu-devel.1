Received: from eggs.gnu.org ([2001:4830:134:3::10]:54544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gXkVi-0005fs-EF
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gXkVc-0003JR-02
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:15:58 -0500
References: <20181213173113.11211-1-armbru@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ebdef399-64a3-3995-16d8-a57570bc2133@vivier.eu>
Date: Fri, 14 Dec 2018 11:15:36 +0100
MIME-Version: 1.0
In-Reply-To: <20181213173113.11211-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] error: Remove NULL checks
 on error_propagate() calls
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

On 13/12/2018 18:31, Markus Armbruster wrote:
> Patch created mechanically by rerunning:
> 
>   $  spatch --sp-file scripts/coccinelle/error_propagate_null.cocci \
>             --macro-file scripts/cocci-macro-file.h \
>             --dir . --in-place
> 
> Whitespace tidied up manually.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  blockdev.c              | 4 +---
>  hw/s390x/s390-pci-bus.c | 4 +---
>  qga/commands-posix.c    | 7 ++-----
>  3 files changed, 4 insertions(+), 11 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gXkWh-0006AX-7O
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gXkWd-0003xK-36
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:16:59 -0500
References: <20181213175807.12039-1-armbru@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <13484f73-1119-cac2-5c12-877557c3474f@vivier.eu>
Date: Fri, 14 Dec 2018 11:16:47 +0100
MIME-Version: 1.0
In-Reply-To: <20181213175807.12039-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] vl: Use error_fatal to
 simplify obvious fatal errors (again)
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

On 13/12/2018 18:58, Markus Armbruster wrote:
> Patch created mechanically by rerunning:
> 
>     $ spatch --in-place --sp-file scripts/coccinelle/use-error_fatal.cocci \
>              --macro-file scripts/cocci-macro-file.h vl.c
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  vl.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

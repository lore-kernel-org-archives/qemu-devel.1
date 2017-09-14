Received: from eggs.gnu.org ([2001:4830:134:3::10]:54921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dslav-0008IB-2t
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dslar-0000vq-UX
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:03:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dslar-0000vT-PH
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:03:21 -0400
References: <150538015789.8149.10902725348939486674.stgit@bahia.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b1df38c4-25c1-c91c-85e3-f984b5491d65@redhat.com>
Date: Thu, 14 Sep 2017 15:16:50 +0200
MIME-Version: 1.0
In-Reply-To: <150538015789.8149.10902725348939486674.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] checkpatch: add hwaddr to @typeList
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

On 14/09/2017 11:12, Greg Kurz wrote:
> The script doesn't know about all possible types and learn them as
> it parses the code. If it reaches a line with a type cast but the
> type isn't known yet, it is misinterpreted as an identifier.
> 
> For example the following line:
> 
>     foo = (hwaddr) -1;
> 
> results in the following false-positive to be reported:
> 
> ERROR: spaces required around that '-' (ctx:VxV)
> 
> Let's add this standard QEMU type to the list of pre-known types.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> 
> checkpatch doesn't have an official maintainer, Cc'ing David in case he
> agrees to carry this patch through his ppc tree, along with:
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg03686.html
> 
>  scripts/checkpatch.pl |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index fa478074b88d..def5bc1cc0e1 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -213,6 +213,7 @@ our @typeList = (
>  	qr{${Ident}_handler},
>  	qr{${Ident}_handler_fn},
>  	qr{target_(?:u)?long},
> +	qr{hwaddr},
>  );
>  
>  # This can be modified by sub possible.  Since it can be empty, be careful
> 

Queued, thanks.

Paolo

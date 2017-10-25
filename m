Received: from eggs.gnu.org ([2001:4830:134:3::10]:37296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1e7KQ0-0008Bz-In
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1e7KPv-0007Sl-2Z
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:04:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1e7KPu-0007Rt-TK
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:04:15 -0400
Date: Wed, 25 Oct 2017 14:04:05 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20171025120405.GC10290@vader>
References: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
	<20171023151310.6462-4-vadim.galitsyn@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171023151310.6462-4-vadim.galitsyn@profitbricks.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] tests: test-hmp: extend with
 'writeconfig' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

On Mon, Oct 23, 2017 at 05:13:09PM +0200, Vadim Galitsyn wrote:
> Extend list of test cases with 'writeconfig' command.
> 
> Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  tests/test-hmp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index 5677fbf775..8e21eee61c 100644
> --- a/tests/test-hmp.c
> +++ b/tests/test-hmp.c
> @@ -68,6 +68,7 @@ static const char *hmp_cmds[] = {
>      "sum 0 512",
>      "x /8i 0x100",
>      "xp /16x 0",
> +    "writeconfig /dev/null",
>      NULL
>  };
>  
> -- 
> 2.13.1.394.g41dd433
> 
> 
Reviewed-by: Eduardo Otubo <otubo@redhat.com>

-- 
Eduardo Otubo

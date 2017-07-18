Received: from eggs.gnu.org ([2001:4830:134:3::10]:33799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dXVrz-000293-Kv
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dXVry-00079s-R7
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:01:11 -0400
Date: Tue, 18 Jul 2017 13:00:58 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170718170058.GS4997@localhost.localdomain>
References: <20170717142620.6970-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717142620.6970-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: Remove a few tests
 from 'quick' group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, berrange@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Mon, Jul 17, 2017 at 09:26:20AM -0500, Eric Blake wrote:
> A run of './check -qcow2 -g quick' on my machine produced only
> two tests that took longer than 5 seconds; 178 took 18, and
> 189 took 7.  Remove them from the quick group.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/group | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 2aba585287..01f12d6781 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -175,11 +175,11 @@
>  175 auto quick
>  176 rw auto backing
>  177 rw auto quick
> -178 auto quick
> +178 auto
>  179 rw auto quick
>  181 rw auto migration
>  182 rw auto quick
>  183 rw auto migration
>  185 rw auto
>  188 rw auto quick
> -189 rw auto quick
> +189 rw auto
> -- 
> 2.13.3
> 
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>

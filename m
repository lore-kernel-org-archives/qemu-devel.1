Received: from eggs.gnu.org ([2001:4830:134:3::10]:48628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eYPHS-0002yA-Es
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 23:43:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eYPHR-0004Ho-Fk
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 23:43:26 -0500
Date: Sun, 7 Jan 2018 23:43:16 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180108044316.GA31768@localhost.localdomain>
References: <20180105144440.18129-1-muriloo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180105144440.18129-1-muriloo@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] block/ssh: fix possible segmentation fault
 when .desc is not null-terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Richard W M Jones <rjones@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri, Jan 05, 2018 at 12:44:40PM -0200, Murilo Opsfelder Araujo wrote:
> This patch prevents a possible segmentation fault when .desc members are checked
> against NULL.
> 
> The ssh_runtime_opts was added by commit
> 8a6a80896d6af03b8ee0c17cdf37219eca2588a7 ("block/ssh: Use QemuOpts for runtime
> options").
> 
> This fix was inspired by
> http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg00883.html.
> 
> Fixes: 8a6a80896d6af03b8ee0c17cdf37219eca2588a7 ("block/ssh: Use QemuOpts for runtime options")
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
> ---
>  block/ssh.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/ssh.c b/block/ssh.c
> index b049a16eb9..8890a0c4ba 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -556,6 +556,7 @@ static QemuOptsList ssh_runtime_opts = {
>              .type = QEMU_OPT_STRING,
>              .help = "Defines how and what to check the host key against",
>          },
> +        { /* end of list */ }
>      },
>  };
>  
> -- 
> 2.14.3
> 

Thanks,

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc block

-Jeff

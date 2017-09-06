Received: from eggs.gnu.org ([2001:4830:134:3::10]:56850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpXQS-0007eL-As
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 06:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpXQN-0004Bp-Dl
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 06:19:16 -0400
Date: Wed, 6 Sep 2017 12:19:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170906101905.GD3753@dhcp-200-186.str.redhat.com>
References: <20170906085006.26983-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170906085006.26983-1-rjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] qemu-options: Document the -drive
 locking parameter.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, famz@redhat.com, qemu-trivial@nongnu.org, mjt@tls.msk.ru

Am 06.09.2017 um 10:50 hat Richard W.M. Jones geschrieben:
> Commit 16b48d5d66d2 ("file-posix: Add 'locking' option") added this
> option, but as it was not documented in the -help output it was not
> easily possible to tell if a particular qemu binary supports it.
> 
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  qemu-options.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 9f6e2adfff..f8f95eb498 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -796,7 +796,7 @@ DEF("drive", HAS_ARG, QEMU_OPTION_drive,
>      "       [,cache=writethrough|writeback|none|directsync|unsafe][,format=f]\n"
>      "       [,serial=s][,addr=A][,rerror=ignore|stop|report]\n"
>      "       [,werror=ignore|stop|report|enospc][,id=name][,aio=threads|native]\n"
> -    "       [,readonly=on|off][,copy-on-read=on|off]\n"
> +    "       [,readonly=on|off][,copy-on-read=on|off][,locking=off|auto|on]\n"
>      "       [,discard=ignore|unmap][,detect-zeroes=on|off|unmap]\n"
>      "       [[,bps=b]|[[,bps_rd=r][,bps_wr=w]]]\n"
>      "       [[,iops=i]|[[,iops_rd=r][,iops_wr=w]]]\n"

'locking' is a driver-specific option and not universally available for
all images, so it shouldn't be included here.

Of course, you're right that driver-specific options should be
documented somewhere, and currently that's only in the QAPI schema for
blockdev-add, which isn't quite satisfying. Maybe adding them to the
'qemu-block-drivers' man page could work (which currently only contains
'qemu-img create' options).

Kevin

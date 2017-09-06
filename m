Received: from eggs.gnu.org ([2001:4830:134:3::10]:58305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpWB1-0003eU-8O
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpWAv-0000ql-J3
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:59:15 -0400
Date: Wed, 6 Sep 2017 09:59:02 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170906085902.GH15510@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170906085006.26983-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-trivial@nongnu.org, mjt@tls.msk.ru, famz@redhat.com, armbru@redhat.com

The 2.10 versio nis already released. Did you mean that you wanted
this in the stable branch ?  If so, then CC qemu-stable@nongnu.org

On Wed, Sep 06, 2017 at 09:50:06AM +0100, Richard W.M. Jones wrote:
> Commit 16b48d5d66d2 ("file-posix: Add 'locking' option") added this
> option, but as it was not documented in the -help output it was not
> easily possible to tell if a particular qemu binary supports it.

NB, nothing should be parsing -help output to look for features
anymore. Is there really no other way to detect this feature ?

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

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cQXyQ-0008OD-3e
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:18:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cQXyM-0006xx-F9
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:18:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cQXyM-0006xB-9a
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:18:42 -0500
Date: Mon, 9 Jan 2017 11:18:35 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170109111835.GE29989@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170109100123.5080-1-jinguojie@loongson.cn>
	<20170109100123.5080-2-jinguojie@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170109100123.5080-2-jinguojie@loongson.cn>
Subject: Re: [Qemu-devel] [PATCH 1/1] Change default CFLAGS to -O3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jin Guojie <jinguojie@loongson.cn>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Jan 09, 2017 at 06:01:23PM +0800, Jin Guojie wrote:
> For better performance.

The commit message needs to have actual data on what the
measured performance improvements are really.

> 
> Signed-off-by: Jin Guojie <jinguojie@loongson.cn>
> ---
>  configure | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configure b/configure
> index 218df87..8ebc286 100755
> --- a/configure
> +++ b/configure
> @@ -4753,9 +4753,9 @@ if test "$gcov" = "yes" ; then
>    CFLAGS="-fprofile-arcs -ftest-coverage -g $CFLAGS"
>    LDFLAGS="-fprofile-arcs -ftest-coverage $LDFLAGS"
>  elif test "$fortify_source" = "yes" ; then
> -  CFLAGS="-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $CFLAGS"
> +  CFLAGS="-O3 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $CFLAGS"
>  elif test "$debug" = "no"; then
> -  CFLAGS="-O2 $CFLAGS"
> +  CFLAGS="-O3 $CFLAGS"
>  fi

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

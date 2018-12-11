Received: from eggs.gnu.org ([2001:4830:134:3::10]:33205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWeOs-0004cM-2a
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:32:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWeOk-0002gK-QN
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:32:21 -0500
Date: Tue, 11 Dec 2018 09:31:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181211093158.GB921@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181211054926.56717-1-aik@ozlabs.ru>
	<20181211054926.56717-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181211054926.56717-2-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu 1/3] configure/fdt: Use more strict
 test for libfdt version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

On Tue, Dec 11, 2018 at 04:49:24PM +1100, Alexey Kardashevskiy wrote:
> The libfdt installed in the system is preferred to the dtc submodule by
> default. The recent libfdt update added a new symbol - fdt_check_full -
> and this breaks compile if there is an older libfdt installed in
> the system.

AFACT, there's no usage of fdt_check_full in the QMEU tree, so this
commit message is wrong.  The first usage is introduced in your
next patch, so this configure change should just be part of that
patch which introduces it.

> 
> This changes the test to force ./configure into using newer libfdt.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 0a3c6a7..e5312da 100755
> --- a/configure
> +++ b/configure
> @@ -3880,7 +3880,7 @@ if test "$fdt" != "no" ; then
>    cat > $TMPC << EOF
>  #include <libfdt.h>
>  #include <libfdt_env.h>
> -int main(void) { fdt_first_subnode(0, 0); return 0; }
> +int main(void) { fdt_check_full(NULL, 0); return 0; }
>  EOF
>    if compile_prog "" "$fdt_libs" ; then
>      # system DTC is good - use it
> -- 
> 2.17.1
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

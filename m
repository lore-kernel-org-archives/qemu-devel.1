Received: from eggs.gnu.org ([2001:4830:134:3::10]:60914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gWkiF-0005YI-D6
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gWkiC-0001A2-O7
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:16:47 -0500
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:53387)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gWkiC-000154-F9
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:16:44 -0500
Received: from player737.ha.ovh.net (unknown [10.109.143.225])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id DCEA2E5C4E
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 17:16:42 +0100 (CET)
Date: Tue, 11 Dec 2018 17:16:35 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181211171635.3ae8fc4f@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20181211054926.56717-2-aik@ozlabs.ru>
References: <20181211054926.56717-1-aik@ozlabs.ru>
	<20181211054926.56717-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu 1/3] configure/fdt: Use
 more strict test for libfdt version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Tue, 11 Dec 2018 16:49:24 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> The libfdt installed in the system is preferred to the dtc submodule by
> default. The recent libfdt update added a new symbol - fdt_check_full -
> and this breaks compile if there is an older libfdt installed in
> the system.
> 
> This changes the test to force ./configure into using newer libfdt.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---

Yeah I had noticed that also... I agree with Daniel that it should be
folded into the next patch.

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

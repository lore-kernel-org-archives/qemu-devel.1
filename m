Received: from eggs.gnu.org ([2001:4830:134:3::10]:50751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1dvMqs-0006i4-9o
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1dvMqo-0003Qr-B6
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:14:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:33685 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1dvMqo-0003Kc-1V
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:14:34 -0400
References: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
	<1505498999-17427-2-git-send-email-ian.jackson@eu.citrix.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <a5d319a8-627b-a0c5-8642-8c6d5f400213@suse.com>
Date: Fri, 22 Sep 2017 14:14:16 +0200
MIME-Version: 1.0
In-Reply-To: <1505498999-17427-2-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/6] xen: link against xentoolcore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: xen-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

On 15/09/17 20:09, Ian Jackson wrote:
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> ---
>  configure | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configure b/configure
> index fd7e3a5..c59a0c0 100755
> --- a/configure
> +++ b/configure
> @@ -2072,14 +2072,14 @@ if test "$xen" != "no" ; then
>        $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
>      xen=yes
>      xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab"
> -    xen_pc="$xen_pc xenevtchn xendevicemodel"
> +    xen_pc="$xen_pc xenevtchn xendevicemodel xentoolcore"
>      QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
>      libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
>      LDFLAGS="$($pkg_config --libs $xen_pc) $LDFLAGS"
>    else
>  
>      xen_libs="-lxenstore -lxenctrl -lxenguest"
> -    xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn"
> +    xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn -lxentoolcore"

I don't think this is necessary. libxentoolcore is only available with
a new Xen, which will always have the xentoolcore.pc file installed.


Juergen

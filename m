Received: from eggs.gnu.org ([209.51.188.92]:42824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glbIl-0004EO-0n
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glbIk-0000Qh-Bh
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:15:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glbIk-0000QJ-6E
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:15:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so23789031wrt.7
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 07:15:50 -0800 (PST)
References: <20190121144841.24467-1-anthony.perard@citrix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <721833db-06fc-5efd-92f5-7824e8b5143d@redhat.com>
Date: Mon, 21 Jan 2019 16:15:47 +0100
MIME-Version: 1.0
In-Reply-To: <20190121144841.24467-1-anthony.perard@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: Don't add Xen's libs to LDFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul.durrant@citrix.com>, Peter Maydell <peter.maydell@linaro.org>

On 1/21/19 3:48 PM, Anthony PERARD wrote:
> When Xen is detected via pkg-config, it isn't necessary to modify
> LDFLAGS as modifying libs_softmmu is enough.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>  configure | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 12fd34f30b..98b270974d 100755
> --- a/configure
> +++ b/configure
> @@ -2355,7 +2355,6 @@ if test "$xen" != "no" ; then
>      fi
>      QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
>      libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
> -    LDFLAGS="$($pkg_config --libs $xen_pc) $LDFLAGS"
>    else
>  
>      xen_libs="-lxenstore -lxenctrl -lxenguest"
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

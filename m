Received: from eggs.gnu.org ([2001:4830:134:3::10]:40369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=644fc49e2=anthony.perard@citrix.com>)
	id 1fAeDu-00058U-L6
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=644fc49e2=anthony.perard@citrix.com>)
	id 1fAeDr-0007ZN-BE
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:21:50 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:32497)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=644fc49e2=anthony.perard@citrix.com>)
	id 1fAeDr-0007YR-1F
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:21:47 -0400
Date: Mon, 23 Apr 2018 17:21:42 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180423162142.GG1980@perard>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-17-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1524156319-11465-17-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH 16/16] configure: do_compiler: Dump some
 extra info under bash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, "Kent R. Spillner" <kspillner@acm.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Apr 19, 2018 at 05:45:19PM +0100, Ian Jackson wrote:
> This makes it much easier to find a particular thing in config.log.
> 
> The information may be lacking in other shells, resulting in harmless
> empty output.  (This is why we don't use the proper ${FUNCNAME[*]}
> array syntax - other shells will choke on that.)
> 
> The extra output is only printed if configure is run with bash.  On
> systems where /bin/sh is not bash, it is necessary to say bash
> ./configure to get the extra debug info in the log.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> ---
>  configure | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/configure b/configure
> index d5435ff..a4c5292 100755
> --- a/configure
> +++ b/configure
> @@ -60,6 +60,10 @@ do_compiler() {
>      # is compiler binary to execute.
>      local compiler="$1"
>      shift
> +    echo >>config.log "
> +funcs: ${FUNCNAME}
> +lines: ${BASH_LINENO}
> +files: ${BASH_SOURCE}"
>      echo $compiler "$@" >> config.log
>      $compiler "$@" >> config.log 2>&1 || return $?
>      # Test passed. If this is an --enable-werror build, rerun

How is this usefull? All I have in my config.log is a lot of:
  funcs: do_compiler
  lines: 91
  files: ./configure

And one:
  funcs: do_compiler
  lines: 95
  files: ./configure

It still don't tell me which test had runned.

Regards,

-- 
Anthony PERARD

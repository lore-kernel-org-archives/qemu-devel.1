Received: from eggs.gnu.org ([2001:4830:134:3::10]:58567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7qd6-0004mq-P8
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 18:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7qd5-0007bS-UX
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 18:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1e7qd5-0007aN-O3
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 18:27:59 -0400
Date: Thu, 26 Oct 2017 15:27:57 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1508506702-17704-8-git-send-email-ian.jackson@eu.citrix.com>
Message-ID: <alpine.DEB.2.10.1710261527150.3086@sstabellini-ThinkPad-X260>
References: <23017.64539.31230.43449@mariner.uk.xensource.com>
	<1508506702-17704-1-git-send-email-ian.jackson@eu.citrix.com>
	<1508506702-17704-8-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v5.1 8/8] configure: do_compiler: Dump some
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
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, peter.maydell@linaro.org, pbonzini@redhat.com, famz@redhat.com, kraxel@redhat.com, stefanha@redhat.com

CC'ing the maintainers for this.

On Fri, 20 Oct 2017, Ian Jackson wrote:
> This makes it much easier to find a particular thing in config.log.
> 
> The information may be lacking in other shells, resulting in harmless
> empty output.  (This is why we don't use the proper ${FUNCNAME[*]}
> array syntax - other shells will choke on that.)
> 
> The extra output is only printed if configure is run with bash.  The
> something), it is necessary to say   bash ./configure  to get the extra
> debug info in the log.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> ---
> v4: No longer tag this patch RFC.
> ---
>  configure | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/configure b/configure
> index 6f691df..21a2b15 100755
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
> -- 
> 2.1.4
> 

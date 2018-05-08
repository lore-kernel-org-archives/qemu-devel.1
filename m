Received: from eggs.gnu.org ([2001:4830:134:3::10]:40119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fG4ni-00055k-SC
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fG4ni-00089V-4l
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:45:14 -0400
Date: Tue, 8 May 2018 11:45:01 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180508154501.GC6722@localhost.localdomain>
References: <20180503225648.13153-1-jsnow@redhat.com>
	<20180503225648.13153-4-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503225648.13153-4-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/5] qemu-img: remove
 references to GEN_DOCS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-trivial@nongnu.org

On Thu, May 03, 2018 at 06:56:46PM -0400, John Snow wrote:
> Nothing seemingly uses this.
>

Indeed - it looks like it has been vestigial for a while now (commit
77bd1119ba even mentions that it appears unused).

Reviewed-by: Jeff Cody <jcody@redhat.com>

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qemu-img.c             | 2 --
>  qemu-options-wrapper.h | 1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 855fa52514..a01425372d 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -123,7 +123,6 @@ static void QEMU_NORETURN help(void)
>             "  " arg_string "\n"
>  #include "qemu-img-cmds.h"
>  #undef DEF
> -#undef GEN_DOCS
>             "\n"
>             "Command parameters:\n"
>             "  'filename' is a disk image filename\n"
> @@ -4685,7 +4684,6 @@ static const img_cmd_t img_cmds[] = {
>      { option, callback },
>  #include "qemu-img-cmds.h"
>  #undef DEF
> -#undef GEN_DOCS
>      { NULL, NULL, },
>  };
>  
> diff --git a/qemu-options-wrapper.h b/qemu-options-wrapper.h
> index 13bfea0294..6f548e3922 100644
> --- a/qemu-options-wrapper.h
> +++ b/qemu-options-wrapper.h
> @@ -34,7 +34,6 @@
>  #undef DEF
>  #undef DEFHEADING
>  #undef ARCHHEADING
> -#undef GEN_DOCS
>  
>  #undef QEMU_OPTIONS_GENERATE_ENUM
>  #undef QEMU_OPTIONS_GENERATE_HELP
> -- 
> 2.14.3
> 
> 

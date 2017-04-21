Received: from eggs.gnu.org ([2001:4830:134:3::10]:41116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1MMb-0004bO-AP
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 20:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1MMa-0005QZ-Di
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 20:23:53 -0400
Date: Fri, 21 Apr 2017 08:23:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170421002344.GP24486@lemon.lan>
References: <1492719341-11476-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1492719341-11476-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Remove PERL_PROG and BC_PROG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, ymankad@redhat.com, qemu-devel@nongnu.org

On Thu, 04/20 22:15, Kevin Wolf wrote:
> We test for the presence of perl and bc and save their path in the
> variables PERL_PROG and BC_PROG, but never actually make use of them.
> Remove the checks and assignments so qemu-iotests can run even when
> bc isn't installed.
> 
> Reported-by: Yash Mankad <ymankad@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/common.config | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
> index 55527aa..1222e43 100644
> --- a/tests/qemu-iotests/common.config
> +++ b/tests/qemu-iotests/common.config
> @@ -75,18 +75,12 @@ _fatal()
>      exit 1
>  }
>  
> -export PERL_PROG="`set_prog_path perl`"
> -[ "$PERL_PROG" = "" ] && _fatal "perl not found"
> -

Then we should drop _readlink which is unused and uses perl too. Whether in this
patch together or in a separate patch doesn't matter much, so:

>  export AWK_PROG="`set_prog_path awk`"
>  [ "$AWK_PROG" = "" ] && _fatal "awk not found"
>  
>  export SED_PROG="`set_prog_path sed`"
>  [ "$SED_PROG" = "" ] && _fatal "sed not found"
>  
> -export BC_PROG="`set_prog_path bc`"
> -[ "$BC_PROG" = "" ] && _fatal "bc not found"
> -

The bc part is nice!

>  export PS_ALL_FLAGS="-ef"
>  
>  if [ -z "$QEMU_PROG" ]; then
> -- 
> 1.8.3.1
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>

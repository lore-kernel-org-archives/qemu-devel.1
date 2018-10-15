Received: from eggs.gnu.org ([2001:4830:134:3::10]:52476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gBx0V-0004EZ-E2
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gBx0U-0001ro-Jc
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:09:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gBx0U-0001pb-97
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:09:38 -0400
References: <20181015065157.3634-1-maozhongyi@cmss.chinamobile.com>
	<20181015065157.3634-2-maozhongyi@cmss.chinamobile.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9e5c01c8-0601-e4e3-20ab-898b1a191121@redhat.com>
Date: Mon, 15 Oct 2018 09:09:31 +0200
MIME-Version: 1.0
In-Reply-To: <20181015065157.3634-2-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] git-submodule.sh: Modern shell
 scripting (use $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Eric Blake <eblake@redhat.com>

On 2018-10-15 08:51, Mao Zhongyi wrote:
> Various shell files contain a mix between obsolete `` and
> modern $(); use of `` is only required when using /bin/sh
> on Solaris. It would be nice to convert to using $()
> everywhere, or at least in all bash scripts, as well as in
> all scripts that are known to not be run on Solaris.
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>  scripts/git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> index 807ca0b4f8..d452149c1a 100755
> --- a/scripts/git-submodule.sh
> +++ b/scripts/git-submodule.sh
> @@ -59,7 +59,7 @@ status)
>      fi
>  
>      test -f "$substat" || exit 1
> -    CURSTATUS=`$GIT submodule status $modules`
> +    CURSTATUS=$($GIT submodule status $modules)
>      OLDSTATUS=`cat $substat`
>      test "$CURSTATUS" = "$OLDSTATUS"
>      exit $?
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

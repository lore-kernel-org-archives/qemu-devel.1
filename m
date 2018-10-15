Received: from eggs.gnu.org ([2001:4830:134:3::10]:53320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gBx3m-00069R-7G
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gBx3i-0003y9-VH
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:13:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gBx3h-0003wB-9D
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:12:58 -0400
References: <20181015065157.3634-1-maozhongyi@cmss.chinamobile.com>
	<20181015065157.3634-3-maozhongyi@cmss.chinamobile.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8cc67f1a-8d1d-ff5e-ce00-941f1461ec8d@redhat.com>
Date: Mon, 15 Oct 2018 09:12:45 +0200
MIME-Version: 1.0
In-Reply-To: <20181015065157.3634-3-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] show-fixed-bugs.sh: Modern shell
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
>  scripts/show-fixed-bugs.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/show-fixed-bugs.sh b/scripts/show-fixed-bugs.sh
> index 36f306898f..a095a4d6ba 100755
> --- a/scripts/show-fixed-bugs.sh
> +++ b/scripts/show-fixed-bugs.sh
> @@ -23,10 +23,10 @@ while getopts "s:e:cbh" opt; do
>  done
>  
>  if [ "x$start" = "x" ]; then
> -    start=`git tag -l 'v[0-9]*\.[0-9]*\.0' | tail -n 2 | head -n 1`
> +    start=$(git tag -l 'v[0-9]*\.[0-9]*\.0' | tail -n 2 | head -n 1)
>  fi
>  if [ "x$end" = "x" ]; then
> -    end=`git tag -l  'v[0-9]*\.[0-9]*\.0' | tail -n 1`
> +    end=$(git tag -l  'v[0-9]*\.[0-9]*\.0' | tail -n 1)
>  fi
>  
>  if [ "x$start" = "x" ] || [ "x$end" = "x" ]; then
> @@ -38,9 +38,9 @@ fi
>  echo "Searching git log for bugs in the range $start..$end"
>  
>  urlstr='https://bugs.launchpad.net/\(bugs\|qemu/+bug\)/'
> -bug_urls=`git log $start..$end \
> +bug_urls=$(git log $start..$end \
>    | sed -n '\,'"$urlstr"', s,\(.*\)\('"$urlstr"'\)\([0-9]*\).*,\2\4,p' \
> -  | sort -u`
> +  | sort -u)
>  
>  echo Found bug URLs:
>  for i in $bug_urls ; do echo " $i" ; done
> @@ -68,7 +68,7 @@ elif [ "x$show_in_browser" = "x1" ]; then
>          bugbrowser=xdg-open
>      elif command -v gnome-open >/dev/null 2>&1; then
>          bugbrowser=gnome-open
> -    elif [ "`uname`" = "Darwin" ]; then
> +    elif [ "$(uname)" = "Darwin" ]; then
>          bugbrowser=open
>      elif command -v sensible-browser >/dev/null 2>&1; then
>          bugbrowser=sensible-browser
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

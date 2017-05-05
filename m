Received: from eggs.gnu.org ([2001:4830:134:3::10]:58536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d6Wg2-0006Ha-6R
	for qemu-devel@nongnu.org; Fri, 05 May 2017 02:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d6Wfz-0002zN-3K
	for qemu-devel@nongnu.org; Fri, 05 May 2017 02:25:18 -0400
References: <20170425131828.22480-1-n54@gmx.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <690b205a-e3d1-f378-97a8-dca129743826@msgid.tls.msk.ru>
Date: Fri, 5 May 2017 09:14:26 +0300
MIME-Version: 1.0
In-Reply-To: <20170425131828.22480-1-n54@gmx.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scripts/qemu-binfmt-conf.sh: Fix shell
 portability issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-trivial@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel <qemu-devel@nongnu.org>

25.04.2017 16:18, Kamil Rytarowski wrote:
> Appease pkgsrc and use portable shell variable comparison.
> This switches "==" to "=". It should not be a functional change.

Applied to -trivial, thanks!

/mjt

> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  scripts/qemu-binfmt-conf.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 0f1aa63872..8afc3eb5bb 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -284,12 +284,12 @@ while true ; do
>          shift
>          # check given cpu is in the supported CPU list
>          for cpu in ${qemu_target_list} ; do
> -            if [ "$cpu" == "$1" ] ; then
> +            if [ "$cpu" = "$1" ] ; then
>                  break
>              fi
>          done
>  
> -        if [ "$cpu" == "$1" ] ; then
> +        if [ "$cpu" = "$1" ] ; then
>              qemu_target_list="$1"
>          else
>              echo "ERROR: unknown CPU \"$1\"" 1>&2
> 	

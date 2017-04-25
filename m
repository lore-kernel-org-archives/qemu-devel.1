Received: from eggs.gnu.org ([2001:4830:134:3::10]:43860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d30bL-0003Iy-UC
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d30bL-0007bo-5A
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:33:55 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:35402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d30bK-0007aR-Vd
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:33:55 -0400
Received: by mail-wr0-x22c.google.com with SMTP id z52so67586227wrc.2
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 06:33:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170425131828.22480-1-n54@gmx.com>
References: <20170425131828.22480-1-n54@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 14:33:33 +0100
Message-ID: <CAFEAcA-PmbjRYb2EDDp60pKNnUQ8Rkdx79TTLgUMf_VRe2JT+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Kamil Rytarowski <n54@gmx.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 25 April 2017 at 14:18, Kamil Rytarowski <n54@gmx.com> wrote:
> Appease pkgsrc and use portable shell variable comparison.
> This switches "==" to "=". It should not be a functional change.
>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---

Thanks for this patch; it's an easy bug to let slip in
if your /bin/sh happens to be bash.

PS: you forgot to cc qemu-devel@ on this patch.

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
> --
> 2.12.2

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

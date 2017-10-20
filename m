Received: from eggs.gnu.org ([2001:4830:134:3::10]:57358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5X81-0004lu-00
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5X80-0005wj-65
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:14:20 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5X7z-0005wV-Ui
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:14:20 -0400
Received: by mail-wm0-x243.google.com with SMTP id f4so22487940wme.0
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 06:14:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171020130748.22983-1-berrange@redhat.com>
References: <20171020130748.22983-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Oct 2017 14:13:58 +0100
Message-ID: <CAFEAcA-m8yK-L-OPOxv7+r_DC5qzqBYeB58A=oDw0xtJcNFa8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] scripts: don't throw away stderr when
 checking out git submodules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 October 2017 at 14:07, Daniel P. Berrange <berrange@redhat.com> wrote:
> The stderr from git is important if git fails to checkout modules
> due to network problems, or other unexpected errors.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  scripts/git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> index d8fbc7e47e..08932a35f0 100755
> --- a/scripts/git-submodule.sh
> +++ b/scripts/git-submodule.sh
> @@ -32,7 +32,7 @@ status)
>      exit $?
>      ;;
>  update)
> -    git submodule update --init $modules 1>/dev/null 2>&1
> +    git submodule update --init $modules 1>/dev/null
>      git submodule status $modules > "${substat}"
>      ;;

Is there a reason why we say "1>/dev/null" rather than just ">/dev/null" ?

thanks
-- PMM

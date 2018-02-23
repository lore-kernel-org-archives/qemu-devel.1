Received: from eggs.gnu.org ([2001:4830:134:3::10]:58345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epEXv-0005m8-Dq
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epEXu-0004rl-Ao
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:41:59 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:43655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epEXu-0004oL-3u
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:41:58 -0500
Received: by mail-pg0-x242.google.com with SMTP id f6so3424280pgs.10
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 06:41:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180216164620.GA53727@humpty.home.comstyle.com>
References: <20180216164620.GA53727@humpty.home.comstyle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 14:41:36 +0000
Message-ID: <CAFEAcA_03rUi-kv2od0n8h1qqNw_J4dcYhW3dmXpq=myMg7XCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] maintainers: Add myself as a OpenBSD
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 February 2018 at 16:46, Brad Smith <brad@comstyle.com> wrote:
> Add myself as an OpenBSD maintainer and add OpenBSD as maintained.
>
> Signed-off-by: Brad Smith <brad@comstyle.com>
>
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57358a08e2..86329e274f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -386,6 +386,12 @@ M: Kamil Rytarowski <kamil@netbsd.org>
>  S: Maintained
>  K: ^Subject:.*(?i)NetBSD
>
> +OPENBSD
> +L: qemu-devel@nongnu.org
> +M: Brad Smith <brad@comstyle.com>
> +S: Maintained
> +K: ^Subject:.*(?i)OpenBSD
> +
>  W32, W64
>  L: qemu-devel@nongnu.org
>  M: Stefan Weil <sw@weilnetz.de>
> diff --git a/configure b/configure
> index 913e14839d..850c46ebac 100755
> --- a/configure
> +++ b/configure
> @@ -760,6 +760,7 @@ OpenBSD)
>    audio_drv_list="sdl"
>    audio_possible_drivers="sdl"
>    HOST_VARIANT_DIR="openbsd"
> +  supported_os="yes"
>  ;;
>  Darwin)
>    bsd="yes"

Thanks for agreeing to help us with the BSD host maintenance.
I've applied this patch to master. If you and Kamil want to
maintain a subtree for doing pull requests for BSD host
patches that's fine with me; otherwise we can continue to
ad-hoc apply patches through whatever route is simplest.

thanks
-- PMM

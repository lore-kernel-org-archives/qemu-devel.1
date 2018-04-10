Received: from eggs.gnu.org ([2001:4830:134:3::10]:49930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5nkU-0000E1-RA
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5nkT-0003vb-Lq
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:31:26 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:40286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5nkT-0003vL-GH
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:31:25 -0400
Received: by mail-ot0-x244.google.com with SMTP id j8-v6so11658071ota.7
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 00:31:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180410005724.10059-1-mdroth@linux.vnet.ibm.com>
References: <20180410005724.10059-1-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 08:31:04 +0100
Message-ID: <CAFEAcA-_CW1w+XXAxWo93t8L+5zAcBRM6v7wF9xw1_EBd5FibA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12] make-release: add skiboot
 .version file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, qemu-stable <qemu-stable@nongnu.org>

On 10 April 2018 at 01:57, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> This is needed to build skiboot from tarball-distributed sources
> since the git data the make_release.sh script relies on to generate
> it is not available.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  scripts/make-release | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/make-release b/scripts/make-release
> index 04fa9defdc..c14f75b12c 100755
> --- a/scripts/make-release
> +++ b/scripts/make-release
> @@ -19,6 +19,7 @@ pushd ${destination}
>  git checkout "v${version}"
>  git submodule update --init
>  (cd roms/seabios && git describe --tags --long --dirty > .version)
> +(cd roms/skiboot && ./make_version.sh > .version)
>  # FIXME: The following line is a workaround for avoiding filename collisions
>  # when unpacking u-boot sources on case-insensitive filesystems. Once we
>  # update to something with u-boot commit 610eec7f0 we can drop this line.

Seeing this comment in the context part of this patch reminds me:
have we updated to a u-boot that lets us drop the workaround yet?

thanks
-- PMM

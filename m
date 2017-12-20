Received: from eggs.gnu.org ([2001:4830:134:3::10]:55697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRfmA-0006jp-NZ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:55:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRfm7-0002Ec-0m
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:55:18 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:59491)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eRfm6-0002D1-OQ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:55:14 -0500
References: <20171219201613.7399-1-michael.weiser@gmx.de>
	<20171219201613.7399-5-michael.weiser@gmx.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <898e3dec-fa7d-1aed-e9d4-4c2557e0f45d@vivier.eu>
Date: Wed, 20 Dec 2017 15:55:03 +0100
MIME-Version: 1.0
In-Reply-To: <20171219201613.7399-5-michael.weiser@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] configure: Add
 aarch64_be-linux-user target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Weiser <michael.weiser@gmx.de>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 19/12/2017 à 21:16, Michael Weiser a écrit :
> Add target aarch64_be-linux-user. This allows a qemu-aarch64_be binary
> to be built that will run big-endian aarch64 binaries.
> 
> Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
> ---
>  configure                                 | 9 +++++----
>  default-configs/aarch64_be-linux-user.mak | 1 +
>  2 files changed, 6 insertions(+), 4 deletions(-)
>  create mode 100644 default-configs/aarch64_be-linux-user.mak
> 
> diff --git a/configure b/configure
> index 9c8aa5a98b..03d95340d8 100755
> --- a/configure
> +++ b/configure
> @@ -657,7 +657,7 @@ case "$cpu" in
>      cpu="arm"
>      supported_cpu="yes"
>    ;;
> -  aarch64)
> +  aarch64|aarch64_be)
>      cpu="aarch64"
>      supported_cpu="yes"

This switch is for host CPU. Do you want to add aarch64_be as a
supported host architecture?

>    ;;
> @@ -6345,7 +6345,7 @@ if test "$linux" = "yes" ; then
>    s390x)
>      linux_arch=s390
>      ;;
> -  aarch64)
> +  aarch64|aarch64_be)
>      linux_arch=arm64

This is also for the host.

Thanks,
Laurent

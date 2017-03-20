Received: from eggs.gnu.org ([2001:4830:134:3::10]:39238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpzTI-0001In-7A
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpzTH-0001cH-CJ
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:43:48 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpzTH-0001c4-4j
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:43:47 -0400
Received: by mail-wr0-x22c.google.com with SMTP id l37so95267097wrc.1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 08:43:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490000743-3615-1-git-send-email-kraxel@redhat.com>
References: <1490000743-3615-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 15:43:25 +0000
Message-ID: <CAFEAcA_Rg_0WePeSg2COsmnDsGQbeWjFjNjvB+HjtLRzeouSGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] audio: catch missing sdl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 March 2017 at 09:05, Gerd Hoffmann <kraxel@redhat.com> wrote:
> sdl is probed before audio, so we can simply look at $sdl so see
> whenever we have support or not.  Throw an error in case sdl audio
> is requested without sdl being available.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  configure | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/configure b/configure
> index 99d8bec..2d088c6 100755
> --- a/configure
> +++ b/configure
> @@ -2894,6 +2894,12 @@ for drv in $audio_drv_list; do
>      audio_pt_int="yes"
>      ;;
>
> +    sdl)
> +    if test "$sdl" = "no"; then
> +        error_exit "sdl not found or disabled, can not use sdl audio driver"
> +    fi
> +    ;;
> +
>      coreaudio)
>        libs_softmmu="-framework CoreAudio $libs_softmmu"
>      ;;
> @@ -2907,8 +2913,8 @@ for drv in $audio_drv_list; do
>        libs_softmmu="$oss_lib $libs_softmmu"
>      ;;
>
> -    sdl|wav)
> -    # XXX: Probes for CoreAudio, DirectSound, SDL(?)
> +    wav)
> +    # XXX: Probes for CoreAudio, DirectSound
>      ;;
>
>      *)
> --
> 1.8.3.1

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Peter Maydell <peter.maydell@linaro.org>

I'll apply this to master as a buildfix in a bit.

thanks
-- PMM

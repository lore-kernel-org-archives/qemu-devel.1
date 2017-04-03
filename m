Received: from eggs.gnu.org ([2001:4830:134:3::10]:47428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cv5HT-0001UK-Gg
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cv5HQ-0000NH-AY
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:56:39 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:55652
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1cv5HQ-0000Mg-2m
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:56:36 -0400
References: <1491224655-5776-1-git-send-email-peter.maydell@linaro.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <9ea84295-10bb-81f6-4062-7b129e92866e@weilnetz.de>
Date: Mon, 3 Apr 2017 18:56:31 +0200
MIME-Version: 1.0
In-Reply-To: <1491224655-5776-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9] configure: on Windows minimum glib
 version must be 2.30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Am 03.04.2017 um 15:04 schrieb Peter Maydell:
> In the 2.7 release we stated in the ChangeLog that the
> minimum glib version for Windows hosts was 2.30, but we
> didn't update configure to enforce this because we were
> very close to the release at the point where we noticed
> the issue, and it only affected building the test suite.
> We then forgot that we needed to do it. Fix the omission.
>
> (The reason for the 2.30 requirement is use of
> g_dir_make_tmp() -- our fallback implementation uses
> mkdtemp(), which isn't available on Windows.)
>
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  configure | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 4b3b5cd..be4d326 100755
> --- a/configure
> +++ b/configure
> @@ -3073,7 +3073,11 @@ fi
>  ##########################################
>  # glib support probe
>
> -glib_req_ver=2.22
> +if test "$mingw32" = yes; then
> +    glib_req_ver=2.30
> +else
> +    glib_req_ver=2.22
> +fi
>  glib_modules=gthread-2.0
>  if test "$modules" = yes; then
>      glib_modules="$glib_modules gmodule-2.0"


Reviewed-by: Stefan Weil <sw@weilnetz.de>

Thanks
Stefan

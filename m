Received: from eggs.gnu.org ([2001:4830:134:3::10]:46016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxZva-0004v3-TW
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 10:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxZvZ-0005Hh-Kx
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 10:04:22 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxZvZ-0005HO-EI
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 10:04:21 -0400
Received: by mail-wm0-x236.google.com with SMTP id w64so39933784wma.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 07:04:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1491224655-5776-1-git-send-email-peter.maydell@linaro.org>
References: <1491224655-5776-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 15:03:59 +0100
Message-ID: <CAFEAcA-AZPYgnQUwmA5rd6sOAm+u_5Mcz3Z=+WTz4YjG2WPj8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Weil <sw@weilnetz.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "patches@linaro.org" <patches@linaro.org>

On 3 April 2017 at 14:04, Peter Maydell <peter.maydell@linaro.org> wrote:
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
> --
> 2.7.4

Applied to master, thanks.

-- PMM

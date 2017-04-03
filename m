Received: from eggs.gnu.org ([2001:4830:134:3::10]:42269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv2O3-00054C-O8
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv2O0-0007jV-Ha
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:51:15 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv2O0-0007jJ-DB
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:51:12 -0400
Received: by mail-qk0-x242.google.com with SMTP id 10so19402217qkh.1
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 06:51:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1491224655-5776-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b1f1b4e4-654a-46cf-423a-72feacaa5a0e@amsat.org>
Date: Mon, 3 Apr 2017 10:51:07 -0300
MIME-Version: 1.0
In-Reply-To: <1491224655-5776-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Stefan Weil <sw@weilnetz.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, patches@linaro.org

On 04/03/2017 10:04 AM, Peter Maydell wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
>

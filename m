Received: from eggs.gnu.org ([209.51.188.92]:34474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0lSR-0000NY-Ap
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 06:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0lSQ-0008Vb-B8
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 06:08:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0lSP-0008RU-AJ
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 06:08:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so5061864wrw.0
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 03:08:26 -0800 (PST)
References: <1551695576-13205-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a0b53ff0-1ded-2a6e-aa4d-b1f4fcc407c1@redhat.com>
Date: Mon, 4 Mar 2019 12:08:22 +0100
MIME-Version: 1.0
In-Reply-To: <1551695576-13205-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] cirrus.yml: Add macOS continuous
 integration task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 3/4/19 11:32 AM, Thomas Huth wrote:
> cirrus-ci.com also has the possibility to run CI tasks on macOS.
> Since most of the QEMU developers do not have access to macOS yet,
> let's add a CI pipeline for this operating system here, too.

Can we get report of failures? (IRC, mail to ML, patchew icon)

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  You can see an example here: https://cirrus-ci.com/task/5099494325616640
> 
>  .cirrus.yml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 303fe72..e3d375b 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -14,3 +14,15 @@ freebsd_12_task:
>      - ../configure || { cat config.log; exit 1; }
>      - gmake -j8
>      - gmake -j8 V=1 check
> +
> +macos_task:
> +  osx_instance:
> +    image: high-sierra-base
> +  env:
> +    CIRRUS_CLONE_DEPTH: 1
> +  install_script:
> +    - brew install pkg-config glib pixman make sdl2
> +  script:
> +    - ./configure || { cat config.log; exit 1; }
> +    - gmake -j$(sysctl -n hw.ncpu)
> +    - gmake check -j$(sysctl -n hw.ncpu)
> 

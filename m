Received: from eggs.gnu.org ([209.51.188.92]:37966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghedl-0001Gz-0E
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghedj-0005Ds-Pm
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:01:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ghedj-0005DX-Ju
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:01:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so12415651wra.6
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 10:01:11 -0800 (PST)
References: <20190110174516.21586-1-alex.bennee@linaro.org>
	<20190110174516.21586-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <83d53502-3387-18ed-ac94-5a255c2d70c4@redhat.com>
Date: Thu, 10 Jan 2019 19:01:09 +0100
MIME-Version: 1.0
In-Reply-To: <20190110174516.21586-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 01/19] docker: Use stable git tag for
 virglrenderer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: ymankad@redhat.com, Fam Zheng <fam@euphon.net>

On 1/10/19 6:44 PM, Alex Bennée wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Use a stable tag instead of some random commit from mainstream
> development, to avoid unexpected build failures.
> 
> This fixes:
> 
>     CC       virglrenderer.lo
>   virglrenderer.c: In function 'virgl_has_gl_colorspace':
>   virglrenderer.c:208:11: error: implicit declaration of function 'virgl_has_egl_khr_gl_colorspace' [-Werror=implicit-function-declaration]
>              virgl_has_egl_khr_gl_colorspace(egl_info));
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   virglrenderer.c:208:43: error: 'egl_info' undeclared (first use in this function)
>              virgl_has_egl_khr_gl_colorspace(egl_info));
>                                              ^~~~~~~~
>   virglrenderer.c:208:43: note: each undeclared identifier is reported only once for each function it appears in
>   cc1: some warnings being treated as errors
> 
> As of this commit 'git virglrenderer-0.7.0' is the last stable tag.
> (virglrenderer commit breaking: fb4f7577f7ef)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/debian-amd64.docker | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
> index 24b113b76f..47a30adbdb 100644
> --- a/tests/docker/dockerfiles/debian-amd64.docker
> +++ b/tests/docker/dockerfiles/debian-amd64.docker
> @@ -24,7 +24,8 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>          libegl1-mesa-dev \
>          libepoxy-dev \
>          libgbm-dev
> -RUN git clone https://anongit.freedesktop.org/git/virglrenderer.git /usr/src/virglrenderer
> +RUN git clone https://anongit.freedesktop.org/git/virglrenderer.git /usr/src/virglrenderer && \
> +    cd /usr/src/virglrenderer && git checkout virglrenderer-0.7.0
>  RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx --disable-tests && make install
>  
>  # netmap
> 

I will prepare another patches for netmap and tricore-binutils.

Received: from eggs.gnu.org ([209.51.188.92]:36177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gheXU-0004AC-Qn
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gheXS-0000q9-Pt
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:54:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gheXS-0000dY-HU
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:54:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so12401308wrw.5
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:54:27 -0800 (PST)
References: <20190110174516.21586-1-alex.bennee@linaro.org>
	<20190110174516.21586-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4e3923c6-ab62-3e78-eb96-5e68544fa7ca@redhat.com>
Date: Thu, 10 Jan 2019 18:54:24 +0100
MIME-Version: 1.0
In-Reply-To: <20190110174516.21586-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 05/19] tests: update Fedora i386 cross
 image to Fedora 29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: ymankad@redhat.com, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Fam Zheng <fam@euphon.net>

On 1/10/19 6:45 PM, Alex Bennée wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> Using the "latest" tag is not a good idea because this changes what
> release it points to every 6 months. Together with caching of docker
> builds this can cause confusion where CI has cached & built with Fedora
> N, while a developer tries to reproduce a CI problem with Fedora N + 1,
> or vica-verca.

So we now learned the hard way commiting "FROM x:latest" to a repository
is a bad practice.

> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/fedora-i386-cross.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/docker/dockerfiles/fedora-i386-cross.docker
> index a4fd895b07..eb8108d118 100644
> --- a/tests/docker/dockerfiles/fedora-i386-cross.docker
> +++ b/tests/docker/dockerfiles/fedora-i386-cross.docker
> @@ -1,4 +1,4 @@
> -FROM fedora:latest

If checkpatch wasn't in Perl I'd have added a check to ban :latest.

> +FROM fedora:29
>  ENV PACKAGES \
>      gcc \
>      glib2-devel.i686 \
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Received: from eggs.gnu.org ([209.51.188.92]:33494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDvpo-0005WE-HM
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDvpn-000680-LI
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:51:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDvpl-00066a-L3
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:51:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so3024848wmi.0
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 11:51:01 -0700 (PDT)
References: <20190409154435.28807-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4c8c671d-88f1-7247-9371-c5d16d93d387@redhat.com>
Date: Tue, 9 Apr 2019 20:50:58 +0200
MIME-Version: 1.0
In-Reply-To: <20190409154435.28807-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] docs: replace min-glib with fedora
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 4/9/19 5:44 PM, Marc-André Lureau wrote:
> min-glib.docker was removed in commit
> e7b3af81597db1a6b55f2c15d030d703c6b2c6ac ("glib: bump min required
> glib library version to 2.40").
> 
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  docs/devel/testing.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 60f897d915..cec7d56c57 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -317,17 +317,17 @@ the container, with parameters defined by the make target):
>  
>  .. code::
>  
> -  make docker-test-build@min-glib
> +  make docker-test-build@fedora
>  
> -This will create a container instance using the ``min-glib`` image (the image
> +This will create a container instance using the ``fedora`` image (the image
>  is downloaded and initialized automatically), in which the ``test-build`` job
>  is executed.
>  
>  Images
>  ------
>  
> -Along with many other images, the ``min-glib`` image is defined in a Dockerfile
> -in ``tests/docker/dockefiles/``, called ``min-glib.docker``. ``make docker``
> +Along with many other images, the ``fedora`` image is defined in a Dockerfile
> +in ``tests/docker/dockefiles/``, called ``fedora.docker``. ``make docker``
>  command will list all the available images.
>  
>  To add a new image, simply create a new ``.docker`` file under the
> 

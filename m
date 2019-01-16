Received: from eggs.gnu.org ([209.51.188.92]:36910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjf6l-000891-9G
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:55:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjf6h-0004UM-PI
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:55:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjf6f-0004Sz-TM
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:55:22 -0500
References: <20190115184229.73688-1-emaste@freefall.freebsd.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6de77c0f-6ffa-51dc-1cb5-d8152c65b9ad@redhat.com>
Date: Wed, 16 Jan 2019 07:55:14 +0100
MIME-Version: 1.0
In-Reply-To: <20190115184229.73688-1-emaste@freefall.freebsd.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Maste <emaste@freefall.freebsd.org>, qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 2019-01-15 19:42, Ed Maste wrote:
> From: Ed Maste <emaste@freebsd.org>
> 
> Cirrus-CI (https://cirrus-ci.org) is a hosted CI service which supports
> several platforms, including FreeBSD.  Later on we could build for other
> hosts in Cirrus-CI, but I'm starting with only FreeBSD as it is not
> supported by other CI services.
> 
> Signed-off-by: Ed Maste <emaste@freebsd.org>
> ---
>  .cirrus.yml     | 16 ++++++++++++++++
>  create mode 100644 .cirrus.yml
> 
> diff --git a/.cirrus.yml b/.cirrus.yml
> new file mode 100644
> index 0000000000..ff4bf75ad1
> --- /dev/null
> +++ b/.cirrus.yml
> @@ -0,0 +1,16 @@
> +freebsd_12_task:
> +  freebsd_instance:
> +    image: freebsd-12-0-release-amd64
> +    cpu: 8
> +    memory: 24G
> +  env:
> +    CIRRUS_CLONE_DEPTH: 1
> +  install_script: pkg install -y
> +    bison curl cyrus-sasl fontconfig freetype2 git glib gmake gnutls
> +    nettle perl5 pixman pkgconf png usbredir

Why freetype2 and fontconfig? QEMU does not use freetype, as far as I
know...

Maybe rather add SDL2 or gtk3 if available?

> +  script:
> +    - mkdir build
> +    - cd build
> +    - ../configure || { cat config.log; exit 1; }
> +    - gmake -j8
> +    - gmake -j8 check

I think it would also be good to have an entry in the MAINTAINERS file
for this new yml file - either in the section where we already have
.travis.yml or in a new subsection under "Build and test automation"?

 Thomas

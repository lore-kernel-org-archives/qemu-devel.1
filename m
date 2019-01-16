Received: from eggs.gnu.org ([209.51.188.92]:59066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjkHf-0000sj-Pj
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:27:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjkHe-0001kB-Pf
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:27:03 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gjkHe-0001ch-Dg
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:27:02 -0500
Received: by mail-wr1-x434.google.com with SMTP id s12so6718114wrt.4
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 04:27:00 -0800 (PST)
References: <20190115184229.73688-1-emaste@freefall.freebsd.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190115184229.73688-1-emaste@freefall.freebsd.org>
Date: Wed, 16 Jan 2019 12:26:58 +0000
Message-ID: <87d0owzt2l.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>


Ed Maste <emaste@freefall.freebsd.org> writes:

> From: Ed Maste <emaste@freebsd.org>
>
> Cirrus-CI (https://cirrus-ci.org) is a hosted CI service which supports
> several platforms, including FreeBSD.  Later on we could build for other
> hosts in Cirrus-CI, but I'm starting with only FreeBSD as it is not
> supported by other CI services.

Do you know if there is anyway to eyeball the state of the tree? So far
I can watch the build run at:

  https://cirrus-ci.com/github/stsquad/qemu

but unlike Travis and Shippable there doesn't seem to be a badge I could
transclude into the wiki page:

  https://wiki.qemu.org/Template:CIStatus

which means no one will know if the build fails. Travis also makes some
noise on the IRC channel although given it's stability it's debatable
how much longer we shall do that.

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
> +  script:
> +    - mkdir build
> +    - cd build
> +    - ../configure || { cat config.log; exit 1; }
> +    - gmake -j8
> +    - gmake -j8 check


--
Alex Benn=C3=A9e

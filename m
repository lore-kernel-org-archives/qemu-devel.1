Received: from eggs.gnu.org ([209.51.188.92]:34939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmH2o-0007rz-KO
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmH2k-0006fb-TL
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:50:10 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gmH2h-0006cB-Hd
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:50:03 -0500
Received: by mail-wr1-x441.google.com with SMTP id s12so2082130wrt.4
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 03:50:02 -0800 (PST)
References: <20190122172558.15096-1-emaste@freebsd.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190122172558.15096-1-emaste@freebsd.org>
Date: Wed, 23 Jan 2019 11:50:00 +0000
Message-ID: <871s531tlj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] .cirrus.yml: basic compile and test for
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


emaste@freebsd.org writes:

> From: Ed Maste <emaste@freebsd.org>
>
> Signed-off-by: Ed Maste <emaste@freebsd.org>

Queued to testing/next, thanks.

> ---
> Changes since v3:
> - 8G instead of 24G
> - remove V=3D1 from build (but leave on "gmake check")
>
>  .cirrus.yml | 16 ++++++++++++++++
>  MAINTAINERS |  8 ++++++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 .cirrus.yml
>
> diff --git a/.cirrus.yml b/.cirrus.yml
> new file mode 100644
> index 0000000000..303fe720d6
> --- /dev/null
> +++ b/.cirrus.yml
> @@ -0,0 +1,16 @@
> +freebsd_12_task:
> +  freebsd_instance:
> +    image: freebsd-12-0-release-amd64
> +    cpu: 8
> +    memory: 8G
> +  env:
> +    CIRRUS_CLONE_DEPTH: 1
> +  install_script: pkg install -y
> +    bison curl cyrus-sasl git glib gmake gnutls
> +    nettle perl5 pixman pkgconf png usbredir
> +  script:
> +    - mkdir build
> +    - cd build
> +    - ../configure || { cat config.log; exit 1; }
> +    - gmake -j8
> +    - gmake -j8 V=3D1 check
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af339b86db..f9da8c9cf0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2483,6 +2483,14 @@ W: https://travis-ci.org/qemu/qemu
>  W: https://app.shippable.com/github/qemu/qemu
>  W: http://patchew.org/QEMU/
>
> +FreeBSD Hosted Continuous Integration
> +M: Ed Maste <emaste@freebsd.org>
> +M: Li-Wen Hsu <lwhsu@freebsd.org>
> +L: qemu-devel@nongnu.org
> +S: Maintained
> +F: .cirrus.yml
> +W: https://cirrus-ci.com/github/qemu/qemu
> +
>  Guest Test Compilation Support
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>  R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


--
Alex Benn=C3=A9e

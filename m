Received: from eggs.gnu.org ([209.51.188.92]:52354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gjTvi-000787-7d
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gjTvh-0007ng-0Y
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:59:18 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:34832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gjTvg-0007lb-MS
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:59:16 -0500
Received: by mail-wr1-x42b.google.com with SMTP id 96so4236530wrb.2
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 10:59:12 -0800 (PST)
MIME-Version: 1.0
References: <20190115184229.73688-1-emaste@freefall.freebsd.org>
In-Reply-To: <20190115184229.73688-1-emaste@freefall.freebsd.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 15 Jan 2019 22:58:59 +0400
Message-ID: <CAJ+F1CKEhb0hKSvbwYfjEojqJ9K8Jbtit5oW8CTBmcSHSjVrNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Ed Maste <emaste@freefall.freebsd.org>
Cc: QEMU <qemu-devel@nongnu.org>, Ed Maste <emaste@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Tue, Jan 15, 2019 at 10:42 PM Ed Maste <emaste@freefall.freebsd.org> wro=
te:
>
> From: Ed Maste <emaste@freebsd.org>
>
> Cirrus-CI (https://cirrus-ci.org) is a hosted CI service which supports
> several platforms, including FreeBSD.  Later on we could build for other
> hosts in Cirrus-CI, but I'm starting with only FreeBSD as it is not
> supported by other CI services.

Although I have never tested it, gitlab CI supports FreeBSD, macosx, window=
s...

What about patchew?

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
> --
> 2.20.1
>


--=20
Marc-Andr=C3=A9 Lureau

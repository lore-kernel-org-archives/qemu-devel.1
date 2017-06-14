Received: from eggs.gnu.org ([2001:4830:134:3::10]:54106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dL9XK-000594-EK
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dL9XF-0008E3-K3
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:44:46 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dL9XF-0008Dd-CK
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:44:41 -0400
Received: by mail-wr0-x232.google.com with SMTP id r103so1475230wrb.0
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 07:44:39 -0700 (PDT)
References: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
	<1497369290-20401-2-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1497369290-20401-2-git-send-email-peter.maydell@linaro.org>
Date: Wed, 14 Jun 2017 15:45:12 +0100
Message-ID: <877f0eocg7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] travis: install more library
 dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> Update the travis list of library packages to install so that
> our build tests cover more of our code base.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  .travis.yml | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index 27a2d9c..26dabb6 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -11,28 +11,37 @@ addons:
>        # Build dependencies
>        - libaio-dev
>        - libattr1-dev
> +      - libbluetooth-dev
>        - libbrlapi-dev
> +      - libcap-dev
>        - libcap-ng-dev
>        - libgnutls-dev
>        - libgtk-3-dev
>        - libiscsi-dev
>        - liblttng-ust-dev
> +      - liblzo2-dev
>        - libnfs-dev
>        - libncurses5-dev
>        - libnss3-dev
>        - libpixman-1-dev
>        - libpng12-dev
>        - librados-dev
> +      - librdmacm-dev
>        - libsdl1.2-dev
>        - libseccomp-dev
> +      - libsnappy-dev
>        - libspice-protocol-dev
>        - libspice-server-dev
>        - libssh2-1-dev
>        - liburcu-dev
>        - libusb-1.0-0-dev
> +      - libvde-dev
>        - libvte-2.90-dev
> +      - libxen-dev
> +      - nettle-dev
>        - sparse
>        - uuid-dev
> +      - xfslibs-dev
>
>  # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
>  # to prevent IRC notifications from forks. This was created using:
> @@ -162,28 +171,37 @@ matrix:
>              # Build dependencies
>              - libaio-dev
>              - libattr1-dev
> +            - libbluetooth-dev
>              - libbrlapi-dev
> +            - libcap-dev
>              - libcap-ng-dev
>              - libgnutls-dev
>              - libgtk-3-dev
>              - libiscsi-dev
>              - liblttng-ust-dev
> +            - liblzo2-dev
>              - libnfs-dev
>              - libncurses5-dev
>              - libnss3-dev
>              - libpixman-1-dev
>              - libpng12-dev
>              - librados-dev
> +            - librdmacm-dev
>              - libsdl1.2-dev
>              - libseccomp-dev
> +            - libsnappy-dev
>              - libspice-protocol-dev
>              - libspice-server-dev
>              - libssh2-1-dev
>              - liburcu-dev
>              - libusb-1.0-0-dev
> +            - libvde-dev
>              - libvte-2.90-dev
> +            - libxen-dev
> +            - nettle-dev
>              - sparse
>              - uuid-dev
> +            - xfslibs-dev
>        language: generic
>        compiler: none
>        env:


--
Alex Bennée

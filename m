Received: from eggs.gnu.org ([2001:4830:134:3::10]:60823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dKzMh-0003Rb-Id
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 23:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dKzMc-0007nv-Uo
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 23:53:07 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dKzMc-0007n2-QT
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 23:53:02 -0400
Received: by mail-qk0-x242.google.com with SMTP id r62so6312122qkf.3
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 20:53:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
	<1497369290-20401-2-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f279fd6d-d32f-79e8-66e3-62edc0e425a8@amsat.org>
Date: Wed, 14 Jun 2017 00:52:57 -0300
MIME-Version: 1.0
In-Reply-To: <1497369290-20401-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, patches@linaro.org

As you said, due to Travis using Ubuntu still not all libs get detected 
but at least the following:

  $ ./configure ${CONFIG}
-VirtFS support    no
+VirtFS support    yes
-bluez  support    no
+bluez  support    yes
-xfsctl support    no
+xfsctl support    yes
-lzo support       no
+lzo support       yes
-snappy support    no
+snappy support    yes

Using debian based docker images on Shippable we also get:

-nettle            no
-nettle kdf        no
+nettle            yes (3.3)
+nettle kdf        yes
-rbd support       no
+rbd support       yes
-vde support       no
+vde support       yes
-GlusterFS support no
+GlusterFS support yes
-libnfs support    no
+libnfs support    yes

On 06/13/2017 12:54 PM, Peter Maydell wrote:
> Update the travis list of library packages to install so that
> our build tests cover more of our code base.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
>

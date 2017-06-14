Received: from eggs.gnu.org ([2001:4830:134:3::10]:36298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dLA1W-0005Gb-1y
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dLA1S-0005a3-R9
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:15:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dLA1S-0005Zl-HX
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:15:54 -0400
Date: Wed, 14 Jun 2017 16:15:48 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170614151548.GM4370@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
	<1497369290-20401-2-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1497369290-20401-2-git-send-email-peter.maydell@linaro.org>
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, patches@linaro.org

On Tue, Jun 13, 2017 at 04:54:48PM +0100, Peter Maydell wrote:
> Update the travis list of library packages to install so that
> our build tests cover more of our code base.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I'm seeing the OS-X and GProf/GCov enable build entries fail with
timeouts a reasonable amount of time, so turning on more features
will make timeouts hit even more frequently. This patch would at
least impact the GProf/GCov matrix entry in this respect. Is there
anything we can do to mitigate this problem ?

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
> -- 
> 2.7.4
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

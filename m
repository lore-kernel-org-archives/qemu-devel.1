Received: from eggs.gnu.org ([2001:4830:134:3::10]:54622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elNwS-00065U-Nv
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 18:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elNwP-0004lV-Fl
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 18:55:24 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:42309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elNwP-0004kr-7q
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 18:55:21 -0500
Received: by mail-wr0-x243.google.com with SMTP id k9so3138679wre.9
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 15:55:20 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180212184650.24039-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <17755a1e-cc51-5ba6-861b-c0c268c5529c@redhat.com>
Date: Tue, 13 Feb 2018 00:55:16 +0100
MIME-Version: 1.0
In-Reply-To: <20180212184650.24039-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] travis: use libgcc-4.8-dev (libgcc-6-dev
 is not available on Ubuntu 14.04)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

On 12/02/2018 19:46, Philippe Mathieu-Daudé wrote:
> Travis image is based on Ubuntu Trusty (14.04), since d83414e1fd1 we get:
> 
>   $ sudo -E \
>     apt-get -yq --no-install-suggests --no-install-recommends --force-yes \
>       install \
>         libaio-dev libattr1-dev libbrlapi-dev libcap-ng-dev libgcc-6-dev \
>         libgnutls-dev libgtk-3-dev libiscsi-dev liblttng-ust-dev \
>         libncurses5-dev libnfs-dev libnss3-dev libpixman-1-dev libpng12-dev \
>         librados-dev libsdl1.2-dev libseccomp-dev libspice-protocol-dev \
>         libspice-server-dev libssh2-1-dev liburcu-dev libusb-1.0-0-dev \
>         libvte-2.90-dev sparse uuid-dev
>   Reading package lists...
>   Building dependency tree...
>   Reading state information...
>   E: Unable to locate package libgcc-6-dev
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Since libgcc-dev is used, Travis jobs take much longer.
> 
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 0dd5020552..79377c8de0 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -13,7 +13,7 @@ addons:
>        - libattr1-dev
>        - libbrlapi-dev
>        - libcap-ng-dev
> -      - libgcc-6-dev
> +      - libgcc-4.8-dev
>        - libgnutls-dev
>        - libgtk-3-dev
>        - libiscsi-dev
> 

I can queue this immediately, if that's useful to get it in sooner.

Paolo

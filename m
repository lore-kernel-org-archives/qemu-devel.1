Received: from eggs.gnu.org ([2001:4830:134:3::10]:40580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBLqm-0008JT-G7
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBLqh-0000sF-Ps
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:56:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57376 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBLqh-0000rk-L1
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:56:47 -0400
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-9-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f7a042d7-0a0c-1a83-68a2-885ade3588c1@redhat.com>
Date: Wed, 25 Apr 2018 16:56:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/13] Remove checks on MAX_SERIAL_PORTS
 that are just bounds checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, patches@linaro.org

On 20.04.2018 16:52, Peter Maydell wrote:
> Remove checks on MAX_SERIAL_PORTS that were just checking whether
> they were within bounds for the serial_hds[] array and falling
> back to NULL if not. This isn't needed with the serial_hd()
> function, which returns NULL for all indexes beyond what the
> user set up.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/fsl-imx25.c     | 4 +---
>  hw/arm/fsl-imx31.c     | 4 +---
>  hw/arm/fsl-imx6.c      | 4 +---
>  hw/arm/fsl-imx7.c      | 4 +---
>  hw/arm/mps2-tz.c       | 3 +--
>  hw/arm/mps2.c          | 6 ++----
>  hw/arm/stm32f205_soc.c | 3 +--
>  7 files changed, 8 insertions(+), 20 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHs4K-000550-WB
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 07:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHs4J-00044l-Vz
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 07:57:01 -0500
Received: from mail-vk0-x231.google.com ([2607:f8b0:400c:c05::231]:33559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHs4J-00043j-Hw
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 07:56:59 -0500
Received: by mail-vk0-x231.google.com with SMTP id 137so88414764vkl.0
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 04:56:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161215054812.12602-6-alastair@au1.ibm.com>
References: <20161215054812.12602-1-alastair@au1.ibm.com>
	<20161215054812.12602-6-alastair@au1.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 12:56:38 +0000
Message-ID: <CAFEAcA94pqzDmwhJqOehAd7biugqSQH8JWytJGFFus0F92YCAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v4 5/8] hw/i2c: Tidy up NULL check for i2c
 slave init callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alastair D'Silva <alastair@au1.ibm.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, Alastair D'Silva <alastair@d-silva.org>

On 15 December 2016 at 05:48, Alastair D'Silva <alastair@au1.ibm.com> wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
>
> Remove unnecessary syntax
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  hw/i2c/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index ae3ca94..e40781e 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -262,9 +262,9 @@ static int i2c_slave_qdev_init(DeviceState *dev)
>
>      if (sc->init) {
>          return sc->init(s);
> -    } else {
> -        return 0;
>      }
> +
> +    return 0;
>  }
>
>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)

I'll just squash this change into the 'hw/i2c: Add a NULL check for i2c
slave init callbacks' patch since that's still only in target-arm.next.

thanks
-- PMM

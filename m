Received: from eggs.gnu.org ([2001:4830:134:3::10]:57290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fZxtO-0003la-RX
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fZxtJ-0002yQ-TG
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:25:18 -0400
Date: Mon, 2 Jul 2018 13:25:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180702122510.GB2155@stefanha-x1.localdomain>
References: <20180627143815.1829-1-joel@jms.id.au>
	<20180627143815.1829-2-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <20180627143815.1829-2-joel@jms.id.au>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] arm: Add Nordic Semiconductor nRF51
 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Jim Mussared <jim.mussared@gmail.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 28, 2018 at 12:08:13AM +0930, Joel Stanley wrote:
> +/* TODO: Flash size should be defined by the board. Microbit uses 256KB */
> +#define FLASH_BASE      0x00000000
> +#define FLASH_SIZE      (256 * 1024)
> +
> +/* TODO: Flash size should be defined by the board. Microbit uses 16KB */
> +#define SRAM_BASE       0x20000000
> +#define SRAM_SIZE       (16 * 1024)

Making FLASH_SIZE and SRAM_SIZE properties of the NRF51State object.
Then microbit.c can set them.

> +static void nrf51_soc_init(Object *obj)
> +{
> +    NRF51State *s = NRF51_SOC(obj);
> +
> +    memory_region_init(&s->container, obj, "nrf51-container", UINT64_MAX);
> +
> +    /* TODO: implement a cortex m0 and update this */

Please see "[PATCH v2 0/3] arm: add skeleton Cortex M0 CPU model".  It
should work with TYPE_ARMV7M -> TYPE_ARMV6M and "cortex-m3" ->
"cortex-m0".

Julia is currently completing the Cortex M0 emulation but at this point
guest software may already run successfully.  If not, then the patches
she sends over the next week or two ought to do the trick.

> +typedef struct NRF51State {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    char *kernel_filename;

Is this used by anything?

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbOhmmAAoJEJykq7OBq3PIYsoIAMk7THEXPxeSMgk+Bry8E1/c
V919F6xt1URYGA0crVnZvOpI1qqLCxbCLY42mwnYzp1WWDeOclYuDhI1WpQso42e
IoSAOTb+GmeRW+nPYzoqPw6ERzFtWkVlIymSUnq2zIvdTyA+rSv5FurES4wHL5LZ
jIoDb6v5OBarT9eFumwfR4LDn/QfRfkOaPOU6b4Ah7uHnkKVhuEuPwKsC0tldyqy
manmB5l5Qh457RCVwl7r/RU19JIC2hF+n074IYGPI38Ugtry/HsL54cxzv3XWAfo
jLwTVPJDO/pp9sEfXoZWPXjHDS8og3hzvkMK3KY2C8Yc7hGONapj5QlzzhXI9GY=
=4Jmd
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--

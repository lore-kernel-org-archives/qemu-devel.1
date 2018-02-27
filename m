Received: from eggs.gnu.org ([2001:4830:134:3::10]:47691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eqnnF-0000Y1-8L
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eqnnE-0002UO-0D
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:32:17 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:40619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eqnnD-0002UB-P1
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:32:15 -0500
Received: by mail-lf0-x243.google.com with SMTP id 37so621788lfs.7
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 14:32:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170922171323.10348-3-f4bug@amsat.org>
References: <20170922171323.10348-1-f4bug@amsat.org>
	<20170922171323.10348-3-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Feb 2018 14:31:43 -0800
Message-ID: <CAKmqyKNxnfSyUzzo5=2VyvM86osApVzyRVCGpE2qhzAefZpALg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/7] hw/mdio: Add PHY register definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Grant Likely <grant.likely@arm.com>, Jason Wang <jasowang@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, Sep 22, 2017 at 10:13 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> From: Grant Likely <grant.likely@arm.com>
>
> Trivial patch to add #defines for defined PHY register address and bit fi=
elds
>
> Signed-off-by: Grant Likely <grant.likely@arm.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  include/hw/net/mdio.h | 24 ++++++++++++++++++++++--
>  hw/net/mdio.c         |  8 ++++----
>  2 files changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/net/mdio.h b/include/hw/net/mdio.h
> index ac36aed3c3..7ffa4389b9 100644
> --- a/include/hw/net/mdio.h
> +++ b/include/hw/net/mdio.h
> @@ -25,14 +25,34 @@
>   * THE SOFTWARE.
>   */
>
> -/* PHY Advertisement control register */
> +/* PHY MII Register/Bit Definitions */
> +/* PHY Registers defined by IEEE */
> +#define PHY_CTRL         0x00 /* Control Register */
> +#define PHY_STATUS       0x01 /* Status Regiser */
> +#define PHY_ID1          0x02 /* Phy Id Reg (word 1) */
> +#define PHY_ID2          0x03 /* Phy Id Reg (word 2) */
> +#define PHY_AUTONEG_ADV  0x04 /* Autoneg Advertisement */
> +#define PHY_LP_ABILITY   0x05 /* Link Partner Ability (Base Page) */
> +#define PHY_AUTONEG_EXP  0x06 /* Autoneg Expansion Reg */
> +#define PHY_NEXT_PAGE_TX 0x07 /* Next Page TX */
> +#define PHY_LP_NEXT_PAGE 0x08 /* Link Partner Next Page */
> +#define PHY_1000T_CTRL   0x09 /* 1000Base-T Control Reg */
> +#define PHY_1000T_STATUS 0x0A /* 1000Base-T Status Reg */
> +#define PHY_EXT_STATUS   0x0F /* Extended Status Reg */
> +
> +#define NUM_PHY_REGS     0x20  /* 5 bit address bus (0-0x1F) */
> +
> +#define PHY_CTRL_RST            0x8000 /* PHY reset command */
> +#define PHY_CTRL_ANEG_RST       0x0200 /* Autonegotiation reset command =
*/
> +
> +/* PHY Advertisement control and remote capability registers (same bitfi=
elds) */
>  #define PHY_ADVERTISE_10HALF    0x0020  /* Try for 10mbps half-duplex  *=
/
>  #define PHY_ADVERTISE_10FULL    0x0040  /* Try for 10mbps full-duplex  *=
/
>  #define PHY_ADVERTISE_100HALF   0x0080  /* Try for 100mbps half-duplex *=
/
>  #define PHY_ADVERTISE_100FULL   0x0100  /* Try for 100mbps full-duplex *=
/
>
>  struct qemu_phy {
> -    uint32_t regs[32];
> +    uint32_t regs[NUM_PHY_REGS];
>
>      int link;
>
> diff --git a/hw/net/mdio.c b/hw/net/mdio.c
> index 3763fcc8af..3d70d99077 100644
> --- a/hw/net/mdio.c
> +++ b/hw/net/mdio.c
> @@ -122,12 +122,12 @@ static void tdk_write(struct qemu_phy *phy, unsigne=
d int req, unsigned int data)
>
>  void tdk_init(struct qemu_phy *phy)
>  {
> -    phy->regs[0] =3D 0x3100;
> +    phy->regs[PHY_CTRL] =3D 0x3100;
>      /* PHY Id. */
> -    phy->regs[2] =3D 0x0300;
> -    phy->regs[3] =3D 0xe400;
> +    phy->regs[PHY_ID1] =3D 0x0300;
> +    phy->regs[PHY_ID2] =3D 0xe400;
>      /* Autonegotiation advertisement reg. */
> -    phy->regs[4] =3D 0x01e1;
> +    phy->regs[PHY_AUTONEG_ADV] =3D 0x01e1;
>      phy->link =3D 1;
>
>      phy->read =3D tdk_read;
> --
> 2.14.1
>
>

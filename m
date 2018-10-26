Received: from eggs.gnu.org ([2001:4830:134:3::10]:35710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFw8P-0005xq-PM
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 03:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFw8K-0004lF-EC
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 03:02:16 -0400
References: <cover.1532984236.git.jcd@tribudubois.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2cfde3e3-7c63-d96f-921b-5a49fdc91762@redhat.com>
Date: Fri, 26 Oct 2018 08:01:57 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1532984236.git.jcd@tribudubois.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] i.MX: Add the i.MX6UL SOC and a
 reference board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-devel@nongnu.org, peter.maydell@linaro.org, peter.chubb@nicta.com.au, andrew.smirnov@gmail.com, qemu-arm <qemu-arm@nongnu.org>

On 2018-07-30 22:03, Jean-Christophe Dubois wrote:
> This series adds the i.MX6UL SOC from NXP/Freescale and the reference
> evaluation board.
> 
> This series was tested by booting linux 4.18 (built using imx_v6_v7_defconfig)
> on the emulated board (with the appropriate device tree).
> 
> Jean-Christophe Dubois (3):
>   i.MX6UL: Add i.MX6UL specific CCM device
>   i.MX6UL: Add i.MX6UL SOC
>   i.MX6UL: Add Freescale i.MX6 UltraLite 14x14 EVK Board
> 
>  default-configs/arm-softmmu.mak |   1 +
>  hw/arm/Makefile.objs            |   1 +
>  hw/arm/fsl-imx6ul.c             | 617 ++++++++++++++++++++++
>  hw/arm/mcimx6ul-evk.c           |  85 +++
>  hw/misc/Makefile.objs           |   1 +
>  hw/misc/imx6ul_ccm.c            | 890 ++++++++++++++++++++++++++++++++
>  hw/misc/trace-events            |   7 +
>  include/hw/arm/fsl-imx6ul.h     | 339 ++++++++++++
>  include/hw/misc/imx6ul_ccm.h    | 226 ++++++++
>  9 files changed, 2167 insertions(+)
>  create mode 100644 hw/arm/fsl-imx6ul.c
>  create mode 100644 hw/arm/mcimx6ul-evk.c
>  create mode 100644 hw/misc/imx6ul_ccm.c
>  create mode 100644 include/hw/arm/fsl-imx6ul.h
>  create mode 100644 include/hw/misc/imx6ul_ccm.h

Can we please also get an entry to the MAINTAINERS file for this new
board / files?

 Thanks,
  Thomas

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fYHXI-00008k-M7
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fYHXF-0004ft-JP
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:59:32 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:48605)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linux@roeck-us.net>) id 1fYHXF-0004Lw-Bc
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:59:29 -0400
Date: Wed, 27 Jun 2018 13:59:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180627205915.GA22693@roeck-us.net>
References: <20180627185248.GA19743@roeck-us.net>
	<96809884-2f46-ed63-48fd-9fd4c5050e20@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96809884-2f46-ed63-48fd-9fd4c5050e20@amsat.org>
Subject: Re: [Qemu-devel] Linux kernel configurations for various Microblaze
 systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Michal Simek <monstr@monstr.eu>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>, KONRAD Frederic <frederic.konrad@adacore.com>

On Wed, Jun 27, 2018 at 05:01:34PM -0300, Philippe Mathieu-Daudé wrote:
> Hi Guenter,
> 
> On 06/27/2018 03:52 PM, Guenter Roeck wrote:
> > Hi,
> > 
> > I would like to add Microblaze "petalogix-ml605" and "xlnx-zynqmp-pmu"
> > to my list of qemu boot tests of upstream and stable release kernels.
> 
> Do you mind sharing your tests on this thread?
> 
Nothing secret about it. The test results are always available at
http://kerneltests.org/. The scripts are published at
https://github.com/groeck/linux-build-test. My qemu clone (I carry a few
patches on top of upstream qemu) is at https://github.com/groeck/qemu.

> "Who is running QEMU automated tests, and when?"
> http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg04695.html
> 
> > Unfortunately I have been unable to locate working kernel configurations
> > for the those systems, nor working qemu command lines. I found a few links,
> > but they are all dead.
> 
> I got more lucky using the Xilinx downstream code from:
> https://github.com/Xilinx
> 
> In particular using their downstream DeviceTree:
> 
> https://github.com/Xilinx/device-tree-xlnx
> 
> I also used those links:
> 
> http://www.wiki.xilinx.com/MicroBlaze
> http://www.wiki.xilinx.com/Build%20kernel
> 

AFAICS they are all generic, and don't reference specific boards
(other than maybe the possibility to configure those boards). There are
comments such as "start with mmu_defconfig and modify all parameters
which are special on your board". That is great, but trying to do that
for an evaluation board that I don't own and just try to get running
under qemu is a bit difficult since I don't really know what I am doing.

The best I was able to accomplish was to boot petalogix-ml605 without crash,
but with no console output either. I could try to debug further, but I don't
really want to waste my time.

Thanks,
Guenter

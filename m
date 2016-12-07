Received: from eggs.gnu.org ([2001:4830:134:3::10]:59694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam@ravnborg.org>) id 1cEii0-0007kL-Ce
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 15:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam@ravnborg.org>) id 1cEihw-0006fN-Mc
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 15:20:56 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:41575)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam@ravnborg.org>) id 1cEihw-0006eV-Fp
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 15:20:52 -0500
Date: Wed, 7 Dec 2016 21:20:39 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20161207202039.GA27878@ravnborg.org>
References: <1480595945-63656-2-git-send-email-arei.gonglei@huawei.com>
	<201612041032.loAEWLIy%fengguang.wu@intel.com>
	<33183CC9F5247A488A2544077AF19020DA1528DE@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA1528DE@DGGEMA505-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/1] crypto: add virtio-crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: kbuild test robot <lkp@intel.com>, "davem@davemloft.net" <davem@davemloft.net>, "kbuild-all@01.org" <kbuild-all@01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "Wubin (H)" <wu.wubin@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, longpeng <longpeng2@huawei.com>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>

On Mon, Dec 05, 2016 at 03:12:52AM +0000, Gonglei (Arei) wrote:
> I don't think the root cause of those warnings are introduced by virtio-crypto driver.
> 
> What's your opinion? Sam and David?

Root cause here is that arch/sparc/include/asm/topology_64.h
references cpu_data without including arch/sparc/include/asm/cpudata.h

I think other architectures pull in the dependency from
either smp.h or they have it topology.h.

The easy fix would be to include cpudata.h in arch/sparc/include/asm/topology_64.h.
And that should also be a correct fix.

Could you include this in your patch-set and build test it?

	Sam

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEoBP-0007Aj-DV
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEoBO-0008WK-Gu
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:11:39 -0500
Received: from [45.249.212.188] (port=2430 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEoBN-0008TY-OQ
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:11:38 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 8 Dec 2016 02:10:19 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA156A4C@DGGEMA505-MBX.china.huawei.com>
References: <1480595945-63656-2-git-send-email-arei.gonglei@huawei.com>
	<201612041032.loAEWLIy%fengguang.wu@intel.com>
	<33183CC9F5247A488A2544077AF19020DA1528DE@DGGEMA505-MBX.china.huawei.com>
	<20161207202039.GA27878@ravnborg.org>
In-Reply-To: <20161207202039.GA27878@ravnborg.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 1/1] crypto: add virtio-crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: kbuild test robot <lkp@intel.com>, "davem@davemloft.net" <davem@davemloft.net>, "kbuild-all@01.org" <kbuild-all@01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "Wubin
	(H)" <wu.wubin@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, longpeng <longpeng2@huawei.com>, "Wanzongshun
	(Vincent)" <wanzongshun@huawei.com>

Hi Sam,

>
> Subject: Re: [PATCH v5 1/1] crypto: add virtio-crypto driver
>=20
> On Mon, Dec 05, 2016 at 03:12:52AM +0000, Gonglei (Arei) wrote:
> > I don't think the root cause of those warnings are introduced by virtio=
-crypto
> driver.
> >
> > What's your opinion? Sam and David?
>=20
> Root cause here is that arch/sparc/include/asm/topology_64.h
> references cpu_data without including arch/sparc/include/asm/cpudata.h
>=20
> I think other architectures pull in the dependency from
> either smp.h or they have it topology.h.
>=20
> The easy fix would be to include cpudata.h in
> arch/sparc/include/asm/topology_64.h.
> And that should also be a correct fix.
>=20
> Could you include this in your patch-set and build test it?
>=20
Sure, I can add this one at the head of my patch set, but because I
haven't sparc environment, so it depends on the kbuild test robot
to test.

Thanks,
-Gonglei

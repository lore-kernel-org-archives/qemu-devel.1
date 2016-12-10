Received: from eggs.gnu.org ([2001:4830:134:3::10]:33724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cFdDE-0005t7-Qv
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 03:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cFdDD-0003AP-Gh
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 03:40:56 -0500
Received: from [45.249.212.189] (port=2372 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cFdDC-00038o-Nc
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 03:40:55 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Sat, 10 Dec 2016 08:40:02 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA159386@DGGEMA505-MBX.china.huawei.com>
References: <1481171829-116496-1-git-send-email-arei.gonglei@huawei.com>
	<1481171829-116496-2-git-send-email-arei.gonglei@huawei.com>
	<20161209215851.GA7717@ravnborg.org>
In-Reply-To: <20161209215851.GA7717@ravnborg.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 1/2] sparc: fix a building error
 reported by kbuild
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "Wubin
	(H)" <wu.wubin@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "davem@davemloft.net" <davem@davemloft.net>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, longpeng <longpeng2@huawei.com>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>





Regards,
-Gonglei


> -----Original Message-----
> From: linux-crypto-owner@vger.kernel.org
> [mailto:linux-crypto-owner@vger.kernel.org] On Behalf Of Sam Ravnborg
> Sent: Saturday, December 10, 2016 5:59 AM
> To: Gonglei (Arei)
> Cc: linux-kernel@vger.kernel.org; qemu-devel@nongnu.org;
> virtio-dev@lists.oasis-open.org; virtualization@lists.linux-foundation.or=
g;
> linux-crypto@vger.kernel.org; Luonengjun; mst@redhat.com;
> stefanha@redhat.com; Huangweidong (C); Wubin (H); xin.zeng@intel.com;
> Claudio Fontana; herbert@gondor.apana.org.au; pasic@linux.vnet.ibm.com;
> davem@davemloft.net; Zhoujian (jay, Euler); Hanweidong (Randy);
> arei.gonglei@hotmail.com; cornelia.huck@de.ibm.com; Xuquan (Quan Xu);
> longpeng; Wanzongshun (Vincent); sparclinux@vger.kernel.org
> Subject: Re: [PATCH v6 1/2] sparc: fix a building error reported by kbuil=
d
>=20
> Hi Gonglei.
>=20
> On Thu, Dec 08, 2016 at 12:37:08PM +0800, Gonglei wrote:
> > >> arch/sparc/include/asm/topology_64.h:44:44:
> > error: implicit declaration of function 'cpu_data'
> > [-Werror=3Dimplicit-function-declaration]
> >
> >  #define topology_physical_package_id(cpu) (cpu_data(cpu).proc_id)
> >                                                ^
> > Let's include cpudata.h in topology_64.h.
> >
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: sparclinux@vger.kernel.org
> > Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> > Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>=20
Thanks.

> > ---
> >  arch/sparc/include/asm/topology_64.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/sparc/include/asm/topology_64.h
> b/arch/sparc/include/asm/topology_64.h
> > index 7b4898a..2255430 100644
> > --- a/arch/sparc/include/asm/topology_64.h
> > +++ b/arch/sparc/include/asm/topology_64.h
> > @@ -4,6 +4,7 @@
> >  #ifdef CONFIG_NUMA
> >
> >  #include <asm/mmzone.h>
> > +#include <asm/cpudata.h>
>=20
> Nitpick - if you are going to resend this patch,=20

It depends on the maintainer's thought. :)

> then please order the two includes in alphabetic order.
>=20
> For two includes this looks like bikeshedding, but when we add
> more having them in a defined arder prevents merge conflicts.
> And makes it readable too.
>=20
> We also sometimes order the includes with the longest lines topmost,
> and lines with the ame length are ordered alphabetically.
> But this is not seen so often.
>=20

Regards,
-Gonglei

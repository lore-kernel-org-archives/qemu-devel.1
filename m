Received: from eggs.gnu.org ([2001:4830:134:3::10]:56386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQvhW-0000xA-M0
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:38:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQvhR-00072V-Q0
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:38:54 -0500
Received: from [45.249.212.189] (port=2376 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQvh7-0006tO-JV
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:38:49 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 10 Jan 2017 12:36:27 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA182B83@DGGEMA505-MBX.china.huawei.com>
References: <1481767396-187748-1-git-send-email-arei.gonglei@huawei.com>
	<1481767396-187748-2-git-send-email-arei.gonglei@huawei.com>
	<e235caf4-f51c-dccf-4eb7-548d3fa71644@de.ibm.com>
In-Reply-To: <e235caf4-f51c-dccf-4eb7-548d3fa71644@de.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 1/1] crypto: add virtio-crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "mst@redhat.com" <mst@redhat.com>, Luonengjun <luonengjun@huawei.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, longpeng <longpeng2@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "davem@davemloft.net" <davem@davemloft.net>, "Wubin (H)" <wu.wubin@huawei.com>, "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>

Hi,

>=20
> On 12/15/2016 03:03 AM, Gonglei wrote:
> [...]
> > +
> > +static struct crypto_alg virtio_crypto_algs[] =3D { {
> > +	.cra_name =3D "cbc(aes)",
> > +	.cra_driver_name =3D "virtio_crypto_aes_cbc",
> > +	.cra_priority =3D 501,
>=20
>=20
> This is still higher than the hardware-accelerators (like intel aesni or =
the
> s390 cpacf functions or the arm hw). aesni and s390/cpacf are supported b=
y the
> hardware virtualization and available to the guests. I do not see a way h=
ow
> virtio
> crypto can be faster than that (in the end it might be cpacf/aesni + over=
head)
> instead it will very likely be slower.
> So we should use a number that is higher than software implementations bu=
t
> lower than the hw ones.
>=20
> Just grepping around, the software ones seem be be around 100 and the
> hardware
> ones around 200-400. So why was 150 not enough?
>=20
I didn't find a documentation about how we use the priority, and I assumed
people use virtio-crypto will configure hardware accelerators in the
host. So I choosed the number which bigger than aesni's priority.

Regards,
-Gonglei

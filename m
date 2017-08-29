Received: from eggs.gnu.org ([2001:4830:134:3::10]:60074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmdH7-0004Et-Vh
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmdH3-00009r-14
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:57:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dmdH2-00009a-R3
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:57:32 -0400
Date: Tue, 29 Aug 2017 11:57:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170829115727.4dacb471.cohuck@redhat.com>
In-Reply-To: <8f60cc33-8438-9d5a-56bd-7b56c8abee4e@linux.vnet.ibm.com>
References: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1503907487-2764-5-git-send-email-zyimin@linux.vnet.ibm.com>
	<20170828175722.0b54b59a.cohuck@redhat.com>
	<498a00ca-ea1a-ae09-0772-4a25c729841e@linux.vnet.ibm.com>
	<20170829100746.66c47fd8.cohuck@redhat.com>
	<0d7cc071-cebe-82d5-90da-9737a5f0733e@linux.vnet.ibm.com>
	<20170829113353.0a13f88a.cohuck@redhat.com>
	<8f60cc33-8438-9d5a-56bd-7b56c8abee4e@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] s390x/pci: add iommu replay callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, richard.henderson@linaro.org

On Tue, 29 Aug 2017 17:51:43 +0800
Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:

> =E5=9C=A8 2017/8/29 =E4=B8=8B=E5=8D=885:33, Cornelia Huck =E5=86=99=E9=81=
=93:

> > My question was whether virtio-pci works with your patches on top at
> > all - last time I checked on master, virtio-pci devices failed to
> > realize with a "msi-x is mandatory" message.
> >
> > =20
> I tested. virtio-pci works fine. The message "msix is mandatory" means=20
> we only support
> msix interrupt. If virtio-pci device (like virtio-rng) doesn't support=20
> msix, we don't allow it
> to plug.

Ah, that's it (it's a bit strange that not all virtio-pci devices
support msi-x). I can add a virtio-net-pci device just fine.

(Maybe we can enhance the message so that it is clear that it refers to
that particular device?)

> I thinik this is not related to iommu replay.

This question was unrelated to this particular patch, more to the whole
series :)

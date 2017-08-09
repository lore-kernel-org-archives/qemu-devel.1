Received: from eggs.gnu.org ([2001:4830:134:3::10]:37893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfNYG-00024i-Ip
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfNYF-0001dr-M0
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:45:20 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dfNYF-0001dT-DL
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:45:19 -0400
Received: by mail-wm0-x230.google.com with SMTP id m85so26557858wma.1
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 02:45:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5e015c3e-7973-f397-cc1e-fee190292616@redhat.com>
References: <20170809071718.17924-1-cohuck@redhat.com>
	<f384f920-9d51-4663-f7e7-95c8b13044f4@redhat.com>
	<20170809102737.18436fb4.cohuck@redhat.com>
	<5e015c3e-7973-f397-cc1e-fee190292616@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Aug 2017 10:44:57 +0100
Message-ID: <CAFEAcA8uOOWtp4baLu9VUn38vn1ViG5XoG-v4eJjSDc-MHg-zQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] 9pfs: fix dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

On 9 August 2017 at 10:07, Thomas Huth <thuth@redhat.com> wrote:
> While virtio-pci and virtio-ccw seem to require separate dedicated
> devices (e.g. virtio-9p-pci and virtio-9p-ccw) for everything,

You don't *have* to use the dedicated virtio-foo-pci device;
if you like you can manually plug together the virtio-pci
transport and the virtio-foo-device backend yourself. The
'fused' device is just for convenience and compatibility
with existing command lines. There is no fused device for
virtio-mmio because the board itself creates the transport
devices so the user only needs to create the backends
(which then auto-plug into the virtio bus).

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfNaX-00038Q-VR
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfNaW-0003N5-PG
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:47:42 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dfNaW-0003Mh-Iw
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:47:40 -0400
Received: by mail-wm0-x229.google.com with SMTP id m85so26603483wma.1
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 02:47:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5e015c3e-7973-f397-cc1e-fee190292616@redhat.com>
References: <20170809071718.17924-1-cohuck@redhat.com>
	<f384f920-9d51-4663-f7e7-95c8b13044f4@redhat.com>
	<20170809102737.18436fb4.cohuck@redhat.com>
	<5e015c3e-7973-f397-cc1e-fee190292616@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Aug 2017 10:47:18 +0100
Message-ID: <CAFEAcA99yzszYLH4rVt4T5h7qJbePkU=TgCJ==nhDU-ogscuDw@mail.gmail.com>
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
> virtio-mmio seems to work different. As far as I can see, there are no
> dedicated virtio-xxx-mmio devices in the code at all. According to
> https://www.redhat.com/archives/libvir-list/2013-August/msg00009.html
> you simply have to use virtio-xxx-device here instead. And a
> virtio-9p-device is available. So theoretically, the 9p code should work
> with virtio-mmio, too, or is there a problem that I did not see yet?
>
> Anyway, we likely should not blindly enable this, so unless somebody has
> a setup to test it, we should go with your current patch instead, I think.

As you say, we already compile the virtio-9p-device that can
plug into any virtio transport. So why not just build it
whenever virtio of any form is enabled? Having it only
build if PCI is also enabled seems very odd: the backend
should not care at all about what transport it is using.

thanks
-- PMM

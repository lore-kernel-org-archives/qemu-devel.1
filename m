Received: from eggs.gnu.org ([2001:4830:134:3::10]:60145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwYOq-0002J7-9U
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwYOp-0004xL-EM
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:46:36 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:46302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dwYOp-0004wz-7x
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:46:35 -0400
Received: by mail-wr0-x22e.google.com with SMTP id o42so9462056wrb.3
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 11:46:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170925182031.GF3030@localhost.localdomain>
References: <20170925135316.74fed6da.cohuck@redhat.com>
	<20170925133153.GZ3030@localhost.localdomain>
	<20170925154647.357047b9@nial.brq.redhat.com>
	<20170925143439.GA3030@localhost.localdomain>
	<f078939d-4ae0-0ae8-4030-3df0ed66299a@redhat.com>
	<CAFEAcA-kmSkjhM0f+Ti7nY1_AuDm1pPcYHNGn50fes20YvOeBg@mail.gmail.com>
	<59e890ab-45e4-fe8a-a8de-3c441de19080@redhat.com>
	<CAFEAcA9b=XOhczb=vYRJLDFR5yYqHwYFF6YtO9veYFqsEDgYsw@mail.gmail.com>
	<20170925175141.GC3030@localhost.localdomain>
	<CAFEAcA8S0sAgpsKe0B7hjF9028rJdA6Ng6jFwvTFh+GupK7CRA@mail.gmail.com>
	<20170925182031.GF3030@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Sep 2017 19:46:12 +0100
Message-ID: <CAFEAcA8zwGDWWOMsvzuLCzxWT0r8xfprEX__81U0=ebD4907cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] qdev: Mark devices as non-hotpluggable
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Amit Shah <amit@kernel.org>

On 25 September 2017 at 19:20, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Mon, Sep 25, 2017 at 07:02:06PM +0100, Peter Maydell wrote:
>> On 25 September 2017 at 18:51, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> > On Mon, Sep 25, 2017 at 06:45:15PM +0100, Peter Maydell wrote:
>> >> You should be able to on the command line for x86 do something
>> >> like -device virtio-pci,... -device virtio-foo-device,...
>> >> to manually create the pci transport and the backend.
>> >
>> > virtio-pci is abstract, so this is not possible.  (The same
>> > applies to virtio-ccw-device).
>>
>> Did I use the wrong device name? I meant the transport
>> layer device (which virtio-pci-blk creates along with
>> virtio-blk-device internally), not the abstract device
>> that's a base class for the pci devices.
>
> AFAIK, virtio-pci/virtio-pci-blk itself is the transport layer
> device.  Internally, it creates two objects: a virtio-pci-bus
> (which is a 1-device bus, not creatable using -device), and a
> virtio-blk-device attached to that bus.

Hmm, I thought the way we structured this was that
virtio-pci-blk is the convenience wrapper device,
which creates both the endpoint device (virtio-blk-device)
and the transport device (which is the thing that
has a PCI bus interface on one end and a virtio bus
on the other). But maybe we didn't restructure the
pci virtio devices to do that...

thanks
-- PMM

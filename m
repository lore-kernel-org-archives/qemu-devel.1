Received: from eggs.gnu.org ([2001:4830:134:3::10]:42174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwXS5-0004t5-8K
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 13:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwXS4-0003H1-C8
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 13:45:53 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:49637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dwXRp-0003Dw-7f
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 13:45:52 -0400
Received: by mail-wm0-x232.google.com with SMTP id r74so22212221wme.4
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 10:45:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <59e890ab-45e4-fe8a-a8de-3c441de19080@redhat.com>
References: <1506071794-4373-1-git-send-email-thuth@redhat.com>
	<20170925135316.74fed6da.cohuck@redhat.com>
	<20170925133153.GZ3030@localhost.localdomain>
	<20170925154647.357047b9@nial.brq.redhat.com>
	<20170925143439.GA3030@localhost.localdomain>
	<f078939d-4ae0-0ae8-4030-3df0ed66299a@redhat.com>
	<CAFEAcA-kmSkjhM0f+Ti7nY1_AuDm1pPcYHNGn50fes20YvOeBg@mail.gmail.com>
	<59e890ab-45e4-fe8a-a8de-3c441de19080@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Sep 2017 18:45:15 +0100
Message-ID: <CAFEAcA9b=XOhczb=vYRJLDFR5yYqHwYFF6YtO9veYFqsEDgYsw@mail.gmail.com>
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
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Amit Shah <amit@kernel.org>

On 25 September 2017 at 18:42, Thomas Huth <thuth@redhat.com> wrote:
> On 25.09.2017 17:26, Peter Maydell wrote:
>> On 25 September 2017 at 16:19, Thomas Huth <thuth@redhat.com> wrote:
>>> Not sure whether this works for the virtio-xxx-device devices,
>>> though, since they are marked as user_creatable = true currently...
>>
>> That's deliberate -- for the arm boards with virtio-mmio
>> the board creates a bunch of virtio-mmio transports and the
>> virtio-foo-device can be user created to plug into those.
>
> Yes, I know ... I'm just wondering whether the virtio-xxx-device devices
> should be non-user_creatable on the non-ARM targets, since they
> apparently can't be used with "-device" there...?

You should be able to on the command line for x86 do something
like -device virtio-pci,... -device virtio-foo-device,...
to manually create the pci transport and the backend.

thanks
-- PMM

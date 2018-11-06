Received: from eggs.gnu.org ([2001:4830:134:3::10]:49329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK0l0-0004l4-LO
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK0dx-00079O-S6
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:39:42 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gK0dx-000799-LK
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:39:41 -0500
Received: by mail-ot1-x341.google.com with SMTP id t5so7620772otk.1
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 04:39:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9k544ZduSLR2iFk2AXwWoXC3rQMpdhX28wq_U4C=yZjw@mail.gmail.com>
References: <20181105181353.39804-1-mst@redhat.com>
	<a4e0dd6a-a1d5-10a1-a9e0-d01ca8d88d84@redhat.com>
	<20181106060647-mutt-send-email-mst@kernel.org>
	<CAFEAcA9k544ZduSLR2iFk2AXwWoXC3rQMpdhX28wq_U4C=yZjw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 12:39:20 +0000
Message-ID: <CAFEAcA-eULHQn9qdnNNXsu9rFLa8Q9bGUtqw6HmFtaX=+bOuUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/33] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>

On 6 November 2018 at 11:20, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 6 November 2018 at 11:07, Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Tue, Nov 06, 2018 at 09:18:49AM +0100, Thomas Huth wrote:
>>> On 2018-11-05 19:14, Michael S. Tsirkin wrote:
>>> > The following changes since commit b2f7a038bb4c4fc5ce6b8486e8513dfd97665e2a:
>>> >
>>> >   Merge remote-tracking branch 'remotes/rth/tags/pull-softfloat-20181104' into staging (2018-11-05 10:32:49 +0000)
>>> >
>>> > are available in the Git repository at:
>>> >
>>> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>>> >
>>> > for you to fetch changes up to 6196df5c8e6688c1c3f06f73442820066335337c:
>>> >
>>> >   vhost-scsi: prevent using uninitialized vqs (2018-11-05 12:59:35 -0500)
>>> >
>>> > ----------------------------------------------------------------
>>> > pci, pc, virtio: fixes, features
>>> >
>>> > AMD IOMMU VAPIC support + fixes all over the place.
>>> >
>>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> >
>>> > ----------------------------------------------------------------
>>> > Gerd Hoffmann (1):
>>> >       pci-testdev: add optional memory bar
>>> >
>>> > Laszlo Ersek (4):
>>> >       MAINTAINERS: list "tests/acpi-test-data" files in ACPI/SMBIOS section
>>> [...]
>>> >  tests/{acpi-test-data => data/acpi}/pc/APIC        | Bin
>>> >  tests/{acpi-test-data => data/acpi}/pc/APIC.cphp   | Bin
>>> >  .../{acpi-test-data => data/acpi}/pc/APIC.dimmpxm  | Bin
>>> >  tests/{acpi-test-data => data/acpi}/pc/DSDT        | Bin
>>>
>>> So patch 1 moves tests/acpi-test-data/ to tests/data/acpi/ and patch 20
>>> adds an entry for tests/acpi-test-data/ ? Does not make much sense to me
>>> ... I think patch 20 needs to be adapted now.
>>>
>>>  Thomas
>>
>> Oh right, MAINTAINERS needs to be fixed. Can be done with a patch on top
>> though.
>
> Yeah, given the timing for rc0 I'll just apply this version of
> the pullreq, and we can fix up MAINTAINERS afterwards.

...applied.

thanks
-- PMM

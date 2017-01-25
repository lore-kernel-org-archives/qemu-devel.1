Received: from eggs.gnu.org ([2001:4830:134:3::10]:50757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1cWRuV-0007I5-NX
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:03:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1cWRuR-00051B-Rf
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:03:07 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1cWRuR-00050X-Ld
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:03:03 -0500
Received: by mail-wm0-x243.google.com with SMTP id r126so44193504wmr.3
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 10:03:01 -0800 (PST)
Reply-To: marcel@redhat.com
References: <1485297322-10595-1-git-send-email-mst@redhat.com>
	<CAFEAcA_TW1JK8DOHt-=kisvemGXjtuadJ+eH7L8NJwsQcQz8sw@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <3958a41a-9b0e-4616-19dc-173824a87b31@gmail.com>
Date: Wed, 25 Jan 2017 20:02:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_TW1JK8DOHt-=kisvemGXjtuadJ+eH7L8NJwsQcQz8sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 00/16] virtio, vhost, pci: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 01/25/2017 06:36 PM, Peter Maydell wrote:
> On 24 January 2017 at 22:36, Michael S. Tsirkin <mst@redhat.com> wrote:
>> The following changes since commit a9e404600a9bd1e6a26431fc89e5069092e67f14:
>>
>>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170124' into staging (2017-01-24 17:26:26 +0000)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>>
>> for you to fetch changes up to b562d945fc840131d290d4bf5af8d6cc3bb98a2b:
>>
>>   vhost-user: delete chardev on cleanup (2017-01-24 21:49:25 +0200)
>>
>> ----------------------------------------------------------------
>> virtio, vhost, pci: fixes, features
>>
>> generic pci root port support
>> fixes and cleanups all over the place
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> Hi; I'm afraid this fails to build:
>
> /home/pm215/qemu/hw/pci-bridge/gen_pcie_root_port.c:54:9: error:
> implicit declaration of function ‘VMSTATE_PCIE_DEVICE’
> [-Werror=implicit-function-declaration]
>          VMSTATE_PCIE_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
>          ^
> /home/pm215/qemu/hw/pci-bridge/gen_pcie_root_port.c:54:29: error:
> ‘parent_obj’ undeclared here (not in a function)
>          VMSTATE_PCIE_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
>                              ^
> /home/pm215/qemu/hw/pci-bridge/gen_pcie_root_port.c:54:63: error:
> expected expression before ‘PCIESlot’
>          VMSTATE_PCIE_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
>

Hi Peter,

Strange, I re-based in the same day I posted and compiled just fine...
However, I get the same error using today's master.

I'll fix and re-post the series.

Thanks,
Marcel
                                                                 ^
>
> thanks
> -- PMM
>

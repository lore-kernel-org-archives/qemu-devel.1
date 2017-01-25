Received: from eggs.gnu.org ([2001:4830:134:3::10]:50856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWQYu-0005nA-N3
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWQYt-0001DO-NP
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:36:44 -0500
Received: from mail-vk0-x22f.google.com ([2607:f8b0:400c:c05::22f]:36084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cWQYt-0001DB-J6
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:36:43 -0500
Received: by mail-vk0-x22f.google.com with SMTP id t8so137331321vke.3
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 08:36:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485297322-10595-1-git-send-email-mst@redhat.com>
References: <1485297322-10595-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Jan 2017 16:36:22 +0000
Message-ID: <CAFEAcA_TW1JK8DOHt-=kisvemGXjtuadJ+eH7L8NJwsQcQz8sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/16] virtio, vhost, pci: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 January 2017 at 22:36, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit a9e404600a9bd1e6a26431fc89e5069092e67f=
14:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170124' into =
staging (2017-01-24 17:26:26 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to b562d945fc840131d290d4bf5af8d6cc3bb98a2b:
>
>   vhost-user: delete chardev on cleanup (2017-01-24 21:49:25 +0200)
>
> ----------------------------------------------------------------
> virtio, vhost, pci: fixes, features
>
> generic pci root port support
> fixes and cleanups all over the place
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Hi; I'm afraid this fails to build:

/home/pm215/qemu/hw/pci-bridge/gen_pcie_root_port.c:54:9: error:
implicit declaration of function =E2=80=98VMSTATE_PCIE_DEVICE=E2=80=99
[-Werror=3Dimplicit-function-declaration]
         VMSTATE_PCIE_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
         ^
/home/pm215/qemu/hw/pci-bridge/gen_pcie_root_port.c:54:29: error:
=E2=80=98parent_obj=E2=80=99 undeclared here (not in a function)
         VMSTATE_PCIE_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
                             ^
/home/pm215/qemu/hw/pci-bridge/gen_pcie_root_port.c:54:63: error:
expected expression before =E2=80=98PCIESlot=E2=80=99
         VMSTATE_PCIE_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
                                                               ^

thanks
-- PMM

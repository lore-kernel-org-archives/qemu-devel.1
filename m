Received: from eggs.gnu.org ([2001:4830:134:3::10]:59707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD95e-0007sz-3N
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD95d-00049j-7H
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:15:54 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gD95c-00049Q-PN
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:15:53 -0400
Received: by mail-oi1-x244.google.com with SMTP id a203-v6so24149841oib.0
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 07:15:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <29ed5e33-18d5-7c86-d946-02e96b9bff68@gmail.com>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net> <20181016170236.GJ7995@redhat.com>
	<d8b9a6e6-c137-a553-8fe7-939edd2031b3@redhat.com>
	<87murdf73g.fsf_-_@dusky.pond.sub.org>
	<20181017155637.GC31060@habkost.net>
	<29ed5e33-18d5-7c86-d946-02e96b9bff68@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Oct 2018 15:15:31 +0100
Message-ID: <CAFEAcA_f1yAXLTgK6utBYG5H4woPw5UezgB8Co5aauNu2EA+wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] No more chameleon devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Laine Stump <laine@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On 18 October 2018 at 15:11, Marcel Apfelbaum
<marcel.apfelbaum@gmail.com> wrote:
> Maybe would be a step toward a clean "socket-device" modeling (what goes
> where)
> and also QEMU emulation would be cleaner since in bare metal you cannot
> plug a PCIe device into a PCI slot and vice-versa or have the same device ID
> for both a PCI and a PCIe device.

So the command line would then distinguish "-device ne2k-pci" and
"-device ne2k-pcie", and users need to know whether the machine they're
using implements PCI or PCIe, and use the right device name accordingly?

thanks
-- PMM

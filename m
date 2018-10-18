Received: from eggs.gnu.org ([2001:4830:134:3::10]:41586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD9bg-0003lS-FQ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD9bf-0002K5-ND
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:49:00 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gD9bd-0002Ai-SM
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:48:59 -0400
Received: by mail-ot1-x343.google.com with SMTP id x4so28602818otg.3
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 07:48:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6bdbd841-5922-c974-8232-4912a8fd9906@gmail.com>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net> <20181016170236.GJ7995@redhat.com>
	<d8b9a6e6-c137-a553-8fe7-939edd2031b3@redhat.com>
	<87murdf73g.fsf_-_@dusky.pond.sub.org>
	<20181017155637.GC31060@habkost.net>
	<29ed5e33-18d5-7c86-d946-02e96b9bff68@gmail.com>
	<CAFEAcA_f1yAXLTgK6utBYG5H4woPw5UezgB8Co5aauNu2EA+wg@mail.gmail.com>
	<20181018143858.GG20424@redhat.com>
	<CAFEAcA-OyfXgU-NgcSXvUf_KEnAJQYDWAs9=FFLPt7son2W9Ag@mail.gmail.com>
	<6bdbd841-5922-c974-8232-4912a8fd9906@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Oct 2018 15:48:32 +0100
Message-ID: <CAFEAcA-bVOJGSquDd_ikSUMs41xfJuHvc_Pp++08sUq5x8O+Gg@mail.gmail.com>
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Laine Stump <laine@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On 18 October 2018 at 15:45, Marcel Apfelbaum
<marcel.apfelbaum@gmail.com> wrote:
> PCIe machines support PCI devices while PCI machines do not support
> PCIe devices.
>
> I think users of the PCI machines would benefit from having a clear list of
> supported devices, rather than have to find out if their device
>  1. Is a hybrid device - QEMU will 'make' it PCI/PCIe
>  2. Is a PCIe device - would not work on a PCI machine
>  3. Is a PCI device - all good

Ah, I see. So, today, of all the devices labelled as "pci" which
QEMU has, how many of them are in which of those categories?
(I guess I'm mostly interested in whether what we have is
mostly really-PCI devices with one or two PCIe devices, or
if we're currently (mis-)modelling some PCIe devices as hybrid.)

thanks
-- PMM

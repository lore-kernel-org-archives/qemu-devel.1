Received: from eggs.gnu.org ([2001:4830:134:3::10]:39467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD9Ui-0006Jk-Rs
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD9Ui-0001IA-1k
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:41:48 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gD9Uh-0001H7-LW
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:41:47 -0400
Received: by mail-oi1-x241.google.com with SMTP id s69-v6so24165828oie.10
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 07:41:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181018143858.GG20424@redhat.com>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net> <20181016170236.GJ7995@redhat.com>
	<d8b9a6e6-c137-a553-8fe7-939edd2031b3@redhat.com>
	<87murdf73g.fsf_-_@dusky.pond.sub.org>
	<20181017155637.GC31060@habkost.net>
	<29ed5e33-18d5-7c86-d946-02e96b9bff68@gmail.com>
	<CAFEAcA_f1yAXLTgK6utBYG5H4woPw5UezgB8Co5aauNu2EA+wg@mail.gmail.com>
	<20181018143858.GG20424@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Oct 2018 15:41:26 +0100
Message-ID: <CAFEAcA-OyfXgU-NgcSXvUf_KEnAJQYDWAs9=FFLPt7son2W9Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] No more chameleon devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Laine Stump <laine@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On 18 October 2018 at 15:38, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> On Thu, Oct 18, 2018 at 03:15:31PM +0100, Peter Maydell wrote:
>> On 18 October 2018 at 15:11, Marcel Apfelbaum
>> <marcel.apfelbaum@gmail.com> wrote:
>> > Maybe would be a step toward a clean "socket-device" modeling (what go=
es
>> > where)
>> > and also QEMU emulation would be cleaner since in bare metal you canno=
t
>> > plug a PCIe device into a PCI slot and vice-versa or have the same dev=
ice ID
>> > for both a PCI and a PCIe device.
>>
>> So the command line would then distinguish "-device ne2k-pci" and
>> "-device ne2k-pcie", and users need to know whether the machine they're
>> using implements PCI or PCIe, and use the right device name accordingly?
>
> I can understand the rational for splitting the virtio devices, because
> of the way they completely change their functionality, even PCI device ID=
,
> depending on whether plugged into a pci or pcie slot.
>
> I'm not seeing the real world benefit of creating -pci vs -pcie for all
> the other non-virtio devices. AFAIK, the existing devices work the same
> regardless of what bus they are plugged into. So why would a user/app
> want to use such devices ? It feels like extra work for no clear benefit

Well, I don't see the benefit either, which is why I wanted to check
whether that was what was being proposed here. Conversely, if we're
happy that the ne2k-pci device should be allowed to plug into either
PCI or PCIe, it seems wrong to prohibit a virtio PCI device from
also being flexible that way, because then virtio would be a weird special
case as far as the user is concerned (as the only device where they need
to care about PCI vs PCIe).

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDChw-00020A-9R
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDChs-0006U7-8G
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:07:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gDChs-0006Se-20
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:07:36 -0400
Date: Thu, 18 Oct 2018 15:07:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181018180732.GU31060@habkost.net>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net>
	<20181016170236.GJ7995@redhat.com>
	<d8b9a6e6-c137-a553-8fe7-939edd2031b3@redhat.com>
	<87murdf73g.fsf_-_@dusky.pond.sub.org>
	<20181017155637.GC31060@habkost.net>
	<29ed5e33-18d5-7c86-d946-02e96b9bff68@gmail.com>
	<CAFEAcA_f1yAXLTgK6utBYG5H4woPw5UezgB8Co5aauNu2EA+wg@mail.gmail.com>
	<20181018143858.GG20424@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181018143858.GG20424@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Laine Stump <laine@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Cleber Rosa <crosa@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>

On Thu, Oct 18, 2018 at 03:38:58PM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Oct 18, 2018 at 03:15:31PM +0100, Peter Maydell wrote:
> > On 18 October 2018 at 15:11, Marcel Apfelbaum
> > <marcel.apfelbaum@gmail.com> wrote:
> > > Maybe would be a step toward a clean "socket-device" modeling (what=
 goes
> > > where)
> > > and also QEMU emulation would be cleaner since in bare metal you ca=
nnot
> > > plug a PCIe device into a PCI slot and vice-versa or have the same =
device ID
> > > for both a PCI and a PCIe device.
> >=20
> > So the command line would then distinguish "-device ne2k-pci" and
> > "-device ne2k-pcie", and users need to know whether the machine they'=
re
> > using implements PCI or PCIe, and use the right device name according=
ly?
>=20
> I can understand the rational for splitting the virtio devices, because
> of the way they completely change their functionality, even PCI device =
ID,
> depending on whether plugged into a pci or pcie slot.
>=20
> I'm not seeing the real world benefit of creating -pci vs -pcie for all
> the other non-virtio devices. AFAIK, the existing devices work the same
> regardless of what bus they are plugged into. So why would a user/app
> want to use such devices ? It feels like extra work for no clear benefi=
t

Agreed.

--=20
Eduardo

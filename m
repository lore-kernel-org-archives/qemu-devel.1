Received: from eggs.gnu.org ([2001:4830:134:3::10]:35129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cgAVl-0000Xd-4n
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cgAVh-0007qZ-9i
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:29:45 -0500
Received: from greensocs.com ([193.104.36.180]:59932)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cgAVg-0007pv-VN
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:29:41 -0500
References: <5a80994b-3eeb-6ac8-9fbf-e6fae15dfd7a@kamp.de>
	<1a244107-b611-1321-f56f-076ef008ef75@kamp.de>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <73c77ab9-64dd-5955-6935-b1e6a11334ee@greensocs.com>
Date: Tue, 21 Feb 2017 14:29:38 +0100
MIME-Version: 1.0
In-Reply-To: <1a244107-b611-1321-f56f-076ef008ef75@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Creating a dummy PCI device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Peter,

This won't be easy unfortunately, at least not clean :).
The vendor_id device_id are part of the PCIDeviceClass.
So I _think_ you can't use a qom parameter for that.
But... it seems that these fields are used firstly in
pci_qdev_realize (to be checked) so maybe it's okay to change them
later before the device is realized with a parameter..

This is really hackish.. sorry.. but that's a though :).

Fred

On 02/21/2017 01:41 PM, Peter Lieven wrote:
> Am 03.02.2017 um 13:07 schrieb Peter Lieven:
>> Hi,
>>
>>
>> I have a special use case of creating a dummy PCI device with a
>> certain vendor/device ID. The device does not have to actually
>> function, it just
>>
>> has to be visible under lspci.
>>
>>
>> Any idea how to achieve this? I was thinking of modifying the edu pci
>> device to make the device/vendor ID passable via cmdline.
>>
>>
>> Don't know if thats a good idea.
>>
>>
>> Any thoughts?
>=20
> anyone?
>=20
> Thanks,
> Peter
>=20
>=20

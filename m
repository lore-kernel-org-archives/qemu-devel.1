Received: from eggs.gnu.org ([2001:4830:134:3::10]:59349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f5pR7-0000Ou-5q
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f5pR4-00031n-2D
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:19:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f5pR3-00031e-TC
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:19:29 -0400
References: <20180407000117.25640-1-lersek@redhat.com>
	<bf5fc85b-0695-3bd0-117d-759d5dbd4546@redhat.com>
	<6bfdae78-909f-e7ad-b0f0-25f76dfd81f7@redhat.com>
	<20180410090550.GE5155@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7c9bf892-95e9-ae5d-8308-a7575265d4af@redhat.com>
Date: Tue, 10 Apr 2018 11:19:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180410090550.GE5155@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 10.04.2018 11:05, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Apr 09, 2018 at 06:34:41PM +0200, Laszlo Ersek wrote:
>> On 04/09/18 09:26, Thomas Huth wrote:
>>>  Hi Laszlo,
>>>
>>> On 07.04.2018 02:01, Laszlo Ersek wrote:
>>>> Add a schema that describes the properties of virtual machine firmwa=
re.
>>>>
>>>> Each firmware executable installed on a host system should come with=
 a
>>>> JSON file that conforms to this schema, and informs the management
>>>> applications about the firmware's properties.
>>>>
>>>> In addition, a configuration directory with symlinks to the JSON fil=
es
>>>> should exist, with the symlinks carefully named to reflect a priorit=
y
>>>> order. Management applications can then search this directory in pri=
ority
>>>> order for the first firmware executable that satisfies their search
>>>> criteria. The found JSON file provides the management layer with dom=
ain
>>>> configuration bits that are required to run the firmware binary.
>>> [...]
>>>> +##
>>>> +# @FirmwareDevice:
>>>> +#
>>>> +# Defines the device types that a firmware file can be mapped into.
>>>> +#
>>>> +# @memory: The firmware file is to be mapped into memory.
>>>> +#
>>>> +# @kernel: The firmware file is to be loaded like a Linux kernel. T=
his is
>>>> +#          similar to @memory but may imply additional processing t=
hat is
>>>> +#          specific to the target architecture.
>>>> +#
>>>> +# @flash: The firmware file is to be mapped into a pflash chip.
>>>> +#
>>>> +# Since: 2.13
>>>> +##
>>>> +{ 'enum' : 'FirmwareDevice',
>>>> +  'data' : [ 'memory', 'kernel', 'flash' ] }
>>>
>>> This is not fully clear to me... what is this exactly good for? Is th=
is
>>> a way to say how the firmware should be loaded, i.e. via "-bios",
>>> "-kernel" or "-pflash" parameter? If so, the term "memory" is quite
>>> misleading since files that are loaded via -bios can also end up in a=
n
>>> emulated ROM chip.
>>
>> I threw in "-kernel" because, although it also (usually?) means
>> "memory", I expected people would want it separate.
>=20
> What platform / scenario actually uses -kernel to load firmware.

I think uboot uses -kernel in certain cases, see e.g.:

https://balau82.wordpress.com/2010/03/10/u-boot-for-arm-on-qemu/

> If you
> have loaded firmware using -kernel, how do you then load the actual
> kernel ?

The kernel is then loaded from disk or network or another boot device.

 Thomas

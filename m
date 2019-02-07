Received: from eggs.gnu.org ([209.51.188.92]:37459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1grYBW-0001b2-7z
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 20:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1grYBU-0001n4-7p
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 20:08:58 -0500
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-10-philmd@redhat.com>
	<CAFEAcA_ejg0yPkBZ_0-mgM5zgMHKqKe3SDGX0wMZ-neYC_Oy0A@mail.gmail.com>
	<e5dd8130-e041-7774-2141-cc506dee99f7@redhat.com>
	<94f74717-0bab-ea0a-e7cc-239a1b1136bf@comstyle.com>
	<97d5ea1c-0621-8f9c-0ee6-6a64540b4ddd@comstyle.com>
	<87zhr8mzq2.fsf@zen.linaroharston>
From: Brad Smith <brad@comstyle.com>
Message-ID: <1afc34a0-1267-dbf8-15fa-d35ec3428e3d@comstyle.com>
Date: Wed, 6 Feb 2019 20:03:44 -0500
MIME-Version: 1.0
In-Reply-To: <87zhr8mzq2.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/18] tests/vm/openbsd: Install Bash
 from the ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>, Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 2/6/2019 3:25 PM, Alex Benn=C3=A9e wrote:

> Brad Smith <brad@comstyle.com> writes:
>
>> On 2/5/2019 8:57 AM, Brad Smith wrote:
>>
>>> If someone could point me in the right direction as to how the image
>>> is created
>>> I could look at coming up with something newer. I would prefer that
>>> over some
>>> of the workarounds I've seen to date.
>> I started creating the image and then wondered what do I set the root
>> password
>> to? The instructions also talk about an SSH key but I don't know how
>> that would
>> work when this image is used for the VM test framework.
> See tests/keys - basically we have a hard-wired testing key.
So the root password doesn't matter?
>> I updated the instructions on the Wiki to make use of VirtIO for both
>> the NIC and disk controller.
> Can the OpenBSD kernel use virtio-net-pci and virtio-scsi-pci?
>
> It's not super important for build testing but they are the most capabl=
e
> variants of virtio. The virtio-pci gives nice discover-able hotplug and
> I believe you need virtio-scsi-pci if you want to use funky options lik=
e
> discard for thin provisioning.

Yes to both.

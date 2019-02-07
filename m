Received: from eggs.gnu.org ([209.51.188.92]:38813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1grebC-00079x-Lf
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 02:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1grebA-0001vI-NW
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 02:59:54 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1greb7-0001dR-5P
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 02:59:50 -0500
Received: by mail-wr1-x442.google.com with SMTP id z18so9668183wrh.2
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 23:59:39 -0800 (PST)
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-10-philmd@redhat.com>
	<CAFEAcA_ejg0yPkBZ_0-mgM5zgMHKqKe3SDGX0wMZ-neYC_Oy0A@mail.gmail.com>
	<e5dd8130-e041-7774-2141-cc506dee99f7@redhat.com>
	<94f74717-0bab-ea0a-e7cc-239a1b1136bf@comstyle.com>
	<97d5ea1c-0621-8f9c-0ee6-6a64540b4ddd@comstyle.com>
	<87zhr8mzq2.fsf@zen.linaroharston>
	<1afc34a0-1267-dbf8-15fa-d35ec3428e3d@comstyle.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1afc34a0-1267-dbf8-15fa-d35ec3428e3d@comstyle.com>
Date: Thu, 07 Feb 2019 07:59:36 +0000
Message-ID: <87womcm3kn.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Brad Smith <brad@comstyle.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Philippe =?utf-8?Q?Mat?= =?utf-8?Q?hieu-Daud=C3=A9?= <philmd@redhat.com>


Brad Smith <brad@comstyle.com> writes:

> On 2/6/2019 3:25 PM, Alex Benn=C3=A9e wrote:
>
>> Brad Smith <brad@comstyle.com> writes:
>>
>>> On 2/5/2019 8:57 AM, Brad Smith wrote:
>>>
>>>> If someone could point me in the right direction as to how the image
>>>> is created
>>>> I could look at coming up with something newer. I would prefer that
>>>> over some
>>>> of the workarounds I've seen to date.
>>> I started creating the image and then wondered what do I set the root
>>> password
>>> to? The instructions also talk about an SSH key but I don't know how
>>> that would
>>> work when this image is used for the VM test framework.
>> See tests/keys - basically we have a hard-wired testing key.
> So the root password doesn't matter?

I don't think so. See "Adding new guests" in docs/devel/testing.rst

The Ubuntu and CentOS build_image methods are a bit more elaborate in
that they build a cloud-image iso which contains a bunch of metadata for
the image to apply on boot-up. The OpenBSD build_image just downloads
the data and uncompresses it.

The defaults in BaseIMG are:

    GUEST_USER =3D "qemu"
    GUEST_PASS =3D "qemupass"
    ROOT_PASS =3D "qemupass"

>>> I updated the instructions on the Wiki to make use of VirtIO for both
>>> the NIC and disk controller.
>> Can the OpenBSD kernel use virtio-net-pci and virtio-scsi-pci?
>>
>> It's not super important for build testing but they are the most capable
>> variants of virtio. The virtio-pci gives nice discover-able hotplug and
>> I believe you need virtio-scsi-pci if you want to use funky options like
>> discard for thin provisioning.
>
> Yes to both.

Cool.

--
Alex Benn=C3=A9e

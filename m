Received: from eggs.gnu.org ([2001:4830:134:3::10]:49824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fLAFl-0007pW-V3
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fLAFk-0001AL-Pi
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:35:13 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:39590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fLAFk-00019j-FZ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:35:12 -0400
Received: by mail-wm0-x242.google.com with SMTP id f8-v6so1497761wmc.4
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 09:35:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <13e9e7c3-08e3-f876-07f3-b8db5e8ad39c@redhat.com>
References: <20171108022828.7242-1-f4bug@amsat.org>
	<23253f77-ccc8-220d-3028-f27945f9542c@redhat.com>
	<791dd038-8811-6335-75f7-6dd309ff0ff7@amsat.org>
	<20180511135544.GH25013@localhost.localdomain>
	<4e72cde3-8475-2964-b834-f74d15d66cae@redhat.com>
	<CAKmqyKMWgGHackdiiaC-e4yU9h4-OKsc2c3s6RevxZetrb8jQw@mail.gmail.com>
	<13e9e7c3-08e3-f876-07f3-b8db5e8ad39c@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 22 May 2018 09:34:40 -0700
Message-ID: <CAKmqyKPBgo96az_BYemKi=RMhpTcBDUiNs5j4s51-nhb4TtnEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Publishing binary images for testing (was Re: [RFC
 PATCH 0/6] generic way to deprecate machines)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alexander Graf <agraf@suse.de>, avocado-devel@redhat.com, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On Tue, May 22, 2018 at 9:17 AM, Cleber Rosa <crosa@redhat.com> wrote:
>
>
> On 05/18/2018 02:16 PM, Alistair Francis wrote:
>> On Fri, May 11, 2018 at 7:27 AM, Cleber Rosa <crosa@redhat.com> wrote:
>>>
>>>
>>> On 05/11/2018 09:55 AM, Eduardo Habkost wrote:
>>>> (CCing Cleber and avocado-devel in case they have suggestions)
>>>>
>>>> On Tue, May 08, 2018 at 12:47:52PM -0300, Philippe Mathieu-Daud=C3=A9 =
wrote:
>>>> [...]
>>>>> Ironically I have been using the Gumstix machines quite a lot for the=
 SD
>>>>> 'subsystem' refactor, using the MMC commands in U-Boot (I am unable t=
o
>>>>> reach the Linux userland since the kernel crashes), and plan to add S=
D
>>>>> integration tests via Avocado.
>>>>>
>>>>> This raises:
>>>>>
>>>>> - What will happens if I add tests downloading running on their compi=
led
>>>>> u-boot
>>>>> (https://downloads.gumstix.com/images/angstrom/developer/2012-01-22-1=
750/u-boot.bin)
>>>>> and the company decides to remove this old directory?
>>>>> Since sometimes old open-source software are hard to rebuild with rec=
ent
>>>>> compilers, should we consider to use a public storage to keep
>>>>> open-source (signed) blobs we can use for integration testing?
>>>>
>>>> I think a maintained repository of images for testing would be
>>>> nice to have.  We need to be careful to comply with the license
>>>> of the software being distributed, though.
>>>>
>>>> If the images are very small (like u-boot.bin above), it might be
>>>> OK to carry them in qemu.git, just like the images in pc-bios.
>>>>
>>>>>
>>>>> Avocado has a 'vmimage library' which could be extended, adding suppo=
rt
>>>>> for binary url + detached gpg signatures from some QEMU maintainers?
>>>>
>>>> Requiring a signature makes the binaries hard to replace.  Any
>>>> specific reason to suggest gpg signatures instead of just a
>>>> (e.g.) sha256 hash?
>>>>
>>>>>
>>>>> (I am also using old Gentoo/Debian packaged HPPA/Alpha Linux kernel f=
or
>>>>> Avocado SuperIO tests, which aren't guaranteed to stay downloadable
>>>>> forever).
>>>>
>>>> Question for the Avocado folks: how this is normally handled in
>>>> avocado/avocado-vt?  Do you maintain a repository for guest
>>>> images, or you always point to their original sources?
>>>>
>>>
>>> For pure Avocado, the vmimage library attempts to fetch, by default, th=
e
>>> latest version of a guest image directly from the original sources.
>>> Say, a Fedora image will be downloaded by default from the Fedora
>>> servers.  Because of that, we don't pay too much attention to the
>>> availability of specific (old?) versions of guest images.
>>>
>>> For Avocado-VT, there are the JeOS images[1], which we keep on a test
>>> "assets" directory.  We have a lot of storage/bandwidth availability, s=
o
>>> it can be used for other assets proven to be necessary for tests.
>>>
>>> As long as distribution rights and licensing are not issues, we can
>>> definitely use the same server for kernels, u-boot images and what not.
>>>
>>> [1] - https://avocado-project.org/data/assets/
>>
>> Is it possible to add something to the landing page at
>> https://avocado-project.org ?
>>
>
> Done!

Awesome! It looks good and this should help everyone behind a proxy.

Alistair

> - Cleber.
>
>> The Palo Alto Network routers block the avocado-project.org page as
>> they classify it as blank. Something on the root URL would help fix
>> this.
>>
>> Alistair
>>

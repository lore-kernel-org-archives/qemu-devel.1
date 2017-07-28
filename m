Received: from eggs.gnu.org ([2001:4830:134:3::10]:56247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1db7c9-0007Cs-Eq
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1db7c6-00007l-Al
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:55:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1db7c6-00006f-01
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:55:42 -0400
References: <20170714182012.4595-1-marcandre.lureau@redhat.com>
	<20170714182012.4595-3-marcandre.lureau@redhat.com>
	<20170714222023-mutt-send-email-mst@kernel.org>
	<5d31f22d-e0ae-92f4-ea17-690419f72944@redhat.com>
	<20170714230852-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJW1pCqJMN3JmGunFKswNnR=J74+Z_m5Lj5WYT2Z1ZoPQ@mail.gmail.com>
	<20170715012551-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJP2DSo-khn+do0YG_ALDXrqBi6wEPH=m+W59rPfRTuiA@mail.gmail.com>
	<20170715023159-mutt-send-email-mst@kernel.org>
	<CAJ+F1C+F+HjHxzrq0usibfYUidpBW8DQUS72pDAv7xC6O14t3Q@mail.gmail.com>
	<20170726195844-mutt-send-email-mst@kernel.org>
	<CAJ+F1CLH6R7jfQNsTdeUyDB8JsNjvpK1eAcpviiLMwZtr07M_g@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <dba81848-4827-9491-e5cd-cba276527dfa@redhat.com>
Date: Fri, 28 Jul 2017 17:55:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLH6R7jfQNsTdeUyDB8JsNjvpK1eAcpviiLMwZtr07M_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/8] acpi: add vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Dave Anderson <anderson@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

On 07/28/17 16:52, Marc-Andr=C3=A9 Lureau wrote:
> Hi Dave
>=20
> On Wed, Jul 26, 2017 at 10:21 AM, Michael S. Tsirkin <mst@redhat.com> w=
rote:
>> On Sat, Jul 15, 2017 at 01:47:50AM +0200, Marc-Andr=C3=A9 Lureau wrote=
:
>>>>
>>>> There's more info scattered in other places.
>>>>
>>>> Why do you get to document it? Because you are the one exposing it
>>>> across the hypervisor/vm boundary where it will need to be
>>>> understood by people/tools not running within guest.
>>>>
>>>> So "just read the script in qemu source" is not how an interface
>>>> should be documented.
>>>
>>> I don't understand the issue, it's a kernel ELF note that qemu passes
>>> for dump/crash tools in the dump headers/sections.
>>
>> The way it looks to me, this patchset is exposing an internal kernel
>> detail and making it part of ABI maybe it already is, my point was 1.
>> should we get a confirmation from upstream it's not going to change? 2=
.
>> if it's ABI let's document what do we expect to be there.
>=20
>=20
> Could you help explain the expectations and stability guarantees of
> vmcoreinfo ELF note ?
>=20
> I am a bit stuck here, after all, vmcoreinfo is mostly used by crash
> so I thought you could help.
>=20
> The only thing qemu does with it is try to get NUMBER(phys_base)=3D
> field to update the phys_base used in the various dump headers. (this
> could be dropped, and qemu ignoring the note content, if the debug
> tools take vmcoreinfo values  with higher priority than other header
> fields)

I agree; if "crash" guarantees that the vmcoreinfo note will override
whatever phys_base value QEMU may have guessed otherwise (from other
places) and written to some dedicated phys_base header fields, then in
QEMU we don't have to propagate phys_base from the vmcoreinfo note to
said other fields -- we can treat the vmcoreinfo note entirely opaquely.

Thanks
Laszlo

>=20
>> But again since there's not a whole lot of documentation here
>> that you provided, I might be misunderstanding completely.
>=20
> Because there isn't much available in the kernel either, except
> Documentation/ABI/testing/sysfs-kernel-vmcoreinfo.
>=20
>=20

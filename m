Received: from eggs.gnu.org ([2001:4830:134:3::10]:36268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dW8om-0006Y8-5x
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 18:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dW8ok-0005Zn-Kz
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 18:12:12 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dW8ok-0005Xc-Bs
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 18:12:10 -0400
Received: by mail-lf0-x243.google.com with SMTP id f28so9068339lfi.3
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 15:12:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170714230852-mutt-send-email-mst@kernel.org>
References: <20170714182012.4595-1-marcandre.lureau@redhat.com>
	<20170714182012.4595-3-marcandre.lureau@redhat.com>
	<20170714222023-mutt-send-email-mst@kernel.org>
	<5d31f22d-e0ae-92f4-ea17-690419f72944@redhat.com>
	<20170714230852-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 15 Jul 2017 00:12:06 +0200
Message-ID: <CAJ+F1CJW1pCqJMN3JmGunFKswNnR=J74+Z_m5Lj5WYT2Z1ZoPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Dave Anderson <anderson@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

On Fri, Jul 14, 2017 at 10:17 PM, Michael S. Tsirkin <mst@redhat.com> wrote=
:
> On Fri, Jul 14, 2017 at 10:04:31PM +0200, Laszlo Ersek wrote:
>> > It worries me that the format of this seems completely undefined
>> > except in the patchset cover letter.
>> > I don't think we should merge this before it is.
>>
>> I'm not sure what you mean, this patch adds "docs/specs/vmcoreinfo.txt".
>> That file is the first level contract between the guest firmware
>> (generally, via the linker/loader), the guest kernel driver
>> (specifically), and QEMU (also specifically).
>>
>> The second level contract is the guest kernel's vmcoreinfo ELF note
>> (which is pointed-to by the first level contract). The layout of that is
>> specified elsewhere indeed (I don't think it belongs here).
>>
>> We've taken care not to trust anything coming from the guest kernel.
>>
>> Can you clarify please?
>>
>> Thanks
>> Laszlo
>
> All there is is this:
>
> +Version 0 content:
> +
> + uint64 paddr:
> +  Physical address of the Linux vmcoreinfo ELF note.
> + uint32 size:
> +  Size of the vmcoreinfo ELF note.
>
> It isn't defined here what is the Linux vmcoreinfo ELF note.
> You want a bit more info so people trying to use it know where to start
> and what they can get out of it.

QEMU is not responsible for the content of the ELF note. All there is afaik=
 is:

https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-kernel-vmcoreinf=
o

The rest you need to dig in the kernel code and git history I think.

--=20
Marc-Andr=C3=A9 Lureau

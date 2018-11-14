Received: from eggs.gnu.org ([2001:4830:134:3::10]:53904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMyT1-00064L-1E
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMySz-0007HM-4s
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:56:38 -0500
References: <20181114132931.22624-1-marcandre.lureau@redhat.com>
	<16b78816-f2cc-a1e5-0d21-906fc2dbaa3d@redhat.com>
	<a2d9a2fd-2c1a-66e3-86ba-17da9f564e79@redhat.com>
	<c0601dcb-142f-3033-b11f-1b951aaf0e3f@redhat.com>
	<CAFEAcA85vaAoo9wJLC25kF00MyPrAoTu_TSZ8NXxym8q7EhArQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3784d1ce-045a-59aa-bde2-7590f51196f0@redhat.com>
Date: Wed, 14 Nov 2018 17:56:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA85vaAoo9wJLC25kF00MyPrAoTu_TSZ8NXxym8q7EhArQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vmstate: constify VMStateField
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, "open list:S390" <qemu-s390x@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

On 2018-11-14 17:49, Peter Maydell wrote:
> On 14 November 2018 at 16:39, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
>> Hi Thomas,
>>
>> On 14/11/18 17:29, Thomas Huth wrote:
>>> Please don't. For rationale, see:
>>> https://www.kernel.org/doc/html/v4.19/process/coding-style.html#typed=
efs
>>
>>
>> Thanks for the pointer, I am interested in understanding why not do th=
at.
>> However in the link you pasted I don't see a rational about enforcing
>> constness, I understand that since this case doesn't match the 5 rules=
, we
>> should use 'struct VMStateField' directly and remove the typedef.
>=20
> QEMU's coding style is not the kernel's. In the kernel, yes,
> they prefer "struct foo". In QEMU we generally prefer to use
> a typedef for most structs.

Yes - my point was simply: Let's do not start to hide more things beside
"struct" in a typedef. If I look at QEMU source code containing just a
"VMStateField", I expect it to be a shortcut for "struct VMStateField".
I'd never expect that it also contains the "const" attribute. I'm pretty
sure that this would cause some confusion in the future otherwise.

 Thomas

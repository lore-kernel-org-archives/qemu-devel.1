Received: from eggs.gnu.org ([2001:4830:134:3::10]:51998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMyN0-0002Wq-9l
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:50:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMyMy-0002Eh-CF
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:50:26 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMyMw-0001rD-Hw
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:50:24 -0500
Received: by mail-oi1-x242.google.com with SMTP id a77so8232782oii.5
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 08:50:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c0601dcb-142f-3033-b11f-1b951aaf0e3f@redhat.com>
References: <20181114132931.22624-1-marcandre.lureau@redhat.com>
	<16b78816-f2cc-a1e5-0d21-906fc2dbaa3d@redhat.com>
	<a2d9a2fd-2c1a-66e3-86ba-17da9f564e79@redhat.com>
	<c0601dcb-142f-3033-b11f-1b951aaf0e3f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Nov 2018 16:49:51 +0000
Message-ID: <CAFEAcA85vaAoo9wJLC25kF00MyPrAoTu_TSZ8NXxym8q7EhArQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, "open list:S390" <qemu-s390x@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

On 14 November 2018 at 16:39, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> Hi Thomas,
>
> On 14/11/18 17:29, Thomas Huth wrote:
>> Please don't. For rationale, see:
>> https://www.kernel.org/doc/html/v4.19/process/coding-style.html#typedefs
>
>
> Thanks for the pointer, I am interested in understanding why not do that.
> However in the link you pasted I don't see a rational about enforcing
> constness, I understand that since this case doesn't match the 5 rules, w=
e
> should use 'struct VMStateField' directly and remove the typedef.

QEMU's coding style is not the kernel's. In the kernel, yes,
they prefer "struct foo". In QEMU we generally prefer to use
a typedef for most structs.

thanks
-- PMM

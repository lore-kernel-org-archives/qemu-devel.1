Received: from eggs.gnu.org ([2001:4830:134:3::10]:43230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fQnIa-00062V-V2
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 01:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fQnIZ-000697-NB
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 01:17:24 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:42078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1fQnIZ-00068d-HL
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 01:17:23 -0400
Received: by mail-ot0-x22d.google.com with SMTP id 92-v6so10036480otw.9
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 22:17:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e1a37ad1-07c4-3c7e-8714-e9263690c2f7@redhat.com>
References: <alpine.BSF.2.21.1806061909150.94568@zero.eik.bme.hu>
	<87muw768wq.fsf@dusky.pond.sub.org>
	<e1a37ad1-07c4-3c7e-8714-e9263690c2f7@redhat.com>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 7 Jun 2018 07:17:22 +0200
Message-ID: <CABoDooMh850mkexGvBp1Nd6baj7bGncAGVPVZhEAhXjPCVo72A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Stair step trace output since 12fb0ac05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, Patryk Olszewski <patryk@fala.ehost.pl>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, Jun 7, 2018 at 6:56 AM, Thomas Huth <thuth@redhat.com> wrote:
> On 06.06.2018 20:56, Markus Armbruster wrote:
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>
>>> Hello,
>>>
>>> Since 12fb0ac05 (char: Remove unwanted crlf conversion) trace output
>>> is printed in stair steps when using -trace and -serial stdio
>>> together. E.g.
>>> $ qemu-system-i386 -trace 'pci*' -serial stdio
>>>
>>> Regards,
>>> BALATON Zoltan
>>
>> I cc'ed the people involved with this patch for you.
>
> Is it OK if you revert the change to chardev/char-stdio.c, but not
> chardev/char-serial.c ?

That's what I did, and it was enough to fix the issues I had.

Thanks,

Laurent

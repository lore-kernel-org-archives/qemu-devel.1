Received: from eggs.gnu.org ([2001:4830:134:3::10]:50550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYA6f-0007EK-Kt
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYA6Z-0000ig-Ga
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:03:33 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYA6Z-0000gW-0d
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:03:27 -0400
Received: by mail-wm0-x242.google.com with SMTP id u18-v6so5441435wmc.1
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 06:03:26 -0700 (PDT)
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
	<6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
	<20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
	<0df8a05c-43fc-6e85-b13c-d3f5c4691964@redhat.com>
	<87fu18ach6.fsf_-_@dusky.pond.sub.org>
	<20180627110923.GG30628@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180627110923.GG30628@redhat.com>
Date: Wed, 27 Jun 2018 14:03:24 +0100
Message-ID: <87d0wcwfdv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Drop support for 32bit hosts in qemu? (was: [PULL
 1/6] audio/hda: create millisecond timers that handle IO)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Martin Schrodt <martin@schrodt.org>, Thomas Huth <thuth@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jun 27, 2018 at 09:57:09AM +0200, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>
>> > On 27.06.2018 08:51, Gerd Hoffmann wrote:
>> [...]
>> >> Drop support for 32bit hosts in qemu?
>> >
>> > I guess the only way to answer that question reliably is to send a pat=
ch
>> > to mark 32-bit hosts as deprecated...
>> >
>> > Anyway, you still have got to fix that problem with -m32 now somehow
>> > since we certainly can not drop 32-bit immediately.
>>
>> We certainly can if we want to.
>>
>> Our formal deprecation policy codifies our compromise between the need
>> to evolve QEMU and the need of its users for stable external interfaces.
>>
>> "Compiles on host X" is also a need, but it's a different one.
>> Evidence: "Supported build platforms" has its own appendix, separate
>> from "Deprecated features".  It's mum on 32-bit hosts.
>
> It is silent on host architecture coverage in general in fact. It was
> only really focusing on operating systems and so any arch coverage is
> at best inferred from what those OS target. Fedora covers 32-bit & 64-bit
> arches for example, so you could take that to imply we need to support
> both in QEMU.
>
> It is fuzzier though because while Peter has good OS coverage for his
> merge testing, I don't think he has full host arch coverage for everything
> that downstreams expect QEMU to build on ?

We do however have cross build infrastructure for all tcg/foo backends.
They are run by the shippable CI framework (which is how I noticed):

  https://app.shippable.com/github/qemu/qemu/runs?branchName=3Dmaster

Once we have the changes made to the wiki I'd like to use:

  https://wiki.qemu.org/Template:CIStatus

In a few choice places on the wiki, including the front page, for better
visibility.

>> I'm not saying we *should* drop 32-bit hosts immediately.  Only that the
>> feature deprecation policy does not apply.
>>
>> Is QEMU still useful on 32-bit hosts?  Honest question!
>
> That answer varies depending on what you're using QEMU for I think. It
> could be that people see tools like qemu-img/qemu-nbd as useful even
> if they don't use system emulators. And of course userspace emulators
> are enough distinct use case.
>
> IMHO as long as distros are shipping 32-bit support, it is reasonable
> to assume there will be people who find QEMU useful to some degree.
>
> Personally I don't have any need for 32-bit hosts, but clearly some
> people do since otherwise distros would  have killed their 32-bit
> arches already.

I know of at least one kernel developer who uses qemu-system-aarch64 on
their 32 bit ARM Chromebook to test their 64 bit code. Next time I see
them I'll see if they are still using it.

My feeling is although probably not widespread it certainly can be handy.

>
> Regards,
> Daniel


--
Alex Benn=C3=A9e

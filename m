Received: from eggs.gnu.org ([2001:4830:134:3::10]:51062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEIPW-0005OI-JL
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEIPT-0007Rj-Er
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:16:06 -0500
Received: from mail-ua0-f170.google.com ([209.85.217.170]:35517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cEIPT-0007Qx-9b
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:16:03 -0500
Received: by mail-ua0-f170.google.com with SMTP id 12so386327036uas.2
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 08:16:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161206155116.66f397be@squid.athome>
References: <1478194258-75276-1-git-send-email-julian@codesourcery.com>
	<1478194258-75276-2-git-send-email-julian@codesourcery.com>
	<CAFEAcA_Z88S+mMRjMzJg+iOx6t4_hwEsEYVuYBWgk6JJL2UEhg@mail.gmail.com>
	<20161206151130.204280f0@squid.athome>
	<CAFEAcA_-6tWPmeXGVajJeG_SkWWUdYXoH-gubZikm0aNrUJcBg@mail.gmail.com>
	<20161206155116.66f397be@squid.athome>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Dec 2016 16:14:41 +0000
Message-ID: <CAFEAcA9RE-FPJGgMmrM-7-Qdkcz2STKE_C2ifmyB7mobfkwh7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/5] ARM BE8/BE32 semihosting and gdbstub
 support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 6 December 2016 at 15:51, Julian Brown <julian@codesourcery.com> wrote:
> On Tue, 6 Dec 2016 15:44:07 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> On 6 December 2016 at 15:11, Julian Brown <julian@codesourcery.com>
>> wrote:
>> > On Thu, 3 Nov 2016 22:23:09 +0000
>> > Peter Maydell <peter.maydell@linaro.org> wrote:
>> >
>> >> Strong 'no' for the approach of having different CPU
>> >> names, I'm afraid. What you want is to have a CPU
>> >> property which works like the hardware CPU's CFGEND
>> >> signal to set the reset value of the SCTLR.EE bit. Then
>> >> a board can use that where it would wire up CFGEND
>> >> in real hardware, and on the command line you can
>> >> have -cpu whatever,cfgend=yes (which is a bit ugly
>> >> but then it's borderline whether it makes any sense at
>> >> all for the user to be able to set the endianness on
>> >> the commandline).
>> >
>> > How about something like this?
>>
>> Could you send that as an inline patch rather than
>> an attachment? Patches hidden in attachments are kind
>> of painful to deal with.
>
> Does this work? Sorry, sending replies direct from git is the level
> past the one I've got to so far :-).

Yes, this works; it's probably easiest to just send a v2
of the patchset, though, since I notice you sent followups
with patches to most of the original patch emails.

This patch looks like it's trying to do too many
things at once; "add property which allows config of the
SCTLR.EE reset value" should definitely be its own patch,
and there may be other useful things that could be split
out of it.

thanks
-- PMM

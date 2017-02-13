Received: from eggs.gnu.org ([2001:4830:134:3::10]:32913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdHdB-0000eX-1P
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:29:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdHd8-0005cO-DE
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:29:29 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:38431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cdHd8-0005bs-5A
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:29:26 -0500
Received: by mail-wm0-x22a.google.com with SMTP id r141so95344650wmg.1
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 06:29:26 -0800 (PST)
References: <CAJSP0QWGcG9bTZZr22BEj-P_G2r4UhmNwGSfwSnwjZeTC687GQ@mail.gmail.com>
	<CAFEAcA_OJWrknC+YSsbjgcv=YtMq5GY04EcyXZt+V8eBH5TSWw@mail.gmail.com>
	<e5673883-cd68-7d4a-01fc-394c506b18a9@redhat.com>
	<CAFEAcA8zSZ8S09APwV8SGy3oHeiutY1j+LSSP327hyZLFfDURw@mail.gmail.com>
	<DM5PR03MB2827878B91C80E6DA61C56589E450@DM5PR03MB2827.namprd03.prod.outlook.com>
	<CAFEAcA_zXQOBWqOmyH-_RA5pcREutKPUZAOm-OBuCExp-nMSGw@mail.gmail.com>
	<20170213134637.GC10361@stefanha-x1.localdomain>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170213134637.GC10361@stefanha-x1.localdomain>
Date: Mon, 13 Feb 2017 14:29:42 +0000
Message-ID: <87k28uupt5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Call for GSoC 2017 mentors & project ideas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>


Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Thu, Feb 09, 2017 at 10:17:45PM +0000, Peter Maydell wrote:
>> On 9 February 2017 at 22:12, Andrew Baumann
>> <Andrew.Baumann@microsoft.com> wrote:
>> >> From: Peter Maydell [mailto:peter.maydell@linaro.org]
>> >> Sent: Thursday, 9 February 2017 14:02
>> >> On 9 February 2017 at 20:46, John Snow <jsnow@redhat.com> wrote:
>> >> > On 02/09/2017 07:46 AM, Peter Maydell wrote:
>> >> >> Slightly late, but I had an idea last night: would "get
>> >> >> Raspbian booting on our raspi2 board model" be a good
>> >> >> project? Would involve some mix of bug fixing, cleaning
>> >> >> up and adding device models from the raspi2 tree on github,
>> >> >> and implementing missing devices. Bit of a "how long is a
>> >> >> piece of string" project, but on the other hand breaks
>> >> >> down easily into small parts that can all go upstream
>> >> >> individually. Would suit student who likes debugging :-)
>> >>
>> >> > Who was working on this most recently? There was someone submitting
>> >> > patches pretty frequently for the raspi2 board within the last year,
>> >> > wasn't there?
>> >>
>> >> That was Andrew Baumann, but I think his use case was
>> >> getting Windows 10 to boot on it, which exercises
>> >> different bits of the hardware.
>> >
>> > That's right, but I thought we also had Raspbian working after
>> > Peter C's implementation of SETEND. (I wouldn't be surprised if
>> > it had regressed, however.)
>>
>> For the raspbian kernel image I had it never worked -- I
>> think the kernel gained some new functionality that means
>> it now touches some device we don't yet implement (vague
>> recollection it was somethnig message-box related?).

There are RNG related patches on the list at the moment.

>>
>> > I've dropped the ball on this, and don't forsee finding time
>> > for it in the immediate future, but if anyone wants to work
>> > on it there are still some outstanding bits of emulation
>> > lurking in my github tree (github.com/0xabu/qemu)
>>
>> Yeah, I figured that was probably the situation, and I
>> don't personally have the time to do it either; but
>> it seemed like maybe it would make a GSoC project.
>
> It sounds like this can be broken down into tasks by a mentor willing to
> participate and knowledgable (or willing to do the homework) on device
> support status.
>
> Are there any volunteers?

I'd be happy to help mentor if needed. I guess it will depend of anyone
picks the project up?

>
> This would be a great project to have on board.
>
> Stefan


--
Alex Bennée

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYDTd-0001mp-BT
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYDTY-0000My-An
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:02:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cYDTY-0000MY-2f
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:02:36 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <mailman.205.1485450031.31314.qemu-devel@nongnu.org>
	<E8A8BF62-0E39-4401-B330-2E27CFA3A83F@gmail.com>
	<8ae107ad-0f3f-46ef-e734-2f88b14bad9a@redhat.com>
	<265EAA01-0C75-45D5-A55D-481DAC288AE5@gmail.com>
	<d95139a6-0e38-75b5-b8df-b4e12391e032@redhat.com>
	<CAFEAcA9N41fGAuVScUXOMorKHmvzzOoNKppEP6eniQEivVT_jg@mail.gmail.com>
	<87wpdh9er8.fsf@dusky.pond.sub.org>
	<CAFEAcA8zGt-HUjEgVTdCvGhhqHqxWDO4_FrCyxRX1UVFycT0MQ@mail.gmail.com>
	<20170130142157.GK2118@stefanha-x1.localdomain>
Date: Mon, 30 Jan 2017 16:02:33 +0100
In-Reply-To: <20170130142157.GK2118@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Mon, 30 Jan 2017 14:21:57 +0000")
Message-ID: <87tw8gmvzq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Qemu-devel] Poll on QEMU documentation project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, G 3 <programmingkidx@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Fri, Jan 27, 2017 at 10:08:49AM +0000, Peter Maydell wrote:
>> On 27 January 2017 at 06:51, Markus Armbruster <armbru@redhat.com> wrote:
>> > "What can we cut" is the wrong question.  The right one is "what are our
>> > requirements".  Here's my try:
>> >
>> > HTML: required
>> > nroff with an macros: required
>> > PDF: wanted (try printing a website)
>> > plain text: nice to have (for me personally, more than that)
>> > info: nice to have
>> >
>> > If a solution we like can't provide something that's nice to have, we
>> > can decide to take it anyway.
>> >
>> > If a solution we like can provide something that's nice to have, we
>> > should let it provide, unless it turns out to be a drag.
>> 
>> Well, every extra documentation format:
>>  * increases the build time

Yes.  The increase can range from "lost in the noise" through "painful"
to "prohibitive".  The more pain, the more gain we need to show to
justify.

Right now, documentation formatting is a drop in the compilation time
bucket.

>>  * increases the chances of makefile bugs

Yes.  Those can be a pain to debug, such as when you don't realize it's
a Makefile bug (instead of say a long-obsolete version of a tool playing
tricks on you on a platform you can't access).

Fortunately, such bugs get created mostly when we're messing with the
doc toolchain, which should be rare.

Right now, documentation formatting is a drop in the Makefile complexity
bucket.

>>  * may require extra tooling to produce

Again, the more pain, the more gain we need to show.

Right now, our build requirements for documentation are a drop in the
build requirements bucket on Linux.  Can't judge other hosts.

>>  * either requires us to check it for problems or increases
>>    the chance of confusing users because that output format
>>    has a formatting problem that doesn't happen in the doc
>>    formats most people use

Yes, formatting issues specific to the output format are possible.
Probably more likely when producing it involves options or tools that
aren't in common use.

>>  * may require significant extra work to produce something
>>    that's actually useful: a manpage and an info doc aren't
>>    just the same content in a different file format, they
>>    should have definitely different contents and structure
>>    to fit what people expect a manpage or an info doc to be

Yes, but isn't that a solved problem for us?

Any proposal that "unsolves" it needs to justify the pain by showing
commensurate gain.

>> So my list is:
>>  * HTML: required
>>  * PDF: nice-to-have
>
> We also need to produce man pages for the command-line tools.

That's what I meant by "nroff with an macros".  Hard requirement.

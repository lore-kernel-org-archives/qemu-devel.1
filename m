Received: from eggs.gnu.org ([2001:4830:134:3::10]:56452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cX0O9-0005GS-MT
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 01:52:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cX0O6-0003Q2-JA
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 01:52:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cX0O6-0003Pj-DA
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 01:51:58 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <mailman.205.1485450031.31314.qemu-devel@nongnu.org>
	<E8A8BF62-0E39-4401-B330-2E27CFA3A83F@gmail.com>
	<8ae107ad-0f3f-46ef-e734-2f88b14bad9a@redhat.com>
	<265EAA01-0C75-45D5-A55D-481DAC288AE5@gmail.com>
	<d95139a6-0e38-75b5-b8df-b4e12391e032@redhat.com>
	<CAFEAcA9N41fGAuVScUXOMorKHmvzzOoNKppEP6eniQEivVT_jg@mail.gmail.com>
Date: Fri, 27 Jan 2017 07:51:55 +0100
In-Reply-To: <CAFEAcA9N41fGAuVScUXOMorKHmvzzOoNKppEP6eniQEivVT_jg@mail.gmail.com>
	(Peter Maydell's message of "Thu, 26 Jan 2017 17:57:10 +0000")
Message-ID: <87wpdh9er8.fsf@dusky.pond.sub.org>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, G 3 <programmingkidx@gmail.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 26 January 2017 at 17:52, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> - HTML is mostly a destination format.  With the listed formats it is
>> possible to produce a variety of outputs (mostly HTML itself and PDF;
>> secondarily text or ePub or others).
>
> It's an interesting question to ask what destination formats
> we should be generating, though. At the moment we output
> HTML, plain text, PDF and info. Personally I think that list
> is too long and we should probably cut it down to HTML
> and PDF or perhaps even just HTML.

"What can we cut" is the wrong question.  The right one is "what are our
requirements".  Here's my try:

HTML: required
nroff with an macros: required
PDF: wanted (try printing a website)
plain text: nice to have (for me personally, more than that)
info: nice to have

If a solution we like can't provide something that's nice to have, we
can decide to take it anyway.

If a solution we like can provide something that's nice to have, we
should let it provide, unless it turns out to be a drag.

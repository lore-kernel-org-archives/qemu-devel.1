Received: from eggs.gnu.org ([2001:4830:134:3::10]:43411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX3Sx-00069X-Bg
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX3Sw-0001KX-Du
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:09:11 -0500
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:34192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cX3Sw-0001Jl-8X
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:09:10 -0500
Received: by mail-ua0-x236.google.com with SMTP id 35so201574658uak.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 02:09:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87wpdh9er8.fsf@dusky.pond.sub.org>
References: <mailman.205.1485450031.31314.qemu-devel@nongnu.org>
	<E8A8BF62-0E39-4401-B330-2E27CFA3A83F@gmail.com>
	<8ae107ad-0f3f-46ef-e734-2f88b14bad9a@redhat.com>
	<265EAA01-0C75-45D5-A55D-481DAC288AE5@gmail.com>
	<d95139a6-0e38-75b5-b8df-b4e12391e032@redhat.com>
	<CAFEAcA9N41fGAuVScUXOMorKHmvzzOoNKppEP6eniQEivVT_jg@mail.gmail.com>
	<87wpdh9er8.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 10:08:49 +0000
Message-ID: <CAFEAcA8zGt-HUjEgVTdCvGhhqHqxWDO4_FrCyxRX1UVFycT0MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Qemu-devel] Poll on QEMU documentation project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, G 3 <programmingkidx@gmail.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 27 January 2017 at 06:51, Markus Armbruster <armbru@redhat.com> wrote:
> "What can we cut" is the wrong question.  The right one is "what are our
> requirements".  Here's my try:
>
> HTML: required
> nroff with an macros: required
> PDF: wanted (try printing a website)
> plain text: nice to have (for me personally, more than that)
> info: nice to have
>
> If a solution we like can't provide something that's nice to have, we
> can decide to take it anyway.
>
> If a solution we like can provide something that's nice to have, we
> should let it provide, unless it turns out to be a drag.

Well, every extra documentation format:
 * increases the build time
 * increases the chances of makefile bugs
 * may require extra tooling to produce
 * either requires us to check it for problems or increases
   the chance of confusing users because that output format
   has a formatting problem that doesn't happen in the doc
   formats most people use
 * may require significant extra work to produce something
   that's actually useful: a manpage and an info doc aren't
   just the same content in a different file format, they
   should have definitely different contents and structure
   to fit what people expect a manpage or an info doc to be

So my list is:
 * HTML: required
 * PDF: nice-to-have

thanks
-- PMM

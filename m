Received: from eggs.gnu.org ([2001:4830:134:3::10]:33130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eKqb4-0006lC-6f
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:03:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eKqb3-0007kV-9g
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:03:38 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:41630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eKqb3-0007kA-3t
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:03:37 -0500
Received: by mail-ot0-x234.google.com with SMTP id b54so9869714otd.8
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 11:03:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f67de9f9-dfe6-ae9a-d2ea-b4ae5e309757@redhat.com>
References: <20171129035502.GD8889@lemon>
	<20171129120018.GB2601@stefanha-x1.localdomain>
	<20171130094709.GA20286@lemon>
	<20171130141954.GC14748@stefanha-x1.localdomain>
	<20171201101644.GB11092@lemon>
	<20171201140833.GB12803@stefanha-x1.localdomain>
	<f67de9f9-dfe6-ae9a-d2ea-b4ae5e309757@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Dec 2017 19:03:15 +0000
Message-ID: <CAFEAcA_9wnMkJ+BHjrU8Eb_0vQMK-cYyxtgtsoFN2OWpSHbsCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Block layer complexity: what to do to keep it
 under control?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 1 December 2017 at 17:03, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Same here.  Just like fixing the C code provides a good foundation for a
> language switch, some more battle-tested code could be converted from
> QEMU to Rust, in order to get familiar with it and probe whether the
> benefits are real.  Maybe the memory API could be a good candidate; it
> certainly would benefit from generics.

At the moment I feel like betting the future of the project on
Rust would be quite a courageous decision. On the other hand
it might be interesting to look at prototyping to see what
benefits it might bring. (One candidate I had in mind was the
device API -- given that we have had quite a few buffer overruns
in device code, converting some of the device models to Rust
might cut off that particular security issue.)

I agree with you that trying to tackle conversion without at
least one developer with reasonably-expert Rust knowledge is
likely to be fraught, though -- what you really need is to be
able to design APIs which are idiomatic for the language, rather
than the kind of thing you'd write in C but transliterated across...

thanks
-- PMM

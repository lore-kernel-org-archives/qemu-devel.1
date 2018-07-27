Received: from eggs.gnu.org ([2001:4830:134:3::10]:45167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fj2br-00055k-2i
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fj2bq-000054-4A
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:16:43 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:33596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fj2bp-0008Vy-Km
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:16:42 -0400
Received: by mail-oi0-x22b.google.com with SMTP id l10-v6so8978697oii.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 06:16:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180727130317.GE28555@stefanha-x1.localdomain>
References: <20180717195028.GA6691@localhost.localdomain>
	<CAFEAcA-pPsvfn7ARu_pn0HH03rZh05fLP=wr+p=hx5douSf7vA@mail.gmail.com>
	<87a7qnk9qa.fsf@dusky.pond.sub.org>
	<20180727130317.GE28555@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jul 2018 14:16:18 +0100
Message-ID: <CAFEAcA93LZ5Mw9o5xbDL_H=+aNhfSiSB_LWQ7qYf9YgYbZJuAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Why do we typedef every struct on QEMU?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 27 July 2018 at 14:03, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Thu, Jul 19, 2018 at 08:42:05AM +0200, Markus Armbruster wrote:
>> That the code shows anything resembling consistency at all is a
>> testament to humanity's yearning for order within a chaotic world.
>
> Going back to something concrete after this nice philosophical musing:
>
> The coding style checker (checkpatch.pl) seems like a huge success to
> me.  Without it, achieving consistency is futile.
>
> checkpatch.pl defines the true coding style of QEMU - the subset that
> can be automatically checked by patchew.  If we want to follow a coding
> style, implementing the rules in checkpatch.pl is important.

I think that overall if you look at QEMU's code we have a lot of
consistency in that we follow the common "open source Unix C code"
coding style. For instance if you look at:

static BOOL GetSystemName(
    const void *pvSystemStore,
    DWORD dwFlags,
    PENUM_ARG pEnumArg,
    LPCWSTR *ppwszSystemName ) {

you probably recognize immediately that it's Windows style,
and we don't require checkpatch to avoid code that is that
sharply divergent from the cultural norm.

CODING_STYLE has a lot of nitpicky stuff because we mostly
disagree about the edge cases rather than the core things, I think.

thanks
-- PMM

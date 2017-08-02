Received: from eggs.gnu.org ([2001:4830:134:3::10]:40429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcrXx-0007K1-Th
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 07:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcrXw-0006oO-Qj
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 07:10:37 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dcrXw-0006nl-I6
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 07:10:36 -0400
Received: by mail-wm0-x236.google.com with SMTP id m85so38442037wma.1
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 04:10:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170802110400.GI5531@stefanha-x1.localdomain>
References: <CAFEAcA8oyHi+7NVCE8YWHY+v0UXLbt2tWHGE4AP_V8TtDBc89g@mail.gmail.com>
	<20170727152137.GW2555@redhat.com>
	<CAFEAcA-eH7J+fFXYgFo6Wx58zgD8=kqhrGE5BqR+NrhHjipsFw@mail.gmail.com>
	<20170727154535.GY2555@redhat.com>
	<20170728133430.GS12364@stefanha-x1.localdomain>
	<CAFEAcA9p38P2x3s4grvFPkGaH+JEmwqyAC9SsLWqqFL8k+Eiww@mail.gmail.com>
	<20170728140623.GQ31495@redhat.com> <87vamclf6w.fsf@frigg.lan>
	<20170801134825.GC22017@stefanha-x1.localdomain>
	<CAFEAcA9KKqyiNfsfjSDVhhE7hMMsAZ==TuSjgtqb6pB=fVF+_w@mail.gmail.com>
	<20170802110400.GI5531@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Aug 2017 12:10:14 +0100
Message-ID: <CAFEAcA82EBmOF3k=fXN4tAAL2=J6s8avUoQGXKrBwchh1rmMCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/13] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>, Alessandro Di Federico <ale+qemu@clearmind.me>, "Daniel P. Berrange" <berrange@redhat.com>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>

On 2 August 2017 at 12:04, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Tue, Aug 01, 2017 at 02:54:29PM +0100, Peter Maydell wrote:
>> and I don't need the TCG engine to be a library to do that...
>
> You do need TCG APIs if you want TCG-level instrumentation, tuning
> options, callbacks, etc.

I need an API; that doesn't necessarily look like the kind
of API you want to be able to embed the TCG engine into
other things, I think.

>> I agree that we want to provide something that is at least
>> closer to a stable API than "just expose trace events",
>> though.
>
> libqemu has at least three parts:
>
> 1. VM API (i.e. qemu_init(argc, argv), qemu_run(), qemu_vcpu_get_reg32())
> 2. TCG engine
> 3. Device models
>
> Like I said in my email, start with what matters for the instrumentation
> use case (VM API at a minimum to control guest execution).  Other people
> can flesh out the other parts later, as needed.
>
> Other attempts to provide a stable API will be essentially the same
> thing as libqemu.

I don't think this is the case -- you could have a stable
instrumentation API without it looking anything like
libqemu. In particular I don't think you need to have
something that sits at the top level and says 'run'.

In particular I think that pulling TCG out of QEMU
is an enormous and painful undertaking that you just
don't need to do at all to allow this kind of
instrumentation API.

thanks
-- PMM

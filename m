Received: from eggs.gnu.org ([2001:4830:134:3::10]:34007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcXdM-0000co-9v
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcXdL-0000em-CV
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:54:52 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dcXdL-0000df-3t
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:54:51 -0400
Received: by mail-wr0-x235.google.com with SMTP id k71so7199623wrc.2
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 06:54:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170801134825.GC22017@stefanha-x1.localdomain>
References: <CAFEAcA_pXX6ZCsBwAQnzQbTSbxzAh=nFpPeEzZoRBhBDt2r+vA@mail.gmail.com>
	<20170727104302.GI2555@redhat.com>
	<CAFEAcA8oyHi+7NVCE8YWHY+v0UXLbt2tWHGE4AP_V8TtDBc89g@mail.gmail.com>
	<20170727152137.GW2555@redhat.com>
	<CAFEAcA-eH7J+fFXYgFo6Wx58zgD8=kqhrGE5BqR+NrhHjipsFw@mail.gmail.com>
	<20170727154535.GY2555@redhat.com>
	<20170728133430.GS12364@stefanha-x1.localdomain>
	<CAFEAcA9p38P2x3s4grvFPkGaH+JEmwqyAC9SsLWqqFL8k+Eiww@mail.gmail.com>
	<20170728140623.GQ31495@redhat.com> <87vamclf6w.fsf@frigg.lan>
	<20170801134825.GC22017@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Aug 2017 14:54:29 +0100
Message-ID: <CAFEAcA9KKqyiNfsfjSDVhhE7hMMsAZ==TuSjgtqb6pB=fVF+_w@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>, Alessandro Di Federico <ale+qemu@clearmind.me>, "Daniel P. Berrange" <berrange@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 1 August 2017 at 14:48, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> Thanks for sharing the requirements.  A stable API is necessary for
> providing these features.
>
> We're essentially talking about libqemu.  That means QEMU in library
> form with an API for JIT engine, reverse engineering, instrumentation,
> etc tasks.

> Maintaining libqemu will take ongoing effort and no one has committed.
> The last discussion about libqemu was here:
> https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg04847.html

That thread seems to be focused on trying to extract TCG
from the rest of QEMU, which definitely isn't a requirement
for instrumentation, and I would suggest is something
of a distraction from it. I want to be able to say "just
instrument this setup that QEMU already provides as a
board model", not have to write a driver that duplicates
all the work vl.c and our board models do for us today,
and I don't need the TCG engine to be a library to do that...

I agree that we want to provide something that is at least
closer to a stable API than "just expose trace events",
though.

thanks
-- PMM

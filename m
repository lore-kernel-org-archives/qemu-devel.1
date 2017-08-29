Received: from eggs.gnu.org ([2001:4830:134:3::10]:50722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dmcgJ-000564-Lx
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dmcgI-0002TH-P6
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:19:35 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dmcgI-0002Rf-Fr
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:19:34 -0400
Received: by mail-wr0-x230.google.com with SMTP id j29so7381063wre.2
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 02:19:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170826000232.GB29654@flamenco>
References: <CAFEAcA_pXX6ZCsBwAQnzQbTSbxzAh=nFpPeEzZoRBhBDt2r+vA@mail.gmail.com>
	<20170727104302.GI2555@redhat.com>
	<CAFEAcA8oyHi+7NVCE8YWHY+v0UXLbt2tWHGE4AP_V8TtDBc89g@mail.gmail.com>
	<20170727152137.GW2555@redhat.com>
	<CAFEAcA-eH7J+fFXYgFo6Wx58zgD8=kqhrGE5BqR+NrhHjipsFw@mail.gmail.com>
	<20170727154535.GY2555@redhat.com>
	<20170728133430.GS12364@stefanha-x1.localdomain>
	<CAFEAcA9p38P2x3s4grvFPkGaH+JEmwqyAC9SsLWqqFL8k+Eiww@mail.gmail.com>
	<20170728140623.GQ31495@redhat.com> <87vamclf6w.fsf@frigg.lan>
	<20170826000232.GB29654@flamenco>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2017 10:19:11 +0100
Message-ID: <CAFEAcA9UzR_HSHxP+mXPPH-ghzruaWW4SzWmDpni0RrdNGc4xw@mail.gmail.com>
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 26 August 2017 at 01:02, Emilio G. Cota <cota@braap.org> wrote:
> An additional "nice to have" would be:
>
> * Allow inlining of TCG code by the instrumenter. Example use case:
>   the instrumenter wants to increment a counter every time a
>   basic block is executed. Instead of calling a callback function on every block's
>   execution, we could just have a translation-time callback to emit at the beginning
>   of the translated block the counter increment. This would be much faster, and
>   is something that all other tools (e.g. DynamoRIO/Pin) implement.

This is a feature I would strongly prefer us not to implement.
It exposes too much of QEMU's internals (ie TCG) to the
instrumentation, and it would be pretty complicated to use.

thanks
-- PMM

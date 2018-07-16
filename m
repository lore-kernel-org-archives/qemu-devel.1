Received: from eggs.gnu.org ([2001:4830:134:3::10]:43862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffAJK-0005vT-EC
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 16:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffAJJ-000077-NS
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 16:41:34 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffAJJ-00006l-Hm
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 16:41:33 -0400
Received: by mail-oi0-x242.google.com with SMTP id s198-v6so77383892oih.11
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 13:41:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180716195851.0FE177456B7@zero.eik.bme.hu>
References: <20180716195851.0FE177456B7@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 21:41:12 +0100
Message-ID: <CAFEAcA-Lu=gZWQOROa+oEwaWP8FWSY__=jneDQZVK=mFXAcFMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Do not enable QOM debugging by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 16 July 2018 at 20:47, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Commit 3556c233d 5 years ago added an option to disable QOM debugging,
> noting that it can have high performance cost but left the default to on.
> Change the default to off and only enable it when debugging is requested
> to avoid the performance penalty for those compiling without debug options.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Looking at the code, doesn't this disable all the type checking
on the QOM casts? That is not something I think we should drop,
in the same way that we do not disable assert()s even in the
non-debug build.

Is this coming up as significant in profiling? In the past we've
done some special casing if there are particular QOM casts in
hot paths that use significant runtime.

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHApH-0004a4-3m
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHApB-0007WQ-Fz
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:51:07 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:46409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHApB-0007Vp-9A
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:51:01 -0500
Received: by mail-ot0-x232.google.com with SMTP id j29so10889106oth.13
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 07:51:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171121142538.22072-1-berrange@redhat.com>
References: <20171121142538.22072-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 15:50:39 +0000
Message-ID: <CAFEAcA8BQFsaQG0_KkcnAK67BSt6uwOeSH=nCarTiW42GBsOgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] build: disarm the TCG unit test trap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 November 2017 at 14:25, Daniel P. Berrange <berrange@redhat.com> wrote:
> Developers sometimes mistakenly run 'make test' instead of 'make check'.
> 'make test' triggers the ancient, unmaintained tcg unit tests in
> tests/tcg/Makefile which have long since ceased compiling.
>
> Even if someone fixes the TCG tests, it makes little sense to put
> them in a 'make test' target, rather they should be 'make check-tcg',
> possibly wired up as a dependency of 'make check'.
>
> In the meantime, this patch disarms the 'make test' trap by simply
> deleting it so users get an immediate error. This should be enough
> for them to remember to type 'make check' instead (or 'make help'
> to learn). It also deletes 'make speed' which is another route
> into the tcg tests.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>

Applied to master, thanks (will be nice to stop having to
tell people about this one :-))

-- PMM

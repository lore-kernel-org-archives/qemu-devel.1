Received: from eggs.gnu.org ([2001:4830:134:3::10]:41413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gEuim-0007te-0i
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gEuik-0003oS-4E
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:19:35 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:41328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gEuic-0003fR-9y
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:19:30 -0400
Received: by mail-oi1-x229.google.com with SMTP id l197-v6so759134oib.8
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 04:19:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181022181623.8810-1-richard.henderson@linaro.org>
References: <20181022181623.8810-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Oct 2018 12:19:00 +0100
Message-ID: <CAFEAcA9jwS+6rzrP-PFOgd1FGKojKT6_HAZ470MwhQwLSQnGsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH, build fix] osdep: Work around MinGW assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 October 2018 at 19:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
> In several places we use assert(FEATURE), and assume that if FEATURE
> is disabled, all following code is removed as unreachable.  Which allows
> us to compile-out functions that are only present with FEATURE, and
> have a link-time failure if the functions remain used.
>
> MinGW does not mark its internal function _assert() as noreturn, so the
> compiler cannot see when code is unreachable, which leads to link errors
> for this host that are not present elsewhere.
>
> The current build-time failure concerns 62823083b8a2, but I remember
> having seen this same error before.  Fix it once and for all for MinGW.
>

Applied to master (with the typo fixed), thanks.

-- PMM

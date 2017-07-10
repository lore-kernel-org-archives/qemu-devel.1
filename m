Received: from eggs.gnu.org ([2001:4830:134:3::10]:37977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUZn2-0003vO-OM
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUZn1-0001Ie-UT
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:35:56 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUZn1-0001IA-Mu
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:35:55 -0400
Received: by mail-wr0-x234.google.com with SMTP id r103so141570008wrb.0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 07:35:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170710142850.10468-1-alex.bennee@linaro.org>
References: <20170710142850.10468-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2017 15:35:34 +0100
Message-ID: <CAFEAcA-eLe6b-0pKkoam1TBQD680W0nunARrSFxQTgUkoqug+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] include/exec/cpu-defs.h: try and make
 SoftMMU page size match target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Pranith Kumar <bobby.prani@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On 10 July 2017 at 15:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> While the SoftMMU is not emulating the target MMU of a system there is
> a relationship between its page size and that of the target. If the
> target MMU is full featured the functions called to re-fill the
> entries in the SoftMMU entries start moving up the perf profiles. If
> we can we should try and prevent too much thrashing around by having
> the page sizes the same.
>
> Ideally we should use TARGET_PAGE_BITS_MIN but that potentially
> involves a fair bit of #include re-jigging so I went for 10 bits (1k
> pages) which I think is the smallest of all our emulated systems.

The figures certainly show an improvement, but it's not clear
to me why this is related to the target's page size rather than
just being a "bigger is better" kind of thing?

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eALY7-0003IA-IE
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 15:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eALY6-0001fU-Li
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 15:53:11 -0400
Date: Thu, 2 Nov 2017 15:53:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171102195303.GA25452@flamenco>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
	<4ab3bd81-925c-a281-614c-2cd87fce38b5@redhat.com>
	<20171101203620.GA17963@flamenco>
	<CAFEAcA-CX90dLbR8ypEidniFmORRZ8u7Pzc3fcaKJSeF9zTK1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-CX90dLbR8ypEidniFmORRZ8u7Pzc3fcaKJSeF9zTK1A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/51] tcg queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Thu, Nov 02, 2017 at 13:38:07 +0000, Peter Maydell wrote:
> Maybe we should allow machine models to specify:
>  * max_cpus (the most they can support; 1 if not set by board,
>    as in current code)
>  * min_cpus (the least they can support; 1 if not set by board)
>  * default_cpus (what you get if you don't ask for something else;
>    1 if not set by board)
> 
> Then:
>  * these boards which always create a fixed number of CPUs
>    should set all three to the same thing
>  * boards which only create the CPUs requested by the user
>    can leave them unset (as today)
>  * the generic command line parsing code should stop with an
>    error message if the user sets max_cpus smaller than
>    the board's min_cpus setting or greater than the board's
>    max_cpus, or if they set -smp to less than the board's
>    min_cpus

Shouldn't we just print a warning (like we've been doing in some
boards, e.g. nuri) and upgrade smp_cpus/max_cpus to whatever value?
Changing this now could qualify as a regression.

Also, just noticed 4bd2f93 ("exynos4_boards: Silence lack
of -smp 2 warning for qtest", 2013-11-05); I don't really know how
"-smp 1" is built in qtest code, but doing as above breaks
check-qtest-aarch64.

		E.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:34265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fYyZa-0006X1-BE
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fYyZX-0000Xy-8u
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:56:46 -0400
Date: Fri, 29 Jun 2018 14:56:41 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180629185641.GC14726@flamenco>
References: <6aea7155-d453-95de-7ed6-dca7ef135b4d@ilande.co.uk>
	<20180629181815.GA14726@flamenco>
	<a0d80637-24e1-12fd-d667-0e06f2a80488@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0d80637-24e1-12fd-d667-0e06f2a80488@ilande.co.uk>
Subject: Re: [Qemu-devel] target/ppc: gdbstub single-step broken since
 TranslatorOps conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Richard Henderson <richard.henderson@linaro.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

On Fri, Jun 29, 2018 at 19:38:02 +0100, Mark Cave-Ayland wrote:
> On 29/06/18 19:18, Emilio G. Cota wrote:
> >I tried the last known good commit (as per your bisect) and get the same results
> >as above.
> >
> >Is there any other way I could try reproducing this? Also, can you
> >reproduce with another gdb version?
> 
> Hmmm. Have you got a "git clone" of the OpenBIOS source in roms/ that you
> can add to the gdb source path to make sure that "n" correlates with the
> source file line numbers?

I just cloned it and pointed to it using substitute-path in gdb. I
get the same (good) outcome, except that I see the corresponding source.

> >If I don't manage to reproduce, I can send you off-list some patches to try,
> >basically breaking down the diff in the first bad commit into very small chunks,
> >to see where the problem was introduced.
> 
> If the above doesn't work, please do, and I will test them and report back.

Will do.

Cheers,

		Emilio

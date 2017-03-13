Received: from eggs.gnu.org ([2001:4830:134:3::10]:40998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cnXWL-000379-DC
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cnXWK-0005JP-Hu
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:28:49 -0400
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <9ac37611-70ee-87f6-3ccf-64c72157105f@ilande.co.uk>
Date: Mon, 13 Mar 2017 21:28:18 +0000
MIME-Version: 1.0
In-Reply-To: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-system-ppc video artifacts since "tcg: drop
 global lock during TCG code execution"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jan.kiszka@siemens.com, fred.konrad@greensocs.com, cota@braap.org, alex.bennee@linaro.org, rth@twiddle.net, bobby.prani@gmail.com, qemu-devel <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 13/03/17 21:25, Mark Cave-Ayland wrote:

> I've recently noticed some video artifacts appearing in the form of
> horizontal lines whilst testing OpenBIOS boot on some qemu-system-ppc
> images (see https://www.ilande.co.uk/tmp/qemu/macos9-stripe.png for an
> example) which I've finally bisected down to this commit.
> 
> The horizontal lines tend to appear at different positions with
> different lengths, although it seems to be more common that a complete
> scanline is affected. Reproducing the issue is fairly easy with a MacOS
> 9.2.1 ISO and the command line below:
> 
> ./qemu-system-ppc -cdrom MacOS921.iso -boot d -m 512 -M mac99
> 
> Could it be that this patch is still missing a lock somewhere which
> causes these artifacts to appear?

(Apologies - resending as forgot to add CCs for qemu-devel and qemu-ppc)


ATB,

Mark.

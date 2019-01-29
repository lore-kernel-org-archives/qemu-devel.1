Received: from eggs.gnu.org ([209.51.188.92]:54436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tklauser@sym2.noone.org>) id 1goQhI-0004We-Mr
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:32:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tklauser@sym2.noone.org>) id 1goQhH-0003VS-Nr
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:32:52 -0500
Received: from sym2.noone.org ([2a01:4f8:120:4161::3]:56200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tklauser@sym2.noone.org>)
	id 1goQhH-0003Ub-Ha
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:32:51 -0500
Date: Tue, 29 Jan 2019 11:32:47 +0100
From: Tobias Klauser <tklauser@distanz.ch>
Message-ID: <20190129103247.GF13934@distanz.ch>
References: <1548755497-30459-1-git-send-email-tklauser@distanz.ch>
	<CAFEAcA-nePUjjABt+r6ODq_7Pmbbz58prAU7Gr2LM5efaRMFaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-nePUjjABt+r6ODq_7Pmbbz58prAU7Gr2LM5efaRMFaQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/char: Add Altera JTAG UART emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juro Bystricky <juro.bystricky@intel.com>, QEMU Developers <qemu-devel@nongnu.org>

On 2019-01-29 at 11:19:02 +0100, Peter Maydell <peter.maydell@linaro.org> wrote:
> On Tue, 29 Jan 2019 at 09:51, Tobias Klauser <tklauser@distanz.ch> wrote:
> >
> > Add the Altera JTAG UART model.
> >
> > Hardware emulation based on:
> > https://www.altera.com/en_US/pdfs/literature/ug/ug_embedded_ip.pdf
> > (Please see "Register Map" on page 65)
> >
> > Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
> > Acked-by: Marek Vasut <marex@denx.de>
> > Tested-by: Tobias Klauser <tklauser@distanz.ch>
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> 
> Do you also have a patch which makes one of the QEMU machine
> models use this new device ?

Yes, I have a patch (which needs some adjustments) to add the 3c120 Nios
devboard which will use this UART.

It could also be used with the 10m50 as it was used in version 15 of the
hardware reference design provided by Altera [1]. Though it seems it is
no longer used in version 16 of the reference design [2].

[1]
https://rocketboards.org/foswiki/view/Documentation/AlteraMAX1010M50RevCDevelopmentKitLinuxSetupUsingMAX10GHRDVersion151
[2]
https://rocketboards.org/foswiki/Documentation/AlteraMAX1010M50RevCDevelopmentKitLinuxSetupV160

Thanks
Tobias

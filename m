Received: from eggs.gnu.org ([2001:4830:134:3::10]:47899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1ePhpL-0006CH-TD
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 23:42:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1ePhpG-0000SE-W2
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 23:42:27 -0500
Received: from mail-qk0-x22e.google.com ([2607:f8b0:400d:c09::22e]:41394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1ePhpG-0000RU-Ns
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 23:42:22 -0500
Received: by mail-qk0-x22e.google.com with SMTP id r184so1311788qke.8
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 20:42:22 -0800 (PST)
Date: Thu, 14 Dec 2017 23:42:19 -0500
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20171215044219.GA16571@morn.lan>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-7-f4bug@amsat.org>
	<CAKmqyKOSn_iVVuqF=By8g2wFYG_PeiisepJhYMrK7imETGeE7A@mail.gmail.com>
	<CAAdtpL7npoa8Qs5hARn_da39Ctf5eLZ28CMmV=prh63AxCOvYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAdtpL7npoa8Qs5hARn_da39Ctf5eLZ28CMmV=prh63AxCOvYg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 06/14] sdhci: refactor same sysbus/pci
 properties into a common one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>

On Thu, Dec 14, 2017 at 03:40:17PM -0300, Philippe Mathieu-Daudé wrote:
> >>  /* Capabilities registers provide information on supported features of this
> >>   * specific host controller implementation */
> >> -static Property sdhci_pci_properties[] = {
> >> +static Property sdhci_properties[] = {
> >>      DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
> >>              SDHC_CAPAB_REG_DEFAULT),
> >>      DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
> >> +    DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
> >> +                     false),
> >
> > I like the reduction of code in this patch, but aren't we now going to
> > have device properties that aren't actually connected to anything?
> 
> I'm not sure I understand, ar you worried about the PCI_SDHCI will now
> have this property but not use it?
> 
> I couldn't find any machine using SDHCI via PCI and was tempted to
> just remove this code,

I'm not sure if you are suggesting the removal of PCI SDHCI support or
removal of some of the properties.

I do find qemu's PCI SDHCI support useful for testing.  SeaBIOS can
launch an OS from PCI SDHCI (qemu-system-x86_64 -device sdhci-pci
-device sd-card,drive=drive0 -drive id=drive0,if=none,file=dos-drivec)
and linux has drivers for it as well.  A number of the Chromebooks
ship with PCI SDHCI devices on them, so it's not an unheard of
configuration.

I've never manually set any of the PCI properites, however.

-Kevin

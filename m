Received: from eggs.gnu.org ([2001:4830:134:3::10]:58120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gSS57-0007HP-JT
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:34:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gSS54-0005CL-FB
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:34:37 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:35230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gSS54-0005Bw-21
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:34:34 -0500
Date: Thu, 29 Nov 2018 22:34:22 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20181129193422.tcsauhqarfghpkqf@MacBook-Pro-Roman.local>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-42-cota@braap.org>
	<20181127124352.ll6quqc5xedvdqht@MacBook-Pro-Roman.local>
	<20181127231357.GA19764@flamenco>
	<20181128104330.qkqnfttswihjur6g@MacBook-Pro-Roman.local>
	<20181128172332.GA16387@flamenco>
	<20181129095716.fvkr6cv6ltjcvccy@SPB-NB-133.local>
	<20181129170055.GA27757@flamenco> <20181129174927.GA30917@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181129174927.GA30917@flamenco>
Subject: Re: [Qemu-devel] [RFC 41/48] configure: add --enable-plugins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, =?utf-8?B?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>

On Thu, Nov 29, 2018 at 12:49:27PM -0500, Emilio G. Cota wrote:
> On Thu, Nov 29, 2018 at 12:00:55 -0500, Emilio G. Cota wrote:
> > On Thu, Nov 29, 2018 at 12:57:16 +0300, Roman Bolshakov wrote:
> > > Hi Emilio,
> > > 
> > > I think there's an issue with "\s" character class, it's not recognized
> > > by macOS sed  and I'm getting incorrect lines in
> > > qemu-plugins-ld64.symbols:
> > > _  qemu_xxx
> > > _  qemu_xyz
> > > 
> > > After I replaced "\s" with "[[:space:]]", linking proceeds further
> > 
> > Nice, thanks. Will update.
> > 
> > > , but doesn't succeed because of an unresolved reference for qemu-system cris,
> > > lm32, m68k, microblaze, microblazeel, moxie, nios2, or1k, riscv32,
> > > riscv64, sparc, unicore32, tricore, xtensa, xtensaeb:
> > > 
> > > Undefined symbols for architecture x86_64:
> > >   "_pci_register_bar", referenced from:
> > >       _plugin_chan_realize in plugin-chan.o
> > > 
> > > It probably has nothing to do with macOS per-se and shouldn't link on
> > > Linux as well. If I disable the aforementioned targets the build
> > > succeeds and I can see the symbols from qemu-plugins-ld64.symbols in
> > > compiled qemu-system binaries.
> > 
> > Yes, that's because plugin-chan should only be built if the guest has PCI
> > support. Will fix.
> 
> Pushed the fixes to the github branch. Hope it works for you now!
> 

Thank you Emilio,
the build succeded with the set of declared symbols exposed in
qemu-system.

I've just noticed qemu-plugins-ld64.symbols should be added to
.gitignore.

Best regards,
Roman

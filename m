Received: from eggs.gnu.org ([209.51.188.92]:55545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h0zYn-0003wj-M6
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h0zYm-0003UT-8h
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:12:01 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1h0zYh-0003OV-Tx
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:11:57 -0500
Received: by mail-qt1-f196.google.com with SMTP id d2so7429704qti.11
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 18:11:51 -0800 (PST)
Date: Mon, 4 Mar 2019 21:11:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190304210359-mutt-send-email-mst@kernel.org>
References: <1515509463-2675-1-git-send-email-mst@redhat.com>
	<d29cfb63-233a-f9ae-c326-8ff7c1b490f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d29cfb63-233a-f9ae-c326-8ff7c1b490f3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] isa/piix: move to mips malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Igor Mammedov <imammedo@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Mar 05, 2019 at 01:53:45AM +0100, Philippe Mathieu-Daudé wrote:
> Hi Michael,
> 
> On 1/9/18 3:59 PM, Michael S. Tsirkin wrote:
> > This device is only used on mips malta, move it to the maintainer
> > that's actually testing it.
> 
> Slighly related to this patch, since I included it while working on
> Kconfig/MIPS.
> I splitted PIIX3/PIIX4 (Actually PIIX3 was mixed with I440FX).
> These are indeed 2 different chipsets, PIIX4 is an improved PIIX3.
> 
> I compiled MIPS with PIIX4 and it works, however when I ran all the
> testsuite X86 failed due to PIIX4_PM missing.
> I looked where it is used:
> 
> $ git grep PIIX4_PM
> docs/interop/firmware.json:96:#           enabled with "-global
> PIIX4_PM.disable_s3=0" and disabled
> docs/interop/firmware.json:97:#           with "-global
> PIIX4_PM.disable_s3=1". On the "pc-q35-*"
> docs/interop/firmware.json:105:#           can be enabled with "-global
> PIIX4_PM.disable_s4=0" and
> docs/interop/firmware.json:106:#           disabled with "-global
> PIIX4_PM.disable_s4=1". On the
> hw/i386/pc.c:282:    { "PIIX4_PM", "memory-hotplug-support", "off" },
> hw/i386/pc.c:299:    { "PIIX4_PM",
> "acpi-pci-hotplug-with-bridge-support", "off" },
> 
> So now I'm confused, looking at git history I see you introduced this in
> commit 9e047b98245.
> 
> What chipset do use the PC machine? An unreal hybrid of PIIX3/PIIX4?
> 
> Thanks,
> 
> Phil.

Yes I think it does not match any real hardware at this point.

Not sure what does grep above show: to create piix4 pm
pc_init1 calls piix4_pm_init.


> > 
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > Cc: Yongbok Kim <yongbok.kim@mips.com>
> > Cc: Hervé Poussineau <hpoussin@reactos.org>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Aurelien, pls feel free to merge this or v1.
> > 
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0255113..0b8a5e7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -641,6 +641,7 @@ Malta
> >  M: Aurelien Jarno <aurelien@aurel32.net>
> >  S: Maintained
> >  F: hw/mips/mips_malta.c
> > +F: hw/isa/piix4.c
> >  
> >  Mipssim
> >  M: Yongbok Kim <yongbok.kim@mips.com>
> > @@ -849,7 +850,6 @@ F: hw/pci-host/q35.c
> >  F: hw/pci-host/pam.c
> >  F: include/hw/pci-host/q35.h
> >  F: include/hw/pci-host/pam.h
> > -F: hw/isa/piix4.c
> >  F: hw/isa/lpc_ich9.c
> >  F: hw/i2c/smbus_ich9.c
> >  F: hw/acpi/piix4.c
> > 

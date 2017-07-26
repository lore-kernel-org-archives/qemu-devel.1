Received: from eggs.gnu.org ([2001:4830:134:3::10]:50242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1daMDv-0007tk-S8
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1daMDr-0003Cu-TF
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:19:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1daMDr-0003Cm-MC
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:19:31 -0400
Date: Wed, 26 Jul 2017 16:19:24 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170726161840-mutt-send-email-mst@kernel.org>
References: <20170726093136.13627-1-pbonzini@redhat.com>
	<20170726155118-mutt-send-email-mst@kernel.org>
	<20170726130713.GL7620@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170726130713.GL7620@redhat.com>
Subject: Re: [Qemu-devel] [qemu PATCH for 2.10] i386: acpi: provide an XSDT
 instead of an RSDT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, phil@philjordan.eu, seabios@seabios.org, qemu-devel@nongnu.org, programmingkidx@gmail.com, Kevin O'Connor <kevin@koconnor.net>, kraxel@redhat.com, lists@philjordan.eu, imammedo@redhat.com, lersek@redhat.com

On Wed, Jul 26, 2017 at 02:07:13PM +0100, Daniel P. Berrange wrote:
> On Wed, Jul 26, 2017 at 03:52:43PM +0300, Michael S. Tsirkin wrote:
> > On Wed, Jul 26, 2017 at 11:31:36AM +0200, Paolo Bonzini wrote:
> > > The tables that QEMU provides are not ACPI 1.0 compatible since commit
> > > 77af8a2b95 ("hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve
> > > guest OS support.", 2017-05-03).  This is visible with Windows 2000,
> > > which refuses to parse the rev3 FADT and fails to boot.
> > > 
> > > The recommended solution in this case is to build two FADTs, v1 being
> > > pointed to by the RSDT and v3 by the XSDT.  However, we leave this task
> > > to the firmware.  This patch simply switches the RSDT to the XSDT, which
> > > is valid for all ACPI 2.0-friendly operating systems and also leaves
> > > SeaBIOS the freedom to build an RSDT that points to the compatibility
> > > FADT.
> > > 
> > > When running Windows 2000 with an old BIOS, Windows would simply fall
> > > back to a non-ACPI HAL; however, the plan should be to include a BIOS with
> > > the new feature in 2.10.
> > > 
> > > Reported-by: Programmingkid <programmingkidx@gmail.com>
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > I'm not against this but let's do it for q35 only please. PC is a legacy
> > machine type and let's just leave it alone.
> 
> We've already touched the PC machine type in 77af8a2b95 and that needs
> fixing to deal with the regressions it caused. Even if you call it
> "legacy", the PC machine is used by the vast majority of deployments
> that exist today & likely to be done for the foreseeable future too.
> 
> Regards,
> Daniel

Fine. So let's avoid making cosmetic changes there. Keep working things
working.

> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fT6jK-0006t5-PU
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fT6jG-0003io-TX
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:26:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fT6jG-0003fr-O5
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:26:30 -0400
Date: Wed, 13 Jun 2018 17:26:28 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180613172438-mutt-send-email-mst@kernel.org>
References: <f6aa6ac8-3c3c-bf90-6273-3d584f4707c8@web.de>
	<a2198ea1-e0f6-6b04-63a8-fd04b40c9ff2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2198ea1-e0f6-6b04-63a8-fd04b40c9ff2@web.de>
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Fix IVHD entry length for AMD
 IOMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Tue, May 22, 2018 at 09:06:56AM +0200, Jan Kiszka wrote:
> On 2018-03-29 14:51, Jan Kiszka wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > 
> > Counting from the IVHD ID field to the all-devices entry, we have 28
> > bytes, not 36.
> > 
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >  hw/i386/acpi-build.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index deb440f286..a0cda71411 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -2561,7 +2561,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
> >                               (1UL << 7),  /* PPRSup       */
> >                               1);
> >      /* IVHD length */
> > -    build_append_int_noprefix(table_data, 0x24, 2);
> > +    build_append_int_noprefix(table_data, 28, 2);
> >      /* DeviceID */
> >      build_append_int_noprefix(table_data, s->devid, 2);
> >      /* Capability offset */
> > 
> 
> Waiting to be merged.
> 
> Jan

I'll queue this but you really should Cc maintainers :)

-- 
MST

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cxfoG-0004Nl-Cu
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 16:21:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cxfoD-0007QU-7x
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 16:21:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cxfoD-0007QI-1f
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 16:21:09 -0400
Date: Mon, 10 Apr 2017 23:21:04 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170410232053-mutt-send-email-mst@kernel.org>
References: <20170410150350.3267-1-ard.biesheuvel@linaro.org>
	<f3c8cba3-6cf5-75a1-eaf6-a3ad1d3505f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3c8cba3-6cf5-75a1-eaf6-a3ad1d3505f9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] hw/acpi-defs: replace leading X
 with x_ in FADT field names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, qemu-devel@nongnu.org, peter.maydell@linaro.org, phil@philjordan.eu, imammedo@redhat.com, drjones@redhat.com, zhaoshenglong@huawei.com

On Mon, Apr 10, 2017 at 05:28:44PM +0200, Laszlo Ersek wrote:
> On 04/10/17 17:03, Ard Biesheuvel wrote:
> > At the request of Michael, replace the leading capital X in the FADT
> > field name Xfacs and Xdsdt with lower case x + underscore.
> > 
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  include/hw/acpi/acpi-defs.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> > index 4cc3630e613e..db48807056b3 100644
> > --- a/include/hw/acpi/acpi-defs.h
> > +++ b/include/hw/acpi/acpi-defs.h
> > @@ -165,8 +165,8 @@ struct AcpiFadtDescriptorRev5_1 {
> >      /* ARM-Specific Boot Flags (see below for individual flags) (ACPI 5.1) */
> >      uint16_t arm_boot_flags;
> >      uint8_t minor_revision;  /* FADT Minor Revision (ACPI 5.1) */
> > -    uint64_t Xfacs;          /* 64-bit physical address of FACS */
> > -    uint64_t Xdsdt;          /* 64-bit physical address of DSDT */
> > +    uint64_t x_facs;         /* 64-bit physical address of FACS */
> > +    uint64_t x_dsdt;         /* 64-bit physical address of DSDT */
> >      /* 64-bit Extended Power Mgt 1a Event Reg Blk address */
> >      struct AcpiGenericAddress xpm1a_event_block;
> >      /* 64-bit Extended Power Mgt 1b Event Reg Blk address */
> > 
> 
> (This is for 2.10, or whatever comes after 2.9.)
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks, pls remember to repost after 2.9 is out.

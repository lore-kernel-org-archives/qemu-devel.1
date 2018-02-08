Received: from eggs.gnu.org ([2001:4830:134:3::10]:43985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ejqwD-0003Ii-5c
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ejqw9-00048g-7a
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:28:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ejqw9-00048F-0t
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:28:45 -0500
Date: Thu, 8 Feb 2018 11:28:36 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180208112836.072766e3@w520.home>
In-Reply-To: <b48b5e4d-dc91-acc4-1e72-45c287e9a597@redhat.com>
References: <20180207001615.1156.10547.stgit@gimli.home>
	<20180207002615.1156.74568.stgit@gimli.home>
	<b48b5e4d-dc91-acc4-1e72-45c287e9a597@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/5] vfio/quirks: Add common quirk
 alloc helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org

On Thu, 8 Feb 2018 12:10:35 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Alex,
> On 07/02/18 01:26, Alex Williamson wrote:
> > This will later be used to include list initialization
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  hw/vfio/pci-quirks.c |   48 +++++++++++++++++++++---------------------------
> >  1 file changed, 21 insertions(+), 27 deletions(-)
> > 
> > diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> > index e5779a7ad35b..10af23217292 100644
> > --- a/hw/vfio/pci-quirks.c
> > +++ b/hw/vfio/pci-quirks.c
> > @@ -275,6 +275,15 @@ static const MemoryRegionOps vfio_ati_3c3_quirk = {
> >      .endianness = DEVICE_LITTLE_ENDIAN,
> >  };
> >  
> > +static VFIOQuirk *vfio_quirk_alloc(int nr_mem)
> > +{
> > +    VFIOQuirk *quirk = g_malloc0(sizeof(*quirk));  
> nit: Peter advised the usage of g_new0 as well for that kind of alloc.

Not my favorite interface, but good point.  Updated and R-b added.
Thanks,

Alex

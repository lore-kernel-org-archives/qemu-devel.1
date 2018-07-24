Received: from eggs.gnu.org ([2001:4830:134:3::10]:45251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fhwb8-0007c5-Pw
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fhwb4-000867-Sr
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:39:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fhwb4-00085n-LZ
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:39:22 -0400
Date: Tue, 24 Jul 2018 09:39:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180724123916.GC3896@localhost.localdomain>
References: <20180723193145.24705-1-ehabkost@redhat.com>
	<20180723193145.24705-3-ehabkost@redhat.com>
	<20180724142949.3078da82@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724142949.3078da82@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.1 2/2] acpi: Decouple ACPI hotplug
 callbacks from HotplugHandler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, Jul 24, 2018 at 02:29:49PM +0200, Igor Mammedov wrote:
> On Mon, 23 Jul 2018 16:31:45 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > The ACPI hotplug callbacks get a HotplugHandler object as
> > argument.  This has two problems:
> > 
> > 1) The functions require a TYPE_ACPI_DEVICE_IF object, but the
> >    function prototype doesn't indicate that.  It's possible to
> >    pass an object that would make the function crash.
> > 2) The function does not require the object to implement
> >    TYPE_HOTPLUG_HANDLER at all, but the function prototype
> >    imposes that for no reason.
> > 
> > Change the argument type to AcpiDeviceIf instead of
> > HotplugHandler.
> What is the motivation for this patch,
> do you actually get crashes?

I didn't get crashes, but the idea for the change came when
Michael asked me how to get the HotplugHandler object.  I was
going to suggest current_machine (which is also a hotplug
handler), when I noticed he actually needed an AcpiDeviceIf
object.

The main motivation, however, is to simply make the function
prototypes make sense.  Is there a single reason to make the ACPI
functions get a HotplugHandler argument instead of AcpiDeviceIf?

-- 
Eduardo

Received: from eggs.gnu.org ([209.51.188.92]:47029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtQig-0004xo-V7
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtQie-0001Tm-At
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:34:58 -0500
Date: Tue, 12 Feb 2019 00:34:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190212003414-mutt-send-email-mst@kernel.org>
References: <20190130000653.16267-1-richardw.yang@linux.intel.com>
	<20190212052224.GA4839@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212052224.GA4839@richard>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Trivial cleanup in hw/acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, laurent@vivier.eu, imammedo@redhat.com, philmd@redhat.com

On Tue, Feb 12, 2019 at 01:22:24PM +0800, Wei Yang wrote:
> On Wed, Jan 30, 2019 at 08:06:50AM +0800, Wei Yang wrote:
> >There are several functions/variable which are not used anymore.
> >
> >This serials just remove those without functional change.
> >
> >v3: add ack and repost in a new thread
> >v2: change commit log from "is now used in no place" to "in not used anymore"
> 
> Michael,
> 
> Looks this serials is not merged yet.
> 
> Is there any problem I need to fix?

Yes pls repost with fixed reviewed-by tags.


> >
> >Wei Yang (3):
> >  hw/i386/pc.c: remove unused function pc_acpi_init()
> >  hw/acpi: remove unused function acpi_table_add_builtin()
> >  hw/acpi: remove unnecessary variable acpi_table_builtin
> >
> > hw/acpi/core.c         | 10 +---------
> > hw/i386/pc.c           | 27 ---------------------------
> > include/hw/acpi/acpi.h |  1 -
> > include/hw/i386/pc.h   |  1 -
> > 4 files changed, 1 insertion(+), 38 deletions(-)
> >
> >-- 
> >2.19.1
> 
> -- 
> Wei Yang
> Help you, Help me

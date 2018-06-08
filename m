Received: from eggs.gnu.org ([2001:4830:134:3::10]:46433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fRLO6-0000qA-9t
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fRLO1-0006nv-HW
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:41:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:61309)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fRLO1-0006nQ-6m
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:41:17 -0400
Date: Fri, 8 Jun 2018 11:41:14 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Message-ID: <20180608174114.GA30678@linux.intel.com>
References: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
	<20180607223111.27792-4-ross.zwisler@linux.intel.com>
	<17f8856c-48d9-d112-cd7f-e1b3679d2f43@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17f8856c-48d9-d112-cd7f-e1b3679d2f43@redhat.com>
Subject: Re: [Qemu-devel] [qemu PATCH 4/5] machine: fix some misspelled words
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On Fri, Jun 08, 2018 at 07:38:17AM +0200, Thomas Huth wrote:
> On 08.06.2018 00:31, Ross Zwisler wrote:
> > Normally this might not be worth fixing, but several of these are strings
> > which are displayed to users.
> > 
> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> > ---
> >  hw/core/machine.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 617e5f8d75..a21269fa39 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -609,7 +609,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
> >          machine_get_igd_gfx_passthru, machine_set_igd_gfx_passthru,
> >          &error_abort);
> >      object_class_property_set_description(oc, "igd-passthru",
> > -        "Set on/off to enable/disable igd passthrou", &error_abort);
> > +        "Set on/off to enable/disable igd passthru", &error_abort);
> 
> Shouldn't that rather be "passthrough" instead?

Either works, I think.  "thru" and "passthru" are short informal versions of
"through" and "passthrough", but both the long and short versions of both
words are used all over the QEMU source.  "passthrou" is clearly wrong.  If
the longer version is preferred in this case please feel free to fix up when
you apply.

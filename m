Received: from eggs.gnu.org ([2001:4830:134:3::10]:44571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTDOo-0004y8-Rt
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 17:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTDOk-000819-TT
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 17:33:50 -0400
Date: Wed, 13 Jun 2018 18:33:37 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180613213337.GP7451@localhost.localdomain>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-7-david@redhat.com>
	<20180613145624.3004935c@redhat.com>
	<bb0b033f-d048-06db-96d1-89085000d792@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb0b033f-d048-06db-96d1-89085000d792@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 06/11] pc-dimm: don't allow to access
 "size" before the device was realized
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Wed, Jun 13, 2018 at 04:03:35PM +0200, David Hildenbrand wrote:
> On 13.06.2018 14:56, Igor Mammedov wrote:
> > On Mon, 11 Jun 2018 14:16:50 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> > 
> >> "size" should not be queried before the device was realized. Let' make
> >> that explicit.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> > It's generic property getter, it should work even before realize is called.
> 
> That's the point, as we can see in NVDIMM code , it is *not* a generic
> property getter.

If it were a writeable property, I would agree with Igor because
it would make it impossible to find out what's the default value
for the property.

As it's a read-only property, returning an error seems harmless.
Igor, why exactly do you think it's a problem?

-- 
Eduardo

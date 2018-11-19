Received: from eggs.gnu.org ([2001:4830:134:3::10]:58368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gOo4M-0007rV-L7
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:14:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gOo4K-0002sQ-O9
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:14:46 -0500
Date: Mon, 19 Nov 2018 13:14:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181119131314-mutt-send-email-mst@kernel.org>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181116172919.43f3e27d@redhat.com>
	<d4f6f0ef-1333-a917-e3eb-d9bad47c9648@redhat.com>
	<20181119163110.2f357f40@redhat.com>
	<c09214f5-85fa-bb64-7c7e-2e9435ea4279@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c09214f5-85fa-bb64-7c7e-2e9435ea4279@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/24] ACPI reorganization for
 hardware-reduced API addition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On Mon, Nov 19, 2018 at 06:14:26PM +0100, Paolo Bonzini wrote:
> On 19/11/18 16:31, Igor Mammedov wrote:
> > I've tried to give suggestions how to restructure series
> > on per patch basis. In my opinion it quite possible to split
> > series in several smaller ones and it should really help with
> > making series cleaner and easier/faster to review/amend/merge
> > vs what we have in v5.
> 
> This is true, on the other hand the series makes sense together and,
> even if the patches are more or less independent, they also all follow
> the same "plan".  For reviewing v6, are you aware of Patchew's series
> diff functionality?  It can tell you which patches had comments in v5,
> reorder patches if applicable, and display deleted and new patches at
> the right point in the series.
> 
> v4->v5 is a bit messed up because Samuel probably added a diff order
> setup
> (https://patchew.org/QEMU/20181101102303.16439-1-sameo@linux.intel.com/diff/20181105014047.26447-1-sameo@linux.intel.com/)
> but it's very useful in general.
> 
> Paolo

Oh I didn't realize difforder breaks patchew. Or is the problem
only if one switches from no order to difforder?

-- 
MST

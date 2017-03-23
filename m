Received: from eggs.gnu.org ([2001:4830:134:3::10]:49001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cqxQL-0001RI-DB
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 03:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cqxQK-0004gh-P5
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 03:44:45 -0400
Date: Thu, 23 Mar 2017 08:44:33 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170323074433.u6irjyrmq2gcnpaj@hawk.localdomain>
References: <1490175166-19785-1-git-send-email-he.chen@linux.intel.com>
	<20170322103405.rcye74zye6gvrfis@hawk.localdomain>
	<20170323072335.GC10166@he>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323072335.GC10166@he>
Subject: Re: [Qemu-devel] [PATCH v3] Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: He Chen <he.chen@linux.intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Mar 23, 2017 at 03:23:35PM +0800, He Chen wrote:
> > 
> > And maybe should also point out how to set an unreachable node with 255.
> > 
> Thanks for your careful review. Regarding setting unreachable node,
> which way is good? Set exact 255 as distance or distance that is larger
> than 255 is regarded as unreachable?

If a numeric distance is to be used, then I think following the spec with
255 is best. Alternatively, we could have something like
'-numa dist,src=0,dst=1,unreachable', rather than specifying val at all,
but, IMO, it's not worth it.

Thanks,
drew

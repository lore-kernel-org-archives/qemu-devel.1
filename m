Received: from eggs.gnu.org ([2001:4830:134:3::10]:57499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1chFwA-000474-BS
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:29:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1chFw7-00052D-5p
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:29:30 -0500
Date: Fri, 24 Feb 2017 14:29:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170224142921.495f6871@nial.brq.redhat.com>
In-Reply-To: <20170224130357.GF17615@umbus.fritz.box>
References: <20170222063348.32176-38-david@gibson.dropbear.id.au>
	<1487761555-93223-1-git-send-email-imammedo@redhat.com>
	<20170224130357.GF17615@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 37/43] spapr: reuse machine->possible_cpus
 instead of cores[]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, peter.maydell@linaro.org

On Sat, 25 Feb 2017 00:03:57 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Feb 22, 2017 at 12:05:55PM +0100, Igor Mammedov wrote:
> > Replace SPAPR specific cores[] array with generic
> > machine->possible_cpus and store core objects there.
> > It makes cores bookkeeping similar to x86 cpus and
> > will allow to unify similar code.
> > It would allow to replace cpu_index based NUMA node
> > mapping with property based one (for -device created
> > cores) since possible_cpus carries board defined
> > topology/layout.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>  
> 
> Sorry Igor, Peter has applied the original version.  Can you resend
> these updates as deltas against the applied versions of the patches.
> 
> > ---
> > v3:
> >   - drop "// TODO" comment as todo is completed in next patch anyway
> >     fixes checkpatch error wrt // comment
there is no need for patches on top as the next applied patch
38/43 removed c++ style comment as part of removed
spapr_query_hotpluggable_cpus().

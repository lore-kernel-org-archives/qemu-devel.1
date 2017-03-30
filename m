Received: from eggs.gnu.org ([2001:4830:134:3::10]:38661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctbZL-0000bx-Gw
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctbZK-0004vm-Lu
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:00:59 -0400
Date: Thu, 30 Mar 2017 12:00:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170330150048.GL3709@thinpad.lan.raisama.net>
References: <1490175166-19785-1-git-send-email-he.chen@linux.intel.com>
	<20170323102955.5e2d1c65@nial.brq.redhat.com>
	<20170329085000.GA20377@he>
	<20170329134458.793e882d@nial.brq.redhat.com>
	<20170329123038.u6ebwn2xazbzr4nv@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170329123038.u6ebwn2xazbzr4nv@kamzik.brq.redhat.com>
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
To: Andrew Jones <drjones@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, He Chen <he.chen@linux.intel.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Mar 29, 2017 at 02:30:38PM +0200, Andrew Jones wrote:
> On Wed, Mar 29, 2017 at 01:44:58PM +0200, Igor Mammedov wrote:
> > On Wed, 29 Mar 2017 16:50:00 +0800
> > He Chen <he.chen@linux.intel.com> wrote:
> > > > > +static void default_numa_distance(void)
> > > > > +{
> > > > > +    int src, dst;
> > > > > +  
> > > > fill in defaults only if there weren't any '-numa dist' on CLI
> > > > and refuse to start if partial filled table were explicitly provided on CLI
> > > >   
> > > I am afraid that I may have a bad function name here, fill_numa_distance
> > > might be a better name?
> > > 
> > > Also, since the distance can be asymmetric, IMHO, providing a partial
> > > filled table looks fine. If we set many NUMA nodes e.g. 8 nodes for
> > > guest, the whole filled table would require many command lines which
> > > might be inconvenient and less flexible.
> > asymmetric doesn't imply sparse, so one has to specify full matrix
> > it might be inconvenient /long/ but is very flexible.
> 
> This makes me realize that a user only inputting one of A -> B or B -> A
> command line inputs doesn't imply symmetry.  It could be that the user
> just forgot to input the opposite.  To avoid the ambiguity we either need
> to force both to be input (as it was before I suggested otherwise), or
> add a '-numa symmetric' type of property to enable the shortcut.  I guess
> we should just avoid the shortcut, at least for now.

Is protecting the user from one very specific (and very rare[1])
mistake a good reason for making the automatic default less
useful? Requiring an explicit '-numa symmetric' option to enable
the automatic default seems to defeat the purpose of having an
automatic default, to me.

I bet people would just specify the distances for both
directions, instead of having to read the documentation for
"-numa symmetric" to be sure if that's exactly what they want.

[1] I mean: forgetting an option isn't rare, but asymmetric NUMA
    distances are so rare that most people who reviewed those
    patches were surprised when they learned that the specs allow
    asymmetric distances.

-- 
Eduardo

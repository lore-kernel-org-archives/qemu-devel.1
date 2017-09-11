Received: from eggs.gnu.org ([2001:4830:134:3::10]:56898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1drT6e-00081T-8T
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1drT6Y-0005aR-Bq
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:06:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1drT6Y-0005Za-6N
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:06:42 -0400
Date: Mon, 11 Sep 2017 15:06:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170911180632.GQ7570@localhost.localdomain>
References: <20170907201335.13956-1-david@redhat.com>
	<20170907201335.13956-9-david@redhat.com>
	<1603f6bf-f481-13c2-c7eb-ac155c5a14cc@redhat.com>
	<b8f78724-b6be-3e95-60fa-8c7dcafe2eec@redhat.com>
	<20170909220737.GL7570@localhost.localdomain>
	<c758ae70-a664-d13a-dd24-768f71e3f2e4@redhat.com>
	<20170911175224.GP7570@localhost.localdomain>
	<8cf0bf17-c1cb-ee13-768c-dcf1836687c2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cf0bf17-c1cb-ee13-768c-dcf1836687c2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 08/21] s390x: move sclp_service_call()
 to sclp.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Sep 11, 2017 at 07:56:19PM +0200, David Hildenbrand wrote:
> 
> >>>>
> >>>>  #endif
> >>>
> >>> Why not use typedefs.h?
> >>
> >> See Markus's reply.  But, maybe it's even better to use S390CPU* and
> >> include target/s390x/cpu-qom.h, which by design provides as little
> >> definitions as needed.
> > 
> > I don't see an argument against moving typedef CPUS390XState to
> > typedefs.h in Markus' reply.  I see one argument for it (reducing
> > the need for non-cyclic includes).
> > 
> > cpu-qom.h includes cpu.h, so I don't know why using S390CPU*
> > would solve any problem.  I don't disagree about changing the
> > function to use S390CPU* eventually, but it would still require
> > us make a choice between: a) including the header where the
> > typedef name is declared (cpu.h or cpu-qom.h); or b) moving the
> > typedef name declaration to typedefs.h.
> 
> It includes qom/cpu.h, not cpu.h. That's why using cpu-qom.h for such
> typedefs works (see v4).
> 

Oops, I was looking at an older tree (before commit 347b1a5c).
You're right, sorry for the noise.

-- 
Eduardo

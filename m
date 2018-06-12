Received: from eggs.gnu.org ([2001:4830:134:3::10]:51291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSkcQ-00040z-Ci
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 10:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSkcN-0003Of-Nl
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 10:49:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38833)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSkcN-0003MG-HA
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 10:49:55 -0400
Date: Tue, 12 Jun 2018 11:49:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180612144922.GJ7451@localhost.localdomain>
References: <20180608205830.308627-1-mst@redhat.com>
	<20180612145605.50f64965@redhat.com>
	<20180612155708-mutt-send-email-mst@kernel.org>
	<20180612155803.4ca0d137@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612155803.4ca0d137@redhat.com>
Subject: Re: [Qemu-devel] [RFC untested PATCH] i386/cpu: make -cpu host
 support monitor/mwait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Jun 12, 2018 at 03:58:03PM +0200, Igor Mammedov wrote:
[...]
> > > > +    if (xcc->host_cpuid_required && enable_cpu_pm) {
> > > > +        host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
> > > > +                   &cpu->mwait.ecx, &cpu->mwait.edx);
> > > > +    }  
> > > could this state be migrated? or 'host' is still unmigratable?  
> > 
> > Host is still unmigratable.
> 'max' cpu model has 'migratable = true' property and 'host' is inherited from it,
> hence was the question.

Host can be migratable if and only if the source and destination
CPUs + kernel + QEMU are exactly the same.  Not something I would
recommend to anyone, but still something we try not to break.

> 
> > 
> > > also max_x86_cpu_initfn() might be better place for filling it up.

Why?


-- 
Eduardo

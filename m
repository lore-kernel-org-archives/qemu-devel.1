Received: from eggs.gnu.org ([209.51.188.92]:55478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goVKj-0002HL-CP
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goVKV-0007ol-SH
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:29:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1goVKV-0007Q5-K1
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:29:39 -0500
Date: Tue, 29 Jan 2019 15:28:12 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190129152811.GF2650@work-vm>
References: <20190125114155.32062-1-vkuznets@redhat.com>
	<20190125114155.32062-5-vkuznets@redhat.com>
	<20190125124738.GB30730@rkaganb.sw.ru>
	<87bm44onnh.fsf@vitty.brq.redhat.com>
	<20190128113017.GA2435@rkaganb.sw.ru>
	<87lg34zy37.fsf@vitty.brq.redhat.com>
	<20190128182229.GF2585@work-vm>
	<877eenze0u.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877eenze0u.fsf@vitty.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 4/8] i386/kvm: Implement 'hv-all'
 pass-through mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

* Vitaly Kuznetsov (vkuznets@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
> > I'm not sure what the equivalent bear traps are in the Hyper-V world,
> > but I'd be surprised if there weren't any; for example what happens
> > when someone upgrades one of their hosts to some minor version that
> > adds/removes a feature?
> 
> Here we're talking about Hyper-V emulation in KVM, features only get
> added there, but even if it gets removed it will be detected by libvirt ...

OK, but then you do get the same behaviour; upgrade a host to a new
kernel/qemu and get a new enlightenment, and you can't back migrate to
the older one (possibly with no warning).

> >
> > Also, how does libvirt figure out that the features are actually the
> > same - does it need a bunch of detection code?
> 
> ... as I *think* it compares Feature CPUID words (and all Hyper-V
> features which we enable with hv-all are there).

Not too bad if it does, but also look at the scary command lines we get
generated full of -cpu ...+feature,+feature,-feature,.... 

Dave

> -- 
> Vitaly
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

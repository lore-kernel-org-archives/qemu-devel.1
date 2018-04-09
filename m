Received: from eggs.gnu.org ([2001:4830:134:3::10]:52165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f5d4T-00078G-NJ
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 16:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f5d4Q-00027Z-9Y
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 16:07:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f5d4Q-00027F-3L
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 16:07:18 -0400
Date: Mon, 9 Apr 2018 17:07:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180409200706.GB29865@localhost.localdomain>
References: <1522186271-27743-1-git-send-email-babu.moger@amd.com>
	<1522186271-27743-5-git-send-email-babu.moger@amd.com>
	<867epg48oh.fsf@profitbricks.com>
	<CY4PR12MB176888DEF8DDA722F1F6E64C95BF0@CY4PR12MB1768.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR12MB176888DEF8DDA722F1F6E64C95BF0@CY4PR12MB1768.namprd12.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH v5 4/9] i386: Add new property to control
 cache info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Moger, Babu" <Babu.Moger@amd.com>
Cc: Alexandr Iarygin <alexandr.iarygin@profitbricks.com>, "mst@redhat.com" <mst@redhat.com>, "marcel@redhat.com" <marcel@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>

On Mon, Apr 09, 2018 at 07:51:24PM +0000, Moger, Babu wrote:
[...]
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index 67faa53..f4fbe3a 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -5132,6 +5132,7 @@ static Property x86_cpu_properties[] = {
> > >                       false),
> > >      DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU,
> > vmware_cpuid_freq, true),
> > >      DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
> > > +    DEFINE_PROP_BOOL("legacy-cache", X86CPU, legacy_cache, false),
> > 
> > I'm wondering the reason why Intel L1 caches aren't shared per threads,
> > L2 not shared per threads/cores etc? I mean, changing that will also
> > require new compat flag with very similar name.
> 
> I am not an expert on this topic. But, yes, If there is any future change in cache topology
> then it would require similar change. 

In the future I really hope we manage to represent cache
information in a more structured way, so other incompatible
changes could be represented by more descriptive options like
"l1-cache-size=N", "l2-sharing=cores", etc.

-- 
Eduardo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fG7y4-0006ux-U4
	for qemu-devel@nongnu.org; Tue, 08 May 2018 15:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fG7y1-0007gQ-1v
	for qemu-devel@nongnu.org; Tue, 08 May 2018 15:08:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fG7y0-0007g7-On
	for qemu-devel@nongnu.org; Tue, 08 May 2018 15:08:04 -0400
Date: Tue, 8 May 2018 16:07:54 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180508190754.GO25013@localhost.localdomain>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
	<1524760009-24710-2-git-send-email-babu.moger@amd.com>
	<20180507190501.GA13350@localhost.localdomain>
	<BL0PR12MB24682009D5F23F48755C2A7F959B0@BL0PR12MB2468.namprd12.prod.outlook.com>
	<20180507212726.GK13350@localhost.localdomain>
	<BL0PR12MB24680A8B8EAAD6C75BB53B3D959B0@BL0PR12MB2468.namprd12.prod.outlook.com>
	<SN1PR12MB24775A07CD6D903172F107F4959A0@SN1PR12MB2477.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN1PR12MB24775A07CD6D903172F107F4959A0@SN1PR12MB2477.namprd12.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH v7 1/9] i386: Helpers to encode cache
 information consistently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Moger, Babu" <Babu.Moger@amd.com>
Cc: "geoff@hostfission.com" <geoff@hostfission.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "kash@tripleback.net" <kash@tripleback.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "marcel@redhat.com" <marcel@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

On Tue, May 08, 2018 at 06:40:23PM +0000, Moger, Babu wrote:
> Hi Eduardo, One more comment below.
> 
> > -----Original Message-----
> > From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org]
> > On Behalf Of Moger, Babu
> > Sent: Monday, May 7, 2018 5:48 PM
> > To: Eduardo Habkost <ehabkost@redhat.com>
> > Cc: geoff@hostfission.com; kvm@vger.kernel.org; mst@redhat.com;
> > kash@tripleback.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> > marcel@redhat.com; pbonzini@redhat.com; rth@twiddle.net
> > Subject: RE: [Qemu-devel] [PATCH v7 1/9] i386: Helpers to encode cache
> > information consistently
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> > > Sent: Monday, May 7, 2018 4:27 PM
> > > To: Moger, Babu <Babu.Moger@amd.com>
> > > Cc: geoff@hostfission.com; kvm@vger.kernel.org; mst@redhat.com;
> > > kash@tripleback.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> > > marcel@redhat.com; pbonzini@redhat.com; rth@twiddle.net
> > > Subject: Re: [Qemu-devel] [PATCH v7 1/9] i386: Helpers to encode cache
> > > information consistently
> > >
> > > On Mon, May 07, 2018 at 09:14:27PM +0000, Moger, Babu wrote:
> > > > Eduardo,
> > > >    Thanks for all the comments. Will respond to each one separately.
> > > >
> > > > > -----Original Message-----
> > > > > From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> > > > > Sent: Monday, May 7, 2018 2:05 PM
> > > > > To: Moger, Babu <Babu.Moger@amd.com>
> > > > > Cc: mst@redhat.com; marcel@redhat.com; pbonzini@redhat.com;
> > > > > rth@twiddle.net; mtosatti@redhat.com; geoff@hostfission.com;
> > > > > kash@tripleback.net; qemu-devel@nongnu.org; kvm@vger.kernel.org
> > > > > Subject: Re: [Qemu-devel] [PATCH v7 1/9] i386: Helpers to encode
> > cache
> > > > > information consistently
> > > > >
> > > > > Hi,
> > > > >
> > > > > I was about to apply this because I assumed it was the same patch
> > > > > I sent in March, but then I found this:
> > > > >
> > > > > On Thu, Apr 26, 2018 at 11:26:41AM -0500, Babu Moger wrote:
> > > > > > From: Eduardo Habkost <ehabkost@redhat.com>
> > > > > >
> > > > > > Instead of having a collection of macros that need to be used in
> > > > > > complex expressions to build CPUID data, define a CPUCacheInfo
> > > > > > struct that can hold information about a given cache.  Helper
> > > > > > functions will take a CPUCacheInfo struct as input to encode
> > > > > > CPUID leaves for a cache.
> > > > > >
> > > > > > This will help us ensure consistency between cache information
> > > > > > CPUID leaves, and make the existing inconsistencies in CPUID info
> > > > > > more visible.
> > > > > >
> > > > > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > > > > Tested-by: Geoffrey McRae <geoff@hostfission.com>
> > > > > [...]
> > > > > > -#define L2_ASSOCIATIVITY      16
> > > > > [...]
> > > > > >  /*FIXME: CPUID leaf 0x80000006 is inconsistent with leaves 2 & 4 */
> > > > > > +static CPUCacheInfo l2_cache_amd = {
> > > > > [...]
> > > > > > +    .associativity = 8,
> > > > > [...]
> > > > > > +};
> > > > > [...]
> > > > > >      case 0x80000006:
> > > > > [...]
> > > > > > -        *ecx = (L2_SIZE_KB_AMD << 16) | \
> > > > > > -               (AMD_ENC_ASSOC(L2_ASSOCIATIVITY) << 12) | \
> > > > > > -               (L2_LINES_PER_TAG << 8) | (L2_LINE_SIZE);
> > > > > [...]
> > > > > > +        encode_cache_cpuid80000006(&l2_cache_amd,
> > > > > > +                                   cpu->enable_l3_cache ? &l3_cache : NULL,
> > > > > > +                                   ecx, edx);
> > > > > [...]
> > > > >
> > > > > The structs added by this patch are supposed to represent the
> > > > > legacy cache sizes, and must match the old code.  My original
> > > > > patch set l2_cache_amd.associativity=16 because of that.
> > > > >
> > > > > This patch changes 0x80000006 from associativity=16 to
> > > > > associativity=8.  Why?
> 
> Keeping this to 16 will be a problem. It breaks the size rule(line size *associativity * partitions * sets).
> It asserts violating that rule. Now I remember. That is why I changed it to 8. I would think it would be
> better to fix it now.

You can fix it, no problem.  You just need to make sure
CPUID[0x80000006] data for old machine-types without topoext will
stay the same.

Remember that l2_cache_amd is just for the legacy values enabled
by legacy-cache=on.  Non-legacy values with more consistent data
can be set at the CPU model table.

The current CPUID data is:

#define L2_SIZE_KB_AMD       512
#define L2_ASSOCIATIVITY      16
#define L2_LINES_PER_TAG       1
#define L2_LINE_SIZE          64
[...]
    case 0x80000006:
        *ecx = (L2_SIZE_KB_AMD << 16) | \
               (AMD_ENC_ASSOC(L2_ASSOCIATIVITY) << 12) | \
               (L2_LINES_PER_TAG << 8) | (L2_LINE_SIZE);


This means l2_cache_amd.size must be 512KiB,
l2_cache_amd.associativity must be 16, l2_cache_amd.lines_per_tag
must be 1, and l2_cache_amd.line_size must be 64.

l2_cache_amd.partitions and l2_cache_amd.sets, on the other hand,
can be set to any value you wish.

Another option is to simply disable CPUID[0x8000001d] if
legacy-cache=on, so we don't need to worry about consistency on
legacy cache entries that are known to be inconsistent.

If we want to be extra safe/consistent, we can automatically set
legacy-cache=off if topoext is enabled, and prevent QEMU from
starting if topoext is enabled on a CPU without
X86CPUDefinition.cache_info.

We have lots of freedom on what to do when topoext is enabled or
when using new machine-types.  We just can't change the CPUID
data of old machine-types when topoext is disabled.


> 
> > > >
> > > > The original code had a bug here.   The associativity should have been 8.
> > > > My earlier response from the thread
> > > > http://patchwork.ozlabs.org/patch/884880/
> > > >
> > > > This should have been 8-way. This is a bug. Will fix.
> > > > This should have been (AMD_ENC_ASSOC(L2_ASSOCIATIVITY_AMD) <<
> > > 12)
> > >
> > > If we want to change the associativity, we must keep the old
> > > values on older machine-types, which was the whole purpose of the
> > > "legacy-cache" property.
> > >
> > > I suggest using the new X86CPUDefinition::cache_info field if you
> > > want to make AMD CPUs report different associativity.
> > 
> > Ok. Sure. I will change it. Thanks
> > 
> > >
> > > --
> > > Eduardo

-- 
Eduardo

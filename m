Received: from eggs.gnu.org ([2001:4830:134:3::10]:42676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gaLPv-00031w-C6
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gaLPs-0008KH-Mn
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:04:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:34912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1gaLPs-0008G2-8u
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:04:40 -0500
Message-ID: <1545401072.44118.7.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Fri, 21 Dec 2018 22:04:32 +0800
In-Reply-To: <5ee7dd18-e70c-e654-25ee-e700a8174ee9@redhat.com>
References: <1545227081-213696-1-git-send-email-robert.hu@linux.intel.com>
	<1545227081-213696-2-git-send-email-robert.hu@linux.intel.com>
	<20181219140136.GJ20465@redhat.com>
	<1545265096.44118.3.camel@linux.intel.com>
	<e1b012da-7aac-1063-35ae-0ab3c4c5eb4b@redhat.com>
	<1545310252.44118.5.camel@linux.intel.com>
	<5ee7dd18-e70c-e654-25ee-e700a8174ee9@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] i386: remove the new CPUID 'PCONFIG'
 from Icelake-Server CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, kai.huang@intel.com, luwei.kang@intel.com
Cc: robert.hu@intel.com, robert.hu@linux.intel.com, thomas.lendacky@amd.com, ehabkost@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net

On Fri, 2018-12-21 at 07:27 +0100, Paolo Bonzini wrote:
> On 20/12/18 13:50, Robert Hoo wrote:
> > On Thu, 2018-12-20 at 13:38 +0100, Paolo Bonzini wrote:
> > > On 20/12/18 01:18, Robert Hoo wrote:
> > > > I think the sooner, the better. Take the time window that
> > > > Icelake
> > > > CPU
> > > > model has just shipped with QEMU 3.1.0 and is not
> > > > publicly/widely
> > > > used
> > > > yet.
> > > 
> > > We should still leave it in the 3.1 machine types.  I've just
> > > sent a
> > > patch to do the same with MPX.
> > > 
> > 
> > I took a look your patch of "Disable MPX support on named CPU
> > models".
> > Seems you do the same as I do to PCONFIG. So you agree with my
> > above
> > patch?:-)
> > 
> > I won't object that keep it in 3.1 machine type as you do to MPX.
> 
> Sorry Robert, I changed my mind.  If no hypervisor exists that
> enables
> PCONFIG for guests (using the PCONFIG_ENABLE processor control),
> effectively no one can ever have used it.  We should disable it in
> all
> machine types and Cc qemu-stable.

Thanks Paolo.
> 
> In fact, the same is true for INTEL_PT, which is not supported by any
> released kernel version and, even is going to be available only with
> a
> module parameter when it will be.

Add Luwei in judging this.
> 
> This is not the same as MPX, which did work even though nobody was
> probably using it.
> 
> So this series is correct and I will follow up with one for INTEL_PT;
> however, this begs the question of how the patches are being tested.
> 
My apologies for carelessness.

I've seen you patch for INTEL_PT. So am I going to resend these 2
patches and Cc qemu-stable? or simply reply these 2 patches adding
qemu-stable in Cc list?

> Paolo

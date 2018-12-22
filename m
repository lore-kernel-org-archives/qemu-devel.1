Received: from eggs.gnu.org ([2001:4830:134:3::10]:33760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gaVev-0005w8-FV
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 20:00:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gaVel-0003Ud-BC
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 20:00:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:45757)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1gaVeZ-0007Pl-OS
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 20:00:34 -0500
Message-ID: <1545440328.44118.8.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Sat, 22 Dec 2018 08:58:48 +0800
In-Reply-To: <bd0addb6-9d5f-b4dc-8cd9-f2d096ccd16c@redhat.com>
References: <1545227081-213696-1-git-send-email-robert.hu@linux.intel.com>
	<1545227081-213696-2-git-send-email-robert.hu@linux.intel.com>
	<20181219140136.GJ20465@redhat.com>
	<1545265096.44118.3.camel@linux.intel.com>
	<e1b012da-7aac-1063-35ae-0ab3c4c5eb4b@redhat.com>
	<1545310252.44118.5.camel@linux.intel.com>
	<5ee7dd18-e70c-e654-25ee-e700a8174ee9@redhat.com>
	<1545401072.44118.7.camel@linux.intel.com>
	<bd0addb6-9d5f-b4dc-8cd9-f2d096ccd16c@redhat.com>
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

On Fri, 2018-12-21 at 16:03 +0100, Paolo Bonzini wrote:
> On 21/12/18 15:04, Robert Hoo wrote:
> > > So this series is correct and I will follow up with one for
> > > INTEL_PT;
> > > however, this begs the question of how the patches are being
> > > tested.
> > 
> > My apologies for carelessness.
> 
> No problem.  In the future please check that "-cpu Icelake-Client"
> doesn't have warnings such as
> 
> qemu-system-x86_64: warning: host doesn't support requested feature:
> CPUID.07H:EBX.intel-pt [bit 25]
> 
> when run on an Icelake-Client host.

Sure. I'm going to ask our validation team to add these in test
criteria.
> 
> > I've seen you patch for INTEL_PT. So am I going to resend these 2
> > patches and Cc qemu-stable? or simply reply these 2 patches adding
> > qemu-stable in Cc list?
> 
> I can take care of that, thanks.
> 
> Paolo
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqj2P-00010r-Qc
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqj2K-0002sw-NW
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:59:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35004 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fqj2K-0002s2-GL
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:59:48 -0400
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-2-git-send-email-robert.hu@linux.intel.com>
	<f859ae02-015a-5ef8-66b4-f54a630d1f5f@redhat.com>
	<20180817155524.GF15372@localhost.localdomain>
	<d0df647b-ed1c-e497-10a7-f64a048b9f19@redhat.com>
	<20180817174814.GI15372@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b71dd1c-59d2-324d-0284-0ea5869f4ec1@redhat.com>
Date: Fri, 17 Aug 2018 19:59:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180817174814.GI15372@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] X86CPU "feature-words" property on QEMU (was Re:
 [PATCH v3 1/3] x86: Data structure changes to support MSR based) features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Robert Hoo <robert.hu@linux.intel.com>, rth@twiddle.net, thomas.lendacky@amd.com, qemu-devel@nongnu.org, robert.hu@intel.com, jingqi.liu@intel.com, Jiri Denemark <jdenemar@redhat.com>, libvir-list@redhat.com

On 17/08/2018 19:48, Eduardo Habkost wrote:
> So let's do what's necessary to remove it.  But I don't think the
> removal of "feature-words" should block the inclusion of this
> series.
> 
> Now, should QOM properties follow our feature deprecation policy,
> or they were never a supported external API and we can remove it
> immediately?
> 
> CCing Jiri and libvir-list, because I just found that there's
> code on libvirt that uses it, but I don't know exactly it does
> with that info.

It is used to check whether the host supports invtsc and pv-unhalt and
avoid changing the guest ABI when migrating: see
https://marc.info/?l=libvir-list&m=152445761414746&w=2 for a patch that
introduces one user.

I think we should extend it to MSRs, not remove it.

Paolo

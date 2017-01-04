Received: from eggs.gnu.org ([2001:4830:134:3::10]:60861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cOkCl-0005zQ-J5
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cOkCi-0007PH-Kq
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:58:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1cOkCi-0007P8-Eq
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:58:04 -0500
Date: Wed, 4 Jan 2017 09:57:40 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
Message-ID: <20170104115737.GC14961@amt.cnet>
References: <1482866480-26208-1-git-send-email-ehabkost@redhat.com>
	<1482866480-26208-3-git-send-email-ehabkost@redhat.com>
	<20170104114404.GA14961@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170104114404.GA14961@amt.cnet>
Subject: Re: [Qemu-devel] [PATCH 2/4] kvm: Allow invtsc migration if tsc-khz
 is set explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>

On Wed, Jan 04, 2017 at 09:44:06AM -0200, Marcelo Tosatti wrote:
> On Tue, Dec 27, 2016 at 05:21:18PM -0200, Eduardo Habkost wrote:
> > We can safely allow a VM to be migrated with invtsc enabled if
> > tsc-khz is set explicitly, because QEMU already refuses to start
> > if it can't set the TSC frequency to the configured value.
> 
> On the source host, yes, but on the destination it does not.
> 
> SOURCE: -cpu kvm64,tsc-frequency=2660001000
> DESTINATION: -cpu kvm64
> 
> Only prints:
> 
> qemu-system-x86_64: warning: TSC frequency mismatch between VM (2660001
> kHz) and host (2893428 kHz), and TSC scaling unavailable
> qemu-system-x86_64: warning: TSC frequency mismatch between VM (2660001
> kHz) and host (2893428 kHz), and TSC scaling unavailable
> 
> And allows migration.

Ignore that comment, patch 4 deals with it.

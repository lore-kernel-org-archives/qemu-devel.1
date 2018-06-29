Received: from eggs.gnu.org ([2001:4830:134:3::10]:44194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYxE7-0002AM-Q3
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYxE4-0000PK-5r
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:30:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fYxE3-0000OS-KH
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:30:27 -0400
Date: Fri, 29 Jun 2018 14:30:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180629173023.GN7451@localhost.localdomain>
References: <1529897961-134132-1-git-send-email-robert.hu@linux.intel.com>
	<1529897961-134132-3-git-send-email-robert.hu@linux.intel.com>
	<58ec011e-0f19-f882-abca-dd73bda95fe5@redhat.com>
	<20180628183033.GF914@localhost.localdomain>
	<a1bae170-2543-2030-05a7-51378544b575@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1bae170-2543-2030-05a7-51378544b575@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] i386: Add CPUID bit and feature words
 for IA32_ARCH_CAPABILITIES MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Robert Hoo <robert.hu@linux.intel.com>, qemu-devel@nongnu.org, rth@twiddle.net, robert.hu@intel.com, "Daniel P. Berrange" <berrange@redhat.com>

On Fri, Jun 29, 2018 at 01:34:04PM +0200, Paolo Bonzini wrote:
> On 28/06/2018 20:30, Eduardo Habkost wrote:
> >> For migration to work, you need to add new "features" corresponding to
> >> the bits in the MSR, and include them in the Icelake-Server and
> >> Icelake-Client models.  Unfortunately there is no code for this in QEMU
> >> yet, though the API is there in KVM.
> > Will all Icelake VCPUs of a given model have the same value on
> > MSR_IA32_ARCH_CAPABILITIES?
> > 
> > If not, we can't choose a value that will work on all cases, and
> > it will require management software to be smarter and explicitly
> > configure some of the MSR bits on the command-line.
> 
> We can expect that it will change as more vulnerabilities are found and
> more microcode updates are issued.  We should get it right from the
> beginning.

Right.  Also, we probably want to enable arch-capabilities on
CPUID by default whenever possible, even if using an old CPU
model.  I expect Daniel's versioned CPU model proposal to help us
address this.

I'm worried about the soft freeze deadline (next Tuesday),
though.  I wouldn't like Icelake to miss QEMU 3.0 just because we
couldn't decide on a default MSR_IA32_ARCH_CAPABILITIES value in
time.

-- 
Eduardo

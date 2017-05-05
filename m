Received: from eggs.gnu.org ([2001:4830:134:3::10]:42408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6guz-0004ri-Dw
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6guv-00076B-GB
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:21:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d6guv-00075v-AG
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:21:21 -0400
Date: Fri, 5 May 2017 14:21:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170505172118.GJ3482@thinpad.lan.raisama.net>
References: <20170502203115.22233-1-ehabkost@redhat.com>
	<20170502203115.22233-5-ehabkost@redhat.com>
	<20170504114938.3c58ebf0@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170504114938.3c58ebf0@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] x86: Support feature=force on the
 command-line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Thu, May 04, 2017 at 11:49:38AM +0200, Igor Mammedov wrote:
> On Tue,  2 May 2017 17:31:15 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > Introduce a new CPUFeatureSetting QAPI data type, and use it to support
> > feature=force on -cpu.
> commit message lacks rationale why it's needed.
> I suspect that it's to enable forced mwait.
> It would be nice to put here answer to what
> motivated to write this patch and reference commit ids
> of kernel patches if there are/needed any to make it work.

In this case I need to ask Alex for help writing the rationale,
as he is sent the original mwait CPUID override patch.

It's not clear to me yet why KVM doesn't return MONITOR on
GET_SUPPORTED_CPUID today, making this patch unnecessary.

-- 
Eduardo

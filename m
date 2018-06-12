Received: from eggs.gnu.org ([2001:4830:134:3::10]:57148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSkoS-0000w7-Km
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSko1-0000Yj-9V
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:02:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSko1-0000Y6-2P
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:01:57 -0400
Date: Tue, 12 Jun 2018 12:01:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180612150153.GK7451@localhost.localdomain>
References: <20180611203712.12086-1-ehabkost@redhat.com>
	<a8426bf6-7531-6306-d1c6-bb4c6c2099cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8426bf6-7531-6306-d1c6-bb4c6c2099cd@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] i386: Remove ospke CPUID flag name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Tue, Jun 12, 2018 at 08:55:55AM +0200, Paolo Bonzini wrote:
> On 11/06/2018 22:37, Eduardo Habkost wrote:
> > RFC NOTE: Paolo, Richard, as far as I can see, there's no point
> > in enabling OSPKE in user-mode QEMU.  Do you confirm that?
> > 
> > OSPKE is not a static feature flag: it changes dynamically at
> > runtime depending on CR4, and it was never configurable: KVM
> > never returned OSPKE on GET_SUPPORTED_CPUID, and on TCG enables
> > it automatically if CR4_PKE_MASK is set.
> > 
> > Remove OSPKE from the feature name array so users don't try to
> > configure it manually.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> Yes, it's the same as OSXSAVE.  Thanks!

CR4_OSXSAVE_MASK is automatically enabled on user-mode QEMU,
though.

My question is if it would make any sense to enable CR4_PKE_MASK
too.

-- 
Eduardo

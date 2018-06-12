Received: from eggs.gnu.org ([2001:4830:134:3::10]:54428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSnzJ-0007ff-Lu
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSnzE-0002Ml-Ow
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:25:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSnzE-0002MP-I0
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:25:44 -0400
Date: Tue, 12 Jun 2018 15:25:41 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180612182541.GN7451@localhost.localdomain>
References: <20180611203712.12086-1-ehabkost@redhat.com>
	<a8426bf6-7531-6306-d1c6-bb4c6c2099cd@redhat.com>
	<20180612150153.GK7451@localhost.localdomain>
	<6c9b3744-7323-cd1f-7b07-2b77df7ae80d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c9b3744-7323-cd1f-7b07-2b77df7ae80d@redhat.com>
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

On Tue, Jun 12, 2018 at 05:12:58PM +0200, Paolo Bonzini wrote:
> On 12/06/2018 17:01, Eduardo Habkost wrote:
> >>>
> >>> Remove OSPKE from the feature name array so users don't try to
> >>> configure it manually.
> >>>
> >>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> >> Yes, it's the same as OSXSAVE.  Thanks!
> > CR4_OSXSAVE_MASK is automatically enabled on user-mode QEMU,
> > though.
> > 
> > My question is if it would make any sense to enable CR4_PKE_MASK
> > too.
> 
> If you mean OSPKE, then yes---if PKU is available.  Likewise, OSXSAVE
> should only be enabled if XSAVE is available.

Yeah, I mean enabling it only if PKU is available, like we
already do with OSXAVE/XSAVE.

But we don't do it today, so enabling it automatically in
CONFIG_USER_ONLY would be a new feature.  Would it be useful for
anything, though?

I'm asking that to find out if somebody could be already using
"-cpu ...,+ospke" with user-mode QEMU today (which this patch
would break).  If RDPKRU/WRPKRU is useless under user-mode QEMU,
than we don't need to worry about that.

-- 
Eduardo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMBoW-0002HJ-T4
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMBoS-0003cl-0b
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:27:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fMBoR-0003cN-RR
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:27:15 -0400
Date: Fri, 25 May 2018 15:27:13 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180525152433-mutt-send-email-mst@kernel.org>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
	<1527086545-68024-8-git-send-email-mst@redhat.com>
	<CAFEAcA9JwWR29YSBKGS1fmmOE=wrSQY+OeJxQc4kmAEHRXUzWQ@mail.gmail.com>
	<CAFEAcA9mAMCznsf1hao2PFziXnATrCxa8Of33NckUGXxFU6yEQ@mail.gmail.com>
	<20180525151719-mutt-send-email-mst@kernel.org>
	<CAFEAcA_bDdefEuy183ma4oso5bZ2QxheDs9oOObBCKPL2hx+Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_bDdefEuy183ma4oso5bZ2QxheDs9oOObBCKPL2hx+Uw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 07/28] x86/cpu: use
 standard-headers/asm-x86.kvm_para.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm-devel <kvm@vger.kernel.org>

On Fri, May 25, 2018 at 01:21:24PM +0100, Peter Maydell wrote:
> On 25 May 2018 at 13:18, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Fri, May 25, 2018 at 12:53:44PM +0100, Peter Maydell wrote:
> >> For the moment I'm using this workaround (I wanted to do a header
> >> update for something else I'm working on):
> >>
> >> --- a/target/i386/kvm.c
> >> +++ b/target/i386/kvm.c
> >> @@ -48,6 +48,11 @@
> >>  #include "exec/memattrs.h"
> >>  #include "trace.h"
> >>
> >> +/* Work around this kernel header constant changing its name */
> >> +#ifndef KVM_HINTS_REALTIME
> >> +#define KVM_HINTS_REALTIME KVM_HINTS_DEDICATED
> >> +#endif
> >> +
> >>  //#define DEBUG_KVM
> >>
> >>  #ifdef DEBUG_KVM
> >
> > I don't think we need this chunk.
> 
> My view is that header update commits should be exactly and only
> the result of running update-linux-headers, no manual tweaking.
> If you don't add this chunk before the update, compilation with the
> update will fail. You can remove the chunk after the update, of course...
> 
> thanks
> -- PMM

I see.  I guess you did all the work already, do you still need help
or will you just go ahead and post it? Or even commit directly,
it's a trivial enough patch.

-- 
MST

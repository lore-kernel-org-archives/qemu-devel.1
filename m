Received: from eggs.gnu.org ([209.51.188.92]:57028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtDY6-0007yd-RU
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtDY5-0007Fx-Rd
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:31:10 -0500
Date: Mon, 11 Feb 2019 16:31:02 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190211163102.0a99b023.cohuck@redhat.com>
In-Reply-To: <6de44209-a135-0894-5407-4f6af7a0965e@suse.de>
References: <1549456893-16589-1-git-send-email-thuth@redhat.com>
	<20190206135840.60a2a49f.cohuck@redhat.com>
	<52b3de29-6918-952d-9d91-abdfb6dba25b@vivier.eu>
	<6de44209-a135-0894-5407-4f6af7a0965e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x: Fix the confusing
 contributions-after-2012 license statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Christian Borntraeger <borntraeger@de.ibm.com>

On Mon, 11 Feb 2019 16:24:48 +0100
Alexander Graf <agraf@suse.de> wrote:

> On 02/06/2019 02:02 PM, Laurent Vivier wrote:
> > On 06/02/2019 13:58, Cornelia Huck wrote:  
> >> On Wed,  6 Feb 2019 13:41:33 +0100
> >> Thomas Huth <thuth@redhat.com> wrote:
> >>  
> >>> The license information in these files is rather confusing. The text
> >>> declares LGPL first, but then says that contributions after 2012 are
> >>> licensed under the GPL instead. How should the average user who just
> >>> downloaded the release tarball know which part is now GPL and which
> >>> is LGPL?  
> >> FWIW, that statement was added in ccb084d3f0ec ("s390: new
> >> contributions GPLv2 or later").
> >>  
> >>> Looking at the text of the LGPL (see COPYING.LIB in the top directory),
> >>> the license clearly states how this should be done instead:
> >>>
> >>> "3. You may opt to apply the terms of the ordinary GNU General Public
> >>>   License instead of this License to a given copy of the Library. To do
> >>>   this, you must alter all the notices that refer to this License, so
> >>>   that they refer to the ordinary GNU General Public License, version 2,
> >>>   instead of to this License."  
> >> Hm. This talks about GPL v2, not GPL v2-or-later...
> >>  
> >>> Thus let's clean up the confusing statements and use the proper GPL
> >>> text only.
> >>>
> >>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>> ---
> >>>   linux-user/s390x/target_cpu.h | 19 ++++++++-----------
> >>>   target/s390x/cpu.c            | 19 ++++++++-----------
> >>>   target/s390x/cpu.h            | 19 ++++++++-----------
> >>>   target/s390x/kvm.c            | 19 ++++++++-----------  
> >> BTW: Is the original author of the code still around?  
> > For the linux-user/s390x/target_cpu.h, it seems this code has been pushed by Alex Graf:
> >
> > commit 10ec51174ca69a4c3c5149b0b3baaa6ccba66273
> > Author: Alexander Graf <agraf@suse.de>
> > Date:   Sat Dec 5 12:44:21 2009 +0100
> >
> >      S/390 CPU fake emulation
> >      
> >      Because Qemu currently requires a TCG target to exist and there are quite some
> >      useful helpers here to lay the groundwork for out KVM target, let's create a
> >      stub TCG emulation target for S390X CPUs.
> >      
> >      This is required to make tcg happy. The emulation target itself won't work
> >      though.
> >      
> >      Signed-off-by: Alexander Graf <agraf@suse.de>
> >      Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> >
> > But the "(c) 2009 Ulrich Hecht" is confusing.  
> 
> Why? Ulrich was the one that started the port, I then cleaned it up, 
> improved it, added system emulation and upstreamed it.

It's just a bit confusing that Ulrich does not show up in the sign-off
chain.

> What problem exactly are you trying to solve?

The confusing license statements?

I thought I'd ask whether the original author had any thoughts; if you
think this patch is problematic, I can dequeue it again.

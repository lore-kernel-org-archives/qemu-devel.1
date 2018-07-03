Received: from eggs.gnu.org ([2001:4830:134:3::10]:53109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bergwolf@gmail.com>) id 1faCdY-0002lG-4G
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 00:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bergwolf@gmail.com>) id 1faCdX-0002To-4x
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 00:09:56 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:32922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bergwolf@gmail.com>) id 1faCdW-0002S1-UT
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 00:09:55 -0400
Received: by mail-wr0-x243.google.com with SMTP id k7-v6so437264wrq.0
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 21:09:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180702221516.GB8790@redhat.com>
References: <20180331084500.33313-1-jiangshanlai@gmail.com>
	<20180702131054.GE2155@stefanha-x1.localdomain>
	<CA+a=Yy72YN1DAczTnb47b4ZW_vummOVuK3M=F2CF5KF3mRD2Zw@mail.gmail.com>
	<20180702221516.GB8790@redhat.com>
From: Peng Tao <bergwolf@gmail.com>
Date: Tue, 3 Jul 2018 12:09:33 +0800
Message-ID: <CA+a=Yy5db+YZgT3fCJ6+C4hUemEv_o6rqZ0qapfH3h1AnbRzUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] migration: add capability to bypass the
 shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Xu Wang <gnawux@gmail.com>, "James O . D . Hunt" <james.o.hunt@intel.com>, Juan Quintela <quintela@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

On Tue, Jul 3, 2018 at 6:15 AM, Andrea Arcangeli <aarcange@redhat.com> wrote:
> Hello,
>
> On Mon, Jul 02, 2018 at 09:52:08PM +0800, Peng Tao wrote:
>> I think we can write some host generated random seeds to guest's
>> urandom device, when cloning VMs from the same template before handing
>> it to users. Is it enough or do you think there are more to do w/
>> re-randomizing?
>
> That may be enough, but it's critically important to get
> right. Reusing the same /dev/urandom number just twice on two
> different operations, can lead to leak of the entire private key even
> if the reused random number itself is not predictable.
>
> You may want to look into the upstream random number generator that
> can be configured at build time to printk() a warning if it's being
> used at boot before it had its "shutdown" state restored. It would
> sound safer if you could re-trigger such warning post vmrestore of a
> cloned image if userland uses random number before the random number
> has been re-seeded post vmrestore. With a full loaded userland running
> immediately post vmrestore, an userland race condition would otherwise
> risk to go unnoticed.
>
Good point! Thanks a lot!

Cheers,
Tao

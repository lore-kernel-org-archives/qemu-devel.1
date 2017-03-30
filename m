Received: from eggs.gnu.org ([2001:4830:134:3::10]:57982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctbDP-0000QV-5f
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctbDM-00064f-2A
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:38:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ctbDL-000638-SP
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:38:15 -0400
Date: Thu, 30 Mar 2017 15:38:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170330143808.GH2800@work-vm>
References: <20170330050924.22134-1-iwona260909@gmail.com>
	<20170330142848.GK3709@thinpad.lan.raisama.net>
	<490e1a52-f8b9-ee01-aa57-fd0b672be36c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <490e1a52-f8b9-ee01-aa57-fd0b672be36c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] hmp: fix "info cpu" segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Iwona Kotlarska <iwona260909@gmail.com>, qemu-devel@nongnu.org, marcel@redhat.com, rth@twiddle.net

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> 
> 
> On 30/03/2017 16:28, Eduardo Habkost wrote:
> > On Thu, Mar 30, 2017 at 07:09:24AM +0200, Iwona Kotlarska wrote:
> >> Running QEMU with "qemu-system-x86_64 -M none -nographic -m 256" and executing
> >> "dump-guest-memory /dev/null 0 8192" results in segfault.
> >> Fix by checking if we have CPU.
> >>
> >> Signed-off-by: Iwona Kotlarska <iwona260909@gmail.com>
> > 
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> > 
> > Thanks!
> > 
> > Paolo, are you queueing x86 bug fixes for the next -rc?
> 
> This being HMP, I was leaving it to Dave, but I can queue it too since I
> have some memory API stuff to post too.

Yeh I'll take this.

Dave

> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

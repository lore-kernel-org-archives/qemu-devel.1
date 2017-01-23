Received: from eggs.gnu.org ([2001:4830:134:3::10]:52888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1cVcRj-0001Ut-Cs
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1cVcRg-0006yx-5O
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:05:59 -0500
Received: from mx4-phx2.redhat.com ([209.132.183.25]:54044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1cVcRf-0006yi-SE
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:05:56 -0500
Date: Mon, 23 Jan 2017 06:05:54 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <535965022.14896900.1485169554749.JavaMail.zimbra@redhat.com>
In-Reply-To: <4ef4f8ad-d492-0276-3c30-e51fe3445a08@redhat.com>
References: <1485069471-3680-1-git-send-email-pagupta@redhat.com>
	<20170123054052.GA1679@amit-lp.rh>
	<4ef4f8ad-d492-0276-3c30-e51fe3445a08@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Change name of live migration thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com

Hi Paolo,

> > On (Sun) 22 Jan 2017 [12:47:51], Pankaj Gupta wrote:
> >> Change the name of live migration thread from 'migration'
> >> to 'qemu_vm_migration' to identify it clearly. 'migration'
> >> is a generic word and kernel also has  tasks for process
> >> migration with the name 'migration/cpu#'.
> > 
> > Makes sense.
> > 
> > Reviewed-by: Amit Shah <amit.shah@redhat.com>
> 
> It's a bit ugly that no other thread name has qemu in it, and the limit
> is 15 characters---which is more than "qemu_vm_migration"'s length.  So
> maybe "live_migration" or "migrate" would be better.

Thanks for the suggestion.
"live_migration" seems like good option.
> 
> Spaces vs. underscores are also inconsistent.  A patch to fix that would
> be helpful!

Sure, will do that.
> 
> Paolo
> 

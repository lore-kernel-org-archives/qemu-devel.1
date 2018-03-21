Received: from eggs.gnu.org ([2001:4830:134:3::10]:53961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyXKR-0000S8-2B
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 02:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyXKM-0004wq-2J
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 02:34:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32906 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eyXKL-0004wm-Tw
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 02:34:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52841406E8C3
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 06:34:20 +0000 (UTC)
Date: Wed, 21 Mar 2018 14:34:13 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180321063413.GA20571@xz-mi>
References: <20180320151857.26340-1-pbonzini@redhat.com>
	<20180321032547.GB20227@xz-mi>
	<0378f258-f357-5fb9-b98f-8dd5d95b8db9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0378f258-f357-5fb9-b98f-8dd5d95b8db9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] chardev-socket: remove useless if
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Mar 21, 2018 at 06:50:46AM +0100, Paolo Bonzini wrote:
> On 21/03/2018 04:25, Peter Xu wrote:
> > On Tue, Mar 20, 2018 at 04:18:57PM +0100, Paolo Bonzini wrote:
> >> This trips Coverity, which believes the subsequent qio_channel_create_watch
> >> can dereference a NULL pointer.  In reality, tcp_chr_connect's callers
> >> all have s->ioc properly initialized, since they are all rooted at
> >> tcp_chr_new_client.
> >>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > (maybe replacing with an assertion would be nicer? No big deal.)
> 
> It's already asserting, it just raises SIGSEGV instead of SIGABRT. :)

Ah yes it's in the next qio_channel_create_watch(). :)

-- 
Peter Xu

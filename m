Received: from eggs.gnu.org ([2001:4830:134:3::10]:38270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fZwSd-0002ED-0k
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fZwSZ-0002t3-RM
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:53:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fZwSZ-0002sz-MQ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:53:31 -0400
Date: Mon, 2 Jul 2018 18:53:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180702105325.GN2455@xz-mi>
References: <33183CC9F5247A488A2544077AF19020DB03024F@dggeml511-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DB03024F@dggeml511-mbx.china.huawei.com>
Subject: Re: [Qemu-devel] about live memory snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, dplotnikov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Sat, Jun 30, 2018 at 01:45:29AM +0000, Gonglei (Arei) wrote:
> Hi Peter,
> 
> As we discussed in LC3 China, the current scheme of "migration to file" 
> can't fit on production environment, which will cause the snapshot file bigger 
> and bigger when the guest is under enough memory pressure. We can't
> assume what size the snapshot file is.
>  
> Pls have a look if we have a simple method to resolve the problem. :)

Yeah, it seems that the requirement of this live snapshot feature is
there for a long time but we haven't yet figured out a good way to
solve it.

> 
> PS: the below link is zhanghailiang's scheme based on userfaultfd.
> 
> https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg00664.html

Thanks for the pointer!

Just to mention that there is another ongoing work from Denis that
implemented similar feature but with mprotect() and a new
(to-be-proposed?) kvm interface:

http://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08684.html

Hopefully we can figure something out soon on the list.

Regards,

-- 
Peter Xu

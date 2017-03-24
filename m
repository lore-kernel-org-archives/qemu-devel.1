Received: from eggs.gnu.org ([2001:4830:134:3::10]:39821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1crTQ4-0005mr-PE
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1crTPz-0005bj-RB
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:54:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1crTPz-0005bW-Ku
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:54:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7050E4E02D
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 17:54:31 +0000 (UTC)
Date: Fri, 24 Mar 2017 18:54:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170324175338.GD3823@noname.redhat.com>
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-5-git-send-email-armbru@redhat.com>
	<fe5583dc-bbe7-3387-dea9-3f4b89d682a8@redhat.com>
	<a438ce0a-3035-1b2e-0d16-296ee930ed35@redhat.com>
	<e6621b99-a980-dc61-b267-590eb08923c0@redhat.com>
	<59a3aed6-e1cf-a601-4369-1a7cd74500cc@redhat.com>
	<20170324035537.GA22342@localhost.localdomain>
	<87fui3yx0y.fsf@dusky.pond.sub.org>
	<20170324124213.GC22342@localhost.localdomain>
	<89101331-9bba-fb6c-42a1-dfce7775fe4c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89101331-9bba-fb6c-42a1-dfce7775fe4c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] rbd: Peel off redundant
 RbdAuthMethod wrapper struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, jdurgin@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, dillaman@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>

Am 24.03.2017 um 14:49 hat Eric Blake geschrieben:
> On 03/24/2017 07:42 AM, Jeff Cody wrote:
> 
> > Agree.  My preference is to leave it as an array of methods, so long as that
> > is tenable to libvirt.
> 
> The -drive syntax should remain unchanged (that's an absolute must for
> libvirt).  But the QMP syntax being an array of methods sounds best to
> me, and I think password-secret should be part of the array.  So my vote
> would be for:
> 
> { "driver": "rbd", "image": "foo",
>   "auth": [ { "type": "cephx", "password-secret": "sec0" },
>             { "type": "none" } ],
>   "pool": "bar" }
> 
> It makes mapping -drive arguments into QMP form a bit trickier, but the
> QMP form is then easily extensible if we add another auth method down
> the road.

Not sure if anybody cares, but I came to the same conclusion, so I like
this.

Kevin

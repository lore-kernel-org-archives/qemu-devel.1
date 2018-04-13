Received: from eggs.gnu.org ([2001:4830:134:3::10]:57608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1f6wxQ-0004oR-Lr
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1f6wxK-0007C0-MJ
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:33:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1f6wxK-0007BX-Ei
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:33:26 -0400
Date: Fri, 13 Apr 2018 14:33:18 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20180413113317.GA3624@yuvallap>
References: <20180312183628.394722-9-eblake@redhat.com>
	<20180412175140.GA5406@yuvallap>
	<db626048-18ff-0a21-c084-aaa79a32b980@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db626048-18ff-0a21-c084-aaa79a32b980@redhat.com>
Subject: Re: [Qemu-devel] [PULL, 08/36] qapi: Remove qobject_to_X() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Thu, Apr 12, 2018 at 03:52:50PM -0500, Eric Blake wrote:
> On 04/12/2018 12:51 PM, Yuval Shaia wrote:
> > Hi Eric,
> > 
> > On Mon, Mar 12, 2018 at 01:35:59PM -0500, Eric Blake wrote:
> >> From: Max Reitz <mreitz@redhat.com>
> >>
> >> They are no longer needed now.
> > 
> > I'm doing some off-list development which use these functions.
> > Unfortunately i'm not subscribed (yet) to qemu-devel so obviously missed
> > this email.
> > 
> > Is there any alternative to these functions?
> 
> Yes, in the patches right before this one.
> 
> > 
> > My code looks something like this:
> > 
> > QObject *oid;
> > unsigned long id;
> > 
> > oid = qlist_pop(list);
> > id = qnum_get_uint(qobject_to_qnum(oid));
> > 
> 
> id = qnum_get_uint(qobject_to(QNum, oid));

Thanks,

> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6161f7288=Ian.Jackson@citrix.com>)
	id 1f0TRt-0007mJ-QH
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6161f7288=Ian.Jackson@citrix.com>)
	id 1f0TRn-0006UN-Kj
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:50:13 -0400
Received: from smtp.citrix.com ([66.165.176.89]:49014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6161f7288=Ian.Jackson@citrix.com>)
	id 1f0TRn-0006Tu-En
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:50:07 -0400
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23224.64658.859133.831793@mariner.uk.xensource.com>
Date: Mon, 26 Mar 2018 14:58:42 +0100
In-Reply-To: <e2f1cee4-8dad-d901-ae2f-51495a855b4e@redhat.com>
References: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
	<1520535787-6223-2-git-send-email-ian.jackson@eu.citrix.com>
	<e2f1cee4-8dad-d901-ae2f-51495a855b4e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/12] checkpatch: Add
 xendevicemodel_handle to the list of types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano  Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Eric  Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Paolo Bonzini writes ("Re: [PATCH 01/12] checkpatch: Add xendevicemodel_handle to the list of types"):
> On 08/03/2018 20:02, Ian Jackson wrote:
> > This avoids checkpatch misparsing (as statements) long function
> > definitions or declarations, which sometimes start with constructs
> > like this:
> > 
> >   static inline int xendevicemodel_relocate_memory(
> >       xendevicemodel_handle *dmod, domid_t domid, ...
...
> 
> Or just rename it so that it is CamelCase.  Then checkpatch will be happy.

I can do that if you want, although it seems a bit like pointless
churn.  If I do that it ought to be renamed as well as re-spelled
because xendevicemodel_handle is actually a struct, not a "handle"
(ie, not a scalar).[1]  So
   s/xendevicemodel_handle/XendevicemodelInterface/
I guess ?

[1] If it were a scalar CODING_STYLE says it should be in lowercase
with _t.  This is a violation of the C standard, which reserves names
ending _t for the implementation...

Ian.

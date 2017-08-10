Received: from eggs.gnu.org ([2001:4830:134:3::10]:45532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfhSz-0003zd-M3
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfhSt-0000Oh-MD
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:01:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dfhSt-0000OL-H2
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:01:07 -0400
Date: Thu, 10 Aug 2017 09:01:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170810090100.4885f0ea.cohuck@redhat.com>
In-Reply-To: <20170809185248.230b6166@bahia.lan>
References: <20170809163019.21593-1-cohuck@redhat.com>
	<20170809185248.230b6166@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] 9pfs: fix dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, qemu-devel@nongnu.org

On Wed, 9 Aug 2017 18:53:11 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Wed,  9 Aug 2017 18:30:19 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > Nothing in fsdev/ or hw/9pfs/ depends on pci; it should rather depend
> > on CONFIG_VIRTFS and CONFIG_VIRTIO/CONFIG_XEN only.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   
> 
> I think we're ok now. Thanks for fixing that!
> 
> IIUC, this patch will be needed when your zpci cleanup patches get merged.

Yes, it does not really matter before that.

> I suggest you add it to your series with my:
> 
> Acked-by: Greg Kurz <groug@kaod.org>

Thanks!

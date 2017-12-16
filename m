Received: from eggs.gnu.org ([2001:4830:134:3::10]:43570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQ582-0001tS-5D
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 00:35:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQ57z-0002Xd-2k
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 00:35:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eQ57y-0002Wc-Sm
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 00:35:15 -0500
Date: Sat, 16 Dec 2017 13:34:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171216053458.GX7780@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-13-peterx@redhat.com>
	<20171213171934.GC8317@stefanha-x1.localdomain>
	<20171215094010.GB15187@lemon>
	<20171215132642.GH26982@stefanha-x1.localdomain>
	<20171215135353.GF15187@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171215135353.GF15187@lemon>
Subject: Re: [Qemu-devel] [RFC v5 12/26] qmp: negociate QMP capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Dec 15, 2017 at 09:53:53PM +0800, Fam Zheng wrote:
> On Fri, 12/15 13:26, Stefan Hajnoczi wrote:
> > > > QEMU always offers the 'oob' capability, even if the monitor does not
> > > > support it.  Should it send 'oob' only when mon->use_io_thr to make
> > > > things easier for clients?

Agree.

> > > 
> > > So should we firstly agree on whether the capabilities is on the current monitor
> > > connection or QEMU as a whole?
> > 
> > It's more flexible to allow per-connection capabilities.  Is there a
> > reason against it?
> 
> No, I just think either way we should document it. So if we define it
> per-connection, like you said, "oob" shouldn't be sent in the greeting message,
> and patch 11 need to be updated.

Yeah, that's where I'll do the update.  Thanks!

-- 
Peter Xu

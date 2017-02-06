Received: from eggs.gnu.org ([2001:4830:134:3::10]:49288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cabIQ-0004jI-3H
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 23:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cabIP-00082l-65
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 23:52:58 -0500
Date: Mon, 6 Feb 2017 12:52:48 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170206045248.GA5377@lemon.lan>
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-4-famz@redhat.com>
	<dba94e70-c4fd-4871-cdc1-0e0fc2d9522f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dba94e70-c4fd-4871-cdc1-0e0fc2d9522f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 03/16] qemu-io: Set "share-rw" flag
 together with read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com

On Sun, 02/05 22:52, Max Reitz wrote:
> On 23.01.2017 13:30, Fam Zheng wrote:
> > qemu-io is a low level tool to read or modify guest visible data, which
> > implies the user knows very well what is being done. Allowing reading
> > from a locked image is harmless in most cases, so do it.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  qemu-io.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> What about open_f()?

Right, should do the same.

Fam

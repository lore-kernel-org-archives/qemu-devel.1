Received: from eggs.gnu.org ([209.51.188.92]:60282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gj6q2-0007KX-Jj
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gj6fA-00009K-4o
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:08:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gj6f7-00005Y-A5
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:08:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8A5A46233
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 18:08:29 +0000 (UTC)
Date: Mon, 14 Jan 2019 13:08:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190114130814-mutt-send-email-mst@kernel.org>
References: <1545225205-7227-1-git-send-email-thuth@redhat.com>
	<87h8f9efa9.fsf@dusky.pond.sub.org>
	<20190114180410.GZ4500@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114180410.GZ4500@habkost.net>
Subject: Re: [Qemu-devel] [PATCH v2] hw/misc/ivshmem: Remove deprecated
 "ivshmem" legacy device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On Mon, Jan 14, 2019 at 04:04:10PM -0200, Eduardo Habkost wrote:
> On Wed, Dec 19, 2018 at 03:56:30PM +0100, Markus Armbruster wrote:
> > Thomas Huth <thuth@redhat.com> writes:
> > 
> > > It's been marked as deprecated in QEMU v2.6.0 already, so really nobody
> > > should use the legacy "ivshmem" device anymore (but use ivshmem-plain or
> > > ivshmem-doorbell instead). Time to remove the deprecated device now.
> > >
> > > Belatedly also update a mention of the deprecated "ivshmem" in the file
> > > docs/specs/ivshmem-spec.txt to "ivshmem-doorbell". Missed in commit
> > > 5400c02b90b ("ivshmem: Split ivshmem-plain, ivshmem-doorbell off ivshmem").
> > >
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > 
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> Who should merge this?

I can do it.

> -- 
> Eduardo

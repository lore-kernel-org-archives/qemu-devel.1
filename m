Received: from eggs.gnu.org ([2001:4830:134:3::10]:50052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPQbs-0005rD-UO
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 04:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPQbp-0007OV-3o
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 04:14:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPQbo-0007NC-TQ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 04:14:49 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F13E3C009A03
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 09:14:48 +0000 (UTC)
Date: Fri, 6 Jan 2017 09:14:43 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170106091443.GC31112@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170105160321.21786-1-berrange@redhat.com>
	<20170105160321.21786-5-berrange@redhat.com>
	<24cdd629-d593-fad5-8154-c4f44b559ad2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24cdd629-d593-fad5-8154-c4f44b559ad2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/8] io: add ability to associate an opaque
 "result" with with a task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Jan 05, 2017 at 02:32:46PM -0600, Eric Blake wrote:
> On 01/05/2017 10:03 AM, Daniel P. Berrange wrote:
> > Currently there is no data associated with a successful
> > task completion. This adds an opaque pointer to the task
> > to store an arbitrary result.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  include/io/task.h | 27 +++++++++++++++++++++++++++
> >  io/task.c         | 20 ++++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> > 
> 
> I suppose a different approach would have been changing QIOTaskFunc() to
> have a void* return, but that would be more invasive.  Grabbing the
> result separately from the task completing is a bit weird, but looks
> like it will work.

FYI, the design I've chosen here closely matches that used by GLib in its
own GTask / GAsyncResult, on which the QIOTask was modelled. The idea is
that in future when we eventually bump to a newer glib, we can switch
over to GTask easily.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

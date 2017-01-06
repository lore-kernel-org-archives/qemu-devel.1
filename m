Received: from eggs.gnu.org ([2001:4830:134:3::10]:54205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPTHS-0004Gc-Ep
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPTHP-00056L-9n
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:05:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPTHP-00056E-4D
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:05:55 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1249F64E2
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 12:05:55 +0000 (UTC)
Date: Fri, 6 Jan 2017 12:05:49 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170106120549.GJ31112@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170105160321.21786-1-berrange@redhat.com>
	<20170105160321.21786-7-berrange@redhat.com>
	<51fbdc69-0704-19bd-28b9-fc2310ee2e44@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51fbdc69-0704-19bd-28b9-fc2310ee2e44@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/8] io: change the QIOTask callback
 signature
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

On Thu, Jan 05, 2017 at 03:47:57PM -0600, Eric Blake wrote:
> On 01/05/2017 10:03 AM, Daniel P. Berrange wrote:
> > Currently the QIOTaskFunc signature takes an Object * for
> > the source, and an Error * for any error. We also need to
> > be able to provide a result pointer. Rather than continue
> > to add parameters to QIOTaskFunc, remove the existing
> > ones and simply pass the QIOTask object instead. This
> > has methods to access all the other data items required
> > in the callback impl.
> 
> Hmmm. If you're going to change the callback signature after all, then
> is it worth considering having the callback return void* instead of the
> clunky way of passing the result pointer around, with existing callers
> updated to return NULL if they have nothing better to do?  Accessing the
> error pointer through the QIOTask object seems okay, it's just the
> return type that feels clunky.
> 
> But that's bike-shedding, so I'll review as written.

Per my comments in previous patch, the approach taken here was chosen
to align with GLib's GTask/GAsyncResult design more closely.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpdFP-0005JR-J7
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:32:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpdFL-00037K-Ec
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:32:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpdFL-00036Z-8z
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:32:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1EC18C049E31
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 16:32:10 +0000 (UTC)
Date: Wed, 6 Sep 2017 17:32:05 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170906163205.GX15510@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170906115143.27451-1-quintela@redhat.com>
	<20170906115143.27451-2-quintela@redhat.com>
	<7e71d190-8e49-ca6b-ef44-522100b27b8c@redhat.com>
	<87pob351o5.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pob351o5.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v7 01/22] Revert "io: add new
 qio_channel_{readv, writev, read, write}_all functions"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

On Wed, Sep 06, 2017 at 04:42:18PM +0200, Juan Quintela wrote:
> Eric Blake <eblake@redhat.com> wrote:
> > On 09/06/2017 06:51 AM, Juan Quintela wrote:
> >> This reverts commit d4622e55883211072621958d39ddaa73483d201e.
> >
> > But with no reason why?  What bugs are you fixing by reverting this?
> 
> I put it on the cover letter.  I am investigating *why* it fails on me.
> It got the thread handed.

Your functions return the number of bytes written. My impl only
returns the 0 or -1 on the basis that the caller does not need
to know how many bytes were written - its always exactly the
amount asked for. You probably need to adjust your code to take
that into account.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

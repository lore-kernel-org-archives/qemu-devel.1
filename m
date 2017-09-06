Received: from eggs.gnu.org ([2001:4830:134:3::10]:53793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpb3H-0003gC-VG
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpb3D-0005UT-Tg
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:11:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpb3D-0005TW-NN
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:11:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4265356D3
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 14:11:30 +0000 (UTC)
Date: Wed, 6 Sep 2017 15:11:25 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170906141125.GT15510@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170906115143.27451-1-quintela@redhat.com>
	<20170906115143.27451-9-quintela@redhat.com>
	<f46e8437-a739-08cf-75c4-cbb5309b5c23@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f46e8437-a739-08cf-75c4-cbb5309b5c23@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 08/22] qio: Create new
 qio_channel_{readv, writev}_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Wed, Sep 06, 2017 at 09:03:40AM -0500, Eric Blake wrote:
> On 09/06/2017 06:51 AM, Juan Quintela wrote:
> > The functions waits until it is able to write the full iov.
> > 
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > 
> > --
> > 
> > Add tests.
> > 
> > fix reader to check for len == 0.
> > 
> > make reader wait on G_IO_IN (dave)
> > change tests to make sure that all combinations of call work with all backends
> 
> Since Dan's patch to add qio_channel_readv_all has already landed,
> shouldn't this patch just be rebased to add the tests? Or is it also
> fixing some bugs?

I don't think this patch is needed at all from the QIO pov now - the test
script changes don't add any extra coverage compared to what merged.

IOW, only needs the migration/ bit of the patch

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

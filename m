Received: from eggs.gnu.org ([2001:4830:134:3::10]:48216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f6xPh-0001kT-KL
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f6xPd-0007pU-M5
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:02:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f6xPd-0007oz-Hk
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:02:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14C038DC4F
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 12:02:41 +0000 (UTC)
Date: Fri, 13 Apr 2018 13:02:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180413120234.GF16263@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180404112731.5922-1-quintela@redhat.com>
	<20180404112731.5922-5-quintela@redhat.com>
	<20180412130932.GG2704@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180412130932.GG2704@work-vm>
Subject: Re: [Qemu-devel] [PATCH v7 4/8] migration: Create socket-address
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com

On Thu, Apr 12, 2018 at 02:09:33PM +0100, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
> > It will be used to store the uri parameters. We want this only for
> > tcp, so we don't set it for other uris.  We need it to know what port
> > is migration running.
> > 
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > 
> > --
> > 
> > This used to be uri parameter, but it has so many troubles to
> > reproduce that it don't just make sense.
> > 
> > This used to be a port parameter.  I was asked to move to
> > SocketAddress, done.
> > I also merged the setting of the migration tcp port in this one
> > because now I need to free the address, and this makes it easier.
> > This used to be x-socket-address with a single direction, now it is a
> > list of addresses.
> 
> Is there a reason it's a parameter rather than just an entry in
> MigrationInfo?

I imagine it is a side-effect of earlier versions of this patch
which used the migration parameter setter method. Having it in
the MigrationInfo does seem reasonable to me since this is not
a tunable parameter.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

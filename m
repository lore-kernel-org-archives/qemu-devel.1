Received: from eggs.gnu.org ([2001:4830:134:3::10]:57281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dT1kk-0002qi-T8
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dT1kg-0006OX-Ua
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:03:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dT1kg-0006ON-O0
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:03:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D56AC04D28B
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 08:03:04 +0000 (UTC)
Date: Thu, 6 Jul 2017 09:02:53 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170706080253.GA3988@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170705144302.32017-1-dgilbert@redhat.com>
	<20170705162811.GI22008@redhat.com> <20170705163324.GC2284@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170705163324.GC2284@work-vm>
Subject: Re: [Qemu-devel] [PATCH] hmp: Update info vnc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lcapitulino@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com

On Wed, Jul 05, 2017 at 05:33:24PM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrange (berrange@redhat.com) wrote:
> > On Wed, Jul 05, 2017 at 03:43:02PM +0100, Dr. David Alan Gilbert (git) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > The QMP query-vnc interfaces have gained a lot more information that
> > > the HMP interfaces hasn't got yet. Update it.
> > > 
> > > Note the output format has changed, but this is HMP so that's OK.
> > > 
> > > In particular, this now includes client information for reverse
> > > connections:
> > > 
> > > -vnc :0
> > > (qemu) info vnc
> > > default:
> > >   Server: 0.0.0.0:5900 (ipv4)
> > >     Auth: none (Sub: none)
> > >   Auth: none (Sub: none)
> > 
> > If you're reporting Auth: against the individual Server entry,
> > there's no reason to report it at the top level too. We only
> > keep that duplication in QMP for sake of backcompat, which
> > is not important for HMP
> 
> Where would it get reported for a 'reverse' connection then?
> That has no server entry.

Ah right. So lets only report it at the top level, if operating
in reverse mode.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

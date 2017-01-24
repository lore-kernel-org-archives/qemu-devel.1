Received: from eggs.gnu.org ([2001:4830:134:3::10]:41061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxaG-0006FC-Bp
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:40:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxaF-00011d-Bt
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:40:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVxaF-00011W-6a
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:40:11 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F52D7EBBF
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:40:11 +0000 (UTC)
Date: Tue, 24 Jan 2017 09:40:05 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170124094005.GE14563@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170120164322.21851-1-pbonzini@redhat.com>
	<20170120164322.21851-7-pbonzini@redhat.com>
	<20170124093619.GC14563@redhat.com>
	<e4da0456-32eb-0a26-07d3-46c7c9dfa4fd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4da0456-32eb-0a26-07d3-46c7c9dfa4fd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/17] io: make qio_channel_yield aware of
 AioContexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, famz@redhat.com

On Tue, Jan 24, 2017 at 10:38:51AM +0100, Paolo Bonzini wrote:
> 
> 
> On 24/01/2017 10:36, Daniel P. Berrange wrote:
> > On Fri, Jan 20, 2017 at 05:43:11PM +0100, Paolo Bonzini wrote:
> >> Support separate coroutines for reading and writing, and place the
> >> read/write handlers on the AioContext that the QIOChannel is registered
> >> with.
> >>
> >> Cc: Daniel P. Berrange <berrange@redhat.com>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>         v1->v2:
> >>         improved qio_channel_set_aio_context docs, renamed to
> >>                 qio_channel_attach_aio_context [Daniel, Stefan]
> >>         fixed pasto in "io: make qio_channel_yield aware of AioContexts"
> >>
> >>  include/io/channel.h | 47 ++++++++++++++++++++++++++--
> >>  io/channel.c         | 86 +++++++++++++++++++++++++++++++++++++++-------------
> >>  2 files changed, 109 insertions(+), 24 deletions(-)
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> 
> I suppose you mean either Reviewed-by or Acked-by? :)
> 
> Anyway, thanks for the reviews!

Well whatever is appropriate - I just meant to indicate that you can send
a pull request including these two io: patches without funnelling them
separately via my io-next queue :-)

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

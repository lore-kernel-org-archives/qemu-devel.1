Received: from eggs.gnu.org ([2001:4830:134:3::10]:51602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmxZr-0007pZ-Mc
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 03:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmxZo-0003u0-Jh
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 03:38:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmxZo-0003tY-Cs
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 03:38:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14E365F7AD
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 07:38:15 +0000 (UTC)
Date: Wed, 30 Aug 2017 15:38:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170830073810.GG5920@pxdev.xzpeter.org>
References: <1502777827-18874-1-git-send-email-peterx@redhat.com>
	<1502777827-18874-6-git-send-email-peterx@redhat.com>
	<20170815083714.GA9674@redhat.com>
	<20170815085006.GA19446@pxdev.xzpeter.org>
	<20170815092707.GE9674@redhat.com>
	<20170815094708.GB19446@pxdev.xzpeter.org>
	<20170816094713.GA2294@pxdev.xzpeter.org>
	<20170829103831.GE3783@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170829103831.GE3783@redhat.com>
Subject: Re: [Qemu-devel] [RFC 5/6] migration: store listen task tag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Aug 29, 2017 at 11:38:31AM +0100, Daniel P. Berrange wrote:
> > > > So, IMHO, you should change all the callbacks to 'return TRUE' so that
> > > > they keep the watch registered, and then explicitly call g_source_remove()
> > > > passing the listen tag, when incoming migration starts.
> > > 
> > > Yes this sounds better.  Thanks!
> > 
> > Hmm... when incoming migration starts, we are still in the handler of
> > the listening gsource. I am not sure whether it's safe to remove the
> > gsource in its own handlers.
> 
> Yes, it should be safe to call g_source_remove from within the handler
> itself.

Thanks for confirmation.  Will post a new version soon.

-- 
Peter Xu

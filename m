Received: from eggs.gnu.org ([2001:4830:134:3::10]:56983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dshlu-0001q3-Qb
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dshlr-0000rg-QF
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:58:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dshlr-0000pq-Km
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:58:27 -0400
Date: Fri, 15 Sep 2017 11:58:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170915035817.GN3617@pxdev.xzpeter.org>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<20170914185603.GB3280@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170914185603.GB3280@work-vm>
Subject: Re: [Qemu-devel] [RFC 00/15] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>

On Thu, Sep 14, 2017 at 07:56:04PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > This series was born from this one:
> > 
> >   https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04310.html
> 
> Are patches 1..6 separable and mergable without the rest ?

Yes I think so.

(I was always trying to put pre-requisite patches like these ones at
 the front of any of my series rather than separating them into more
 series, since I thought it is convenient for me to manage them (or
 add new ones when respin), and also easier for reviewers (so people
 don't need to try to find the dependencies).  And since I put them at
 the head, we can easily merge them without rebasing issue when they
 are good while the rest may still need further work.  Hopefully this
 is the right thing to do.)

-- 
Peter Xu

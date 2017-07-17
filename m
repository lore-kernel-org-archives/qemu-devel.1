Received: from eggs.gnu.org ([2001:4830:134:3::10]:56406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dX2sK-000466-Rt
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dX2sH-0000WZ-MT
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:03:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dX2sH-0000VE-GA
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:03:33 -0400
Date: Mon, 17 Jul 2017 11:03:26 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170717100326.GG3640@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170717063521.GA7393@lemon>
	<20170717090531.GA7163@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170717090531.GA7163@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On Mon, Jul 17, 2017 at 10:05:31AM +0100, Stefan Hajnoczi wrote:
> On Mon, Jul 17, 2017 at 02:35:21PM +0800, Fam Zheng wrote:
> > Q1: In the worst case, you get four individual auto replies from patchew. Is
> > that too many? Do you prefer one reply with all the results concatenated into
> > one?
> 
> I'd like to avoid situations where one of the failure emails is sent
> hours after the others, because it's possible that the patch series
> author has already sent the next (still broken) revision by that time.
> The simplest way to avoid that is by sending just one email.

If you do that, then you delay reporting of all 4 test systems, if only
one of them gets backlogged. I'd much rather see each test failure
reported immediately without waiting for other jobs which might complete
hours or days later in the worst case.

> > Q2: Some think the full log in the mail body is more than necessary. Is it
> > better or worse if it is a "tail -n 200" of the log in the body and the full log
> > attached?
> 
> tail output and a link to the full logs would be nice.  Often there is a
> lot of irrelevant output.



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

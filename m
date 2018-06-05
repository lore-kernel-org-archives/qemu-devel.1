Received: from eggs.gnu.org ([2001:4830:134:3::10]:46827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQ9Su-0002ts-T2
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQ9Sr-00022u-Ow
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:45:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42612 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQ9Sr-000223-8n
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:45:21 -0400
Date: Tue, 5 Jun 2018 18:45:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180605104515.GF9216@xz-mi>
References: <20180515234017.2277-1-quintela@redhat.com>
	<20180515234017.2277-17-quintela@redhat.com>
	<CAFEAcA_cpAT27=DQj6qyvoP8u=zUgzG2vidcgN=vP1KLDn8LMA@mail.gmail.com>
	<20180605074809.GE9216@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180605074809.GE9216@xz-mi>
Subject: Re: [Qemu-devel] [PULL 16/40] migration: allow dst vm pause on
 postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jun 05, 2018 at 03:48:09PM +0800, Peter Xu wrote:

[...]

> > There are also a couple of other things Coverity thinks might
> > be data race conditions (CID 1391295 and CID 1391288) that you
> > might want to look at, though I suspect they are false-positives
> > (access occurs before thread create of the thread the mutex
> > is providing protection against).
> 
> Could you kindly let me know if there is any way for me to lookup
> these CIDs?  E.g., I searched "CID 1391295 QEMU Coverity" on Google
> but I can't find any link.  Any preferred way to do this?
> 
> (I think a stupid way is to lookup the CID in every Coverity reports,
>  but I guess there is a faster way)

Dave helped pointed out that there was a CID entry on the top-right
corner that I can fill in...  I'll have a look on both defects.

Thanks,

-- 
Peter Xu

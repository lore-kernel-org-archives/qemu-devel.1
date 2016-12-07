Received: from eggs.gnu.org ([2001:4830:134:3::10]:60360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cEZ4o-0007VN-W0
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 05:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cEZ4o-0001Zo-1t
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 05:03:50 -0500
Date: Wed, 7 Dec 2016 18:03:39 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161207100339.GB2286@lemon>
References: <87oa0q1t21.fsf@dusky.pond.sub.org> <20161207025457.GB30227@lemon>
	<20161207094832.GA4773@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161207094832.GA4773@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block]  Meeting notes on -blockdev,
 dynamic backend reconfiguration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Wed, 12/07 10:48, Kevin Wolf wrote:
> > If so I think there is no race to worry about, mirror-filter should go
> > away only after a QMP command.
> 
> Currently, a mirror job goes away whenever it is done. This is not
> directly tied to a QMP command.

Ah right, block-job-complete is only "start to complete" and the job goes away
at some later point. I thought this is "the" QMP command but it is not.

> 
> Of course, in the new job API we want an explicit job-delete, so in
> that case it wouldn't happen, but we need to keep the old case for
> compatibility.

Another possibility is to add a placeholder node in the right location first
then fill in the actual throttling node once created. QMP owns the placeholder
node so it won't suddenly vanish when mirror job goes away.

Fam

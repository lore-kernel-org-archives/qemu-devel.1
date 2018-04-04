Received: from eggs.gnu.org ([2001:4830:134:3::10]:53805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f3WSi-0002vA-HP
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 20:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f3WSf-0002fT-DA
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 20:39:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f3WSf-0002ex-8l
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 20:39:37 -0400
Date: Wed, 4 Apr 2018 08:39:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180404003917.GF26441@xz-mi>
References: <20180403050115.6037-1-peterx@redhat.com>
	<e9d37d29-82ae-ac3e-9919-62586206c88a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9d37d29-82ae-ac3e-9919-62586206c88a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] monitor: bind dispatch bh to
 iohandler context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

On Tue, Apr 03, 2018 at 08:02:44AM -0500, Eric Blake wrote:
> On 04/03/2018 12:01 AM, Peter Xu wrote:
> > Eric Auger reported the problem days ago that OOB broke ARM when running
> > with libvirt:
> > 
> > http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html
> > 
> > This patch fixes the problem.
> > 
> > It's not really needed now since we have turned OOB off now, but it's
> > still a bug fix, and it'll start to work when we turn OOB on for ARM.
> 
> It may be more than just ARM affected, and just that ARM happened to
> trigger the problem easier.

Yes.  Please feel free to add something to the commit message if you
think necessary.

[...]

> > This patch will fix all known OOB breakages I know so far, but I think
> > for better safety I'll still keep OOB off, and I'll send another patch
> > to turn default OOB on after 2.12 release.
> 
> Yes, leaving OOB defaulting to off unless you use x-oob=on for 2.12 is
> the most conservative action, although we still want to fix all known
> bugs that you can trigger by using that.
> 
> How did you run iotests with OOB on by default, by recompiling the
> binary to undo commit be933ffc2, or by tweaking the iotests scripts to
> pass x-oob=on by default?

Not really undo be933ffc2, but pick up 3fd2457d18 manually.

Thanks,

-- 
Peter Xu

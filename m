Received: from eggs.gnu.org ([2001:4830:134:3::10]:44462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezMK3-0005Bx-Mr
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezMJy-0003bU-0E
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:01:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47476 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ezMJx-0003b2-Ss
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:01:25 -0400
Date: Fri, 23 Mar 2018 21:01:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180323130117.GP32362@xz-mi>
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-21-peterx@redhat.com>
	<1bd08e1d-b6ff-6b39-e053-599bddd1a208@de.ibm.com>
	<20180323122538.GN32362@xz-mi>
	<332a9ef5-549a-d329-ec5e-d68609b1fbe1@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <332a9ef5-549a-d329-ec5e-d68609b1fbe1@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v8 20/23] monitor: enable IO thread for
 (qmp & !mux) typed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, Stefan Hajnoczi <shajnocz@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Auger Eric <eric.auger@redhat.com>

On Fri, Mar 23, 2018 at 01:44:54PM +0100, Christian Borntraeger wrote:
> 
> 
> On 03/23/2018 01:25 PM, Peter Xu wrote:
> > On Fri, Mar 23, 2018 at 01:10:51PM +0100, Christian Borntraeger wrote:
> >> As Max Reitz said, this breaks several qemu iotests. I can reproduce that on s390
> >> e.g. with ./check -qcow2 030 in the qemu-iotest.
> >>
> >> Why was this merged?
> > 
> > My fault.  Sorry.  I should have done iotests before submission.
> > 
> > Now I'm trying to fix those iotest issues.
> > 
> > I'm not extremely familiar with block, so the progress is a bit slow,
> > but I'll do it asap (though I'll possibly need some help from the
> > block team, since there are some not-easy ones for me).
> 
> As this patch also seems to trigger something else for Eric, can we revert this
> patch for the time being and re-apply as soon as we have solutions for the issues?
> 
> After all a hard hang in the iotest can break CI environments (as you run into timeouts).

I'm fine with it if it helps.

Then I can work in background to solved existing problems, then we
turn it on again in 2.13 when ready (but still it might break things -
at least it can be during dev cycle rather than softfreeze).

-- 
Peter Xu

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dts1C-0001QJ-Ky
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dts16-000771-UE
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:07:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dts16-00076F-OX
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:07:00 -0400
Date: Mon, 18 Sep 2017 11:06:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170918110656.0e1ec9f3.cohuck@redhat.com>
In-Reply-To: <ebbeb89f-73d2-cb41-048d-a62ac574a65f@de.ibm.com>
References: <20170918085542.13265-1-cohuck@redhat.com>
	<ebbeb89f-73d2-cb41-048d-a62ac574a65f@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] s390x/ccw: create s390 phb for compat
 reasons as well
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Mon, 18 Sep 2017 10:58:47 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 09/18/2017 10:55 AM, Cornelia Huck wrote:
> > d32bd032d8 ("s390x/ccw: create s390 phb conditionally") made
> > registering the s390 pci host bridge conditional on presense
> > of the zpci facility bit. Sadly, that breaks migration from
> > machines that did not use the cpu model (2.7 and previous).
> > 
> > Create the s390 phb for pre-cpu model machines as well: We can
> > tweak s390_has_feat() to always indicate the zpci facility bit
> > when no cpu model is available (on 2.7 and previous compat machines).  
> 
> Looks better now. Thanks
> > 
> > Fixes: d32bd032d8 ("s390x/ccw: create s390 phb conditionally")
> > Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> > 
> > v2->v3:
> > - no longer RFC (I tested a bit more)
> > - removed unrelated hunk
> > - more verbose patch description
> > 
> > I'll wait a bit for more acks/reviews and will probably send a pull
> > request for s390x tomorrow or so before the amount of queued patches
> > gets out of hand...  
> 
> I have a small amount of patches pending, but then I got sick last week
> so I still have to sort out things. Lets do the pull request and we can
> then queue the other patches after they have received proper review.

Sounds like a plan.

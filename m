Received: from eggs.gnu.org ([2001:4830:134:3::10]:45203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dmywC-00021c-JH
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dmyw8-0002C6-Me
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:05:28 -0400
Date: Wed, 30 Aug 2017 11:05:08 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170830090508.pvllzkp6swbxyoip@eukaryote>
References: <20170829165058.8229-1-kchamart@redhat.com>
	<CAJSP0QUSXyb8MNVf6Tq8hLgb2wVWLX6GVAPgG-mmrGCxAEOcXg@mail.gmail.com>
	<defa8205-e31e-9199-c929-f2e22849e8c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <defa8205-e31e-9199-c929-f2e22849e8c7@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] qemu-iotests: Extend
 non-shared storage migration test (194)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Dave Gilbert <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Aug 29, 2017 at 04:16:54PM -0500, Eric Blake wrote:
> On 08/29/2017 12:42 PM, Stefan Hajnoczi wrote:
> > On Tue, Aug 29, 2017 at 5:50 PM, Kashyap Chamarthy <kchamart@redhat.com> wrote:
> >> This is the follow-up patch that was discussed[*] as part of feedback to
> >> qemu-iotest 194.
> >>
> 
> >> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> >> ---
> >> Changes in v3:
> >>  - Wait for migration to complete before issuing `block-job-cancel`
> >>    (StefanH)
> >>  - Wait for the event BLOCK_JOB_COMPLETED on the source before stopping
> >>    the NBD server on the destination (StefanH)
> >>
> >> Changes in v2:
> >>  - Check for both the events: MIGRATION and BLOCK_JOB_COMPLETED (EricB)
> >> ---
> >>  tests/qemu-iotests/194     | 23 +++++++++++++++++------
> >>  tests/qemu-iotests/194.out | 11 ++++++++---
> >>  2 files changed, 25 insertions(+), 9 deletions(-)
> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Thanks; I've added this to my NBD queue (pull request to come shortly
> after 2.11 release is finalized), since the test uses NBD.

Sure, thanks for the quick reviews, both!

-- 
/kashyap

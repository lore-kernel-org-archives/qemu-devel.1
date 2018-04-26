Received: from eggs.gnu.org ([2001:4830:134:3::10]:54146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fBdOD-0000fh-Ox
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:40:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fBdO7-0007QV-V0
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:40:33 -0400
Received: from mail.ispras.ru ([83.149.199.45]:42258)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fBdO7-0007Q6-Gv
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:40:27 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
	<20180425124608.17182.4528.stgit@pasha-VirtualBox>
	<613234ff-4a1a-6ab1-4003-3326a6bf508f@redhat.com>
In-Reply-To: <613234ff-4a1a-6ab1-4003-3326a6bf508f@redhat.com>
Date: Thu, 26 Apr 2018 12:40:16 +0300
Message-ID: <00a301d3dd42$95660eb0$c0322c10$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH 06/17] migration: introduce icount
 field for snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Eric Blake' <eblake@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

> From: Eric Blake [mailto:eblake@redhat.com]
> On 04/25/2018 07:46 AM, Pavel Dovgalyuk wrote:
> > Saving icount as a parameters of the snapshot allows navigation between
> > them in the execution replay scenario.
> > This information can be used for finding a specific snapshot for rewinding
> > the recorded execution to the specific moment of the time.
> > E.g., 'reverse step' action needs to load the nearest snapshot which is
> > prior to the current moment of time .
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > ---
> >  block/qapi.c             |   11 +++++++----
> >  blockdev.c               |    3 +++
> >  include/block/snapshot.h |    1 +
> >  migration/savevm.c       |    1 +
> >  qapi/block-core.json     |    5 ++++-
> >  qapi/block.json          |    3 ++-
> >  6 files changed, 18 insertions(+), 6 deletions(-)
> 
> Using scripts/git.orderfile may make your patches easier to review, by
> hoisting interfaces above implementation.

Thank you. This script makes the patches look much better.


Pavel Dovgalyuk

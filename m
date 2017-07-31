Received: from eggs.gnu.org ([2001:4830:134:3::10]:43237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dcCI1-0003GO-LG
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dcCI0-0005ka-Ob
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:07:25 -0400
Date: Mon, 31 Jul 2017 11:07:10 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170731150710.GG6240@localhost.localdomain>
References: <cover.1501508049.git.jcody@redhat.com>
	<3064c6292e5771533bab598210f7cbb791faa384.1501508049.git.jcody@redhat.com>
	<9d9fbac9-b630-2bbc-3b9f-64cec1eedbf0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d9fbac9-b630-2bbc-3b9f-64cec1eedbf0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 1/3] qemu-iotests: set TEST_DIR
 to a unique dir for each test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com

On Mon, Jul 31, 2017 at 09:44:13AM -0500, Eric Blake wrote:
> On 07/31/2017 08:47 AM, Jeff Cody wrote:
> > Right now, all qemu-iotests output data into the same scratch directory,
> > and so each tests needs to be responsible for cleanup up its own files.
> 
> s/cleanup up/cleaning up/
>

Thanks - I'll send a v3 with that change after a while, in case there are more
comments. Or if someone applies it to their branch, they can just fix up the
commit message if they want.


(Hmm... I guess also s/each tests/each test as well, to be grammatically
correct)


> > 
> > Have each test use 'scratch/$seq' as its temp directory, so the check
> > script can do simple cleanup of removing the whole temporary directory.
> > 
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > ---
> >  tests/qemu-iotests/check | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> R-b stands (thanks for adding the && fix from v1).
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 

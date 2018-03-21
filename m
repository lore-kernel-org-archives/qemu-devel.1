Received: from eggs.gnu.org ([2001:4830:134:3::10]:56339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyhRC-0005Vs-HF
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyhRB-0003mn-MK
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:22:10 -0400
Date: Wed, 21 Mar 2018 18:22:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180321172202.GG3898@localhost.localdomain>
References: <20180320173632.25480-1-kwolf@redhat.com>
	<20180320173632.25480-7-kwolf@redhat.com>
	<10dae97f-263b-bc96-e504-5079b742bc22@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10dae97f-263b-bc96-e504-5079b742bc22@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 06/12] qemu-iotests: Test invalid
 resize on luks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

Am 20.03.2018 um 19:33 hat Eric Blake geschrieben:
> On 03/20/2018 12:36 PM, Kevin Wolf wrote:
> > This tests that the .bdrv_truncate implementation for luks doesn't crash
> > for invalid image sizes.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   tests/qemu-iotests/210 | 37 +++++++++++++++++++++++++++++++++++++
> >   1 file changed, 37 insertions(+)
> 
> Missing a change to 210.out?

Obviously. I wonder how that happened... Thanks!

Kevin

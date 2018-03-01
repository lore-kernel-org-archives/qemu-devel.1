Received: from eggs.gnu.org ([2001:4830:134:3::10]:40869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1erCo4-0006qa-5n
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 20:14:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1erCo3-0002GX-GP
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 20:14:48 -0500
Date: Thu, 1 Mar 2018 09:14:38 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180301011438.GG21336@lemon.usersys.redhat.com>
References: <20180202052310.7870-1-famz@redhat.com>
	<1a2f11f4-2807-69de-fa4a-46541753b487@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a2f11f4-2807-69de-fa4a-46541753b487@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] iotests: Fix CID for VMDK afl image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com

On Wed, 02/28 18:50, Max Reitz wrote:
> On 2018-02-02 06:23, Fam Zheng wrote:
> > This reverts commit 76bf133c4 which updated the reference output, and
> > fixed the reference image, because the code path we want to exercise is
> > actually the invalid image size.
> > 
> > The descriptor block in the image, which includes the CID to verify, has been
> > invalid since the reference image was added. Since commit 9877860e7bd we report
> > this error earlier than the "file too large", so 059.out mismatches.
> > 
> > The binary change is generated along the operations of:
> > 
> >   $ bunzip2 afl9.vmdk.bz2
> >   $ qemu-img create -f vmdk fix.vmdk 1G
> >   $ dd if=afl9.vmdk of=fix.vmdk bs=512 count=1 conv=notrunc
> >   $ mv fix.vmdk afl9.vmdk
> >   $ bzip2 afl9.vmdk
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > 
> > ---
> 
> Could you rebase this on master (so only the _notrun portion remains)?
> It appears that v2 has hit master already...

OK, will do!

Fam

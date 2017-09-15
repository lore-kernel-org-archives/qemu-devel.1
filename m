Received: from eggs.gnu.org ([2001:4830:134:3::10]:57762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dspm6-0004Pg-TM
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dspm3-0001U2-U8
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:31:14 -0400
Date: Fri, 15 Sep 2017 20:30:56 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170915123056.GL17199@lemon>
References: <20170915054526.20588-1-famz@redhat.com>
	<20170915121634.GC4077@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170915121634.GC4077@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] iotests: Print full path of bad output if
 mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Fri, 09/15 14:16, Kevin Wolf wrote:
> Am 15.09.2017 um 07:45 hat Fam Zheng geschrieben:
> > So it is easier to copy paste the path.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> I don't think I ever tried to do anything with the diff that would have
> required the full path, but if you say so... :-)
> 
> Thanks, applied to the block branch.

Thanks.

I often create a new reference output or fix an old one by

    cp /x/y/z.out.bad tests/qemu-iotests/???.out

and either the /x/y/z or the path to QEMU repo is some typing if from
out-of-tree build, so getting it from the output of check is handy..

Fam

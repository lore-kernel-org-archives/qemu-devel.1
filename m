Received: from eggs.gnu.org ([209.51.188.92]:51608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hCRkw-0004Cq-OP
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hCRkv-00016K-C3
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:31:54 -0400
Date: Fri, 5 Apr 2019 18:24:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190405162427.GC4597@linux.fritz.box>
References: <20190405114513.3141-1-armbru@redhat.com>
	<20190405125140.GB4597@linux.fritz.box>
	<20190405161158.GA3275@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405161158.GA3275@work-vm>
Subject: Re: [Qemu-devel] [PATCH for-4.0] hmp: Fix drive_add ... format=help
 crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 05.04.2019 um 18:11 hat Dr. David Alan Gilbert geschrieben:
> * Kevin Wolf (kwolf@redhat.com) wrote:
> > Am 05.04.2019 um 13:45 hat Markus Armbruster geschrieben:
> > > drive_new() returns null without setting an error when it provided
> > > help.  add_init_drive() assumes null means failure, and crashes trying
> > > to report a null error.
> > > 
> > > Fixes: c4f26c9f37ce511e5fe629c21c180dc6eb7c5a25
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > 
> > We should probably have a test case for this.
> 
> Perhaps just adding:
> 
> drive_add 0 format=help
> 
> to the hmp_cmds list in tests/test-hmp.c  ?

This would catch the crash, but not check the output. I think I'd prefer
a qemu-iotests case where the output is checked.

Kevin

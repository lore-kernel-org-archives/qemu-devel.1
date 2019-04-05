Received: from eggs.gnu.org ([209.51.188.92]:45154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCRZe-000052-D1
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCRZc-0004hE-6M
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:20:14 -0400
Date: Fri, 5 Apr 2019 17:11:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190405161158.GA3275@work-vm>
References: <20190405114513.3141-1-armbru@redhat.com>
	<20190405125140.GB4597@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405125140.GB4597@linux.fritz.box>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

* Kevin Wolf (kwolf@redhat.com) wrote:
> Am 05.04.2019 um 13:45 hat Markus Armbruster geschrieben:
> > drive_new() returns null without setting an error when it provided
> > help.  add_init_drive() assumes null means failure, and crashes trying
> > to report a null error.
> > 
> > Fixes: c4f26c9f37ce511e5fe629c21c180dc6eb7c5a25
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> 
> We should probably have a test case for this.

Perhaps just adding:

drive_add 0 format=help

to the hmp_cmds list in tests/test-hmp.c  ?

Dave

> Kevin
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

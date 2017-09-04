Received: from eggs.gnu.org ([208.118.235.92]:42858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dot1T-00027D-3v
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dosz5-0000R8-Rm
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:10:47 -0400
Date: Mon, 4 Sep 2017 17:05:54 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170904150554.hnfgiqqv5g6b4fzj@eukaryote>
References: <20170904111616.21333-1-kchamart@redhat.com>
	<20170904144812.GD27285@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170904144812.GD27285@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Make test 192 use QMP;
 convert it to Python
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com

On Mon, Sep 04, 2017 at 03:48:12PM +0100, Daniel P. Berrange wrote:
> On Mon, Sep 04, 2017 at 01:16:16PM +0200, Kashyap Chamarthy wrote:
> > The test 192 ("Test NBD export with '-incoming' (non-shared
> > storage migration use case from libvirt")) is currently using HMP.
> > Replace the HMP usage with QMP, as the upstream preference seems to be:
> > "Use QMP where possible, unless you're explicitly testing something
> > related to HMP".
> > 
> > While at it, convert the test from Bash to Python.
> 
> FYI This looks like it'll clash with the patch I sent to fix this
> test case with LUKS
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg00041.html

Oh, thanks for the pointer.  Then, I think I should wait until yours is
merged, and then rework my changes on top of it.

-- 
/kashyap

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1e9AWl-0005NZ-Ez
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1e9AWk-0007Ep-OL
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:54:55 -0400
Date: Mon, 30 Oct 2017 14:54:38 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171030135438.eyv5ytesk2axxfej@eukaryote>
References: <20171029125338.25988-1-kwolf@redhat.com>
	<20171030083916.z5bglhjeiabfeoy5@eukaryote>
	<20171030101321.GA2967@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171030101321.GA2967@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Use -nographic in 182
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com

On Mon, Oct 30, 2017 at 11:13:21AM +0100, Kevin Wolf wrote:
> Am 30.10.2017 um 09:39 hat Kashyap Chamarthy geschrieben:
> > On Sun, Oct 29, 2017 at 01:53:38PM +0100, Kevin Wolf wrote:

[...]

> > >  echo
> > >  echo "Starting a second QEMU using the same image should fail"
> > > -echo 'quit' | $QEMU -monitor stdio \
> > > +echo 'quit' | $QEMU -nographic -monitor stdio \
> > 
> > Isn't "-display none" preferred instead of "-nographic"?

[...]

> It's not the same thing, -nographic does more than just that, like
> redirecting the serial port to stdio.

True, because in this test case the monitor is being sent explicitly to
'stdio'.  To your point, I now vaguely recall Paolo saying on IRC that
'-nographic' is a shorthand for:

    '-serial mon:stdio -machine graphics=off -display none'

> In this specific case, -display
> none should actually be enough, but for consistency I just did the same
> thing as other qemu-iotest cases are doing.

Ah, okay.  At any rate:

    Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

-- 
/kashyap

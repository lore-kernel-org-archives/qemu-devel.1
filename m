Received: from eggs.gnu.org ([2001:4830:134:3::10]:39107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e974b-0002Nk-WE
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 06:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e974W-0002eV-BM
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 06:13:37 -0400
Date: Mon, 30 Oct 2017 11:13:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171030101321.GA2967@localhost.localdomain>
References: <20171029125338.25988-1-kwolf@redhat.com>
	<20171030083916.z5bglhjeiabfeoy5@eukaryote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171030083916.z5bglhjeiabfeoy5@eukaryote>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Use -nographic in 182
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 30.10.2017 um 09:39 hat Kashyap Chamarthy geschrieben:
> On Sun, Oct 29, 2017 at 01:53:38PM +0100, Kevin Wolf wrote:
> > This avoids that random UI frontend error messages end up in the output.
> > In particular, we were seeing this line in CI error logs:
> > 
> > +Unable to init server: Could not connect: Connection refused
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/182 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
> > index 2e078ceed8..4b31592fb8 100755
> > --- a/tests/qemu-iotests/182
> > +++ b/tests/qemu-iotests/182
> > @@ -62,7 +62,7 @@ _launch_qemu -drive file=$TEST_IMG,if=none,id=drive0,file.locking=on \
> >  
> >  echo
> >  echo "Starting a second QEMU using the same image should fail"
> > -echo 'quit' | $QEMU -monitor stdio \
> > +echo 'quit' | $QEMU -nographic -monitor stdio \
> 
> Isn't "-display none" preferred instead of "-nographic"?
> 
> Assuming you'll change it to "-display none":
> 
>     Reviewed-by: Kashyap CHamarthy <kchamart@redhat.com>

It's not the same thing, -nographic does more than just that, like
redirecting the serial port to stdio. In this specific case, -display
none should actually be enough, but for consistency I just did the same
thing as other qemu-iotest cases are doing.

Kevin

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3dTp-0000ER-FU
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3dTo-0004BM-JB
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:04:45 -0400
Date: Thu, 27 Apr 2017 15:04:35 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170427070435.GK9205@lemon.lan>
References: <20170426033413.17192-1-famz@redhat.com>
	<20170426033413.17192-14-famz@redhat.com>
	<20170426123441.GD4538@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426123441.GD4538@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v15 13/21] iotests: 091: Quit QEMU before
 checking image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Wed, 04/26 14:34, Kevin Wolf wrote:
> Am 26.04.2017 um 05:34 hat Fam Zheng geschrieben:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > Reviewed-by: Max Reitz <mreitz@redhat.com>
> > ---
> >  tests/qemu-iotests/091 | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
> > index 32bbd56..10ac4a8 100755
> > --- a/tests/qemu-iotests/091
> > +++ b/tests/qemu-iotests/091
> > @@ -95,7 +95,9 @@ echo "vm2: qemu process running successfully"
> >  echo "vm2: flush io, and quit"
> >  _send_qemu_cmd $h2 'qemu-io disk flush' "(qemu)"
> >  _send_qemu_cmd $h2 'quit' ""
> > +_send_qemu_cmd $h1 'quit' ""
> >  
> > +wait
> 
> I think it's better to use the function from common.qemu for this:
> 
>     wait=1 _cleanup_qemu
> 

I didn't look into it, but that would get such an error:

091 1s ... - output mismatch (see 091.out.bad)
--- /stor/work/qemu/tests/qemu-iotests/091.out	2016-10-27 14:31:53.671300277 +0800
+++ 091.out.bad	2017-04-27 15:03:28.965504185 +0800
@@ -18,6 +18,20 @@
 vm2: qemu-io disk write complete
 vm2: qemu process running successfully
 vm2: flush io, and quit
+total time: 48 milliseconds
+downtime: 25 milliseconds
+setup: 1 milliseconds
+transferred ram: 465 kbytes
+throughput: 99.28 mbps
+remaining ram: 0 kbytes
+total ram: 131592 kbytes
+duplicate: 32854 pages
+skipped: 0 pages
+normal: 44 pages
+normal bytes: 176 kbytes
+dirty sync count: 2
+(qemu) quit
+(qemu) quit
 Check image pattern
 read 4194304/4194304 bytes at offset 0
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

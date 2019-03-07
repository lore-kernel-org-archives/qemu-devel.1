Received: from eggs.gnu.org ([209.51.188.92]:42914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1tpK-0002r7-Py
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1tpJ-0006rb-Pi
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:16:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1h1tpJ-0006np-Gn
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:16:49 -0500
Date: Thu, 7 Mar 2019 15:16:42 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190307141642.GE5786@linux.fritz.box>
References: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
	<8b794ba1-f719-e1f4-5a17-ba261aeebea6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b794ba1-f719-e1f4-5a17-ba261aeebea6@redhat.com>
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org, john.g.johnson@oracle.com, sstabellini@kernel.org, jag.raman@oracle.com, konrad.wilk@oracle.com, ross.lagerwall@citrix.com, liran.alon@oracle.com, stefanha@redhat.com, kanth.ghatraju@oracle.com

Am 07.03.2019 um 09:14 hat Thomas Huth geschrieben:
> On 07/03/2019 08.22, elena.ufimtseva@oracle.com wrote:
> > From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > 
> > TODO: Make relevant changes to the doc.
> > 
> > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > ---
> >  docs/devel/qemu-multiprocess.txt | 1109 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 1109 insertions(+)
> >  create mode 100644 docs/devel/qemu-multiprocess.txt
> > 
> > diff --git a/docs/devel/qemu-multiprocess.txt b/docs/devel/qemu-multiprocess.txt
> > new file mode 100644
> > index 0000000..e29c6c8
> > --- /dev/null
> > +++ b/docs/devel/qemu-multiprocess.txt
> > @@ -0,0 +1,1109 @@
> > +/*
> > + * Copyright 2019, Oracle and/or its affiliates. All rights reserved.
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaining a copy
> > + * of this software and associated documentation files (the "Software"), to deal
> > + * in the Software without restriction, including without limitation the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> > + * copies of the Software, and to permit persons to whom the Software is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> 
> Somehow weird to see such a big license statement talking about
> "software", but which applies to a text file only... Not sure if it is
> an option for you, but maybe one of the Creative Common licenses
> (dual-licensed with the GPLv2+) would be a better fit? E.g. for the QEMU
> website, the content is dual-licensed: https://www.qemu.org/license.html

While we're talking about licenses, the "All rights reserved." notice is
out of place in a license header that declares that a lot of permissions
are granted. Better to remove it to avoid any ambiguities that could
result from the contradiction. (Applies to the whole series.)

Kevin

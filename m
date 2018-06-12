Received: from eggs.gnu.org ([2001:4830:134:3::10]:34326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fSdJZ-0008QR-NT
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fSdJT-0004PK-OP
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:02:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51262 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fSdJT-0004P7-JN
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:01:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1CB70402242D
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 07:01:55 +0000 (UTC)
Date: Tue, 12 Jun 2018 15:01:52 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180612070152.GD29380@lemon.usersys.redhat.com>
References: <20180612062430.GA15344@xz-mi>
	<20180612064119.GC29380@lemon.usersys.redhat.com>
	<20180612065229.GB15344@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612065229.GB15344@xz-mi>
Subject: Re: [Qemu-devel] Is there a way to package QEMU binaries?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>

On Tue, 06/12 14:52, Peter Xu wrote:
> On Tue, Jun 12, 2018 at 02:41:19PM +0800, Fam Zheng wrote:
> > On Tue, 06/12 14:24, Peter Xu wrote:
> > > Hi,
> > > 
> > > For example, I wanted to compile QEMU once and install it on multiple
> > > systems.  What would be the suggested way to do so?
> > > 
> > > Is there something similar to "make bin-rpmpkg" for Linux?
> > > 
> > > Thanks in advance,
> > 
> > No. The big question is the libraries. Even if you create the rpm, the libraries
> > that you have linked against are not necessarily available on the systems you
> > install. This means you either list all possible libraries as required in the
> > rpm spec, which is a waste, or the list is generated dynamically, which is not
> > trivial. For example, you can easily build QEMU against a custom glib, but it's
> > very tricky to generate an rpm from it that works on other systems.
> 
> That's true.  But my question was actually specific to when the
> systems are sharing basically the same environment (kernel, library
> versions, etc.).  A simple solution is that on each system I install
> qemu official package then the dependencies will all be there, then I
> install my custom package (which will possibly install the binaries
> under /usr/local) and I run the customized binary.

Then simply do

    ./configure --prefix=/tmp/qemu-install && \
    make && \
    make install && \
    scp -r /tmp/qemu-install $remote

?

Fam

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds75q-00078t-5M
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds75p-0004C1-7d
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:48:38 -0400
Date: Wed, 13 Sep 2017 14:48:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170913144825.48cad531.cohuck@redhat.com>
In-Reply-To: <20170913124456.GB2096@work-vm>
References: <20170912140149.7692-1-lvivier@redhat.com>
	<20170912140149.7692-2-lvivier@redhat.com>
	<20170913053533.GF7550@umbus.fritz.box>
	<20170913124456.GB2096@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] hmp: fix "dump-quest-memory"
 segfault (ppc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

On Wed, 13 Sep 2017 13:44:57 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * David Gibson (david@gibson.dropbear.id.au) wrote:
> > On Tue, Sep 12, 2017 at 04:01:47PM +0200, Laurent Vivier wrote:  
> > > Running QEMU with
> > >     qemu-system-ppc64 -M none -nographic -m 256
> > > and executing
> > >     dump-guest-memory /dev/null 0 8192
> > > results in segfault
> > > 
> > > Fix by checking if we have CPU, and exit with
> > > error if there is no CPU:
> > > 
> > >     (qemu) dump-guest-memory /dev/null
> > >     this feature or command is not currently supported
> > > 
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>  
> > 
> > Applied to ppc-for-2.11.  I'm not really sure what to do with the rest
> > of the series though.  
> 
> I can take the whole set through HMP.

If you do so, you should probably take "dump: do not dump non-existent
guest memory" as well.

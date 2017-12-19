Received: from eggs.gnu.org ([2001:4830:134:3::10]:37028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eRKYY-000186-UW
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eRKYX-0002SG-SD
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:15:50 -0500
Date: Tue, 19 Dec 2017 16:15:35 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171219161535.GW2787@redhat.com>
References: <20171115162648.30135-1-ptoscano@redhat.com>
	<16ae9efe-78df-2e59-39db-1570deba2847@redhat.com>
	<20171218213140.GT2787@redhat.com>
	<20171219152418.GB20944@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219152418.GB20944@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] ssh: switch from libssh2
 to libssh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: John Snow <jsnow@redhat.com>, kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, Pino Toscano <ptoscano@redhat.com>, asn@redhat.com

On Tue, Dec 19, 2017 at 10:24:18AM -0500, Jeff Cody wrote:
> On Mon, Dec 18, 2017 at 09:31:40PM +0000, Richard W.M. Jones wrote:
> > On Mon, Dec 18, 2017 at 01:43:39PM -0500, John Snow wrote:
> > > Hi, friendly ping:
> > > 
> > > It's been over a month with no replies, so it's safe to say this has
> > > gotten lost in the 2.11 release shuffle.
> > > 
> > > Recommend you re-send it for the 2.12 window.
> > 
> > Actually there is an interop problem with the ssh daemon on ESXi which
> > I've not resolved yet.  Unfortunately there was no response to my
> > upstream message about collecting debugging info:
> > 
> > https://www.libssh.org/archive/libssh/2017-12/0000000.html
> > 
> > Since liberating guests from VMware is a prime reason to have an ssh
> > driver in qemu, I'd really like this to be fixed first ...
> > 
> > Rich.
> 
> I also sent a review, and found an issue with at least libssh 0.7-4 (not
> getting EOF on short reads).

Thanks, yes, I read that after I sent the email, so I'd like to
test again once that bug has been fixed.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW

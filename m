Received: from eggs.gnu.org ([2001:4830:134:3::10]:43882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1df44S-0007bU-O2
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1df44N-0001lh-Rc
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:57:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1df44N-0001kV-Lq
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:57:11 -0400
Date: Tue, 8 Aug 2017 09:57:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170808125706.GQ3108@localhost.localdomain>
References: <20170804213625.3756-1-ehabkost@redhat.com>
	<20170804213625.3756-2-ehabkost@redhat.com>
	<20170808100721.GC16801@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170808100721.GC16801@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-2.11 1/5] qmp-shell: Use argparse module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>

On Tue, Aug 08, 2017 at 11:07:21AM +0100, Stefan Hajnoczi wrote:
> On Fri, Aug 04, 2017 at 06:36:21PM -0300, Eduardo Habkost wrote:
> > It makes command-line parsing and generation of help text much
> > simpler.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  scripts/qmp/qmp-shell | 61 +++++++++++++++++----------------------------------
> >  1 file changed, 20 insertions(+), 41 deletions(-)
> 
> The minimum Python version is 2.6.  The argparse module was introduced
> in Python 2.7 so we cannot use it without increasing the minimum Python
> version:
> 
> https://docs.python.org/2.6/modindex.html
> 
> I suggest holding off on this for now.

2.6 is the minimum Python version for what, exactly?  Is it for
building QEMU?

Note that qmp-shell is a tool for developers, not required for
building or running QEMU.  People who really want to run
qmp-shell on a python-2.6 system can still install argparse if
they want to use qmp-shell.

I could backport the code to optparse.  But should we add code
that relies on a deprecated module, if developers running Python
2.6 can install argparse?

-- 
Eduardo

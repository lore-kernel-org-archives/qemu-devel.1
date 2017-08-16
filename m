Received: from eggs.gnu.org ([2001:4830:134:3::10]:60830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1di5HQ-0000kj-9w
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 16:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1di5HP-0002y7-Kj
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 16:51:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1di5HP-0002xS-EB
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 16:51:07 -0400
Date: Thu, 17 Aug 2017 04:50:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170816205059.GA17882@lemon>
References: <20170816072104.24420-1-famz@redhat.com>
	<20170816072104.24420-4-famz@redhat.com>
	<20170816083220.GA3180@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170816083220.GA3180@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH RFC 3/9] qemu.py: Add "wait()" method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, pbonzini@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Wed, 08/16 09:32, Stefan Hajnoczi wrote:
> On Wed, Aug 16, 2017 at 03:20:58PM +0800, Fam Zheng wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  scripts/qemu.py | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/scripts/qemu.py b/scripts/qemu.py
> > index e5f314efdb..3e7eb44035 100644
> > --- a/scripts/qemu.py
> > +++ b/scripts/qemu.py
> > @@ -144,6 +144,11 @@ class QEMUMachine(object):
> >              self._post_shutdown()
> >              raise
> >  
> > +    def wait(self):
> > +        self._popen.wait()
> > +        self._qmp.close()
> > +        self._post_shutdown()
> > +
> 
> Please include docstrings for public methods.

OK.

> 
> Is this method for users who do not use shutdown() because the guest
> halts itself?

Yes, cooperative shutdown (e.g. "shutdown" command from guest or acpi signal) is
cleaner when we want to make sure changes are flushed to disk.

> 
> Why is self._load_io_log() not called?

Will add it.

Fam

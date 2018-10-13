Received: from eggs.gnu.org ([2001:4830:134:3::10]:59638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gBQeZ-0007dE-7W
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gBQeV-0003A1-AK
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:36:51 -0400
Date: Sat, 13 Oct 2018 17:36:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181013203607.GL31060@habkost.net>
References: <20181013050227.17022-1-ehabkost@redhat.com>
	<219bba9b-4102-f838-a46f-11b9704ca78f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <219bba9b-4102-f838-a46f-11b9704ca78f@redhat.com>
Subject: Re: [Qemu-devel] [RFC] Require Python 3 for building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Sat, Oct 13, 2018 at 08:20:25PM +0200, Max Reitz wrote:
> On 13.10.18 07:02, Eduardo Habkost wrote:
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > I'd like to do this in QEMU 3.1.  I think it's time to drop
> > support for old systems that have only Python 2.
> > 
> > We still have a few scripts that are not required for building
> > QEMU that still work only with Python 2 (iotests being the most
> > relevant set).  Requiring Python 3 for building QEMU won't
> > prevent people from using those scripts with Python 2 until they
> > are finally ported.
> 
> It very much does because the iotests specifically use the python path
> qemu was configured with.
> 
> To fix this, configure would need to write something else for into
> tests/qemu-iotests/common.env for $PYTHON.  But what?  I don't really
> want to introduce a new configure option for this.

What's wrong with '/usr/bin/env python2' and just using the
python2 binary from $PATH?  Why do we need to make the Python
interpreter path for iotests configurable?

> 
> So the real fix is indeed to make the iotests work with Python 3, and I
> think that needs to be done before we can require Python 3.  Maybe it
> even needs to be done at the same time.

I agree that this would be even better.  I just don't think the
pending iotest porting should force all the rest of the build
scripts to be compatible with Python 2.

-- 
Eduardo

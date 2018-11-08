Received: from eggs.gnu.org ([2001:4830:134:3::10]:51173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKp1S-000104-93
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:27:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKp1N-0005AT-7y
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:27:14 -0500
Date: Thu, 8 Nov 2018 16:26:44 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181108182644.GP12503@habkost.net>
References: <20181031003120.26771-12-ehabkost@redhat.com>
	<CAFEAcA_ScL828ya7P_5=HMx=vbxo=jK4047nAbmb9Ep=6r=2og@mail.gmail.com>
	<f1bd429f-198a-ee27-9184-636692332816@redhat.com>
	<20181106141302.GP12503@habkost.net>
	<87efbxxw1c.fsf@dusky.pond.sub.org>
	<8ecdbb0e-aaf8-ddc5-6442-87977585d9d8@redhat.com>
	<87y3a4ot3g.fsf@dusky.pond.sub.org>
	<f69012ad-af21-783c-d378-acd3131451e4@redhat.com>
	<20181108165136.GK12503@habkost.net>
	<d8782551-ca89-c70c-a2b9-0ba665171c63@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8782551-ca89-c70c-a2b9-0ba665171c63@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tests: Fix Python 3 detection
 on older GNU make versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Thu, Nov 08, 2018 at 12:36:37PM -0500, Cleber Rosa wrote:
> 
> 
> On 11/8/18 11:51 AM, Eduardo Habkost wrote:
> 
> > I'm not sure I agree with the "is an important thing to keep
> > track of" part.  I don't think we'll have any need to keep track
> > of the Python version in shell script or makefiles after we start
> > requiring Python 3.
> > 
> 
> Well, "Python 3" is not a uniform thing.  There are many changes across
> the 3.x spectrum that can bite you.  I'm speaking out of the experience
> with Avocado, that supports Python 3.4, 3.5 and 3.6 (and that reminds me
> we should add tests for 3.7).

Do you expect us to need to keep track of the exact Python
version before running the Python interpreter?  Code written in
Python doesn't count, because it can simply use sys.version_info.


> 
> > Extra cleanups (like moving version checks to ./configure) are
> > still welcome, but keep in mind that this will probably be thrown
> > away once we drop Python 2 support.
> > 
> 
> I don't think it should.  Let me give the example of a "Python 3.0" job
> on Travis, related to the following snippet:
> 
>     # Python builds
>     - env: CONFIG="--target-list=x86_64-softmmu"
>       python:
>         - "3.0"
> 
> If you look at https://travis-ci.org/clebergnu/qemu/jobs/452033247#L983
> you'll see that the intended goal was missed.  That has to do with how
> Travis makes the requested Python version available, and it was only
> obvious because this branch prints the Python version used.
> 
> Developers writing Python code, for instance tests, may assume a given
> API that doesn't exist or behave like they expect, and not knowing the
> Python version used on a remote environment makes debugging extra hard.

I'm not sure I get your point.  We can surely add diagnostic
messages to show the Python version, and we can make ./configure
fail if Python 3 is unavailable.  I'm talking about adding code
to ./configure to save Python version info for makefile rules and
shell scripts.  I expect the extra code to be unnecessary in the
future.

-- 
Eduardo

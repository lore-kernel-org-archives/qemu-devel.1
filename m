Received: from eggs.gnu.org ([2001:4830:134:3::10]:37394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fNfgU-0004GA-78
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:33:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fNfgO-0007li-Be
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:33:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29611)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fNfgO-0007l6-5u
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:33:04 -0400
Date: Tue, 29 May 2018 11:32:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180529143257.GA8988@localhost.localdomain>
References: <20180525005839.11556-1-crosa@redhat.com>
	<20180525005839.11556-4-crosa@redhat.com>
	<20180525053718.GB28589@lemon.usersys.redhat.com>
	<65f0262a-20ff-f243-7434-a48daf7e5225@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f0262a-20ff-f243-7434-a48daf7e5225@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] Acceptance tests: add quick VNC tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, May 25, 2018 at 12:27:46PM -0400, Cleber Rosa wrote:
> 
> 
> On 05/25/2018 01:37 AM, Fam Zheng wrote:
> > On Thu, 05/24 20:58, Cleber Rosa wrote:
> >> This patch adds a few simple behavior tests for VNC.  These tests
> >> introduce manipulation of the QEMUMachine arguments, by setting
> >> the arguments, instead of adding to the existing ones.
> > 
> > I'm confused by this. The code uses 'add_args', so it does add to the arguments,
> > no?
> > 
> 
> And you should be.  I changed the code to just add args, and forgot to
> update the commit message.  If a better example comes up that requires
> setting arguments, I'll get back to this.
> 
> >>
> >> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> >> ---
> >>  tests/acceptance/test_vnc.py | 50 ++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 50 insertions(+)
> >>  create mode 100644 tests/acceptance/test_vnc.py
> >>
> >> diff --git a/tests/acceptance/test_vnc.py b/tests/acceptance/test_vnc.py
> >> new file mode 100644
> >> index 0000000000..9d9a35cf55
> >> --- /dev/null
> >> +++ b/tests/acceptance/test_vnc.py
> >> @@ -0,0 +1,50 @@
> > 
> > Copyright header is missing here too.
> > 
> 
> Indeed.
> 
> > Fam
> > 
> >> +from avocado_qemu import Test
> >> +
> >> +
> >> +class Vnc(Test):
> > 
> > Should VncTest be a better class name?
> > 
> 
> I'm favoring simpler names.  If you think about the complete test names,
> it's already too verbose IMO: "test_vnc.Vnc.test_no_vnc".
> 
> That's actually an interesting point: how would you feel about dropping
> the "test_" prefix from the file names?

I would like this.  The file is already inside a tests/acceptance
directory.

About the class name, I would be less surprised when reading the
code if it was called "VncTest", but I won't object to "Vnc" if
you prefer it.

-- 
Eduardo

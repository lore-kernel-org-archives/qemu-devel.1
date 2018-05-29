Received: from eggs.gnu.org ([2001:4830:134:3::10]:57846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fNjxg-0000zJ-Jc
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fNjxb-0006wU-LL
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:07:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fNjxb-0006vc-FE
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:07:07 -0400
Date: Tue, 29 May 2018 16:06:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180529190659.GL8988@localhost.localdomain>
References: <20180525005839.11556-1-crosa@redhat.com>
	<20180525005839.11556-5-crosa@redhat.com>
	<20180525054744.GC28589@lemon.usersys.redhat.com>
	<5ebe0b6d-11b9-8c66-0e09-01706ebc57ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ebe0b6d-11b9-8c66-0e09-01706ebc57ca@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] scripts/qemu.py: introduce
 set_console() method
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

On Fri, May 25, 2018 at 12:57:54PM -0400, Cleber Rosa wrote:
> On 05/25/2018 01:47 AM, Fam Zheng wrote:
[...]
> >> +class QEMU(unittest.TestCase):
> > 
> > 'QEMU' is too generic, what is the intended tests to do here? It seems to be
> > more about exercising the set_console() method.
> > 
> 
> Yes, but again, I'm favoring simpler names when the scope is supposed to
> be limited.  The chances of a name clash here are close to none IMO.  I
> don't think this class would be reused elsewhere, or a class with the
> same name would be imported here.
> 
> > Any test should be added to tests/, not scripts/.
> > 
> 
> One of the reasons for this file to be in this patch was to generate
> this exact discussion.  "qemu.py" itself is not a script, but a
> module/library.  Still it lacks the structure to have accompanying tests.
> 
> I was hoping to get away with these tests here, so that they wouldn't be
> thrown away, until "qemu.py", "qmp/*.py" and others are given the status
> and structure of Python modules.
> 
> I can definitely move these to tests/, but how about its relation to the
> other tests living there and its activation?  Should we recognize its
> existence and add a check-* target?

"scripts/test_qemu.py" makes it look like a script that will test
QEMU.  While we don't rearrange the Python modules to follow a
more Pythonic structure, probably moving it to tests/ is the best
option we have.  Maybe tests/python?

Wherever we store the test code, running those tests on
"make check" is a good idea.

But I wouldn't like this to delay the inclusion of this series.
If rearranging the Python modules would make the job easier,
including the test code only later would be a reasonable option,
too.

-- 
Eduardo

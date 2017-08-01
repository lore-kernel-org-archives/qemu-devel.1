Received: from eggs.gnu.org ([2001:4830:134:3::10]:37752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dcevj-000521-8v
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dcevi-00089V-5f
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:42:19 -0400
Date: Tue, 1 Aug 2017 17:42:06 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170801214206.GA1525@localhost.localdomain>
References: <cover.1501508049.git.jcody@redhat.com>
	<cover.1501508049.git.jcody@redhat.com>
	<ded25c757d9f8854ce47e2e674a44f18132a94ed.1501508049.git.jcody@redhat.com>
	<871sovztie.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871sovztie.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 3/3] qemu-iotests: add option
 to save temp files on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com

On Tue, Aug 01, 2017 at 08:34:01AM +0200, Markus Armbruster wrote:
> Jeff Cody <jcody@redhat.com> writes:
> 
> > Now that ./check takes care of cleaning up after each tests, it
> > can also selectively not clean up.  Add option to leave all output from
> > tests intact if that test encountered an error.
> >
> > Note: this currently only works for bash tests, as the python tests
> > still clean up after themselves manually.
> 
> Should we add a TODO comment for that?
> 

Couldn't hurt!

> Much appreciated work, by the way.  You might want to mention in one of
> your commit messages that this is also a step towards running iotests in
> parallel.
> 

Thanks.  I'll go ahead and spin a v3 to clean up commit messages and add a
TODO, since 2.11 won't open for a while.


> Another step towards sanity would be making $TEST_DIR instead of
> $source_iotests the current working directory for running tests.

Yep!

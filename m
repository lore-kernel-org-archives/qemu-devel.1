Received: from eggs.gnu.org ([209.51.188.92]:48149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gs2s0-0004tj-9E
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 04:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gs2rz-0007i7-CX
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 04:54:52 -0500
Date: Fri, 8 Feb 2019 10:54:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190208105438.001db484.cohuck@redhat.com>
In-Reply-To: <370c3eaa-a348-b6c8-a772-94b4ab24e2a6@redhat.com>
References: <20190202005610.24048-1-crosa@redhat.com>
	<20190202005610.24048-3-crosa@redhat.com>
	<20190206153639.61a5411c.cohuck@redhat.com>
	<85b0f519-38d8-cf7d-a22a-537dab8470a7@redhat.com>
	<20190206182043.49a18542.cohuck@redhat.com>
	<12a1b55d-bb0b-8a5d-20ba-9777172144c3@redhat.com>
	<20190207112554.6368595d.cohuck@redhat.com>
	<370c3eaa-a348-b6c8-a772-94b4ab24e2a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/20] Acceptance tests: show avocado
 test execution by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Caio Carrara <ccarrara@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On Thu, 7 Feb 2019 13:32:54 -0500
Cleber Rosa <crosa@redhat.com> wrote:

> On 2/7/19 5:25 AM, Cornelia Huck wrote:
> > On Wed, 6 Feb 2019 12:36:23 -0500
> > Cleber Rosa <crosa@redhat.com> wrote:
> >   
> >> On 2/6/19 12:20 PM, Cornelia Huck wrote:  
> >>> So, to summarize:
> >>> - add 'make check-acceptance-quick' that excludes tests marked as 'slow'    
> >>
> >> Yes... with one caveat: since the default is to have functional tests
> >> that are not necessarily quick, the other approach has been used.  Tests
> >> that are known to be quick are currently marked as such.
> >>
> >> Anyway, this task is being tracked here:
> >>
> >> https://trello.com/c/9HZWfKeE/79-add-a-make-check-acceptance-quick-target  
> > 
> > Yes, that sounds good as well.
> >   
> >>  
> >>> - use the avocado command line interface to further narrow down
> >>>   architectures and machines, if wanted
> >>> ?
> >>>     
> >>
> >> Yes.  Do you think this deserves a section in the docs?  
> > 
> > I know that I'll find myself searching the docs for that info at some
> > point in the future, so yes :)
> >   
> 
> Sure thing, tracking it here:
> 
> https://trello.com/c/7Fxbtx6F/80-document-how-to-use-the-avocado-command-line-and-tags

Great, thanks!

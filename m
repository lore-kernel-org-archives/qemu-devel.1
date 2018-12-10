Received: from eggs.gnu.org ([2001:4830:134:3::10]:50430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWPeO-0002dl-CE
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:47:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWPeJ-0004Ad-Kq
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:47:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWPeJ-0004AI-1s
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:47:19 -0500
Date: Mon, 10 Dec 2018 15:47:15 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181210174715.GI4669@habkost.net>
References: <20181207204107.GH7395@habkost.net>
	<20181209222738.GA9292@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209222738.GA9292@flamenco>
Subject: Re: [Qemu-devel] Help needed: test-qht-par hangs on Travis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On Sun, Dec 09, 2018 at 05:27:38PM -0500, Emilio G. Cota wrote:
> On Fri, Dec 07, 2018 at 18:41:07 -0200, Eduardo Habkost wrote:
> > I've noticed QEMU Travis builds are failing recently, and they
> > seem to happen only on the --enable-gprof jobs.  I have enabled
> > V=1 and noticed that the jobs are hanging inside test-qht-par.
> > 
> > Example here (look for "/qht/parallel/2threads-0%updates-1s"):
> > 
> > https://travis-ci.org/ehabkost/qemu-hacks/jobs/465081311
> > 
> > Does anybody have any idea why?
> 
> So if I read that output correctly, it seems that the second
> test in qht-par never completes.
> 
> Enabling gprof and gcov (as in that build) should just lower
> the throughput of the benchmark (test-qht-par invokes qht-bench),
[...]

Unrelated question: is there a specific reason why test-qht-par
is written in C using gtest, instead of being just a shell script
that runs qht-bench?

-- 
Eduardo

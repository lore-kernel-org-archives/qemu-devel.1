Received: from eggs.gnu.org ([2001:4830:134:3::10]:51467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gVJCz-0004U8-3g
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gVJCy-0001cx-71
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:42:32 -0500
Date: Fri, 7 Dec 2018 17:42:09 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181207164209.GH5119@linux.fritz.box>
References: <20181207115343.6747-1-kwolf@redhat.com>
	<20181207115343.6747-5-kwolf@redhat.com>
	<87in05wkev.fsf@dusky.pond.sub.org>
	<20181207144519.GF5119@linux.fritz.box>
	<5c0dd2fb-fbe6-41da-77ff-def0f2f3e830@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c0dd2fb-fbe6-41da-77ff-def0f2f3e830@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 4/5] iotests: Add VMDK tests for
 blockdev-create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 07.12.2018 um 16:40 hat Eric Blake geschrieben:
> On 12/7/18 8:45 AM, Kevin Wolf wrote:
> > Am 07.12.2018 um 14:12 hat Markus Armbruster geschrieben:
> > > git-am complains
> > > 
> > >      Applying: iotests: Add VMDK tests for blockdev-create
> > >      .git/rebase-apply/patch:281: trailing whitespace.
> > >                  format:
> > >      .git/rebase-apply/patch:308: trailing whitespace.
> > >                  format:
> > >      .git/rebase-apply/patch:335: trailing whitespace.
> > >                  format:
> > >      .git/rebase-apply/patch:600: new blank line at EOF.
> > >      +
> > >      warning: 4 lines add whitespace errors.
> > 
> > This is in the reference output, so trailing whitespace/blank lines are
> > actually correct.
> 
> Ah, but doesn't ./check already ignore differences in trailing whitespace
> present in the actual running that is not present in the *.out files,
> precisely so we don't have to check in trailing whitespace reference
> outputs?

It does ignore whitespace changes, so even if we remove that whitespace,
the test won't fail. But I don't think that's a good reason to check in
inaccurate reference output.

There are a few test cases that have a reference output like this and
it's always annoying: When I later add a new subtest, I add the new test
code, review the ./check output and if it looks good, I do something
like 'cp 237.out.bad 237.out'. At that point, I'll have to manually
revert completely unrelated whitespace changes again.

Some 'git am' warnings feel like the lesser evil to me.

Kevin

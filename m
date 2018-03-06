Received: from eggs.gnu.org ([2001:4830:134:3::10]:40006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1et9lc-0001UJ-GA
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:24:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1et9lb-0001fx-NW
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:24:20 -0500
Date: Tue, 6 Mar 2018 11:24:04 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180306102404.GB7139@localhost.localdomain>
References: <20180305175107.20210-1-kwolf@redhat.com>
	<CAFEAcA_gi4Pt41arfrmseZzxs0YZtkvBShcszRftW0y0ar4Z1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_gi4Pt41arfrmseZzxs0YZtkvBShcszRftW0y0ar4Z1A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v2 00/38] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Am 06.03.2018 um 11:09 hat Peter Maydell geschrieben:
> On 5 March 2018 at 17:51, Kevin Wolf <kwolf@redhat.com> wrote:
> > The following changes since commit 86f4c7e05b1c44dbe1b329a51f311f10aef6ff34:
> >
> >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180302' into staging (2018-03-02 14:37:10 +0000)
> >
> > are available in the git repository at:
> >
> >   git://repo.or.cz/qemu/kevin.git tags/for-upstream
> >
> > for you to fetch changes up to bfe1a14c180ec44c033be12b9151252ffda69292:
> >
> >   block: Fix NULL dereference on empty drive error (2018-03-05 18:45:32 +0100)
> >
> > ----------------------------------------------------------------
> > Block layer patches
> >
> > ----------------------------------------------------------------
> 
> This pull turns out to add a bunch of tests that end in the name "error",
> which triggers my buildlog scanning scripts that look for "error:".
> Could we rename those?

Wouldn't it make more sense to change your script so that it considers
"error" only if it's a whole word rather than part of an identifier?
These test cases concern error paths, so it's kind of expected that
their name contains "error" as a substring.

Kevin

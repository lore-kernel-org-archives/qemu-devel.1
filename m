Received: from eggs.gnu.org ([2001:4830:134:3::10]:60039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3YHx-00054M-Uz
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3YHx-0005V0-4T
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:32:09 -0400
Date: Thu, 27 Apr 2017 09:32:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170427013200.GE9205@lemon.lan>
References: <20170426033413.17192-1-famz@redhat.com>
	<20170426033413.17192-22-famz@redhat.com>
	<20170426144948.GL4538@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426144948.GL4538@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v15 21/21] qemu-iotests: Add test case 153
 for image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Wed, 04/26 16:49, Kevin Wolf wrote:
> Am 26.04.2017 um 05:34 hat Fam Zheng geschrieben:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> I'll do the actual review of the test case later, but I already have a
> question... Can we find a way to accept the expected lock losses on
> systems without OFD? I'm using RHEL 7 as my main development OS, so I
> wouldn't like having to deal with false positives there.

Split the lock loss cases to a separate case and _not_run? :)

> 
> Hm... And actually, printing a warning will probably invalidate all the
> other reference outputs, too. After all, every single invocation of
> qemu/qemu-img/qemu-io will print a warning. Maybe that's a bit too much
> even for manual users when they can't do anything about it (which is
> unlike the format probing warning that you can get rid of by simply
> changing your command line).

An idea: make locking=on/off/auto, and auto is on iff OFD is usable, otherwise
off. When user specifies locking=on but OFD is unusable, we print a warning.

Only in this on test case the warning will be printed on RHEL, and it's easy to
filter it out.

Fam

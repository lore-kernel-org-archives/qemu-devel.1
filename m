Received: from eggs.gnu.org ([2001:4830:134:3::10]:38710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3OGb-0005eg-Tt
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3OGW-0003aX-GA
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:50:05 -0400
Date: Wed, 26 Apr 2017 16:49:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170426144948.GL4538@noname.str.redhat.com>
References: <20170426033413.17192-1-famz@redhat.com>
	<20170426033413.17192-22-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426033413.17192-22-famz@redhat.com>
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 26.04.2017 um 05:34 hat Fam Zheng geschrieben:
> Signed-off-by: Fam Zheng <famz@redhat.com>

I'll do the actual review of the test case later, but I already have a
question... Can we find a way to accept the expected lock losses on
systems without OFD? I'm using RHEL 7 as my main development OS, so I
wouldn't like having to deal with false positives there.

Hm... And actually, printing a warning will probably invalidate all the
other reference outputs, too. After all, every single invocation of
qemu/qemu-img/qemu-io will print a warning. Maybe that's a bit too much
even for manual users when they can't do anything about it (which is
unlike the format probing warning that you can get rid of by simply
changing your command line).

Kevin

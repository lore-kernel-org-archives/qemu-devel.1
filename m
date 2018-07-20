Received: from eggs.gnu.org ([2001:4830:134:3::10]:36277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fgQiN-0005zM-FA
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 04:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fgQiM-0002ij-Lt
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 04:24:39 -0400
Date: Fri, 20 Jul 2018 16:24:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180720082427.GG29900@lemon.usersys.redhat.com>
References: <20180719034118.27741-1-famz@redhat.com>
	<6757101d-316a-79f5-1dbc-4546b054c9da@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6757101d-316a-79f5-1dbc-4546b054c9da@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Don't lock /dev/null
 and /dev/zero automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu, 07/19 13:57, John Snow wrote:
> Should we instead modify the test in this case to not attempt to take a
> lock on a device we know cannot meaningfully store state, or is it your
> preference to attempt to maintain such a list in the raw driver itself?
> 
> I guess we never want QEMU to try to lock things like /dev/zero, but I
> don't know if there are more such pseudo-devices we should never try to
> lock and if so, what common property unifies them such that we don't
> have to maintain a list.

They are 0 sized anyway so I only expect them to be used in test cases like the
one we're fixing. So this really doesn't matter.  An exceptional one would be
/dev/nullb* but that is not used in real world either.

I'm not trying to maintain a complete list (e.g. /dev/urandom and /dev/nullb*
are missing), this patch is just trying to make writing test code easier.

Fam

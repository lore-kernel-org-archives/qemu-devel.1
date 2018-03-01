Received: from eggs.gnu.org ([2001:4830:134:3::10]:60582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1erICs-0002Ee-SW
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 02:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1erICo-00079b-3J
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 02:00:46 -0500
Date: Thu, 1 Mar 2018 15:00:13 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180301070013.GE21198@lemon.usersys.redhat.com>
References: <20180228180507.3964-1-mreitz@redhat.com>
	<20180228180507.3964-12-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228180507.3964-12-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 11/16] test-hbitmap: Add non-advancing
 iter_next tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, 02/28 19:05, Max Reitz wrote:
> Add a function that wraps hbitmap_iter_next() and always calls it in
> non-advancing mode first, and in advancing mode next.  The result should
> always be the same.
> 
> By using this function everywhere we called hbitmap_iter_next() before,
> we should get good test coverage for non-advancing hbitmap_iter_next().

Haha, clever!

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0eaC-0008HX-Su
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 22:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0eaA-00022d-BL
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 22:43:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52524 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0eaA-00022R-64
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 22:43:30 -0400
Date: Tue, 27 Mar 2018 10:43:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180327024315.GH17789@xz-mi>
References: <20180327013620.1644387-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180327013620.1644387-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Monitor: OOB related patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, borntraeger@de.ibm.com

On Mon, Mar 26, 2018 at 08:36:16PM -0500, Eric Blake wrote:
> This is patches 2, 3, 7, and 8 (with 7 rewritten) from Peter Xu's
> series.  I've pushed them to git://repo.or.cz/qemu/ericb.git qapi-next
> (on top of the other pending qapi patches at branch qapi); hopefully
> this will be part of my pull request tomorrow for -rc1.
> 
> Eric Blake (1):
>   tests: Add parameter to qtest_init_without_qmp_handshake
> 
> Peter Xu (3):
>   qmp: cleanup qmp queues properly
>   monitor: new parameter "x-oob"
>   tests: qmp-test: add test for new "x-oob"
> 
>  tests/libqtest.h          |  7 +++-
>  include/monitor/monitor.h |  1 +
>  vl.c                      |  5 +++
>  tests/libqtest.c          | 10 +++--
>  monitor.c                 | 94 ++++++++++++++++++++++++++++++++++++-----------
>  tests/qmp-test.c          | 84 +++++++++++++++++++++++++++++++++++++++++-
>  6 files changed, 173 insertions(+), 28 deletions(-)

All of them look good to me.

Thanks Eric!

-- 
Peter Xu

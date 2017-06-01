Received: from eggs.gnu.org ([2001:4830:134:3::10]:51090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dGMBW-0005IL-0l
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dGMBV-0004Zj-8f
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:14:25 -0400
Date: Thu, 1 Jun 2017 11:14:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170601091416.GC4987@noname.redhat.com>
References: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
	<20170531144331.30173-3-pbutsykin@virtuozzo.com>
	<3cc61060-de94-0db5-ca25-6ba4906a3081@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cc61060-de94-0db5-ca25-6ba4906a3081@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-iotests: add reducing image test
 in 025
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com

Am 31.05.2017 um 16:54 hat Pavel Butsykin geschrieben:
> On 31.05.2017 17:43, Pavel Butsykin wrote:
> >Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> >---
> >  tests/qemu-iotests/025     | 19 +++++++++++++++++--
> >  tests/qemu-iotests/025.out | 12 +++++++++++-
> >  2 files changed, 28 insertions(+), 3 deletions(-)
> >
> >diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
> >index f5e672e6b3..658601579b 100755
> >--- a/tests/qemu-iotests/025
> >+++ b/tests/qemu-iotests/025
> >@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> >  . ./common.filter
> >  . ./common.pattern
> >-_supported_fmt raw qcow2 qed
> >+_supported_fmt raw qcow2
> 
> I'm not sure, can I so blatantly drop QED here. But this place is very
> suitable for reduce image case. Perhaps the alternative would be adding
> a new test, I just didn't want to copy the tests, which are testing
> almost the same thing.

I think it's better to have a separate test case for shrinking, so that
we don't damage the test coverage of qed. The resulting new patch would
be a very small one, but that's okay.

Kevin

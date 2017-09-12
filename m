Received: from eggs.gnu.org ([2001:4830:134:3::10]:55409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drhwa-0002Xu-JO
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drhwV-00048X-PQ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:57:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1drhwV-00047j-Iq
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:57:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C0E5C04B317
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:57:18 +0000 (UTC)
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-28-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f003201a-a676-cee4-f814-4201d012a7bf@redhat.com>
Date: Tue, 12 Sep 2017 11:57:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-28-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 27/38] libqtest: Swap order of
 qtest_init() and qtest_start()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com

On 11.09.2017 19:20, Eric Blake wrote:
> We already have another qtest_init() in the tree (namely, as part
> of the device initialization of the qtest device at the top level
> qtest.c), with a different signature; having two different
> qtest_init() is confusing, so an upcoming patch will consolidate
> all testsuite callers onto a unified spelling.  But the
> consolidation is easier if qtest_start() is further down the call
> chain, rather than an intermediate wrapper, so swap the call chain
> around.  This includes renaming qtest_init_without_qmp_handshake()
> into qtest_start_without_qmp_handshake(), as it remains the lowest
> point in the call stack.
> 
> Note that qtest_init() now asserts that global_qtest was not set
> on entry, and clears it on exit, to preserve the behavior of
> existing tests that assert the same (and also proving that we
> fixed all tests that had parallel connections); but later patches
> will eventually simplify things by getting rid of qtest_init()
> and global_qtest altogether.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dp81a-0004rd-N1
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dp81W-0006Li-2T
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:11:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dp81V-0006L8-SP
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:11:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5A687572C
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 07:11:48 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-22-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6fa7c1bb-ec7f-0722-03ad-32563b37c935@redhat.com>
Date: Tue, 5 Sep 2017 09:11:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-22-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 21/29] qmp-test: Drop dependence on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com

On 01.09.2017 20:03, Eric Blake wrote:
> As a general rule, we prefer avoiding implicit global state
> because it makes code harder to safely copy and paste without
> thinking about the global state.  Although qmp-test does not
> maintain parallel qtest connections, it was the last test
> assigning to global_qtest.  It's just as easy to be explicit
> about the state; once all tests have been cleaned up, a later
> patch can then get rid of global_qtest and a layer of wrappers
> in libqtest.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qmp-test.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

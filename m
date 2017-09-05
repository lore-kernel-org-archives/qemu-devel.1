Received: from eggs.gnu.org ([2001:4830:134:3::10]:40463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBbq-0000BE-77
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBbg-0007pv-MS
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:01:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dpBbg-0007pR-Ge
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:01:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D70780464
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 11:01:23 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-26-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f220253f-01f8-ca60-2908-bb2d0e4299b6@redhat.com>
Date: Tue, 5 Sep 2017 13:01:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-26-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 25/29] wdt_ib700-test: Drop dependence
 on global_qtest
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
> thinking about the global state.  Improve this test to be
> explicit about the state.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/wdt_ib700-test.c | 63 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 34 insertions(+), 29 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

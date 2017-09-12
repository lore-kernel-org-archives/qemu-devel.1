Received: from eggs.gnu.org ([2001:4830:134:3::10]:39462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drh7v-0007MK-PG
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drh7q-0006CL-SO
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:05:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1drh7q-0006BR-Lq
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:04:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0B67C0587DD
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:04:57 +0000 (UTC)
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-16-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <30c4ef27-43ee-3de8-a82b-334553e7660d@redhat.com>
Date: Tue, 12 Sep 2017 11:04:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-16-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 15/38] libqos: Use explicit QTestState
 for i2c operations
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

On 11.09.2017 19:19, Eric Blake wrote:
> Drop one more client of global_qtest by teaching all i2c test
> functionality to pass in an explicit QTestState, adjusting all
> callers.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqos/i2c.h      |  7 ++++--
>  tests/ds1338-test.c     |  6 ++---
>  tests/libqos/i2c-imx.c  | 67 +++++++++++++++++++++++++------------------------
>  tests/libqos/i2c-omap.c | 45 +++++++++++++++++----------------
>  tests/tmp105-test.c     |  6 ++---
>  5 files changed, 66 insertions(+), 65 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

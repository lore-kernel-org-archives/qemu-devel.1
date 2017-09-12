Received: from eggs.gnu.org ([2001:4830:134:3::10]:39970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dricu-0001xP-Um
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dricp-0001YS-6L
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:41:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dricp-0001XH-0M
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:41:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F37379D768
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 10:41:01 +0000 (UTC)
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-31-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5bef89f3-6b33-ddf4-983c-ef007800b31f@redhat.com>
Date: Tue, 12 Sep 2017 12:40:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-31-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 30/38] qtest: Avoid passing raw strings
 through hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 11.09.2017 19:20, Eric Blake wrote:
> hmp() passes its string argument through the sprintf() family;
> with a proper attribute, gcc -Wformat warns us when we do something
> dangerous like passing a non-constant format string.  Fortunately,
> all our strings were safe, but checking whether the string can
> contain an unintended % is easy to avoid and therefore worth doing.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v7: add GCC_FMT_ATTR here, drop R-b
> ---
>  tests/libqtest.h | 8 ++++----
>  tests/test-hmp.c | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

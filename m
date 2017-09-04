Received: from eggs.gnu.org ([2001:4830:134:3::10]:50239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dos1C-0007Io-Bp
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dos17-0007wB-PB
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:06:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36879)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dos17-0007uy-IT
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:06:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A65DF6E775
	for <qemu-devel@nongnu.org>; Mon,  4 Sep 2017 14:06:20 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-5-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5a6de38f-8e7b-60c6-015a-5dccad13175b@redhat.com>
Date: Mon, 4 Sep 2017 16:06:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 04/29] qtest: Don't perform side effects
 inside assertion
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
> Assertions should be separate from the side effects, since in
> theory, g_assert() can be disabled (in practice, we can't really
> ever do that).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qtest.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 57 insertions(+), 23 deletions(-)

Right, we should get rid of this bad coding style in the QEMU sources.

Reviewed-by: Thomas Huth <thuth@redhat.com>

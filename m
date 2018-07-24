Received: from eggs.gnu.org ([2001:4830:134:3::10]:39019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fhtV1-0000Vw-9g
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fhtUx-0006zt-Ab
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:20:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52262 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fhtUx-0006zV-5M
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:20:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C989540241D3
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 09:20:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180723123305.24792-2-peterx@redhat.com> (Peter Xu's message of
	"Mon, 23 Jul 2018 20:33:02 +0800")
References: <20180723123305.24792-1-peterx@redhat.com>
	<20180723123305.24792-2-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 24 Jul 2018 11:20:41 +0200
Message-ID: <87bmaxgfbq.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.0 1/4] migration: update recv bitmap
 only on dest vm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> We shouldn't update the received bitmap if we're the source VM.  This
> fixes a breakage when release-ram is enabled on postcopy.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/ram.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Juan Quintela <quintela@redhat.com>

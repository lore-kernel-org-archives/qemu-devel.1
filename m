Received: from eggs.gnu.org ([2001:4830:134:3::10]:43911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dG2Fe-0006CN-4N
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dG2Fa-0004r2-94
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:57:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dG2Fa-0004qs-3U
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:57:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2BE9469
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 11:57:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1496226934-29752-1-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Wed, 31 May 2017 18:35:34 +0800")
References: <1496226934-29752-1-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 31 May 2017 13:57:13 +0200
Message-ID: <871sr5ck86.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration: isolate return path on src
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> There are some places that binded "return path" with postcopy. Let's be
> prepared for its usage even without postcopy. This patch mainly did this
> on source side.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> standalone patch isolated from the return path series. ok to be picked
> up in case one day we'll re-face the return path enablement.
> With it, we are ready on source side. The dst side change has been queued.


Reviewed-by: Juan Quintela <quintela@redhat.com>

queued

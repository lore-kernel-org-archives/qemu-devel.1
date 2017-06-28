Received: from eggs.gnu.org ([2001:4830:134:3::10]:52674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQ7WF-0006Jy-S7
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQ7WC-000700-Ba
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:36:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dQ7WC-0006zu-5x
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:36:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 408AB804F1
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 07:36:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1498472935-14461-1-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Mon, 26 Jun 2017 18:28:55 +0800")
References: <1498472935-14461-1-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 28 Jun 2017 09:36:02 +0200
Message-ID: <87vang7ee5.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration: add "return-path" capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> When this capability is enabled, QEMU will use the return path even for
> precopy migration. This is helpful at least in one case when destination
> failed to load the image while source quited without confirmation. With
> return path, source will wait for the last response from destination,
> and if destination fails, it'll fail the migration on source, then the
> guest can be run again on the source (rather than assuming to be good,
> then the guest will be lost after source quits).
>
> It needs to be enabled explicitly on source, otherwise disabled.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

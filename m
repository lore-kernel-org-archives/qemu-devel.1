Received: from eggs.gnu.org ([2001:4830:134:3::10]:52071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIf0n-0005mV-Ui
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIf0l-0003Tv-Ct
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:44:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIf0l-0003Tr-6g
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:44:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35B9337EE1
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 17:44:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1496745042-2379-4-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Tue, 6 Jun 2017 18:30:39 +0800")
References: <1496745042-2379-1-git-send-email-peterx@redhat.com>
	<1496745042-2379-4-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 07 Jun 2017 19:44:45 +0200
Message-ID: <87fufbd75e.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/6] migration: use compat bit for
 global_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Removing two callers of global_state_set_optional() since now we can use
> HW_COMPAT_2_3. However there is still one more caller (xen_init), so we
> still need to keep the function until it disappears.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Ah, you do it here, nice.

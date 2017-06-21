Received: from eggs.gnu.org ([2001:4830:134:3::10]:36297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNbU0-0004LM-Rs
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:59:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNbTx-0000yn-0i
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:59:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dNbTw-0000yB-Qs
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:59:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE96819D387
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 08:59:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1498031528-1990-6-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Wed, 21 Jun 2017 15:52:03 +0800")
References: <1498031528-1990-1-git-send-email-peterx@redhat.com>
	<1498031528-1990-6-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 21 Jun 2017 10:59:18 +0200
Message-ID: <87d19xn2c9.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 05/10] migration: move
 global_state.optional out
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Put it into MigrationState then we can use the properties to specify
> whether to enable storing global state.
>
> Removing global_state_set_optional() since now we can use HW_COMPAT_2_3
> for x86/power, and AccelClass.global_props for Xen.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

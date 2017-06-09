Received: from eggs.gnu.org ([2001:4830:134:3::10]:44654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dJEZd-0006F1-IR
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 03:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dJEZX-00072Y-Iq
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 03:43:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dJEZX-0006z2-Cf
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 03:43:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 423F781236
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 07:43:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1496980142-8986-4-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Fri, 9 Jun 2017 11:48:59 +0800")
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
	<1496980142-8986-4-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 09 Jun 2017 09:43:01 +0200
Message-ID: <87bmpxa9oa.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/6] migration: move
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Put it into MigrationState then we can use the properties to specify
> whether to enable storing global state.
>
> Removing global_state_set_optional() since now we can use HW_COMPAT_2_3
> for x86/power in general, and the register_compat_prop() for xen_init().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Yeap, that is what I had in mind.

Reviewed-by: Juan Quintela <quintela@redhat.com>

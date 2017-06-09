Received: from eggs.gnu.org ([2001:4830:134:3::10]:45349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dJEc0-0007y7-2W
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 03:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dJEbw-0008AP-VM
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 03:45:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dJEbw-0008AG-PQ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 03:45:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C023081236
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 07:45:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1496980142-8986-6-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Fri, 9 Jun 2017 11:49:01 +0800")
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
	<1496980142-8986-6-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 09 Jun 2017 09:45:34 +0200
Message-ID: <8737b9a9k1.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 5/6] migration: move skip_configuration
 out
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
> It was in SaveState but now moved to MigrationState altogether. Again,
> using HW_COMPAT_2_3 for old PC/SPAPR machines, and
> register_compat_prop() for xen_init().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

if you had to respin, I think it would be better to change the name to
save_configuration, and change the true/false logic.  I don't like
negative logic, but it was used in this case due to how it was used,
now, it is not needed anymore.

Later, Juan.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dMytq-0001m4-Nu
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dMytm-0004qx-Po
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:47:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dMytm-0004qe-JV
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:47:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A9284E4FC
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 15:47:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1497876588-947-11-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Mon, 19 Jun 2017 20:49:45 +0800")
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
	<1497876588-947-11-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 19 Jun 2017 17:47:23 +0200
Message-ID: <87y3so9dys.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 10/13] migration: move
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
> for x86/power, and accel_register_prop() for xen_init().
>

Reviewed-by: Juan Quintela <quintela@redhat.com>

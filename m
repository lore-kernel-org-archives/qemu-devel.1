Received: from eggs.gnu.org ([2001:4830:134:3::10]:36690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX9bi-00086u-MH
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX9be-0007aD-Jc
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:14:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX9be-0007Zs-Cz
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:14:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2EE76356DB
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:14:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1500279971-13875-11-git-send-email-peterx@redhat.com> (Peter
	Xu's message of "Mon, 17 Jul 2017 16:26:10 +0800")
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
	<1500279971-13875-11-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 17 Jul 2017 19:14:44 +0200
Message-ID: <87vamryohn.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 10/11] migration: provide
 migrate_cap_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Abstracted from migrate_set_block_enabled() to allocate
> MigrationCapabilityStatusList properly.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


Nitpick

> -void migrate_set_block_enabled(bool value, Error **errp)
> +static MigrationCapabilityStatusList *migrate_cap_add(
> +    MigrationCapabilityStatusList *head,

We have a parameter called head

> +    MigrationCapability index,
> +    bool state)
>  {
>      MigrationCapabilityStatusList *cap;
>  
>      cap = g_new0(MigrationCapabilityStatusList, 1);
>      cap->value = g_new0(MigrationCapabilityStatus, 1);
> -    cap->value->capability = MIGRATION_CAPABILITY_BLOCK;
> -    cap->value->state = value;
> +    cap->value->capability = index;
> +    cap->value->state = state;
> +    cap->next = head;
> +
> +    return cap;


But we don't do the *head = cap?

Pelhaps is better to call it "next" or "list"?

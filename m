Received: from eggs.gnu.org ([2001:4830:134:3::10]:57788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX9ME-000052-Pe
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX9M9-0005O5-5L
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:58:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX9M8-0005NG-Vv
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:58:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 849F6C04B329
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 16:58:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1500279971-13875-4-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Mon, 17 Jul 2017 16:26:03 +0800")
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
	<1500279971-13875-4-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 17 Jul 2017 18:58:44 +0200
Message-ID: <878tjn0zln.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 03/11] migration: export capabilities to
 props
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
> Do the same thing to migration capabilities, just like what we did in
> previous patch for migration parameters.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


A pitty that the preprocessor is not able to pass to uppercase ...

> +#define DEFINE_PROP_MIG_CAP(name, x)             \
> +    DEFINE_PROP_BOOL(name, MigrationState, enabled_capabilities[x], false)

#define DEFINE_PROP_MIG_CAP(name)             \
    DEFINE_PROP_BOOL(#name, MigrationState,
    enabled_capabilities[MIGRATION_CAPABILITY_##name], false)

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNbX4-0006IG-AK
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNbX0-0003OH-Db
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:02:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dNbX0-0003Nz-7G
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:02:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30677145F8C
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 09:02:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1498031528-1990-10-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Wed, 21 Jun 2017 15:52:07 +0800")
References: <1498031528-1990-1-git-send-email-peterx@redhat.com>
	<1498031528-1990-10-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 21 Jun 2017 11:02:27 +0200
Message-ID: <87wp85lnmk.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 09/10] migration: merge
 enforce_config_section somewhat
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
> These two parameters:
>
> - MachineState::enforce_config_section
> - MigrationState::send_configuration
>
> are playing similar role here. This patch merges the first one into
> second, then we'll have a single place to reference whether we need to
> send the configuration section.
>
> I didn't remove the MachineState.enforce_config_section field since when
> applying that machine property (in machine_set_property()) we haven't
> yet initialized global properties and migration object. Then, it's
> still not easy to pass that boolean to MigrationState at such an early
> time.
>
> A natural benefit for current patch is that now we kept the meaning of
> "enforce-config-section" since it'll still have the highest
> priority (that's what "enforce" mean I guess).
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Nice!!!

Reviewed-by: Juan Quintela <quintela@redhat.com>

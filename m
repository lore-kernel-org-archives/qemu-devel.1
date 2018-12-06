Received: from eggs.gnu.org ([2001:4830:134:3::10]:36885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUyp2-0003AW-Gu
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUyp0-00031C-Hq
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:56:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUyou-0002Rf-TJ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:56:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E8993001589
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 18:56:01 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-28-marcandre.lureau@redhat.com>
Date: Thu, 06 Dec 2018 19:55:57 +0100
In-Reply-To: <20180706105753.26700-28-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 6 Jul 2018
	12:57:53 +0200")
Message-ID: <87sgza5vsy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 27/27] qapi: add conditions to
 REPLICATION type/commands on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add #if defined(CONFIG_REPLICATION) in generated code, and adjust the
> code accordingly.
>
> Made conditional:
>
> * xen-set-replication, query-xen-replication-status,
>   xen-colo-do-checkpoint
>
>   Before the patch, we first register the commands unconditionally in
>   generated code (requires a stub), then conditionally unregister in
>   qmp_unregister_commands_hack().
>
>   Afterwards, we register only when CONFIG_REPLICATION.  The command
>   fails exactly the same, with CommandNotFound.
>
>   Improvement, because now query-qmp-schema is accurate, and we're one
>   step closer to killing qmp_unregister_commands_hack().
>
> * enum BlockdevDriver value "replication" in command blockdev-add
>
> * BlockdevOptions variant @replication
>
> And related structures.

This sentence no verb :)

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

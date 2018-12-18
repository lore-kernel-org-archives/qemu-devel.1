Received: from eggs.gnu.org ([2001:4830:134:3::10]:40667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZJwD-0008Q9-Ur
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:17:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZJgX-0006LD-NO
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:01:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZJgX-0005fl-Cu
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:01:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BED6C3C2CCC
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 18:01:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181216140902.23986-1-marcandre.lureau@redhat.com>
	<20181216140902.23986-12-marcandre.lureau@redhat.com>
Date: Tue, 18 Dec 2018 19:01:19 +0100
In-Reply-To: <20181216140902.23986-12-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Sun, 16 Dec 2018
	18:09:00 +0400")
Message-ID: <87r2eed89c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/13] qapi: make query-cpu-definitions
 depend on specific targets
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

> It depends on TARGET_PPC || TARGET_ARM || TARGET_I386 || TARGET_S390X.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
[...]
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 18579bc5e8..dc0a7413a4 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -36,6 +36,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-visit-misc.h"
>  #include "qapi/qapi-visit-run-state.h"
> +#include "qapi/target-qapi-commands.h"

You already added this one in the previous patch.

>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qapi/visitor.h"
[...]

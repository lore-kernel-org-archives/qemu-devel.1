Received: from eggs.gnu.org ([2001:4830:134:3::10]:42498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUvAV-0005Nj-BC
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUvAS-0002S2-7T
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:30:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57250 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fUvAS-0002R7-2z
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:30:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9476401DEAF
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 14:30:03 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-2-marcandre.lureau@redhat.com>
Date: Mon, 18 Jun 2018 16:29:59 +0200
In-Reply-To: <20180321115211.17937-2-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 21 Mar 2018 12:51:23 +0100")
Message-ID: <87wouw88wo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/49] qapi/visit: remove useless prefix
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/visit.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> index 5d72d8936c..3c5ea1289e 100644
> --- a/scripts/qapi/visit.py
> +++ b/scripts/qapi/visit.py
> @@ -293,7 +293,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVis=
itor):
>  #include "qapi/qmp/qerror.h"
>  #include "%(visit)s.h"
>  ''',
> -                                      visit=3Dvisit, prefix=3Dself._pref=
ix))
> +                                      visit=3Dvisit))
>          self._genh.preamble_add(mcgen('''
>  #include "qapi/qapi-builtin-visit.h"
>  #include "%(types)s.h"

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXQxP-0004QQ-9q
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXQxL-0006ri-Oy
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:23:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXQxK-0006oH-6V
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:23:10 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC2DBC045741
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 13:23:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181213123724.4866-1-marcandre.lureau@redhat.com>
	<20181213123724.4866-7-marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 14:23:03 +0100
In-Reply-To: <20181213123724.4866-7-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 13 Dec 2018 16:37:08 +0400")
Message-ID: <87zht9r26g.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 06/22] qapi: add a dictionary form with
 'name' key for enum members
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

> Desugar the enum NAME form to { 'name': NAME }. This will allow to add
> new enum members, such as 'if' in the following patch.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

With the next two patches squashed in:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

Happy to squash when I apply.  I forgot to do it in my qapi-if-2 branch.

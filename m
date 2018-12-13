Received: from eggs.gnu.org ([2001:4830:134:3::10]:48055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXRat-00087e-Uv
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXRap-0007AP-2D
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:04:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXRao-00079i-Qt
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:03:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0474B3082132
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 14:03:58 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181213123724.4866-1-marcandre.lureau@redhat.com>
	<20181213123724.4866-19-marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 15:03:53 +0100
In-Reply-To: <20181213123724.4866-19-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 13 Dec 2018 16:37:20 +0400")
Message-ID: <87bm5pr0ae.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 18/22] qapi: add 'If:' condition to enum
 values documentation
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

> Use a common function to generate the "If:..." line.
>
> While at it, get rid of the existing \n\n (no idea why it was
> there). Use a line-break in member description, this seems to look
> slightly better in the plaintext version.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I'm not entirely happy with texi_member() (see my review of PATCH v7
22/27) and the way we present conditionals in generated documentation
(see my review of PATCH v7 26/27).  But this will do for now.

Reviewed-by: Markus Armbruster <armbru@redhat.com>

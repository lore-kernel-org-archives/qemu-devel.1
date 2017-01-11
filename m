Received: from eggs.gnu.org ([2001:4830:134:3::10]:43872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cRK59-00040G-3K
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 09:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cRK54-0003w8-OO
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 09:40:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cRK54-0003v4-JA
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 09:40:50 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75CA981253
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 14:40:50 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170109143437.30554-1-marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 15:40:47 +0100
In-Reply-To: <20170109143437.30554-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 9 Jan 2017 15:34:16 +0100")
Message-ID: <87k2a1lkwg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 00/21] qapi doc generation (whole
 version, squashed)
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

> Add a qapi2texi script to generate the documentation from the qapi
> schemas.
>
> The SQUASHED patch in this series is a squashed version of the
> documentation move from qmp-commands.txt to the schemas. The whole
> version (not sent on the ML to avoid spamming) is in the following git
> branch: https://github.com/elmarco/qemu/commits/qapi-doc
>
> PDF preview:
> https://fedorapeople.org/~elmarco/qemu-qmp-ref.pdf (v7 without type info)

PATCH 15 "qapi: add qapi2texi script" might need another respin,
depending on discussion.  The rest looks ready to me, with a few commit
message tweaks.

I could take PATCH 01-08,11 right away if that helps.

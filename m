Received: from eggs.gnu.org ([2001:4830:134:3::10]:49112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwWQ-0005w2-8q
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwWN-0001Rm-7Y
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:53:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cDwWM-0001Ra-Vu
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:53:43 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B45C2445DE
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 16:53:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20161117155504.21843-1-marcandre.lureau@redhat.com>
Date: Mon, 05 Dec 2016 17:53:39 +0100
In-Reply-To: <20161117155504.21843-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 17 Nov 2016 19:54:47 +0400")
Message-ID: <87bmwquxkc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/17] qapi doc generation (whole
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
> The 15th patch in this series is a squashed version of the
> documentation move from qmp-commands.txt to the schemas. The whole
> version (not sent on the ML to avoid spamming) is in the following git
> branch: https://github.com/elmarco/qemu/commits/qapi-doc
>
> PDF preview:
> https://fedorapeople.org/~elmarco/qemu-qmp-ref.pdf

PATCH 2,4-8 applied to qapi-next for 2.8.

PATCH 1,10 are ready, but I'm punting them to 2.9 because they affect
generated code.  Probably overcautious.

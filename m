Received: from eggs.gnu.org ([2001:4830:134:3::10]:49911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQvEa-000285-GS
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQvEX-0003kZ-Bk
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:09:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cQvEX-0003kM-5z
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:08:57 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6728D31B31F
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 12:08:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170109143437.30554-1-marcandre.lureau@redhat.com>
	<20170109143437.30554-9-marcandre.lureau@redhat.com>
Date: Tue, 10 Jan 2017 13:08:54 +0100
In-Reply-To: <20170109143437.30554-9-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 9 Jan 2017 15:34:24 +0100")
Message-ID: <871swbruax.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 08/21] qapi: move experimental note down
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

> Use a better 'Note:' section, move it below parameters following
> guidelines.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Again, I don't mind moving stuff around if it helps getting this series
wrapped, and doesn't make things less readable.  My only nit is the
commit message's claim about the guidelines.  Let's sidestep it:

    Move these notes down and prefix with "Note:", to please the doc
    generator we're going to add.

Okay?

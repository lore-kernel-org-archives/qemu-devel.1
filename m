Received: from eggs.gnu.org ([2001:4830:134:3::10]:41554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cS4VL-0005SP-AM
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:15:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cS4VI-0005Vi-7E
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:15:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cS4VI-0005Uu-1b
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:15:00 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C04FC04D2EC
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 16:15:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
	<20170113144135.5150-9-marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 17:14:57 +0100
In-Reply-To: <20170113144135.5150-9-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 13 Jan 2017 15:41:22 +0100")
Message-ID: <87r347hr7i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 08/21] qapi: move experimental note down
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

As proposed in review of v7, I'm replacing commit message by

  qapi: Move "command is experimental" notes down

  Move these notes down and prefix with "Note:", to please the doc
  generator we're going to add.

if that's okay with you.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQsTI-0000yj-JX
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQsTE-0001b7-HV
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:12:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cQsTE-0001ay-BI
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:11:56 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F62D8FCF4
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:11:56 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170109143437.30554-1-marcandre.lureau@redhat.com>
	<20170109143437.30554-4-marcandre.lureau@redhat.com>
Date: Tue, 10 Jan 2017 10:11:53 +0100
In-Reply-To: <20170109143437.30554-4-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 9 Jan 2017 15:34:19 +0100")
Message-ID: <87r34buvmu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 03/21] qapi: make TODOs named-sections
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

> Have the TODO in the TAG: format, so they will stand out in the
> generated documentation.

I expect TODO without colon to creep back.  Right now, we have three
with and three without colon.  Whack-a-mole is a stupid game, but since
these moles are fairly harmless, I don't care.

The commit message is sub-optimal, though.  At this point, there is no
generated documentation, and we have no concept of "named-sections".
Let's instead say

  qapi: Format TODO comments more consistently

  Consistently put a colon after TODO.  This will make the TODOs stand
  out in the documentation we're going to generate.

With that
Reviewed-by: Markus Armbruster <armbru@redhat.com>

Alternatively, delay the patch until after we generate documentation.

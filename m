Received: from eggs.gnu.org ([2001:4830:134:3::10]:41520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cS4Uv-0005GZ-Lo
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cS4Us-0005Iz-HS
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:14:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cS4Us-0005Io-B9
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:14:34 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73EDF4AEA8
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 16:14:34 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
	<20170113144135.5150-8-marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 17:14:31 +0100
In-Reply-To: <20170113144135.5150-8-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 13 Jan 2017 15:41:21 +0100")
Message-ID: <87shonhr88.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 07/21] qapi: avoid interleaving sections
 and parameters
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

> Follow documentation guideline, body, parameters then additional
> sections.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

As proposed in review of v7, I'm replacing commit message by

  qapi: Reorder doc comments for future doc generator
=20=20
  The doc generator we're going to add expects a fairly rigid doc
  comment structure.  Reorder / rephrase some doc comments to please it.

if that's okay with you.

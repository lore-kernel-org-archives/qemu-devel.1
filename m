Received: from eggs.gnu.org ([2001:4830:134:3::10]:60488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkB9h-0000nM-Ba
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:31:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkB9g-0004Hn-JL
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:31:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkB9g-0004G2-DC
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:31:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 695F681E0F
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 15:31:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-4-marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 17:31:41 +0200
In-Reply-To: <20170822132255.23945-4-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 22 Aug 2017 15:22:04 +0200")
Message-ID: <87378j8vqa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/54] qobject: add literal qobject type
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

> Promote LiteralQObject from tests/check-qjson.c to qobject/qlit.c,
> allowing to statically declare complex qobjects.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Your patch does more than that!  It also

* renames the now externally visible identifiers,

* adds support for qnull and qnum,

* cleans up types (int vs. bool) and style,

* makes compare_litqobj_to_qobj() case QTYPE_QNULL and QTYPE_QSTRING
  more robust, and

* fixes bugs in compare_litqobj_to_qobj() case QTYPE_QDICT, QTYPE_QLIST
  (I think).

Squashing the renames into the code motion is tolerable, but the rest
isn't, because it makes patch review harder for no benefit at all.
Moreover, the commit message fails to record the changes.  I noticed
them only because out of an abundance of caution I checked the patch is
just what it's advertised to be: code motion.  Well, it isn't.

Separate patches, please!

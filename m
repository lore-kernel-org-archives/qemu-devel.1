Received: from eggs.gnu.org ([2001:4830:134:3::10]:35529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dkBKL-0003tH-L3
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dkBKI-0003AG-FB
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:42:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dkBKI-00039d-8f
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:42:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4080677321
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 15:42:45 +0000 (UTC)
Date: Tue, 22 Aug 2017 11:42:37 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <867526927.1885479.1503416557412.JavaMail.zimbra@redhat.com>
In-Reply-To: <87378j8vqa.fsf@dusky.pond.sub.org>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-4-marcandre.lureau@redhat.com>
	<87378j8vqa.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

----- Original Message -----
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > Promote LiteralQObject from tests/check-qjson.c to qobject/qlit.c,
> > allowing to statically declare complex qobjects.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Your patch does more than that!  It also
>=20
> * renames the now externally visible identifiers,
>=20
> * adds support for qnull and qnum,
>=20
> * cleans up types (int vs. bool) and style,
>=20
> * makes compare_litqobj_to_qobj() case QTYPE_QNULL and QTYPE_QSTRING
>   more robust, and
>=20
> * fixes bugs in compare_litqobj_to_qobj() case QTYPE_QDICT, QTYPE_QLIST
>   (I think).
>=20
> Squashing the renames into the code motion is tolerable, but the rest
> isn't, because it makes patch review harder for no benefit at all.

The title said "add" and in the commit message "promote", it's not just a "=
move".

Imho, it's best to take a fresh look at the implementation since it is no l=
onger in tests and can be used from qemu/programs.

As such you can review the code as "new" code, and check the corresponding =
tests. Finally, the existing test is simply adapted to that code.

> Moreover, the commit message fails to record the changes.  I noticed
> them only because out of an abundance of caution I checked the patch is
> just what it's advertised to be: code motion.  Well, it isn't.
>=20
> Separate patches, please!

Sure, I can do that, I just thought it was extra overhead given my approach=
.

thanks

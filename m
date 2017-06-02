Received: from eggs.gnu.org ([2001:4830:134:3::10]:50835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGhSR-00012C-3F
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGhSO-0001eR-2w
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:57:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dGhSN-0001eJ-TC
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:57:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A266FC0467CB
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 07:57:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-11-marcandre.lureau@redhat.com>
Date: Fri, 02 Jun 2017 09:57:11 +0200
In-Reply-To: <20170531135709.345-11-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 31 May 2017 17:56:34 +0400")
Message-ID: <87bmq6kejs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/45] qapi: Remove
 visit_start_alternate() parameter promote_int
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

> Before the previous commit, parameter promote_int =3D true made
> visit_start_alternate() with an input visitor avoid QTYPE_QINT
> variants and create QTYPE_QFLOAT variants instead.  This was used
> where QTYPE_QINT variants were invalid.
>
> The previous commit fused QTYPE_QINT with QTYPE_QFLOAT, rendering
> rendering promote_int useless and unused.

Scratch one of two "rendering".

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

With that tidied up:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

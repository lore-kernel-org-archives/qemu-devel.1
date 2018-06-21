Received: from eggs.gnu.org ([2001:4830:134:3::10]:59728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fW1vA-0002T7-H4
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fW1v7-00067a-Fm
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:54:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43884 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fW1v7-00067Q-B4
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:54:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B5BD40250FF
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 15:54:48 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-14-marcandre.lureau@redhat.com>
Date: Thu, 21 Jun 2018 17:54:45 +0200
In-Reply-To: <20180321115211.17937-14-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 21 Mar 2018
	12:51:35 +0100")
Message-ID: <87d0wkkud6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 13/49] qapi-types: refactor variants
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Generate variants objects outside gen_object(). This will allow to
> easily wrap gen_object() with ifcond_decorator in the following patch.

ifcond_decorator is no more, please update your commit message.

>
> gen_variants_objects() calls gen_object() for each variants, so it

s/for each variants/for each variant/

> remains guarded for each generated variant object.
>
> self._gen_type_cleanup(name) is factored out in _gen_object(), helping
> generated code to be wrapped by the same condition in the following
> patch.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I read this thrice, and I still fail to understand the second and third
paragraph.

I'm skipping this patch for now, because we might not need it; see
review of next patch.

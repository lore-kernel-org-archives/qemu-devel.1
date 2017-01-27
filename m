Received: from eggs.gnu.org ([2001:4830:134:3::10]:35622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cX2zG-00038P-P7
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:38:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cX2zC-0006hD-SD
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:38:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cX2zC-0006h3-Lt
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:38:26 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC33FC05B1FE
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 09:38:26 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170125130308.16104-1-marcandre.lureau@redhat.com>
	<20170125130308.16104-3-marcandre.lureau@redhat.com>
Date: Fri, 27 Jan 2017 10:38:23 +0100
In-Reply-To: <20170125130308.16104-3-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 25 Jan 2017 17:03:08 +0400")
Message-ID: <874m0k971s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi2texi: produce type information
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

> Add type information to the generated documentation. Without it the
> written documentation is not explicit enough to know how to handle
> the various arguments and members.

This is actually a regression of sorts: the type information we used to
have in qmp-commands.txt got lost when we replaced it by generated
qemu-qmp-ref.*.

> Array types have the following syntax: type[]. Ex: str[].
>
> - Struct, commands and events use the following members syntax:
>
>   { 'member': type, ('foo': str), ... }
>
> Optional members are under parentheses.
>
> A structure with a base type will have 'BaseStruct +' prepended.
>
> - Alternates use the following syntax:
>
>   [ 'foo': type, 'bar': type, ... ]
>
> - Simple unions use the following syntax:
>
>   { 'type': str, 'data': 'type' =3D [ 'foo': type, 'bar': type... ] }
>
> - Flat unions use the following syntax:
>
>   BaseStruct + 'discriminator' =3D [ 'foo': type, 'bar': type... ]
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This is a formal language to describe QAPI/QMP from the user's point of
view (the QAPI schema specifies it from the implementor's point of
view).

I intend to implement ideas outlined in my review of "[PATCH v6 05/17]
docs: add master qapi texi files"[*], in particular adding type
information to the argument table.  That will address the stated purpose
of this patch, namely fixing the documentation regression.

We can then compare which fix provides the type information in more
readable form, and whether the additional formal description in your fix
is worth having.

Unfortunately, I need to to some QemuOpts / QAPI work first, because it
blocks features we'd like to have in 2.9.


[*] Message-ID: <87zijp8bxr.fsf@dusky.pond.sub.org>
http://lists.gnu.org/archive/html/qemu-devel/2016-12/msg03002.html

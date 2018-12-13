Received: from eggs.gnu.org ([2001:4830:134:3::10]:50395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXUE5-0000z9-4X
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXUE1-0002ol-Ub
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:52:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXUE1-0002nj-Os
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:52:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24025C049587
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 16:52:37 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181213123724.4866-1-marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 17:52:33 +0100
In-Reply-To: <20181213123724.4866-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 13 Dec 2018 16:37:02 +0400")
Message-ID: <874lbhmkry.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 00/22] qapi: add #if pre-processor
 conditions to generated code (part 2)
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

> This is the second part of the "add #if pre-processor conditions to
> generated code" series, adding schema member conditions (roughly
> 16-38/49).
>
> Members can be exploded as dictionnary with 'type'/'if' keys:
>
> { 'struct': 'TestIfStruct', 'data':
>   { 'foo': 'int',
>     'bar': { 'type': 'int', 'if': 'defined(TEST_IF_STRUCT_BAR)'} } }
>
> Enum values can be exploded as dictionnary with 'type'/'if' keys:
>
> { 'enum': 'TestIfEnum', 'data':
>   [ 'foo',
>     { 'name' : 'bar', 'if': 'defined(TEST_IF_ENUM_BAR)' } ] }
>
> Based-on: git://repo.or.cz/qemu/armbru.git qapi-next

Queued except for PATCH 11, which addresses an issue that no longer
exists.  Thanks!

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXSHN-0006wG-P6
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXSHK-00042m-8W
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:47:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXSHJ-00041L-VM
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:47:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CA49C057F36
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 14:47:53 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181213123724.4866-1-marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 15:47:49 +0100
In-Reply-To: <20181213123724.4866-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 13 Dec 2018 16:37:02 +0400")
Message-ID: <87r2elo54a.fsf@dusky.pond.sub.org>
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

I found nothing I can't easily tidy up when I apply.  Thanks!

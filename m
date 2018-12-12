Received: from eggs.gnu.org ([2001:4830:134:3::10]:59910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX89k-00019Y-RA
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX89h-0007hL-Mw
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:18:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gX89h-0007gz-Fq
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:18:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B044481F0B
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 17:18:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
Date: Wed, 12 Dec 2018 18:18:36 +0100
In-Reply-To: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Sat, 8 Dec 2018 15:15:39 +0400")
Message-ID: <87va3yfytv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 00/27] Hi,
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

PATCH 03,18,20,25 are only losely related to this second part.  They are
also ready.  Queued on branch qapi-next in my public repository, with
PATCH 18 and 20 squashed together.

I took the liberty to implement the the idea on normalization I
mentioned in review of PATCH 08.  I also squashed a few patches that are
essentially fixups into the patches they fix.  I did not address any
other review comments.  Result is on branch qapi-if-2.  Please have a
look.

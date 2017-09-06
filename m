Received: from eggs.gnu.org ([2001:4830:134:3::10]:56121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpYfk-0001UD-5m
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpYfe-0002bv-KR
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:39:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpYfe-0002bl-F3
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:39:02 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-23-marcandre.lureau@redhat.com>
Date: Wed, 06 Sep 2017 13:38:58 +0200
In-Reply-To: <20170822132255.23945-23-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 22 Aug 2017
	15:22:23 +0200")
Message-ID: <87fuc0awfh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 22/54] qapi-introspect: add preprocessor
 conditions to generated QLit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add 'ifcond' condition to QLit objects.
>
> to_qlit() handles the (obj, ifcond) tuples.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I my testing, the generated code changes like this:

    diff -rup qapi-gen-21-64300535f0/test-qmp-introspect.c qapi-gen-22-050f=
2a5d9d/test-qmp-introspect.c
    --- qapi-gen-21-64300535f0/test-qmp-introspect.c	2017-09-06 12:02:11.80=
8681800 +0200
    +++ qapi-gen-22-050f2a5d9d/test-qmp-introspect.c	2017-09-06 12:02:19.08=
5578791 +0200
    @@ -51,19 +51,31 @@ const QLitObject test_qmp_schema_qlit =3D
             { "name", QLIT_QSTR("EVENT_F") },
             {}
         })),
    -    QLIT_QDICT(((QLitDictEntry[]) {
    +=20=20=20=20
    +#if defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)
    +
--> +QLIT_QDICT(((QLitDictEntry[]) {
             { "arg-type", QLIT_QSTR("5") },
             { "meta-type", QLIT_QSTR("command") },
             { "name", QLIT_QSTR("TestIfCmd") },

Indentation's off at the line I marked.

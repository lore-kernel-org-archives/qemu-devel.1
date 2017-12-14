Received: from eggs.gnu.org ([2001:4830:134:3::10]:60296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ePWOs-0005Vn-1b
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:30:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ePWOm-0001X6-Ft
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:30:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ePWOm-0001UN-AG
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:30:16 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-44-marcandre.lureau@redhat.com>
Date: Thu, 14 Dec 2017 17:30:07 +0100
In-Reply-To: <20170911110623.24981-44-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 11 Sep 2017
	13:06:16 +0200")
Message-ID: <87r2rxuvao.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 43/50] build-sys: move qmp-introspect
 per target
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

> The following patches are going to introduce per-target #ifdef, and
> but the introspection data is generated only once, and must thus be
> built with the target.

"and but"?

> Drop "do_test_visitor_in_qmp_introspect(&&qmp_schema_qlit)" since it

s/&&/&/

> is no longer in a common object, and covered by "query-qmp-schema
> test" instead.

Do you mean test /x86_64/qmp/query-qmp-schema of tests/qmp-test.c?

That test tests significantly less.  It runs the command, tests it
succeeds and returns something.  The test you remove additionally tests
the returned value conforms to the schema, by passing it to
visit_type_SchemaInfoList().

Perhaps we can enhance the test you keep to avoid this loss.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

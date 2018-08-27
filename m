Received: from eggs.gnu.org ([2001:4830:134:3::10]:40227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuCJE-0005pY-Gu
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuCFY-0004m3-01
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:47:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51712 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fuCFX-0004li-Qd
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:47:47 -0400
References: <20180825135724.8981-1-marcandre.lureau@redhat.com>
	<20180825135724.8981-7-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7d04b436-d90b-d766-809f-5a27564c9000@redhat.com>
Date: Mon, 27 Aug 2018 09:47:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180825135724.8981-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/9] tests: add a few qmp tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 2018-08-25 15:57, Marc-Andr=C3=A9 Lureau wrote:
> test_object_add_without_props() tests a bug in qmp_object_add() we
> fixed in commit e64c75a975.  Sadly, we don't have systematic
> object-add tests.  This lone test can go into qmp-cmd-test for want of
> a better home.
>=20
> test_qom_set_without_value() is about a bug in infrastructure used by
> the QMP core, fixed in commit c489780203.  We covered the bug in
> infrastructure unit tests (commit bce3035a44).  I wrote that test
> earlier, to cover QMP level as well, the test could go into qmp-test.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qmp-cmd-test.c | 31 +++++++++++++++++++++++++++++++
>  tests/qmp-test.c     | 18 ++++++++++++++++++
>  2 files changed, 49 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>

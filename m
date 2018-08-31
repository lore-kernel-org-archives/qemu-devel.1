Received: from eggs.gnu.org ([2001:4830:134:3::10]:56227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvcSY-0004oR-SB
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 01:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvcSU-0003tb-JU
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 01:59:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48606 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fvcSS-0003so-IB
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 01:59:00 -0400
References: <20180830155810.17629-1-marcandre.lureau@redhat.com>
	<20180830155810.17629-3-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3dfe846b-6d18-fa24-6743-1dfc2821fbf3@redhat.com>
Date: Fri, 31 Aug 2018 07:58:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180830155810.17629-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/4] tests: add
 qmp/object-add-without-props test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 2018-08-30 17:58, Marc-Andr=C3=A9 Lureau wrote:
> test_object_add_without_props() tests a bug in qmp_object_add() we
> fixed in commit e64c75a975.  Sadly, we don't have systematic
> object-add tests.  This lone test can go into qmp-cmd-test for want of
> a better home.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qmp-cmd-test.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>

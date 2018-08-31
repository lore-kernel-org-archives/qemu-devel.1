Received: from eggs.gnu.org ([2001:4830:134:3::10]:56759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvcUO-0005tD-J9
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvcUK-00050K-He
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:01:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34950 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fvcUK-0004x7-B4
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:00:56 -0400
References: <20180830155810.17629-1-marcandre.lureau@redhat.com>
	<20180830155810.17629-4-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b5db24e8-a4c5-6fe5-ceda-ed126a476370@redhat.com>
Date: Fri, 31 Aug 2018 08:00:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180830155810.17629-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/4] tests: add
 qmp/qom-set-without-value test
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
> test_qom_set_without_value() is about a bug in infrastructure used by
> the QMP core, fixed in commit c489780203.  We covered the bug in
> infrastructure unit tests (commit bce3035a44).  I wrote that test
> earlier, to cover QMP level as well, the test could go into qmp-test.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qmp-test.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>

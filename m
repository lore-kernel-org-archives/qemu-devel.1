Received: from eggs.gnu.org ([2001:4830:134:3::10]:58860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dV1A4-0004LB-BX
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dV1A1-0002GZ-8J
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:49:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25389)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dV1A1-0002Ex-2b
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:49:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA692B814E
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 19:49:27 +0000 (UTC)
References: <20170711103011.32631-1-marcandre.lureau@redhat.com>
	<20170711103011.32631-4-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <12c8247f-2563-7494-320b-da011c1717e5@redhat.com>
Date: Tue, 11 Jul 2017 21:49:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170711103011.32631-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/7] tests: add simple vmcoreinfo test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, anderson@redhat.com, imammedo@redhat.com

On 07/11/17 12:30, Marc-Andr=C3=A9 Lureau wrote:
> This test is based off vmgenid test from Ben Warren
> <ben@skyportsystems.com>. It simply checks the vmcoreinfo ACPI device
> is present and that the memory region associated can be read.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/vmcoreinfo-test.c | 127 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/Makefile.include  |   2 +
>  2 files changed, 129 insertions(+)
>  create mode 100644 tests/vmcoreinfo-test.c

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

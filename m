Received: from eggs.gnu.org ([2001:4830:134:3::10]:36522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1epBfd-0005Wz-O1
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:37:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1epBfY-0005EL-OU
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:37:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46874 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1epBfY-0005DE-Ix
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:37:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C555E12267D
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 11:37:39 +0000 (UTC)
References: <20180215212552.26997-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bbf391fa-acf1-16bd-e6e9-336b977160e8@redhat.com>
Date: Fri, 23 Feb 2018 12:37:33 +0100
MIME-Version: 1.0
In-Reply-To: <20180215212552.26997-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/6] vhost-user-test and leak fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On 15/02/2018 22:25, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> The following patches fix a regression introduced in commit
> 218bb57dd79d that prevent ASAN from being detected & used.  There is
> also a works around for a GCC ASAN optimization bug. A few test leaks
> are fixed, and a few patches reenable vhost-user memfd test fixing the
> recent race bug that was identified in the previous version.
>=20
> Marc-Andr=C3=A9 Lureau (6):
>   build-sys: fix -fsanitize=3Daddress check
>   lockable: workaround GCC link issue with ASAN
>   vhost-user-test: add back memfd check
>   vhost-user-test: do not hang if chardev creation failed
>   ahci-test: fix opts leak of skip tests
>   sdhci-test: fix leaks
>=20
>  include/qemu/lockable.h |  2 +-
>  tests/ahci-test.c       |  1 +
>  tests/sdhci-test.c      |  2 ++
>  tests/vhost-user-test.c | 94 +++++++++++++++++++++++++++++++++++------=
--------
>  configure               | 22 ++++++------
>  5 files changed, 83 insertions(+), 38 deletions(-)
>=20

Queued 1-2-5-6, not really confident enough in what's going on with
vhost-user-test. :)

Paolo

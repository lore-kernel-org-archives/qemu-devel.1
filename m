Received: from eggs.gnu.org ([2001:4830:134:3::10]:55299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dp8XK-0003QF-Ne
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dp8XG-00029l-17
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:44:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dp8XF-00029L-Qz
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:44:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFD2975EAA
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 07:44:36 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-6-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <752faf0c-2ed9-2abb-dd6e-23cb65dd376f@redhat.com>
Date: Tue, 5 Sep 2017 09:44:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 05/29] numa-test: Use hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com

On 01.09.2017 20:03, Eric Blake wrote:
> Don't open-code something that has a convenient helper available.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=20
> ---
>  tests/numa-test.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

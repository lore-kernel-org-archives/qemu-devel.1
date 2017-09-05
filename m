Received: from eggs.gnu.org ([2001:4830:134:3::10]:35694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dp9t9-0002ZF-9X
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dp9t1-0001mD-Lv
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:11:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dp9t1-0001lw-Ga
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:11:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8DCB3C0587F6
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 09:11:10 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-10-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4e65a437-ac1c-7e47-5508-0240e2257c61@redhat.com>
Date: Tue, 5 Sep 2017 11:11:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-10-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 09/29] libqtest: Use qemu_strtoul()
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
> This will keep checkpatch happy when the next patch does code motion.
> Fix the include order to match HACKING when adding the needed header.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=20
> ---
>  tests/libqtest.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

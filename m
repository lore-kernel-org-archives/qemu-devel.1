Received: from eggs.gnu.org ([2001:4830:134:3::10]:34967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1doula-0005fC-Bk
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1doulV-0003T3-Sw
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:02:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1doulV-0003Sp-NP
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:02:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9719712BBC
	for <qemu-devel@nongnu.org>; Mon,  4 Sep 2017 17:02:24 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-8-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b918f238-41bc-40d5-ce99-f894fde76ab3@redhat.com>
Date: Mon, 4 Sep 2017 19:02:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 07/29] libqtest: Remove dead
 qtest_instances variable
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
> Prior to commit 063c23d9, we were tracking a list of parallel
> qtest objects, in order to safely clean up a SIGABRT handler
> only after the last connection quits.  But when we switched to
> more of glib's infrastructure, the list became dead code that
> is never assigned to.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/libqtest.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

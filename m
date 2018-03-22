Received: from eggs.gnu.org ([2001:4830:134:3::10]:34370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyqee-0008WG-Qb
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 23:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyqeZ-0004LB-OZ
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 23:12:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eyqeZ-0004Kx-Ju
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 23:12:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 515FE402277B
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 03:12:35 +0000 (UTC)
Date: Thu, 22 Mar 2018 11:12:29 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180322031229.GB32362@xz-mi>
References: <20180321113644.21899-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180321113644.21899-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: fix pfd leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

On Wed, Mar 21, 2018 at 12:36:44PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Fix leak spotted by ASAN:
>=20
> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>     #0 0x7fe1abb80a38 in __interceptor_calloc (/lib64/libasan.so.4+0xde=
a38)
>     #1 0x7fe1aaf1bf75 in g_malloc0 ../glib/gmem.c:124
>     #2 0x7fe1aaf1c249 in g_malloc0_n ../glib/gmem.c:355
>     #3 0x55f4841cfaa9 in postcopy_ram_fault_thread /home/elmarco/src/qe=
mu/migration/postcopy-ram.c:596
>     #4 0x55f48479447b in qemu_thread_start /home/elmarco/src/qemu/util/=
qemu-thread-posix.c:504
>     #5 0x7fe1a043550a in start_thread (/lib64/libpthread.so.0+0x750a)
>=20
> Regression introduced with commit 00fa4fc85b00f1a8a810068d158a7a66e8865=
8eb.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu

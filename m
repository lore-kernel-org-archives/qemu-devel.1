Received: from eggs.gnu.org ([2001:4830:134:3::10]:57344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreiman@redhat.com>) id 1fudnx-0007ii-VZ
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreiman@redhat.com>) id 1fudnt-0004aX-Kz
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:13:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44758 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreiman@redhat.com>) id 1fudnt-0004OX-DW
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:13:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F94C807689D
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 13:12:58 +0000 (UTC)
Date: Tue, 28 Aug 2018 15:12:55 +0200
From: Jens Freimann <jfreiman@redhat.com>
Message-ID: <20180828131255.6y45erawgk3tvt5y@jenstp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit; format=flowed
Content-Disposition: inline
In-Reply-To: <20180713130916.4153-7-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 06/29] libvhost-user: exit by default on
 VHOST_USER_NONE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

> Since commit 2566378d6d13bf4d28c7770bdbda5f7682594bbe, libvhost-user
> no longer panics on disconnect (rc =3D=3D 0), and instead silently igno=
res
> an invalid VHOST_USER_NONE message.
>=20
> Without extra work from the API user, this will simply busy-loop on
> HUP events. The obvious thing to do is to exit(0) instead, while
> additional or different work can be done by overriding
> iface->process_msg().
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jens Freimann <jfreimann@redhat.com>=20

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaMjh-0001Xe-GA
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaMje-0003T2-HP
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:29:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gaMjc-0003Pw-Bs
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:29:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75DFA7E9CB
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 15:29:07 +0000 (UTC)
Date: Fri, 21 Dec 2018 16:28:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181221162855.0b401083.cohuck@redhat.com>
In-Reply-To: <20181221090410.27250-25-marcandre.lureau@redhat.com>
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
	<20181221090410.27250-25-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 24/28] qdev-props: convert global_props
 to GPtrArray
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, ehabkost@redhat.com

On Fri, 21 Dec 2018 13:04:06 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> A step towards being able to call a common function,
> object_apply_global_props().
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/core/qdev-properties.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
>=20

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

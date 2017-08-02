Received: from eggs.gnu.org ([2001:4830:134:3::10]:37320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcmqL-0007ui-8A
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 02:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcmqG-0002gh-9v
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 02:09:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dcmqG-0002gT-2i
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 02:09:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E50B7E7B61
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 06:09:10 +0000 (UTC)
Date: Wed, 2 Aug 2017 14:09:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170802060903.GA4475@pxdev.xzpeter.org>
References: <20170801160419.14180-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170801160419.14180-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: fix small leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Tue, Aug 01, 2017 at 05:04:18PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Spotted thanks to valgrind and tests/device-introspect-test:
>=20
> =3D=3D11711=3D=3D 1 bytes in 1 blocks are definitely lost in loss recor=
d 6 of 14,537
> =3D=3D11711=3D=3D    at 0x4C2EB6B: malloc (vg_replace_malloc.c:299)
> =3D=3D11711=3D=3D    by 0x1E0CDBD8: g_malloc (gmem.c:94)
> =3D=3D11711=3D=3D    by 0x1E0E696E: g_strdup (gstrfuncs.c:363)
> =3D=3D11711=3D=3D    by 0x695693: migration_instance_init (migration.c:=
2226)
> =3D=3D11711=3D=3D    by 0x717C4B: object_init_with_type (object.c:344)
> =3D=3D11711=3D=3D    by 0x717E80: object_initialize_with_type (object.c=
:375)
> =3D=3D11711=3D=3D    by 0x7182EB: object_new_with_type (object.c:483)
> =3D=3D11711=3D=3D    by 0x718328: object_new (object.c:493)
> =3D=3D11711=3D=3D    by 0x4B8A29: qmp_device_list_properties (qmp.c:542=
)
> =3D=3D11711=3D=3D    by 0x4A9561: qmp_marshal_device_list_properties (q=
mp-marshal.c:1425)
> =3D=3D11711=3D=3D    by 0x819D4A: do_qmp_dispatch (qmp-dispatch.c:104)
> =3D=3D11711=3D=3D    by 0x819E82: qmp_dispatch (qmp-dispatch.c:131)
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

--=20
Peter Xu

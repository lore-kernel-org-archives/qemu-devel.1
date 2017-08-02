Received: from eggs.gnu.org ([2001:4830:134:3::10]:33557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dcnjs-00039L-JV
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 03:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dcnjo-0000eI-Kt
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 03:06:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62015)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dcnjo-0000bv-FX
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 03:06:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24127E67B1
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 06:58:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170801160419.14180-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 1 Aug 2017 17:04:18 +0100")
References: <20170801160419.14180-1-marcandre.lureau@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 02 Aug 2017 08:58:46 +0200
Message-ID: <87o9ryh2vt.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> Spotted thanks to valgrind and tests/device-introspect-test:
>
> =3D=3D11711=3D=3D 1 bytes in 1 blocks are definitely lost in loss record =
6 of 14,537
> =3D=3D11711=3D=3D    at 0x4C2EB6B: malloc (vg_replace_malloc.c:299)
> =3D=3D11711=3D=3D    by 0x1E0CDBD8: g_malloc (gmem.c:94)
> =3D=3D11711=3D=3D    by 0x1E0E696E: g_strdup (gstrfuncs.c:363)
> =3D=3D11711=3D=3D    by 0x695693: migration_instance_init (migration.c:22=
26)
> =3D=3D11711=3D=3D    by 0x717C4B: object_init_with_type (object.c:344)
> =3D=3D11711=3D=3D    by 0x717E80: object_initialize_with_type (object.c:3=
75)
> =3D=3D11711=3D=3D    by 0x7182EB: object_new_with_type (object.c:483)
> =3D=3D11711=3D=3D    by 0x718328: object_new (object.c:493)
> =3D=3D11711=3D=3D    by 0x4B8A29: qmp_device_list_properties (qmp.c:542)
> =3D=3D11711=3D=3D    by 0x4A9561: qmp_marshal_device_list_properties (qmp=
-marshal.c:1425)
> =3D=3D11711=3D=3D    by 0x819D4A: do_qmp_dispatch (qmp-dispatch.c:104)
> =3D=3D11711=3D=3D    by 0x819E82: qmp_dispatch (qmp-dispatch.c:131)
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

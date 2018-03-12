Received: from eggs.gnu.org ([2001:4830:134:3::10]:41340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evOdt-0001BH-5B
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evOdp-0000xQ-1r
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:41:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42388 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evOdo-0000wa-Tc
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:41:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B38824000B6E
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 14:41:27 +0000 (UTC)
References: <20180312124939.20562-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <89a8d961-2028-7b7b-fb43-d89a370752dc@redhat.com>
Date: Mon, 12 Mar 2018 09:41:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180312124939.20562-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 0/9] Enable passing pre-opened chardev
 socket FD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 03/12/2018 07:49 AM, Daniel P. Berrang=C3=A9 wrote:
> An update of:
>=20
>    v1: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04618.h=
tml
>    v2: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04706.h=
tml
>    v3: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04892.h=
tml
>    v4: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg00950.h=
tml
>=20
> This enables fixing a long standing problem that libvirt has with
> starting up QEMU. It has to busy-wait retrying connect() on the QMP
> monitor socket until QEMU finally creates & listens on it, but at same
> time must be careful to not wait forever if QEMU exits.
>=20
> With this patch series, libvirt can simply pass in a pre-opened UNIX do=
main
> socket file descriptor, which it can immediately connect to with no bus=
y-wait.
>=20
> NB, this will generate one expected failure with patchew / checkpatch.p=
l
>=20
>    ERROR: consider using qemu_strtol in preference to strtol
>    #729: FILE: util/cutils.c:338:
>    +    lresult =3D strtol(nptr, &ep, base);
>=20
>    ERROR: consider using qemu_strtol in preference to strtol
>    #779: FILE: util/cutils.c:388:
>    +    lresult =3D strtol(nptr, &ep, base);
>=20
> This is ok to ignore, because the patch in question is introducing new
> qemu_strtoXXX wrappers
>=20
> Changed in v5:
>=20
>    - Docs typo (Eric)
>    - Fix errno setting in int parsing code (Eric)

Series:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

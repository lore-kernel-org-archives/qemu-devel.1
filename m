Received: from eggs.gnu.org ([2001:4830:134:3::10]:50883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euK77-0008Pl-EE
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euK76-0000d4-Jm
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:39:21 -0500
References: <152060804669.1497.3662068304242069251@bdbb90650ae5>
From: Eric Blake <eblake@redhat.com>
Message-ID: <de8fcf92-eac6-902d-eafd-f53d1c935dc7@redhat.com>
Date: Fri, 9 Mar 2018 09:39:02 -0600
MIME-Version: 1.0
In-Reply-To: <152060804669.1497.3662068304242069251@bdbb90650ae5>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/2] block latency histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org, vsementsov@virtuozzo.com
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org, mreitz@redhat.com

On 03/09/2018 09:07 AM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on ppcbe host. Please find the details be=
low.
>=20
> Type: series
> Message-id: 20180309144918.44975-1-vsementsov@virtuozzo.com
> Subject: [Qemu-devel] [PATCH v3 0/2] block latency histogram

> In file included from /var/tmp/patchew-tester-tmp-e2uf385_/src/include/=
block/block_int.h:27:0,
>                   from /var/tmp/patchew-tester-tmp-e2uf385_/src/stubs/b=
lockdev-close-all-bdrv-states.c:2:
> /var/tmp/patchew-tester-tmp-e2uf385_/src/include/block/accounting.h:117=
:33: error: unknown type name =E2=80=98uint64List=E2=80=99
>                                   uint64List *boundaries);
>                                   ^

Probably as simple as forgetting to #include "qapi/qapi-builtin-types.h"=20
as part of the rebasing to the recent QAPI refactoring that landed in=20
commit 7fceeb19.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

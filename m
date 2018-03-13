Received: from eggs.gnu.org ([2001:4830:134:3::10]:39458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evpcy-0004aT-JY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 15:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evpcu-0000Hl-E0
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 15:30:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evpcu-0000Gr-9C
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 15:30:24 -0400
References: <152096502240.39.7831586863729707860@71c20359a636>
From: Eric Blake <eblake@redhat.com>
Message-ID: <043a5ae4-79ad-4f3a-75bb-d4d51b87123b@redhat.com>
Date: Tue, 13 Mar 2018 14:30:07 -0500
MIME-Version: 1.0
In-Reply-To: <152096502240.39.7831586863729707860@71c20359a636>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/17] NBD patches for 2018-03-13 (2.12
 softfreeze)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On 03/13/2018 01:17 PM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on s390x host. Please find the details be=
low.
>=20
> Type: series
> Message-id: 20180313171345.659672-1-eblake@redhat.com
> Subject: [Qemu-devel] [PULL 00/17] NBD patches for 2018-03-13 (2.12 sof=
tfreeze)
>=20

>    CC      block/nbd-client.o
> /var/tmp/patchew-tester-tmp-9ge_0fk5/src/block/nbd-client.c: In functio=
n =E2=80=98nbd_client_co_block_status=E2=80=99:
> /var/tmp/patchew-tester-tmp-9ge_0fk5/src/block/nbd-client.c:890:15: err=
or: =E2=80=98extent.flags=E2=80=99 may be used uninitialized in this func=
tion [-Werror=3Dmaybe-uninitialized]
>       NBDExtent extent;
>                 ^~~~~~

Shoot, I missed including that in my cleanups.  Pull request v2 coming up=
.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

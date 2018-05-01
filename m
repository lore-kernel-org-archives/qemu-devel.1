Received: from eggs.gnu.org ([2001:4830:134:3::10]:47481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDeil-0004aE-8C
	for qemu-devel@nongnu.org; Tue, 01 May 2018 19:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDeik-0008BE-Ad
	for qemu-devel@nongnu.org; Tue, 01 May 2018 19:30:07 -0400
References: <20180501220509.14152-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a375bc6-12c8-648b-288b-d256ab040825@redhat.com>
Date: Tue, 1 May 2018 18:29:52 -0500
MIME-Version: 1.0
In-Reply-To: <20180501220509.14152-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] block/mirror: Make cancel always
 cancel pre-READY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

On 05/01/2018 05:05 PM, Max Reitz wrote:
> Currently, you cannot cancel a mirror job without the @force flag set.
> This is intentional once source and target are in sync, but probably no=
t
> so much before that happens.  The main reason for me thinking this is
> because it is an undocumented change in 2.12.0 in respect to 2.11.

Yeah, that definitely feels like a regression worth fixing.

>=20
> (b76e4458b1eb3c32e9824fe6aa51f67d2b251748 only notes a behavior change
>   after READY, but not before.)
>=20
>=20
> This series depends on Stefan=E2=80=99s patch =E2=80=9Cblock/mirror: ho=
nor ratelimit
> again=E2=80=9D (which is in Jeff=E2=80=99s queue).
>=20
> Based-on: <20180424123527.19168-1-stefanha@redhat.com>
>=20


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

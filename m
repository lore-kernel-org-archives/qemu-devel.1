Received: from eggs.gnu.org ([2001:4830:134:3::10]:50209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dufSf-0001GF-Ts
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dufSc-0005KC-TA
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:54:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dufSc-0005K1-Mc
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:54:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9587A86647
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 13:54:41 +0000 (UTC)
References: <1505913885.24609.8.camel@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4102bc02-0439-862b-67b8-b297c29dc121@redhat.com>
Date: Wed, 20 Sep 2017 15:54:36 +0200
MIME-Version: 1.0
In-Reply-To: <1505913885.24609.8.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] kvm_set_phys_mem: assertion failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: pbonzini@redhat.com

On 20.09.2017 15:24, Gerd Hoffmann wrote:
>   Hi,
>=20
> git master crashes:
>=20
> ERROR:/home/kraxel/projects/qemu/accel/kvm/kvm-
> all.c:756:kvm_set_phys_mem: assertion failed:
> (!memory_region_is_ram(mr) && !writeable && !mr->romd_mode)
>=20
> bisect blames:
>=20
> commit f357f564be0bd45245b3ccfbbe20ace08fe83ca8
> Author: David Hildenbrand <david@redhat.com>
> Date:=C2=A0=C2=A0=C2=A0Mon Sep 11 19:49:31 2017 +0200
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0kvm: we never have overlapping slots in kvm_set=
_phys_mem()
>=20
> libvirt config attached.
>=20
> cheers,
>   Gerd
>=20

Thanks. That g_assert() was just a security precaution. I'll double
check if it can be removed or if there is an actual problem.

--=20

Thanks,

David

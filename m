Received: from eggs.gnu.org ([2001:4830:134:3::10]:54393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cRM8Z-0001Gj-Cz
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:52:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cRM8Y-0001rj-IR
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:52:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cRM8Y-0001rZ-CB
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:52:34 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 830F3C051676
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 16:52:34 +0000 (UTC)
References: <20170104132625.28059-1-pbonzini@redhat.com>
	<20170104132625.28059-5-pbonzini@redhat.com>
	<20170111165038.GC9269@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4c3ee6f8-1ffa-1551-54b0-60cd6115677b@redhat.com>
Date: Wed, 11 Jan 2017 17:52:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170111165038.GC9269@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QiEbeN9BJWmv0t6MMPirEbIMLjwrFtmdL"
Subject: Re: [Qemu-devel] [PATCH 04/10] qemu-thread: optimize QemuLockCnt
 with futexes on Linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QiEbeN9BJWmv0t6MMPirEbIMLjwrFtmdL
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com
Message-ID: <4c3ee6f8-1ffa-1551-54b0-60cd6115677b@redhat.com>
Subject: Re: [PATCH 04/10] qemu-thread: optimize QemuLockCnt with futexes on
 Linux
References: <20170104132625.28059-1-pbonzini@redhat.com>
 <20170104132625.28059-5-pbonzini@redhat.com>
 <20170111165038.GC9269@stefanha-x1.localdomain>
In-Reply-To: <20170111165038.GC9269@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 11/01/2017 17:50, Stefan Hajnoczi wrote:
> On Wed, Jan 04, 2017 at 02:26:19PM +0100, Paolo Bonzini wrote:
>> +unsigned qemu_lockcnt_count(QemuLockCnt *lockcnt)
>> +{
>> +    return lockcnt->count >> QEMU_LOCKCNT_COUNT_SHIFT;
>=20
> According to docs/atomics.txt at least atomic_read() should be used her=
e
> otherwise sanitizers could flag up this memory access.

Good point.

Paolo


--QiEbeN9BJWmv0t6MMPirEbIMLjwrFtmdL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYdmLNAAoJEL/70l94x66D/LIIAKxGEwzBMeSlLEowvneOYenB
ywG/GhF8wq8qRevhV3fnolC7MEGE2VPmmtvfHGNQOkTUv6QSowOvTCHGyDZZfHNk
K3qeaxBp71Y1vSA96mhLoRmsZMtLKO6o9IPjxKoeeg4ITyuKquDMwTFWiK2UEiSr
gkT7UQx7wlAftLMpKLpoWzPk04F6e9VDSmDr3CcAqtQPoILotCpIyScVh4JZYH4M
dVHx2edBfZpDJeEHHPfVzY2hCz/fy+uSvNKnFtvG0ZbG7WiYtdAXbx87mYKxJ8gm
A+KtZliZrphmZjXM1Zedqj3ImQDZopztwkRSJKQ4zuA2YCXBg8RrbrPkb4QrzjE=
=KmHX
-----END PGP SIGNATURE-----

--QiEbeN9BJWmv0t6MMPirEbIMLjwrFtmdL--

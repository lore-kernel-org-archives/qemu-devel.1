Received: from eggs.gnu.org ([2001:4830:134:3::10]:53959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRM6p-0007Se-6v
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRM6k-0001U3-89
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:50:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cRM6j-0001Tm-TN
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:50:42 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB1843D95E
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 16:50:41 +0000 (UTC)
Date: Wed, 11 Jan 2017 16:50:38 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170111165038.GC9269@stefanha-x1.localdomain>
References: <20170104132625.28059-1-pbonzini@redhat.com>
	<20170104132625.28059-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <20170104132625.28059-5-pbonzini@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 04, 2017 at 02:26:19PM +0100, Paolo Bonzini wrote:
> +unsigned qemu_lockcnt_count(QemuLockCnt *lockcnt)
> +{
> +    return lockcnt->count >> QEMU_LOCKCNT_COUNT_SHIFT;

According to docs/atomics.txt at least atomic_read() should be used here
otherwise sanitizers could flag up this memory access.

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYdmJeAAoJEJykq7OBq3PITZkH/A4ZVg5BU6WEcm2T9iaAO+ey
fzktTd+awvcREaPN+MQGqA5aiC7WXCFY26edm85mmR+lR6Nr3cyKVm1UazyawRY4
L5Z+fXBAw0yOdXGERTUtO+75eCzacv5mMdLUVGLTsMPK52Q4wADca7WTeZJdMmgD
N61v+6PbvLZRTq5BTDYH1Af29KYZot53JwKRvbZznYhFQNJY4FyE9Zkx2SZg7tZK
1j1AzjZ7cNqjl5vWQlQXmqKA9YK1maQGH9rzSaG2cdmiAYJJNmBb7JlYKWGicn1R
vYURFN/iCWAoFY2pLLXXAUqJ6npd5RDjeSCWFwKK3TunzkOtkRtofDO7mCn0/Xs=
=namC
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--

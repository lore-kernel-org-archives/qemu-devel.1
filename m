Received: from eggs.gnu.org ([2001:4830:134:3::10]:42874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fKsqW-0004og-Es
	for qemu-devel@nongnu.org; Mon, 21 May 2018 18:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fKsqR-0008Kw-Ox
	for qemu-devel@nongnu.org; Mon, 21 May 2018 18:00:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fKsqR-0008Ko-Iw
	for qemu-devel@nongnu.org; Mon, 21 May 2018 17:59:55 -0400
Date: Mon, 21 May 2018 18:59:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180521215949.GW25013@localhost.localdomain>
References: <20180521215424.13520-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180521215424.13520-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] i386: speculative store buffer bypass
 mitigation (CVE-2018-3639)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Richard Henderson <rth@twiddle.net>, kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, May 21, 2018 at 10:54:21PM +0100, Daniel P. Berrang=E9 wrote:
> This provides the QEMU part of the mitigations for the speculative
> store buffer bypass vulnerabilities on the x86 platform[1], and is
> the companion of the kernel patches merged in:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D3b78ce4a34b761c7fe13520de822984019ff1a8f
>=20
> [1] https://bugs.chromium.org/p/project-zero/issues/detail?id=3D1528
>     https://access.redhat.com/security/vulnerabilities/ssbd

Queued, but reordered patch 2 and patch 3 so the flag can't be
enabled without the corresponding MSR migration code being
available.

--=20
Eduardo

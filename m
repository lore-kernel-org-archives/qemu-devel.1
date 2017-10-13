Received: from eggs.gnu.org ([2001:4830:134:3::10]:44773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1e34g4-0006op-NN
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 14:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1e34fz-0002wn-Q8
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 14:27:20 -0400
Received: from mail-dm3nam03on0137.outbound.protection.outlook.com
	([104.47.41.137]:15920
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Andrew.Baumann@microsoft.com>)
	id 1e34fz-0002vc-Hn
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 14:27:15 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Fri, 13 Oct 2017 18:27:12 +0000
Message-ID: <MWHPR21MB0159D916DDC23B9C44DE2CB19E480@MWHPR21MB0159.namprd21.prod.outlook.com>
References: <20171013181913.7556-1-Andrew.Baumann@microsoft.com>
In-Reply-To: <20171013181913.7556-1-Andrew.Baumann@microsoft.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] notdirty_mem_write: implement 8-byte
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

> From: Andrew Baumann
> Sent: Friday, 13 October 2017 11:19
>=20
> Aligned 8-byte memory writes by a 64-bit target on a 64-bit host should
> always turn into atomic 8-byte writes on the host, however if we missed
> in the softmmu, and the TLB line was marked as not dirty, then we
> would end up tearing the 8-byte write into two 4-byte writes in
> access_with_adjusted_size().
>=20
> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> ---
> This manifested as a race in lock-free synchronisation with an aarch64
> Windows guest on an x86-64 host (with multithreaded TCG).
>=20
>  exec.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

By the way, I noticed that watch_mem_ops are also 4-byte only. I suspect th=
e same fix may be needed there?

Andrew

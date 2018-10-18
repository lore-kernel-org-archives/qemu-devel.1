Received: from eggs.gnu.org ([2001:4830:134:3::10]:46741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aaron@os.amperecomputing.com>) id 1gDEtu-0003RJ-7u
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aaron@os.amperecomputing.com>) id 1gDEtp-0001Wy-Sn
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:28:09 -0400
Received: from mail-sn1nam02on0133.outbound.protection.outlook.com
	([104.47.36.133]:17184
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Aaron@os.amperecomputing.com>)
	id 1gDEtp-0001WI-Lr
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:28:05 -0400
From: Aaron Lindsay <Aaron@os.amperecomputing.com>
Date: Thu, 18 Oct 2018 20:28:03 +0000
Message-ID: <20181018202756.GH12691@quinoa.localdomain>
References: <20181018182758.18646-1-richard.henderson@linaro.org>
	<20181018182758.18646-2-richard.henderson@linaro.org>
In-Reply-To: <20181018182758.18646-2-richard.henderson@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A086D2E1D2D8214DA5A0B15F6DF41290@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/3] target/arm: Remove writefn from
 TTBR0_EL3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>

On Oct 18 11:27, Richard Henderson wrote:
> The EL3 version of this register does not include an ASID,
> and so the tlb_flush performed by vmsa_ttbr_write is not needed.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aaron Lindsay <aaron@os.amperecomputing.com>

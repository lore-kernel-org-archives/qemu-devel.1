Received: from eggs.gnu.org ([2001:4830:134:3::10]:46920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aaron@os.amperecomputing.com>) id 1gDEuj-0004QA-Io
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aaron@os.amperecomputing.com>) id 1gDEue-0002bI-4v
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:29:01 -0400
Received: from mail-sn1nam02on0116.outbound.protection.outlook.com
	([104.47.36.116]:32476
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Aaron@os.amperecomputing.com>)
	id 1gDEud-0002Yg-V9
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:28:56 -0400
From: Aaron Lindsay <Aaron@os.amperecomputing.com>
Date: Thu, 18 Oct 2018 20:28:53 +0000
Message-ID: <20181018202845.GI12691@quinoa.localdomain>
References: <20181018182758.18646-1-richard.henderson@linaro.org>
	<20181018182758.18646-3-richard.henderson@linaro.org>
In-Reply-To: <20181018182758.18646-3-richard.henderson@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <734CD0BF40626044B15D782E889DB3E1@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/3] target/arm: Only flush tlb if ASID
 changes
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
> Since QEMU does not implement ASIDs, changes to the ASID must flush the
> tlb.  However, if the ASID does not change there is no reason to flush.
>=20
> In testing a boot of the Ubuntu installer to the first menu, this reduces
> the number of flushes by 30%, or nearly 600k instances.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Aaron Lindsay <aaron@os.amperecomputing.com>

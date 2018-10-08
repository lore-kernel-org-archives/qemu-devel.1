Received: from eggs.gnu.org ([2001:4830:134:3::10]:48383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1g9WAf-00050D-UK
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1g9WAa-0002QP-2o
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:06:05 -0400
Received: from mail-sn1nam01on0138.outbound.protection.outlook.com
	([104.47.32.138]:26051
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1g9WAZ-0002Pp-RY
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:05:59 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 8 Oct 2018 14:05:55 +0000
Message-ID: <BN6PR2201MB12514961A2655922F25F8BBFC6E60@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1538752793-6875-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1538752793-6875-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1538752793-6875-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 5/7] target/mips: Add availability
 control for DSP R3 ASE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>


> From: Stefan Markovic <smarkovic@wavecomp.com>
>
> Add infrastructure for availability control for DSP R3 ASE MIPS
instructions. Only BPOSGE32C currently belongs to DSP R3 ASE, but
this is likely to be changed in near future.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

I think check_dspr3() should be check_dsp_r3(), but this will be then
inconsistent with  check_dspr3(). Consider a separate patch for refactoring
dsp r2/r3-related constant and function names. But that is beyond the scope
of this patch, so:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=

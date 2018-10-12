Received: from eggs.gnu.org ([2001:4830:134:3::10]:56091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gB2F6-0008Bn-WD
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gB2F1-0004nw-V7
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:32:56 -0400
Received: from mail-co1nam05on072f.outbound.protection.outlook.com
	([2a01:111:f400:fe50::72f]:52352
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gB2F1-0004nG-MK
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:32:51 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 12 Oct 2018 18:32:46 +0000
Message-ID: <BN6PR2201MB1251A6FF850FE3209CDD43EAC6E20@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1539362376-12010-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 04/28] linux-user: Add MIPS-specific
 prctl() options
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

> Subject: [PATCH v5 04/28] linux-user: Add MIPS-specific prctl() options
>
> From: Stefan Markovic <smarkovic@wavecomp.com>
>
>Add MIPS-specific prctl() options TARGET_PR_SET_FP_MODE and
TARGET_PR_SET_FP_MODE. These values are essentially copied from
linux kernel header include/uapi/linux/prctl.h.
>
>This is done in a way consistent with a similar case of
aarch64-specific prctl() options TARGET_PR_SVE_SET_VL and
TARGET_PR_SVE_GET_VL.
>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

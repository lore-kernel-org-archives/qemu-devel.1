Received: from eggs.gnu.org ([2001:4830:134:3::10]:34837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fhv3D-0000ic-4H
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fhv37-00027J-68
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:00:19 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com
	([104.47.40.123]:20682
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fhv36-00026T-QZ
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:00:13 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 24 Jul 2018 11:00:09 +0000
Message-ID: <BN7PR08MB4868B6EB81067D0990BE30ECC6550@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-6-git-send-email-stefan.markovic@rt-rk.com>,
	<270ed7c2-9f82-d49d-a745-c43e003b3aa9@linaro.org>
In-Reply-To: <270ed7c2-9f82-d49d-a745-c43e003b3aa9@linaro.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/40] target/mips: Add nanoMIPS
 decoding and extraction utilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Richard Henderson <richard.henderson@linaro.org>
> Sent: Thursday, July 19, 2018 6:57 PM
>
> I think it's worth spending one line to document the pseudocode function =
from
> which each of these come.  E.g.
>
> /* Implement nanoMIPS pseudocode decode_gpr(encoded_gpr, 'gpr4.zero').  *=
/
>
> Which is certainly more accurate than the comment that is there currently=
.
>
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~

Hello, Richard

The comments will be fixed in v4. Also, the fourth decode_gpr_XXX function =
will be moved to this patch (from one of remaining patches with decoding lo=
gic). These functions will be all marked inline. This also means that the c=
ompiler will not complain about "unused functions".

Aleksandar

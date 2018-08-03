Received: from eggs.gnu.org ([2001:4830:134:3::10]:36906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1flaj3-0006Md-AE
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 10:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1flaiy-0000UZ-PS
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 10:06:41 -0400
Received: from mail-eopbgr680139.outbound.protection.outlook.com
	([40.107.68.139]:55680
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <smarkovic@wavecomp.com>)
	id 1flaiy-0000UT-CX
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 10:06:36 -0400
From: Stefan Markovic <smarkovic@wavecomp.com>
Date: Fri, 3 Aug 2018 14:06:32 +0000
Message-ID: <DM6PR08MB48732809232C5A9AD8BDFD77D4230@DM6PR08MB4873.namprd08.prod.outlook.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>,
	<1533219424-7627-40-git-send-email-stefan.markovic@rt-rk.com>,
	<BN7PR08MB486891F4C09A0D9134BA53A8C6230@BN7PR08MB4868.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB486891F4C09A0D9134BA53A8C6230@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 39/77] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>


BPOSGE32C is introduced in DSP-R3. Shouldn't there be check_dspr3(), and ap=
plied here?


You're right. DSPR3 is not supported in QEMU at the moment.
Patch with DSP Revision 3 support will be included in next version of patch=
 set.


>From the code, it turns out that the only difference between BPOSGE32 (supp=
orted in previous mips DSP specifications) and BPOSGE32C (nanoMIPS DSP supp=
orted) is offset calculation. Is this really the only difference - from the=
 documentation?


Yes, the only difference is offset calculation.


Regards,

Stefan

________________________________
From: Aleksandar Markovic
Sent: Friday, August 3, 2018 1:20:16 PM
To: Stefan Markovic; qemu-devel@nongnu.org
Cc: laurent@vivier.eu; riku.voipio@iki.fi; philippe.mathieu.daude@gmail.com=
; aurelien@aurel32.net; richard.henderson@linaro.org; Stefan Markovic; Peta=
r Jovanovic; Paul Burton; Aleksandar Rikalo
Subject: Re: [PATCH v6 39/77] target/mips: Add emulation of DSP ASE for nan=
oMIPS - part 2

> +                case NM_BPOSGE32C:
> +                    check_dsp(ctx);
> +                    {
> +                        int32_t imm =3D extract32(ctx->opcode, 1, 13) |
> +                                      extract32(ctx->opcode, 0, 1) << 13=
;
> +
> +                        gen_compute_branch(ctx, OPC_BPOSGE32, 4, -1, -2,
> +                                           imm, 4);
> +                    }
> +                    break;


BPOSGE32C is introduced in DSP-R3. Shouldn't there be check_dspr3(), and ap=
plied here?

>From the code, it turns out that the only difference between BPOSGE32 (supp=
orted in previous mips DSP specifications) and BPOSGE32C (nanoMIPS DSP supp=
orted) is offset calculation. Is this really the only difference - from the=
 documentation?

Aleksandar M.

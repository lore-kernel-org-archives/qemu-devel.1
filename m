Received: from eggs.gnu.org ([2001:4830:134:3::10]:58449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flY8T-0006XZ-JU
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flY8Q-0000Hc-Gb
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:20:45 -0400
Received: from mail-by2nam05on070c.outbound.protection.outlook.com
	([2a01:111:f400:fe52::70c]:15367
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1flY8P-0000H7-Te
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:20:42 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 3 Aug 2018 11:20:16 +0000
Message-ID: <BN7PR08MB486891F4C09A0D9134BA53A8C6230@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>,
	<1533219424-7627-40-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1533219424-7627-40-git-send-email-stefan.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

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

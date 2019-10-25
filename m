Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D52CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:40:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7473921D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7473921D71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=keithp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO2e1-00021q-KI
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 12:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.com>) id 1iO2a9-0002Qr-QW
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.com>) id 1iO2a8-0006Yy-Cv
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:36:57 -0400
Received: from home.keithp.com ([63.227.221.253]:43884 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.com>) id 1iO2a8-0006YX-2L
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:36:56 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id A67BA3F22EA2;
 Fri, 25 Oct 2019 09:36:53 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id ZXnpgSfUsqMm; Fri, 25 Oct 2019 09:36:53 -0700 (PDT)
Received: from keithp.com (unknown [204.134.242.194])
 by elaine.keithp.com (Postfix) with ESMTPSA id F2FDA3F22E9D;
 Fri, 25 Oct 2019 09:36:52 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id 98D8C158212D; Fri, 25 Oct 2019 09:36:52 -0700 (PDT)
From: "Keith Packard" <keithp@keithp.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
In-Reply-To: <8736fhm9tw.fsf@linaro.org>
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
Date: Fri, 25 Oct 2019 09:36:52 -0700
Message-ID: <87pnik4w9n.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 63.227.221.253
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> I can see the use for this but I'd like to know what you are testing
> with. We only have very basic smoketests in check-tcg but I've tested
> with the latest arm-semihosting tests and they are all fine so no
> regressions there.

I'm adding semihosting support to picolibc
(https://keithp.com/picolibc/) and need a way to automate tests for it's
SYS_READC support, so eventually I'll have automated tests there, but
that depends on qemu support...

> Please keep version history bellow --- so they get dropped when the
> patch is applied.

Sure, I'll edit the mail before sending. In my repo, I'm leaving the
version history in git so I can keep track of it.

>> v4:
>> 	Add qemu_semihosting_console_init to stubs/semihost.c for
>> 	hosts that don't support semihosting
>
> This doesn't appear to be in the diff which is why I'm seeing a compile
> failure for non-CONFIG_SEMIHOST machines. However...

Argh! Just git operation failure -- I'm building another patch on top of
this (for RISC-V semihosting support) and the stubs/semihost.c change
got caught in there. My overall check for changes missed this mistake.

>> +
>> +#include <poll.h>
>
> Headers should go at the top.

Thanks; I've fixed this file and hw/semihosting/console.c

>>      case TARGET_SYS_READC:
>> -        qemu_log_mask(LOG_UNIMP, "%s: SYS_READC not implemented", __fun=
c__);
>> -        return 0;
>> +        return qemu_semihosting_console_inc(env);
>
> I'm not sure this would be correct if there was no character available.
> The docs imply it blocks although don't say so explicitly AFAICT.

Here's what the docs say:

        https://static.docs.arm.com/100863/0200/semihosting.pdf

        Return

        On exit, the RETURN REGISTER contains the byte read from the consol=
e.

If this call didn't block, they'd have to define a value which indicated
that no byte was available? Openocd also implements SYS_READC using
'getchar()', which definitely blocks. So, at least qemu would be the
same.

I realize it's really weird to block the whole emulation for this call,
but given the target environment (deeply embedded devices), it's quite
convenient as the whole qemu process blocks, instead of spinning.

>> +    /* connect semihosting console input if requested */
>> +    qemu_semihosting_console_init();
>> +
>
> I'd rather rename qemu_semihosting_connect_chardevs to
> qemu_semihosting_init and keep all our bits of semihosting setup in
> there rather than having multiple calls out of vl.c

I also thought this would be a nice cleanup. However, the last caller to
qemu_chr_fe_set_handlers gets the focus for input, and connect_chardevs
is called before the serial ports and monitor are initialized, so
semihosting gets pushed aside and stdio input ends up hooked to the monitor
instead.

Adding this function and placing the call after the other stdio users
get hooked up means that semihosting starts with the input focus.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl2zJKQACgkQ2yIaaQAA
ABGTIhAAmiGNN2S90GOK+1tMuv/7nSW1Q3/xmTWdUSv/GcGa9fmTeJtMcmue0xCu
QULzf6bwSlvYPzkWepcDIHfFmuk6CLOYX6AK5n/YWuyUzntAAdaFkP1//LMbf1A1
pn/5GIXyvhQo5Bj3rugEhPMR1zxWCsStcoBSyHKlCk2qUWj5kCZoO/e50BmNT7N0
zVsq9ZSnWsmzGtF8fjM/JB/5VAcpYRWY1iZplKZZwp/QTfqS1uXqjT+c0Ik/2wYK
D2Znbtu+jgi7qZpXenmamYX/iZBA4Vgy5rM1WT20craeUJBN/qIQdOZHgLav0EAe
NAmwiLD6+lODwOv75BD0TjMDlF+Oh6aW1tksjyEcDorj5u3xNxjwGqk8DbrhqVoy
VNR07sfPI/+f6mhk7zPacyFuUa88cKUOodmu6F9ROy7PYpK6HC9druvm2BVH5M+D
BTnK7oKOIa20CLhcLjcpfi3LpYMpJhAjlfN2VI8N8fNzCJUoT02x61vC53ASj5/t
AnOLnQ+Zxfrglbm2aJqN7w0Nj1AgqAf+2J/7QA5utyqyoSkwutvN9rMiMIyGO6kD
ImsJM+5srpaCfDuASuedOQx8Kv9hdIqRNg4ITP3MkwhOQxpDFZTjBZW6Bo8K2jAC
MQRM+Zrtslu+Ko6gxTnV7fK/LZmNX3BZi9FPcjEIKFbbdt7d+w0=
=Psq6
-----END PGP SIGNATURE-----
--=-=-=--


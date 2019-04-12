Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D3DC10F13
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 01:44:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1A42186A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 01:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvmZW32J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1A42186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57312 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hElFD-0007bt-90
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 21:44:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hElEP-0007Iz-7Q
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 21:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hElEO-0007NJ-86
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 21:43:53 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:44105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hElEN-0007Mc-Rt
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 21:43:52 -0400
Received: by mail-yb1-xb41.google.com with SMTP id u187so3004062ybg.11
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 18:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to;
	bh=r+ZU9p9Dti2cRo+bqAkYueviWbcPyCNjOgmuZ7Z3sIA=;
	b=FvmZW32JL317w1I69ixLYbSQbX6MJ9uscZS9Cwtcxe54og6bLEUPe1U4+X/FsoGDK6
	Ngvuga3DmaSA73Hy9eKjEL47iqONqCX3CbufxYz1vHQFsjNjvgY6AhDvd8Mh6Lo804hA
	MHtaYx4j3A8qLnxzBXQKfXLrD2odPPWGj2ndLpJL8kczqiov+2nieh8vMPX7M34zNIDf
	co4FDT8G1wOAXNM787DO/SGce8+ajMbjIuLJa6L7nMHb8UsDvcdfuk1ongug6aPibUJC
	MxdKc/sn6Na7BXDeINqpO0iBrRC4e8lWIrUOwn6V/Buw5XsOiTSyRcIiQrNyOVe5TX1S
	Sf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to;
	bh=r+ZU9p9Dti2cRo+bqAkYueviWbcPyCNjOgmuZ7Z3sIA=;
	b=Wd8AnNsoE7jcyq9RE+Z7YVzQDMYQR8wX86HTi4WWTuxlkz6SpuokO6Vj0nH6kabAtG
	zOyom3lQc9NQhrPseD89/vlUFhgB3yUe3ZPfTvUS7DqCWhsSbHrts1RbdXfA3hpybMdO
	qyT/XEM5eP3y0eRpKLXIjTaN4QsGNnvjGa0OwSZnF7vm59Zsa9IOkgqtaXfw+3RcX2ql
	MrZ8mEFl1D7YE9g2dwZ60jcoC4SXIpqJ9namiajMcN+P/76+QOkhnkh8thiIpvJl9V//
	biF8LwNtQgTJNkQjcj69ps+FLlhm3Oxv247qAcXM2xE92qIOD2W0hnTrINNjLhXNNcAF
	9pRA==
X-Gm-Message-State: APjAAAXWjFewRn8SgGYgOHh3GR4oqvINJPY0gO+hxivZM/L4swVI/uRX
	Vh0/te20h62vyXgJzVeiqOs=
X-Google-Smtp-Source: APXvYqyQzbHrhGWvRM5KGij55MUBL3KmSDOj9atM3OGbG60jRZ9HGTZx6F7WZEK8zIeh6KA5vOrChQ==
X-Received: by 2002:a25:6e86:: with SMTP id
	j128mr22507513ybc.134.1555033430511; 
	Thu, 11 Apr 2019 18:43:50 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
	[69.222.133.165]) by smtp.googlemail.com with ESMTPSA id
	x16sm26556019ywx.74.2019.04.11.18.43.49
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 18:43:49 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190408182748.1238-1-jan.bobek@gmail.com>
	<e38bf007-440c-9d6d-c837-e1e52b661075@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
	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
Message-ID: <a82ec99d-8b5e-6898-c0a7-a3de8e2be07f@gmail.com>
Date: Thu, 11 Apr 2019 21:43:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <e38bf007-440c-9d6d-c837-e1e52b661075@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="5J3APSNVcDpwGuNTMrRsTGN2nMU98mdUJ"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b41
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [RISU PATCH 0/5] Fix RISU build for i386
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412014337.AQ9wKLbVfhnlqpz8FDMgQ_wIC_U25CPnOjkDoolOer8@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5J3APSNVcDpwGuNTMrRsTGN2nMU98mdUJ
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <a82ec99d-8b5e-6898-c0a7-a3de8e2be07f@gmail.com>
Subject: Re: [RISU PATCH 0/5] Fix RISU build for i386
References: <20190408182748.1238-1-jan.bobek@gmail.com>
 <e38bf007-440c-9d6d-c837-e1e52b661075@linaro.org>
In-Reply-To: <e38bf007-440c-9d6d-c837-e1e52b661075@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sorry for the delayed reply, the U.S. tax deadline has caught up with
me, so I spent the last two evenings doing my taxes. (Yuck!)

Anyway...

On 4/8/19 6:18 PM, Richard Henderson wrote:
> On 4/8/19 8:27 AM, Jan Bobek wrote:
>> 2. Note the '-std=3Dc99' switch in the command-line above; without it,=

>>    GCC defines the symbol 'i386' to 1 and the preprocessor magic for
>>    including arch-specific headers in risu.h breaks. Does anyone have
>>    an idea how to fix this in a more robust way?
>=20
> Adding -U$(ARCH) to the command line is probably as good a fix as any.

I didn't know about -U, nice!

>> 3. gas (the GNU assembler) chokes on the syntax of test_i386.s; that's=

>>    why I'm using nasm as the assembler above. Is that intentional? I
>>    haven't found the nasm dependency mentioned anywhere.
>=20
> I think rewriting to not require nasm is better.

Agreed.

>>    Also, nasm will happily emit the UD1 opcode (0F B9) with no
>>    operands (see test_i386.s). That's a bit surprising to me, since
>>    Intel's Software Developer's Manual says UD1 has two operands; I'd
>>    expect at least a follow-up ModR/M byte. gas refuses to assemble
>>    UD1 with no operands, and gdb's disassembler gets confused when I
>>    load up the nasm's binary into risu. Is there something obvious
>>    that I'm missing?
>=20
> You are not missing anything -- ud1 should require a modrm byte.
>=20
> My suggestion is to use only UD1 as the "break" insn, with the differen=
t OP_*
> codes encoded into the modrm byte.

I had to laugh when I read this; this is *exactly* what I had in mind,
but then I found out there was no ModR/M byte.

>> P.S. This is my first time using git send-email, so please bear with
>>      me if something goes wrong and/or let me know how I can improve
>>      my future submissions. Thank you!
>=20
> You've done well with git send-email.  ;-)

Thanks a lot! :)

-Jan


--5J3APSNVcDpwGuNTMrRsTGN2nMU98mdUJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAlyv7UoACgkQZeg2ldrj
Ns8oUw//ZFBOn8+Wq3jnR0e7j/WjQ/MsWrQpmY3N0dnvtnm4O8nxYbbcusyLztr1
ImHrSMu9KL17O6i6hwbGDqrBhoaZdNGMwUPVRi1fGaA0mkacHxOBUnQInPxgMpgB
Wz7pl0zfMBcMhJhuJ0AHqU0FOBbdPY2cd0+zSOC20KDlmN8tN+4SAM7oW/OaHC1Q
XNzIlgX3GQHYUPzfQAA2TNya0dH8A3RN4QvHItl5PrIWhtw9gFTsJCsyzAQmRhx/
xt5FFeGJ+63W3PMR7jR4uWtjPPbSstjbZFDxjB++nqNSagu3UyeOMMNMxe0Wq7aB
hxLx7PSy6ju7kmV/nXbHDNzbNwyrJ1TVip4bC6y0nnayoduh6BrbSUfsocGzlHxD
XZdz2t3LggGODuIiY6LacnSdYJhKCEjexq7b5rfLJyzqcEngTdmTbhiq8g21fSo4
vGIXXU6OLJee3ifHw+94oTj8+1FM40LAi365+TXWKsVkGsrtLeimQjZSOCjt/1lc
NR7G3Gf1FLyAmK7XnpW/z0w9hMmX06Vc4bLBGB6pqo64zrP3Ieo6eeP8OLSi8MFf
aTPY3J2pwqbWGHrpc7lETWxo1U1u1IKhw4BNJmGnJIojaui7jwITmDu3FR4hDajG
yEjk54WN1nGI77nIIS6awT4irqOMPAkQRXPiXukWBQU87/MNr70=
=/PBZ
-----END PGP SIGNATURE-----

--5J3APSNVcDpwGuNTMrRsTGN2nMU98mdUJ--


Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C423CA9EC7
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 05:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC1920818
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 05:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC1920818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=keithp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRr7v-0006R9-JH
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 00:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.com>) id 1iRr7J-00062e-Fq
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 00:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.com>) id 1iRr7I-0002WF-4p
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 00:10:57 -0500
Received: from home.keithp.com ([63.227.221.253]:50066 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.com>) id 1iRr7H-0002VB-RV
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 00:10:56 -0500
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 779833F29409;
 Mon,  4 Nov 2019 21:10:53 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id DmpkNw56l1OG; Mon,  4 Nov 2019 21:10:53 -0800 (PST)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id E46A23F29401;
 Mon,  4 Nov 2019 21:10:52 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id BA09515821EF; Mon,  4 Nov 2019 21:10:52 -0800 (PST)
From: "Keith Packard" <keithp@keithp.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
In-Reply-To: <CAFEAcA-nnkHuj4y8+vFu5=virUoxwarg=kqQvUWeN73SDs+TzA@mail.gmail.com>
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
 <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
 <87mudo4owu.fsf@keithp.com>
 <CAFEAcA-nnkHuj4y8+vFu5=virUoxwarg=kqQvUWeN73SDs+TzA@mail.gmail.com>
Date: Mon, 04 Nov 2019 21:10:52 -0800
Message-ID: <87eeymx603.fsf@keithp.com>
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Peter Maydell <peter.maydell@linaro.org> writes:

> I'm going to push for somebody actually writing out a
> document and putting it somewhere that we can point to
> and say "that's the authoritative spec", please...
> it doesn't have to be a big formal thing, but I do
> think you want it written down, because the whole point
> is for multiple implementations and users to interoperate.

That happened in June -- I was just looking at the wrong version of the
spec. In the current version, which can be found here:

        https://riscv.org/specifications/

                   The RISC-V Instruction Set Manual
                       Volume I: Unprivileged ISA
                Document Version 20190608-Base-Ratified
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20
Section 2.8 says:

        Another use of EBREAK is to support =E2=80=9Csemihosting=E2=80=9D, =
where the
        execution environment includes a debugger that can provide
        services over an alternate system call interface built around
        the EBREAK instruction.  Because the RISC-V base ISA does not
        provide more than one EBREAK instruction, RISC-V semihosting
        uses a special sequence of instructions to distinguish a
        semihosting EBREAK from a debugger inserted EBREAK.

                slli x0, x0, 0x1f   # Entry NOP
                ebreak              # Break to debugger
                srai x0, x0, 7      # NOP encoding the semihosting call num=
ber 7

        Note that these three instructions must be 32-bit-wide
        instructions, i.e., they mustn=E2=80=99t be among the compressed 16=
-bit
        instructions described in Chapter 16.

        The shift NOP instructions are still considered available for
        use as HINTS.

        Semihosting is a form of service call and would be more
        naturally encoded as an ECALL using an existing ABI, but this
        would require the debugger to be able to intercept ECALLs, which
        is a newer addition to the debug standard.  We intend to move
        over to using ECALLs with a standard ABI, in which case,
        semihosting can share a service ABI with an existing standard.

        We note that ARM processors have also moved to using SVC instead
        of BKPT for semihosting calls in newer designs.

I'd like to get the READC patch landed and then post the RISC-V patch
afterwards as the RISC-V patch currently includes READC support.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl3BBFwACgkQ2yIaaQAA
ABFsiw//dTHG3JazDPUz7DBIPrJuwbSMVnV7gi8xMAW508crCbirhmEDXBI/SmXc
598e7xjezlS6dc/k2+nQFrL/099dJfr7bCEb2BsA+DM8DJP7e/xhEruiT+JmOc3q
DlVmRyBG9fOzqLHzMdNTY9OLrjYY41QYbGlH6lyO6AO1gRbyzmN5iVqbqbjZn+UC
cD4k+brFMHldzJo1UzooA3aKxmQy4L1PyTjnZ2bLuf7Wb2ZDrRbjnx0V6phYmAkG
IHeJpaN2wjfqpxHR4beP1045ZPL8M4EbW1kt7qUbTsHug73/JE77ZnRTLN3yQ/h6
Acn3fZUe+s6s0zIXmr5BlhXlNlIup3Lc9KJjF/vWeApvwiIt0LtTxGGvHE0uqLuc
sTaHzhs6oxqAwBhdFo8gget1g8qUP627ERyR36EtyOVMlknPPmYtC8d2HFad+7TV
ZerO0A99uYukxYaUsN3b8MH6cepxjshXUZyZiV/I8wjwhJwfQo8CbdlZXaTsuoVV
6AaPdV6BLT4wtH2W1KuFa5SVyUESFUY/Lptjtj6hBDIsEDi9qZkyLJiy5nl8V/EE
FT1EfvaFk4whL7HkHhYqjpHs0+fU3tJlNetutJMc59masdsAL16sYC2G3T7LZJpG
2KGuLWaWRRl0Js9UMlqJS5Ro5mK+y7pwU1I8BYf6WQh3oJG2mLQ=
=hu/W
-----END PGP SIGNATURE-----
--=-=-=--


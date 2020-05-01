Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7878CC35280
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 20:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107B220787
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 20:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOzE/Gpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107B220787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUbuf-0003oM-7B
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 16:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jUbtv-0003AQ-Od
 for qemu-devel@nongnu.org; Fri, 01 May 2020 16:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jUbtt-0007ux-V1
 for qemu-devel@nongnu.org; Fri, 01 May 2020 16:04:47 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f]:33534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jUbtt-0007tw-Eu; Fri, 01 May 2020 16:04:45 -0400
Received: by mail-lj1-x22f.google.com with SMTP id w20so3693203ljj.0;
 Fri, 01 May 2020 13:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=pMDUZeL2DuE4m6cxdwuT9MuIBihApgkhsT8Iy7tvB48=;
 b=KOzE/GpwzkPGBLYCnlln4D9wsdPc82DKuEAD36nHMdnAB+Py6YkpLHuIJM23u7qDiu
 vtVdfekEIEzeAUlgR1sZOjmNLvlbtv8qqeu7F0D4aL+WrgXqsQM0LgORCMctGA+zaYFs
 XgeVZeh6qbQx3eA7SqZpAcTDJVbG2iKS4e2UQkIO3s4fGyN4FHLSHgbJKJJ1KbYdhLHv
 CE39eGfRX7eN8erIPLtIdLlfqSQ2EPffi1WOanDQXltV7p/MP+RIavhjthUsD6FIFE5N
 Mk01xZldgdC7dQZTjGJxK8Vdn0FQJ5sozpZQMjY5aBHrvA1EBIvqNqv+VjwGoTyLCKxF
 alfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=pMDUZeL2DuE4m6cxdwuT9MuIBihApgkhsT8Iy7tvB48=;
 b=Qfr0QoXYtgBgy+5QlimVS569Qr0pI4goq7vgJxZfw5U+Npjp5zlsOGWt9+41H9biI5
 rjY5vnf43j9TeXOWx18kSM3WcdRQb0JvtR6CNmG48e6t9eTVJiQffRUuu7BVwTe/WTqp
 FDOSRbso08a+fkxY3F3eWWkMDkiPSpN0PbQQVDyUx+lPif6REu1PwQcI/aEcuqO9o615
 P0eptYdEV6HkFTwb6Q71qMw87c6iVQGUWBuqn5BI/KgYaLeLOceifeDJIu0P0L1lcNFu
 C6waKUuiYfpMaY7Ha3ImyC++8j9nCnJ1sXeb4XUkbbV6ITmcYi9jU0uScaLmeyVbQNB4
 v6Ww==
X-Gm-Message-State: AGi0Puad5jY58LXGHid+OjeZCnlA/NN15c0ONfO4Leq728Ja+EbG7zx2
 QGaBeAoElP43EOF4Vannq+LNJdnTt2D0T6GAuSm4AomQ5XvaWw==
X-Google-Smtp-Source: APiQypJEuulSaViSQloox1jV3A2GTWftZ4rnPo+8MkRGntqznInzZLQLt4k0nvVUhainvPZnGUpx75ty15rLmzQfknE=
X-Received: by 2002:a2e:800f:: with SMTP id j15mr3367153ljg.27.1588363482366; 
 Fri, 01 May 2020 13:04:42 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 2 May 2020 04:04:31 +0800
Message-ID: <CAE2XoE-XFG8r85yPOhuNS2YUMqhp70q1RXCy+KLT79doW8qHMg@mail.gmail.com>
Subject: An first try to improve PPC float simulation, not even compiled. Just
 ask question.
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002409c605a49bb1d5"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22f.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::22f
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002409c605a49bb1d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

/*
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| Bits  | Name   | Description
                                                             |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 32    | FE     | Floating-point exception summary. Every floating-point
instruction, except mtfsfi and mtfsf, implicitly sets FX      |
|       |        |  if that instruction causes any of the floating-point
exception bits in the FPSCR to change from 0 to 1. mcrfs,      |
|       |        |  mtfsfi, mtfsf, mtfsb0, and mtfsb1 can alter FPSCR[FX]
explicitly.                                                   |
|       |        |  Note: (Programming) FPSCR[FX] is defined not to be
altered implicitly by mtfsfi and mtfsf because                   |
|       |        |  permitting these instructions to alter FPSCR[FX]
implicitly could cause a paradox. An example is an                 |
|       |        |  mtfsfi or mtfsf that supplies 0 for FPSCR[FX] and 1 for
FPSCR[OX] and executes when FPSCR[OX] =3D 0.                  |
|       |        |  See also the programming notes with the definition of
these two instructions.                                       |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 33    | FEX    | Floating-point enabled exception summary. FEX is the OR
of all the floating-point exception bits masked by           |
|       |        |  their respective enable bits. mcrfs, mtfsfi, mtfsf,
mtfsb0, and mtfsb1 cannot alter FPSCR[FEX] explicitly.          |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 34    | VX     | Floating-point invalid operation exception summary. VX
is the OR of all the invalid operation exception bits.        |
|       |        |  mcrfs, mtfsfi, mtfsf, mtfsb0, and mtfsb1 cannot alter
FPSCR[VX] explicitly.                                         |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 35    | OX     | Floating-point overflow exception. See Section
5.6.1.7.3, =E2=80=9COverflow Exception.=E2=80=9D                           =
           |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 36    | UX     | Floating-point underflow exception. See Section
5.6.1.7.4, =E2=80=9CUnderflow Exception.=E2=80=9D                          =
          |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 37    | ZX     | Floating-Point zero divide exception. See Section
5.6.1.7.2, =E2=80=9CZero Divide Exception.=E2=80=9D                        =
        |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 38    | XX     | Floating-point inexact exception. See Section 5.6.1.7.5,
=E2=80=9CInexact Exception.=E2=80=9D                                       =
 |
|       |        |  FPSCR[XX] is a sticky version of FPSCR[FI] (see below).
Thus the following rules completely describe how            |
|       |        |  FPSCR[XX] is set by a given instruction:
                                                             |
|       |        |  =E2=80=A2 If the instruction affects FPSCR[FI], the new
FPSCR[XX] value is obtained by ORing the old value of               |
|       |        |  FPSCR[XX] with the new value of FPSCR[FI].
                                                             |
|       |        |  =E2=80=A2 If the instruction does not affect FPSCR[FI],=
 the
value of FPSCR[XX] is unchanged                                 |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 39    | VXSNAN | Floating-point invalid operation exception (SNAN). See
Section 5.6.1.7.1, =E2=80=9CInvalid Operation Exception.=E2=80=9D          =
   |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 40    | VXISI  | floating-point invalid operation exception (=E2=88=9E =
=E2=88=92 =E2=88=9E). See
Section 5.6.1.7.1, =E2=80=9CInvalid Operation Exception.=E2=80=9D.         =
  |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 41    | VXIDI  | Floating-point invalid operation exception ( =E2=88=9E =
=C3=B7 =E2=88=9E).See
Section 5.6.1.7.1, =E2=80=9CInvalid Operation Exception.=E2=80=9D.         =
  |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 42    | VXZDZ  | Floating-point invalid operation exception (0 =C3=B7 0) =
See
Section 5.6.1.7.1, =E2=80=9CInvalid Operation Exception.=E2=80=9D.         =
   |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 43    | VXIMZ  | Floating-point invalid operation exception (=E2=88=9E =
=C3=970). See
Section 5.6.1.7.1, =E2=80=9CInvalid Operation Exception.=E2=80=9D.         =
   |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 44    | VXVC   | Floating-point invalid operation exception (invalid
compare). See Section 5.6.1.7.1, =E2=80=9CInvalid Operation Exception.=E2=
=80=9D. |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 45    | FR     | Floating-point fraction rounded. The last arithmetic or
rounding and conversion instruction incremented the          |
|       |        |  fraction during rounding. See Section 4.4.3.6,
=E2=80=9CRounding.=E2=80=9D This bit is not sticky.                        =
          |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 46    | FI     | Floating-point fraction inexact. The last arithmetic or
rounding and conversion instruction either produced an       |
|       |        |  inexact result during rounding or caused a disabled
overflow exception. See Section 4.4.3.6, =E2=80=9CRounding.=E2=80=9D FI is =
     |
|       |        |  not sticky. See the definition of FPSCR[XX], above,
regarding the relationship between FI and XX.                   |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 47-51 | FPRF   | Floating-point result flags. Arithmetic, rounding, and
convert from integer instructions set FPRF based on the       |
|       |        |  result placed into the target register and on the
target precision, except that if any portion of the result is     |
|       |        |  undefined, the value placed into FPRF is undefined.
Floating-point compare instructions set FPRF based on           |
|       |        |  the relative values of the operands compared. For
convert to integer instructions, the value placed into FPRF       |
|       |        |  is undefined. See Table 4-9.
                                                             |
|       |        |  Note: (Programming) A single-precision operation that
produces a denormalized result sets FPRF to indicate          |
|       |        |  a denormalized number. When possible, single-precision
denormalized numbers are represented in                      |
|       |        |  normalized double format in the target register.
                                                             |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 47    | C      | Floating-point result class descriptor. Arithmetic,
rounding, and conversion instructions may set this bit with      |
|       |        |  the FPCC bits, to indicate the class of the result as
shown in Figure 4-9.                                          |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 48-51 | FPCC   | Floating-point condition code. Floating-point Compare
instructions set one of the FPCC bits and clear the            |
|       |        |  other three FPCC bits. Arithmetic, rounding, and
conversion instructions may set the FPCC bits with the C bit       |
|       |        |  to indicate the class of the result. In this case, the
three high-order FPCC bits retain their relational           |
|       |        |  significance indicating that the value is less than,
greater than, or equal to zero.                                |
|       |        |  48 Floating-point less than or negative (FL or <)
                                                            |
|       |        |  49 Floating-point greater than or positive (FG or >)
                                                             |
|       |        |  50 Floating-point equal or zero (FE or =3D)
                                                            |
|       |        |  51 Floating-point unordered or NaN (FU or ?)
                                                             |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 52    | =E2=80=94      | Reserved, should be cleared.
                                                            |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 53    | VXSOFT | Floating-point invalid operation exception (software
request). Can be altered only by mcrfs, mtfsfi, mtfsf,          |
|       |        |  mtfsb0, or mtfsb1
                                                            |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 54    | VXSQRT | Floating-point invalid operation exception (invalid
square root).                                                    |
|       |        |  Note that VXSQRT is defined even for implementations
that do not support either of the two optional                 |
|       |        |  instructions that set it, fsqrt[.] and frsqrte[.].
Defining it for all implementations gives software a standard    |
|       |        |  interface for handling square root exceptions. If an
implementation does not support fsqrt[.] or frsqrte[.],        |
|       |        |  software can simulate the instruction and set VXSQRT to
reflect the exception.                                      |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 55    | VXCVI  | Floating-point invalid operation exception (invalid
integer convert)                                                 |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 56    | VE     | Floating-point invalid operation exception enable
                                                             |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 57    | OE     | Floating-point overflow exception enable
                                                            |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 58    | UE     | Floating-point underflow exception enable
                                                             |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 59    | ZE     | Floating-point zero divide exception enable
                                                             |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 60    | XE     | Floating-point inexact exception enable
                                                             |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 61    | NI     | Floating-point non-IEEE mode. If NI =3D 1, the remaining
FPSCR bits may have meanings other than those given           |
|       |        |  in this document and results of floating-point
operations need not conform to IEEE 754. If the                      |
|       |        |  IEEE-754-conforming result of a floating-point
operation would be a denormalized number, the result of that         |
|       |        |  operation is 0 (with the same sign as the denormalized
number) if FPSCR[NI] =3D 1 and other requirements              |
|       |        |  specified in the user=E2=80=99s manual for the implemen=
tation
are met. The other effects of setting NI may differ among     |
|       |        |  implementations.
                                                             |
|       |        | Setting NI is intended to permit results to be
approximate and to cause performance to be more predictable           |
|       |        |  and less data-dependent than when NI =3D 0. For example=
,
in non-IEEE mode, an implementation returns 0                |
|       |        |  instead of a denormalized number and may return a large
number instead of an infinity. In non-IEEE mode an          |
|       |        |  implementation should provide a means for ensuring that
all results are produced without software assistance        |
|       |        |  (that is, without causing an enabled exception type
program interrupt or a floating-point unimplemented             |
|       |        |  instruction exception type program interrupt and
without invoking an emulation assist). The means may be            |
|       |        |  controlled by one or more other FPSCR bits (recall that
the other FPSCR bits have implementation-dependent          |
|       |        |  meanings if NI =3D 1).
                                                             |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
| 62-63 | RN     | Floating-point rounding control (RN).
                                                             |
|       |        |  00 Round to nearest
                                                            |
|       |        |  01 Round toward zero
                                                             |
|       |        |  10 Round toward +infinity
                                                            |
|       |        |  11 Round toward =E2=80=93infinity
                                                            |
+-------+--------+---------------------------------------------------------=
-------------------------------------------------------------+
*/

static int ieee_ex_to_ppc(int fexcp)
{
    int ret =3D 0;

    /* Question? TODO: How to handling Invalid Operation Exception. */
    if (fexcp & float_flag_invalid) {
        ret |=3D VX;
    }

    if (fexcp & float_flag_overflow) {
        ret |=3D FP_OX;
    }
    if (fexcp & float_flag_underflow) {
        ret |=3D FP_UX;
    }
    if (fexcp & float_flag_divbyzero) {
        ret |=3D FP_ZX;
    }
    if (fexcp & float_flag_inexact) {
        ret |=3D FP_XX;
        ret |=3D FP_FI;
    }
    return ret;
}

void helper_update_fpscr(CPUPPCState *env, int op, uintptr_t retaddr)
{
    int tmp =3D get_float_exception_flags(&env->fp_status);
    if (tmp) {
        tmp =3D ieee_ex_to_ppc(tmp);
        set_float_exception_flags(0, &env->fp_status);
        if (tmp) {
            env->fpscr |=3D tmp;
            if (fp_exceptions_enabled(env) && (env->fpscr & FP_FEX)) {
                if (env->fpscr & FP_VE) {
                    raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
                                        POWERPC_EXCP_FP | op, retaddr);
                }
            }
        }
    }
}
I found the fpscr  are really complicated, especially abount  Invalid
Operation Exception.
And  fp_status can not represent all the  Invalid Operation Exception flags=
.
What I need to do to represent all the  Invalid Operation Exception

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000002409c605a49bb1d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj48YnI+Lyo8YnI+Ky0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSs8YnI+
fCBCaXRzIMKgfCBOYW1lIMKgIHwgRGVzY3JpcHRpb24gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqB8PGJyPistLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rPGJyPnwgMzIg
wqAgwqB8IEZFIMKgIMKgIHwgRmxvYXRpbmctcG9pbnQgZXhjZXB0aW9uIHN1bW1hcnkuIEV2ZXJ5
IGZsb2F0aW5nLXBvaW50IGluc3RydWN0aW9uLCBleGNlcHQgbXRmc2ZpIGFuZCBtdGZzZiwgaW1w
bGljaXRseSBzZXRzIEZYIMKgIMKgIMKgfDxicj58IMKgIMKgIMKgIHwgwqAgwqAgwqAgwqB8IMKg
aWYgdGhhdCBpbnN0cnVjdGlvbiBjYXVzZXMgYW55IG9mIHRoZSBmbG9hdGluZy1wb2ludCBleGNl
cHRpb24gYml0cyBpbiB0aGUgRlBTQ1IgdG8gY2hhbmdlIGZyb20gMCB0byAxLiBtY3JmcywgwqAg
wqAgwqB8PGJyPnwgwqAgwqAgwqAgfCDCoCDCoCDCoCDCoHwgwqBtdGZzZmksIG10ZnNmLCBtdGZz
YjAsIGFuZCBtdGZzYjEgY2FuIGFsdGVyIEZQU0NSW0ZYXSBleHBsaWNpdGx5LiDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB8PGJyPnwgwqAgwqAgwqAgfCDCoCDCoCDCoCDCoHwgwqBOb3RlOiAoUHJvZ3JhbW1p
bmcpIEZQU0NSW0ZYXSBpcyBkZWZpbmVkIG5vdCB0byBiZSBhbHRlcmVkIGltcGxpY2l0bHkgYnkg
bXRmc2ZpIGFuZCBtdGZzZiBiZWNhdXNlIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHw8YnI+
fCDCoCDCoCDCoCB8IMKgIMKgIMKgIMKgfCDCoHBlcm1pdHRpbmcgdGhlc2UgaW5zdHJ1Y3Rpb25z
IHRvIGFsdGVyIEZQU0NSW0ZYXSBpbXBsaWNpdGx5IGNvdWxkIGNhdXNlIGEgcGFyYWRveC4gQW4g
ZXhhbXBsZSBpcyBhbiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8PGJyPnwgwqAgwqAgwqAgfCDC
oCDCoCDCoCDCoHwgwqBtdGZzZmkgb3IgbXRmc2YgdGhhdCBzdXBwbGllcyAwIGZvciBGUFNDUltG
WF0gYW5kIDEgZm9yIEZQU0NSW09YXSBhbmQgZXhlY3V0ZXMgd2hlbiBGUFNDUltPWF0gPSAwLiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHw8YnI+fCDCoCDCoCDCoCB8IMKgIMKgIMKgIMKgfCDC
oFNlZSBhbHNvIHRoZSBwcm9ncmFtbWluZyBub3RlcyB3aXRoIHRoZSBkZWZpbml0aW9uIG9mIHRo
ZXNlIHR3byBpbnN0cnVjdGlvbnMuIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHw8YnI+Ky0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSs8YnI+fCAz
MyDCoCDCoHwgRkVYIMKgIMKgfCBGbG9hdGluZy1wb2ludCBlbmFibGVkIGV4Y2VwdGlvbiBzdW1t
YXJ5LiBGRVggaXMgdGhlIE9SIG9mIGFsbCB0aGUgZmxvYXRpbmctcG9pbnQgZXhjZXB0aW9uIGJp
dHMgbWFza2VkIGJ5IMKgIMKgIMKgIMKgIMKgIHw8YnI+fCDCoCDCoCDCoCB8IMKgIMKgIMKgIMKg
fCDCoHRoZWlyIHJlc3BlY3RpdmUgZW5hYmxlIGJpdHMuIG1jcmZzLCBtdGZzZmksIG10ZnNmLCBt
dGZzYjAsIGFuZCBtdGZzYjEgY2Fubm90IGFsdGVyIEZQU0NSW0ZFWF0gZXhwbGljaXRseS4gwqAg
wqAgwqAgwqAgwqB8PGJyPistLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rPGJyPnwgMzQgwqAgwqB8IFZY
IMKgIMKgIHwgRmxvYXRpbmctcG9pbnQgaW52YWxpZCBvcGVyYXRpb24gZXhjZXB0aW9uIHN1bW1h
cnkuIFZYIGlzIHRoZSBPUiBvZiBhbGwgdGhlIGludmFsaWQgb3BlcmF0aW9uIGV4Y2VwdGlvbiBi
aXRzLiDCoCDCoCDCoCDCoHw8YnI+fCDCoCDCoCDCoCB8IMKgIMKgIMKgIMKgfCDCoG1jcmZzLCBt
dGZzZmksIG10ZnNmLCBtdGZzYjAsIGFuZCBtdGZzYjEgY2Fubm90IGFsdGVyIEZQU0NSW1ZYXSBl
eHBsaWNpdGx5LiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB8PGJyPistLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rPGJyPnwgMzUgwqAgwqB8
IE9YIMKgIMKgIHwgRmxvYXRpbmctcG9pbnQgb3ZlcmZsb3cgZXhjZXB0aW9uLiBTZWUgU2VjdGlv
biA1LjYuMS43LjMsIOKAnE92ZXJmbG93IEV4Y2VwdGlvbi7igJ0gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8PGJyPistLS0tLS0tKy0tLS0t
LS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0rPGJyPnwgMzYgwqAgwqB8IFVYIMKgIMKgIHwgRmxvYXRpbmctcG9pbnQgdW5kZXJm
bG93IGV4Y2VwdGlvbi4gU2VlIFNlY3Rpb24gNS42LjEuNy40LCDigJxVbmRlcmZsb3cgRXhjZXB0
aW9uLuKAnSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHw8YnI+Ky0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSs8YnI+fCAzNyDCoCDCoHwgWlggwqAgwqAg
fCBGbG9hdGluZy1Qb2ludCB6ZXJvIGRpdmlkZSBleGNlcHRpb24uIFNlZSBTZWN0aW9uIDUuNi4x
LjcuMiwg4oCcWmVybyBEaXZpZGUgRXhjZXB0aW9uLuKAnSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHw8YnI+Ky0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSs8YnI+
fCAzOCDCoCDCoHwgWFggwqAgwqAgfCBGbG9hdGluZy1wb2ludCBpbmV4YWN0IGV4Y2VwdGlvbi4g
U2VlIFNlY3Rpb24gNS42LjEuNy41LCDigJxJbmV4YWN0IEV4Y2VwdGlvbi7igJ0gwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8PGJyPnwg
wqAgwqAgwqAgfCDCoCDCoCDCoCDCoHwgwqBGUFNDUltYWF0gaXMgYSBzdGlja3kgdmVyc2lvbiBv
ZiBGUFNDUltGSV0gKHNlZSBiZWxvdykuIFRodXMgdGhlIGZvbGxvd2luZyBydWxlcyBjb21wbGV0
ZWx5IGRlc2NyaWJlIGhvdyDCoCDCoCDCoCDCoCDCoCDCoHw8YnI+fCDCoCDCoCDCoCB8IMKgIMKg
IMKgIMKgfCDCoEZQU0NSW1hYXSBpcyBzZXQgYnkgYSBnaXZlbiBpbnN0cnVjdGlvbjogwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8PGJyPnwg
wqAgwqAgwqAgfCDCoCDCoCDCoCDCoHwgwqDigKIgSWYgdGhlIGluc3RydWN0aW9uIGFmZmVjdHMg
RlBTQ1JbRkldLCB0aGUgbmV3IEZQU0NSW1hYXSB2YWx1ZSBpcyBvYnRhaW5lZCBieSBPUmluZyB0
aGUgb2xkIHZhbHVlIG9mIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHw8YnI+fCDCoCDCoCDCoCB8IMKg
IMKgIMKgIMKgfCDCoEZQU0NSW1hYXSB3aXRoIHRoZSBuZXcgdmFsdWUgb2YgRlBTQ1JbRkldLiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHw8YnI+
fCDCoCDCoCDCoCB8IMKgIMKgIMKgIMKgfCDCoOKAoiBJZiB0aGUgaW5zdHJ1Y3Rpb24gZG9lcyBu
b3QgYWZmZWN0IEZQU0NSW0ZJXSwgdGhlIHZhbHVlIG9mIEZQU0NSW1hYXSBpcyB1bmNoYW5nZWQg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfDxicj4rLS0t
LS0tLSstLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tKzxicj58IDM5IMKgIMKgfCBWWFNOQU4gfCBGbG9hdGluZy1wb2lu
dCBpbnZhbGlkIG9wZXJhdGlvbiBleGNlcHRpb24gKFNOQU4pLiBTZWUgU2VjdGlvbiA1LjYuMS43
LjEsIOKAnEludmFsaWQgT3BlcmF0aW9uIEV4Y2VwdGlvbi7igJ0gwqAgwqAgwqAgwqAgwqAgwqAg
fDxicj4rLS0tLS0tLSstLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKzxicj58IDQwIMKgIMKgfCBWWElTSSDCoHwgZmxv
YXRpbmctcG9pbnQgaW52YWxpZCBvcGVyYXRpb24gZXhjZXB0aW9uICjiiJ4g4oiSIOKInikuIFNl
ZSBTZWN0aW9uIDUuNi4xLjcuMSwg4oCcSW52YWxpZCBPcGVyYXRpb24gRXhjZXB0aW9uLuKAnS4g
wqAgwqAgwqAgwqAgwqAgfDxicj4rLS0tLS0tLSstLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKzxicj58IDQxIMKgIMKg
fCBWWElESSDCoHwgRmxvYXRpbmctcG9pbnQgaW52YWxpZCBvcGVyYXRpb24gZXhjZXB0aW9uICgg
4oieIMO3IOKInikuU2VlIFNlY3Rpb24gNS42LjEuNy4xLCDigJxJbnZhbGlkIE9wZXJhdGlvbiBF
eGNlcHRpb24u4oCdLiDCoCDCoCDCoCDCoCDCoCB8PGJyPistLS0tLS0tKy0tLS0tLS0tKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0r
PGJyPnwgNDIgwqAgwqB8IFZYWkRaIMKgfCBGbG9hdGluZy1wb2ludCBpbnZhbGlkIG9wZXJhdGlv
biBleGNlcHRpb24gKDAgw7cgMCkgU2VlIFNlY3Rpb24gNS42LjEuNy4xLCDigJxJbnZhbGlkIE9w
ZXJhdGlvbiBFeGNlcHRpb24u4oCdLiDCoCDCoCDCoCDCoCDCoCDCoHw8YnI+Ky0tLS0tLS0rLS0t
LS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSs8YnI+fCA0MyDCoCDCoHwgVlhJTVogwqB8IEZsb2F0aW5nLXBvaW50IGludmFs
aWQgb3BlcmF0aW9uIGV4Y2VwdGlvbiAo4oieIMOXMCkuIFNlZSBTZWN0aW9uIDUuNi4xLjcuMSwg
4oCcSW52YWxpZCBPcGVyYXRpb24gRXhjZXB0aW9uLuKAnS4gwqAgwqAgwqAgwqAgwqAgwqB8PGJy
PistLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rPGJyPnwgNDQgwqAgwqB8IFZYVkMgwqAgfCBGbG9hdGlu
Zy1wb2ludCBpbnZhbGlkIG9wZXJhdGlvbiBleGNlcHRpb24gKGludmFsaWQgY29tcGFyZSkuIFNl
ZSBTZWN0aW9uIDUuNi4xLjcuMSwg4oCcSW52YWxpZCBPcGVyYXRpb24gRXhjZXB0aW9uLuKAnS4g
fDxicj4rLS0tLS0tLSstLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKzxicj58IDQ1IMKgIMKgfCBGUiDCoCDCoCB8IEZs
b2F0aW5nLXBvaW50IGZyYWN0aW9uIHJvdW5kZWQuIFRoZSBsYXN0IGFyaXRobWV0aWMgb3Igcm91
bmRpbmcgYW5kIGNvbnZlcnNpb24gaW5zdHJ1Y3Rpb24gaW5jcmVtZW50ZWQgdGhlIMKgIMKgIMKg
IMKgIMKgfDxicj58IMKgIMKgIMKgIHwgwqAgwqAgwqAgwqB8IMKgZnJhY3Rpb24gZHVyaW5nIHJv
dW5kaW5nLiBTZWUgU2VjdGlvbiA0LjQuMy42LCDigJxSb3VuZGluZy7igJ0gVGhpcyBiaXQgaXMg
bm90IHN0aWNreS4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB8PGJyPistLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rPGJyPnwgNDYgwqAgwqB8IEZJIMKgIMKg
IHwgRmxvYXRpbmctcG9pbnQgZnJhY3Rpb24gaW5leGFjdC4gVGhlIGxhc3QgYXJpdGhtZXRpYyBv
ciByb3VuZGluZyBhbmQgY29udmVyc2lvbiBpbnN0cnVjdGlvbiBlaXRoZXIgcHJvZHVjZWQgYW4g
wqAgwqAgwqAgfDxicj58IMKgIMKgIMKgIHwgwqAgwqAgwqAgwqB8IMKgaW5leGFjdCByZXN1bHQg
ZHVyaW5nIHJvdW5kaW5nIG9yIGNhdXNlZCBhIGRpc2FibGVkIG92ZXJmbG93IGV4Y2VwdGlvbi4g
U2VlIFNlY3Rpb24gNC40LjMuNiwg4oCcUm91bmRpbmcu4oCdIEZJIGlzIMKgIMKgIMKgfDxicj58
IMKgIMKgIMKgIHwgwqAgwqAgwqAgwqB8IMKgbm90IHN0aWNreS4gU2VlIHRoZSBkZWZpbml0aW9u
IG9mIEZQU0NSW1hYXSwgYWJvdmUsIHJlZ2FyZGluZyB0aGUgcmVsYXRpb25zaGlwIGJldHdlZW4g
RkkgYW5kIFhYLiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8PGJyPistLS0tLS0tKy0tLS0t
LS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0rPGJyPnwgNDctNTEgfCBGUFJGIMKgIHwgRmxvYXRpbmctcG9pbnQgcmVzdWx0IGZs
YWdzLiBBcml0aG1ldGljLCByb3VuZGluZywgYW5kIGNvbnZlcnQgZnJvbSBpbnRlZ2VyIGluc3Ry
dWN0aW9ucyBzZXQgRlBSRiBiYXNlZCBvbiB0aGUgwqAgwqAgwqAgfDxicj58IMKgIMKgIMKgIHwg
wqAgwqAgwqAgwqB8IMKgcmVzdWx0IHBsYWNlZCBpbnRvIHRoZSB0YXJnZXQgcmVnaXN0ZXIgYW5k
IG9uIHRoZSB0YXJnZXQgcHJlY2lzaW9uLCBleGNlcHQgdGhhdCBpZiBhbnkgcG9ydGlvbiBvZiB0
aGUgcmVzdWx0IGlzIMKgIMKgIHw8YnI+fCDCoCDCoCDCoCB8IMKgIMKgIMKgIMKgfCDCoHVuZGVm
aW5lZCwgdGhlIHZhbHVlIHBsYWNlZCBpbnRvIEZQUkYgaXMgdW5kZWZpbmVkLiBGbG9hdGluZy1w
b2ludCBjb21wYXJlIGluc3RydWN0aW9ucyBzZXQgRlBSRiBiYXNlZCBvbiDCoCDCoCDCoCDCoCDC
oCB8PGJyPnwgwqAgwqAgwqAgfCDCoCDCoCDCoCDCoHwgwqB0aGUgcmVsYXRpdmUgdmFsdWVzIG9m
IHRoZSBvcGVyYW5kcyBjb21wYXJlZC4gRm9yIGNvbnZlcnQgdG8gaW50ZWdlciBpbnN0cnVjdGlv
bnMsIHRoZSB2YWx1ZSBwbGFjZWQgaW50byBGUFJGIMKgIMKgIMKgIHw8YnI+fCDCoCDCoCDCoCB8
IMKgIMKgIMKgIMKgfCDCoGlzIHVuZGVmaW5lZC4gU2VlIFRhYmxlIDQtOS4gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB8PGJyPnwgwqAgwqAgwqAgfCDCoCDCoCDCoCDCoHwgwqBOb3RlOiAoUHJvZ3JhbW1pbmcp
IEEgc2luZ2xlLXByZWNpc2lvbiBvcGVyYXRpb24gdGhhdCBwcm9kdWNlcyBhIGRlbm9ybWFsaXpl
ZCByZXN1bHQgc2V0cyBGUFJGIHRvIGluZGljYXRlIMKgIMKgIMKgIMKgIMKgfDxicj58IMKgIMKg
IMKgIHwgwqAgwqAgwqAgwqB8IMKgYSBkZW5vcm1hbGl6ZWQgbnVtYmVyLiBXaGVuIHBvc3NpYmxl
LCBzaW5nbGUtcHJlY2lzaW9uIGRlbm9ybWFsaXplZCBudW1iZXJzIGFyZSByZXByZXNlbnRlZCBp
biDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHw8YnI+fCDCoCDCoCDCoCB8IMKgIMKg
IMKgIMKgfCDCoG5vcm1hbGl6ZWQgZG91YmxlIGZvcm1hdCBpbiB0aGUgdGFyZ2V0IHJlZ2lzdGVy
LiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHw8YnI+Ky0tLS0t
LS0rLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSs8YnI+fCA0NyDCoCDCoHwgQyDCoCDCoCDCoHwgRmxvYXRpbmctcG9p
bnQgcmVzdWx0IGNsYXNzIGRlc2NyaXB0b3IuIEFyaXRobWV0aWMsIHJvdW5kaW5nLCBhbmQgY29u
dmVyc2lvbiBpbnN0cnVjdGlvbnMgbWF5IHNldCB0aGlzIGJpdCB3aXRoIMKgIMKgIMKgfDxicj58
IMKgIMKgIMKgIHwgwqAgwqAgwqAgwqB8IMKgdGhlIEZQQ0MgYml0cywgdG8gaW5kaWNhdGUgdGhl
IGNsYXNzIG9mIHRoZSByZXN1bHQgYXMgc2hvd24gaW4gRmlndXJlIDQtOS4gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8PGJyPist
LS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0rPGJyPnwgNDgtNTEgfCBGUENDIMKgIHwgRmxvYXRpbmctcG9p
bnQgY29uZGl0aW9uIGNvZGUuIEZsb2F0aW5nLXBvaW50IENvbXBhcmUgaW5zdHJ1Y3Rpb25zIHNl
dCBvbmUgb2YgdGhlIEZQQ0MgYml0cyBhbmQgY2xlYXIgdGhlIMKgIMKgIMKgIMKgIMKgIMKgfDxi
cj58IMKgIMKgIMKgIHwgwqAgwqAgwqAgwqB8IMKgb3RoZXIgdGhyZWUgRlBDQyBiaXRzLiBBcml0
aG1ldGljLCByb3VuZGluZywgYW5kIGNvbnZlcnNpb24gaW5zdHJ1Y3Rpb25zIG1heSBzZXQgdGhl
IEZQQ0MgYml0cyB3aXRoIHRoZSBDIGJpdCDCoCDCoCDCoCB8PGJyPnwgwqAgwqAgwqAgfCDCoCDC
oCDCoCDCoHwgwqB0byBpbmRpY2F0ZSB0aGUgY2xhc3Mgb2YgdGhlIHJlc3VsdC4gSW4gdGhpcyBj
YXNlLCB0aGUgdGhyZWUgaGlnaC1vcmRlciBGUENDIGJpdHMgcmV0YWluIHRoZWlyIHJlbGF0aW9u
YWwgwqAgwqAgwqAgwqAgwqAgfDxicj58IMKgIMKgIMKgIHwgwqAgwqAgwqAgwqB8IMKgc2lnbmlm
aWNhbmNlIGluZGljYXRpbmcgdGhhdCB0aGUgdmFsdWUgaXMgbGVzcyB0aGFuLCBncmVhdGVyIHRo
YW4sIG9yIGVxdWFsIHRvIHplcm8uIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgfDxicj58IMKgIMKgIMKgIHwgwqAgwqAgwqAgwqB8IMKgNDggRmxvYXRpbmct
cG9pbnQgbGVzcyB0aGFuIG9yIG5lZ2F0aXZlIChGTCBvciAmbHQ7KSDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8PGJyPnwgwqAgwqAgwqAgfCDCoCDCoCDCoCDCoHwg
wqA0OSBGbG9hdGluZy1wb2ludCBncmVhdGVyIHRoYW4gb3IgcG9zaXRpdmUgKEZHIG9yICZndDsp
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfDxicj58IMKgIMKgIMKgIHwg
wqAgwqAgwqAgwqB8IMKgNTAgRmxvYXRpbmctcG9pbnQgZXF1YWwgb3IgemVybyAoRkUgb3IgPSkg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfDxi
cj58IMKgIMKgIMKgIHwgwqAgwqAgwqAgwqB8IMKgNTEgRmxvYXRpbmctcG9pbnQgdW5vcmRlcmVk
IG9yIE5hTiAoRlUgb3IgPykgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB8PGJyPistLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rPGJyPnwgNTIgwqAgwqB8IOKA
lCDCoCDCoCDCoHwgUmVzZXJ2ZWQsIHNob3VsZCBiZSBjbGVhcmVkLiDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB8PGJyPistLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rPGJyPnwgNTMgwqAgwqB8IFZYU09GVCB8IEZs
b2F0aW5nLXBvaW50IGludmFsaWQgb3BlcmF0aW9uIGV4Y2VwdGlvbiAoc29mdHdhcmUgcmVxdWVz
dCkuIENhbiBiZSBhbHRlcmVkIG9ubHkgYnkgbWNyZnMsIG10ZnNmaSwgbXRmc2YsIMKgIMKgIMKg
IMKgIMKgfDxicj58IMKgIMKgIMKgIHwgwqAgwqAgwqAgwqB8IMKgbXRmc2IwLCBvciBtdGZzYjEg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfDxicj4rLS0tLS0tLSstLS0tLS0tLSst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tKzxicj58IDU0IMKgIMKgfCBWWFNRUlQgfCBGbG9hdGluZy1wb2ludCBpbnZhbGlkIG9wZXJh
dGlvbiBleGNlcHRpb24gKGludmFsaWQgc3F1YXJlIHJvb3QpLiDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHw8YnI+fCDCoCDCoCDCoCB8IMKgIMKgIMKgIMKgfCDCoE5vdGUgdGhhdCBWWFNRUlQgaXMgZGVm
aW5lZCBldmVuIGZvciBpbXBsZW1lbnRhdGlvbnMgdGhhdCBkbyBub3Qgc3VwcG9ydCBlaXRoZXIg
b2YgdGhlIHR3byBvcHRpb25hbCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8PGJyPnwgwqAgwqAg
wqAgfCDCoCDCoCDCoCDCoHwgwqBpbnN0cnVjdGlvbnMgdGhhdCBzZXQgaXQsIGZzcXJ0Wy5dIGFu
ZCBmcnNxcnRlWy5dLiBEZWZpbmluZyBpdCBmb3IgYWxsIGltcGxlbWVudGF0aW9ucyBnaXZlcyBz
b2Z0d2FyZSBhIHN0YW5kYXJkIMKgIMKgfDxicj58IMKgIMKgIMKgIHwgwqAgwqAgwqAgwqB8IMKg
aW50ZXJmYWNlIGZvciBoYW5kbGluZyBzcXVhcmUgcm9vdCBleGNlcHRpb25zLiBJZiBhbiBpbXBs
ZW1lbnRhdGlvbiBkb2VzIG5vdCBzdXBwb3J0IGZzcXJ0Wy5dIG9yIGZyc3FydGVbLl0sIMKgIMKg
IMKgIMKgfDxicj58IMKgIMKgIMKgIHwgwqAgwqAgwqAgwqB8IMKgc29mdHdhcmUgY2FuIHNpbXVs
YXRlIHRoZSBpbnN0cnVjdGlvbiBhbmQgc2V0IFZYU1FSVCB0byByZWZsZWN0IHRoZSBleGNlcHRp
b24uIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgfDxicj4rLS0tLS0tLSstLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKzxicj58IDU1IMKgIMKgfCBWWENWSSDCoHwg
RmxvYXRpbmctcG9pbnQgaW52YWxpZCBvcGVyYXRpb24gZXhjZXB0aW9uIChpbnZhbGlkIGludGVn
ZXIgY29udmVydCkgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfDxicj4rLS0tLS0tLSstLS0tLS0tLSstLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKzxi
cj58IDU2IMKgIMKgfCBWRSDCoCDCoCB8IEZsb2F0aW5nLXBvaW50IGludmFsaWQgb3BlcmF0aW9u
IGV4Y2VwdGlvbiBlbmFibGUgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB8PGJyPistLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rPGJyPnwgNTcgwqAgwqB8IE9FIMKgIMKg
IHwgRmxvYXRpbmctcG9pbnQgb3ZlcmZsb3cgZXhjZXB0aW9uIGVuYWJsZSDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8PGJyPistLS0tLS0t
Ky0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0rPGJyPnwgNTggwqAgwqB8IFVFIMKgIMKgIHwgRmxvYXRpbmctcG9pbnQg
dW5kZXJmbG93IGV4Y2VwdGlvbiBlbmFibGUgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8PGJyPistLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rPGJy
PnwgNTkgwqAgwqB8IFpFIMKgIMKgIHwgRmxvYXRpbmctcG9pbnQgemVybyBkaXZpZGUgZXhjZXB0
aW9uIGVuYWJsZSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHw8YnI+Ky0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSs8YnI+fCA2MCDCoCDCoHwgWEUgwqAg
wqAgfCBGbG9hdGluZy1wb2ludCBpbmV4YWN0IGV4Y2VwdGlvbiBlbmFibGUgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8PGJyPistLS0t
LS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0rPGJyPnwgNjEgwqAgwqB8IE5JIMKgIMKgIHwgRmxvYXRpbmctcG9p
bnQgbm9uLUlFRUUgbW9kZS4gSWYgTkkgPSAxLCB0aGUgcmVtYWluaW5nIEZQU0NSIGJpdHMgbWF5
IGhhdmUgbWVhbmluZ3Mgb3RoZXIgdGhhbiB0aG9zZSBnaXZlbiDCoCDCoCDCoCDCoCDCoCB8PGJy
PnwgwqAgwqAgwqAgfCDCoCDCoCDCoCDCoHwgwqBpbiB0aGlzIGRvY3VtZW50IGFuZCByZXN1bHRz
IG9mIGZsb2F0aW5nLXBvaW50IG9wZXJhdGlvbnMgbmVlZCBub3QgY29uZm9ybSB0byBJRUVFIDc1
NC4gSWYgdGhlIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfDxicj58IMKgIMKgIMKg
IHwgwqAgwqAgwqAgwqB8IMKgSUVFRS03NTQtY29uZm9ybWluZyByZXN1bHQgb2YgYSBmbG9hdGlu
Zy1wb2ludCBvcGVyYXRpb24gd291bGQgYmUgYSBkZW5vcm1hbGl6ZWQgbnVtYmVyLCB0aGUgcmVz
dWx0IG9mIHRoYXQgwqAgwqAgwqAgwqAgfDxicj58IMKgIMKgIMKgIHwgwqAgwqAgwqAgwqB8IMKg
b3BlcmF0aW9uIGlzIDAgKHdpdGggdGhlIHNhbWUgc2lnbiBhcyB0aGUgZGVub3JtYWxpemVkIG51
bWJlcikgaWYgRlBTQ1JbTkldID0gMSBhbmQgb3RoZXIgcmVxdWlyZW1lbnRzIMKgIMKgIMKgIMKg
IMKgIMKgIMKgfDxicj58IMKgIMKgIMKgIHwgwqAgwqAgwqAgwqB8IMKgc3BlY2lmaWVkIGluIHRo
ZSB1c2Vy4oCZcyBtYW51YWwgZm9yIHRoZSBpbXBsZW1lbnRhdGlvbiBhcmUgbWV0LiBUaGUgb3Ro
ZXIgZWZmZWN0cyBvZiBzZXR0aW5nIE5JIG1heSBkaWZmZXIgYW1vbmcgwqAgwqAgfDxicj58IMKg
IMKgIMKgIHwgwqAgwqAgwqAgwqB8IMKgaW1wbGVtZW50YXRpb25zLiDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHw8YnI+fCDCoCDCoCDCoCB8IMKgIMKgIMKgIMKgfCBTZXR0aW5n
IE5JIGlzIGludGVuZGVkIHRvIHBlcm1pdCByZXN1bHRzIHRvIGJlIGFwcHJveGltYXRlIGFuZCB0
byBjYXVzZSBwZXJmb3JtYW5jZSB0byBiZSBtb3JlIHByZWRpY3RhYmxlIMKgIMKgIMKgIMKgIMKg
IHw8YnI+fCDCoCDCoCDCoCB8IMKgIMKgIMKgIMKgfCDCoGFuZCBsZXNzIGRhdGEtZGVwZW5kZW50
IHRoYW4gd2hlbiBOSSA9IDAuIEZvciBleGFtcGxlLCBpbiBub24tSUVFRSBtb2RlLCBhbiBpbXBs
ZW1lbnRhdGlvbiByZXR1cm5zIDAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8PGJyPnwgwqAgwqAg
wqAgfCDCoCDCoCDCoCDCoHwgwqBpbnN0ZWFkIG9mIGEgZGVub3JtYWxpemVkIG51bWJlciBhbmQg
bWF5IHJldHVybiBhIGxhcmdlIG51bWJlciBpbnN0ZWFkIG9mIGFuIGluZmluaXR5LiBJbiBub24t
SUVFRSBtb2RlIGFuIMKgIMKgIMKgIMKgIMKgfDxicj58IMKgIMKgIMKgIHwgwqAgwqAgwqAgwqB8
IMKgaW1wbGVtZW50YXRpb24gc2hvdWxkIHByb3ZpZGUgYSBtZWFucyBmb3IgZW5zdXJpbmcgdGhh
dCBhbGwgcmVzdWx0cyBhcmUgcHJvZHVjZWQgd2l0aG91dCBzb2Z0d2FyZSBhc3Npc3RhbmNlIMKg
IMKgIMKgIMKgfDxicj58IMKgIMKgIMKgIHwgwqAgwqAgwqAgwqB8IMKgKHRoYXQgaXMsIHdpdGhv
dXQgY2F1c2luZyBhbiBlbmFibGVkIGV4Y2VwdGlvbiB0eXBlIHByb2dyYW0gaW50ZXJydXB0IG9y
IGEgZmxvYXRpbmctcG9pbnQgdW5pbXBsZW1lbnRlZCDCoCDCoCDCoCDCoCDCoCDCoCB8PGJyPnwg
wqAgwqAgwqAgfCDCoCDCoCDCoCDCoHwgwqBpbnN0cnVjdGlvbiBleGNlcHRpb24gdHlwZSBwcm9n
cmFtIGludGVycnVwdCBhbmQgd2l0aG91dCBpbnZva2luZyBhbiBlbXVsYXRpb24gYXNzaXN0KS4g
VGhlIG1lYW5zIG1heSBiZSDCoCDCoCDCoCDCoCDCoCDCoHw8YnI+fCDCoCDCoCDCoCB8IMKgIMKg
IMKgIMKgfCDCoGNvbnRyb2xsZWQgYnkgb25lIG9yIG1vcmUgb3RoZXIgRlBTQ1IgYml0cyAocmVj
YWxsIHRoYXQgdGhlIG90aGVyIEZQU0NSIGJpdHMgaGF2ZSBpbXBsZW1lbnRhdGlvbi1kZXBlbmRl
bnQgwqAgwqAgwqAgwqAgwqB8PGJyPnwgwqAgwqAgwqAgfCDCoCDCoCDCoCDCoHwgwqBtZWFuaW5n
cyBpZiBOSSA9IDEpLiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHw8YnI+Ky0tLS0tLS0r
LS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSs8YnI+fCA2Mi02MyB8IFJOIMKgIMKgIHwgRmxvYXRpbmctcG9pbnQgcm91
bmRpbmcgY29udHJvbCAoUk4pLiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHw8YnI+fCDCoCDCoCDCoCB8IMKgIMKgIMKgIMKgfCDC
oDAwIFJvdW5kIHRvIG5lYXJlc3QgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfDxicj58
IMKgIMKgIMKgIHwgwqAgwqAgwqAgwqB8IMKgMDEgUm91bmQgdG93YXJkIHplcm8gwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqB8PGJyPnwgwqAgwqAgwqAgfCDCoCDCoCDCoCDCoHwgwqAxMCBS
b3VuZCB0b3dhcmQgK2luZmluaXR5IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHw8YnI+fCDCoCDCoCDC
oCB8IMKgIMKgIMKgIMKgfCDCoDExIFJvdW5kIHRvd2FyZCDigJNpbmZpbml0eSDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB8PGJyPistLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rPGJyPiovPGJyPjxicj5zdGF0
aWMgaW50IGllZWVfZXhfdG9fcHBjKGludCBmZXhjcCk8YnI+ezxicj7CoCDCoCBpbnQgcmV0ID0g
MDs8YnI+PGJyPsKgIMKgIC8qIFF1ZXN0aW9uPyBUT0RPOiBIb3cgdG8gaGFuZGxpbmcgSW52YWxp
ZCBPcGVyYXRpb24gRXhjZXB0aW9uLiAqLzxicj7CoCDCoCBpZiAoZmV4Y3AgJmFtcDsgZmxvYXRf
ZmxhZ19pbnZhbGlkKSB7PGJyPsKgIMKgIMKgIMKgIHJldCB8PSBWWDs8YnI+wqAgwqAgfTxicj48
YnI+wqAgwqAgaWYgKGZleGNwICZhbXA7IGZsb2F0X2ZsYWdfb3ZlcmZsb3cpIHs8YnI+wqAgwqAg
wqAgwqAgcmV0IHw9IEZQX09YOzxicj7CoCDCoCB9PGJyPsKgIMKgIGlmIChmZXhjcCAmYW1wOyBm
bG9hdF9mbGFnX3VuZGVyZmxvdykgezxicj7CoCDCoCDCoCDCoCByZXQgfD0gRlBfVVg7PGJyPsKg
IMKgIH08YnI+wqAgwqAgaWYgKGZleGNwICZhbXA7IGZsb2F0X2ZsYWdfZGl2Ynl6ZXJvKSB7PGJy
PsKgIMKgIMKgIMKgIHJldCB8PSBGUF9aWDs8YnI+wqAgwqAgfTxicj7CoCDCoCBpZiAoZmV4Y3Ag
JmFtcDsgZmxvYXRfZmxhZ19pbmV4YWN0KSB7PGJyPsKgIMKgIMKgIMKgIHJldCB8PSBGUF9YWDs8
YnI+wqAgwqAgwqAgwqAgcmV0IHw9IEZQX0ZJOzxicj7CoCDCoCB9PGJyPsKgIMKgIHJldHVybiBy
ZXQ7PGJyPn08YnI+PGJyPnZvaWQgaGVscGVyX3VwZGF0ZV9mcHNjcihDUFVQUENTdGF0ZSAqZW52
LCBpbnQgb3AsIHVpbnRwdHJfdCByZXRhZGRyKTxicj57PGJyPsKgIMKgIGludCB0bXAgPSBnZXRf
ZmxvYXRfZXhjZXB0aW9uX2ZsYWdzKCZhbXA7ZW52LSZndDtmcF9zdGF0dXMpOzxicj7CoCDCoCBp
ZiAodG1wKSB7PGJyPsKgIMKgIMKgIMKgIHRtcCA9IGllZWVfZXhfdG9fcHBjKHRtcCk7PGJyPsKg
IMKgIMKgIMKgIHNldF9mbG9hdF9leGNlcHRpb25fZmxhZ3MoMCwgJmFtcDtlbnYtJmd0O2ZwX3N0
YXR1cyk7PGJyPsKgIMKgIMKgIMKgIGlmICh0bXApIHs8YnI+wqAgwqAgwqAgwqAgwqAgwqAgZW52
LSZndDtmcHNjciB8PSB0bXA7PGJyPsKgIMKgIMKgIMKgIMKgIMKgIGlmIChmcF9leGNlcHRpb25z
X2VuYWJsZWQoZW52KSAmYW1wOyZhbXA7IChlbnYtJmd0O2Zwc2NyICZhbXA7IEZQX0ZFWCkpIHs8
YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGVudi0mZ3Q7ZnBzY3IgJmFtcDsgRlBfVkUp
IHs8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2VfZXhjZXB0aW9uX2Vycl9y
YShlbnYsIFBPV0VSUENfRVhDUF9QUk9HUkFNLDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQT1dFUlBDX0VYQ1BfRlAgfCBvcCwg
cmV0YWRkcik7PGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+wqAgwqAgwqAgwqAgwqAg
wqAgfTxicj7CoCDCoCDCoCDCoCB9PGJyPsKgIMKgIH08YnI+fTxicj48L2Rpdj48ZGl2PkkgZm91
bmQgdGhlIA0KDQpmcHNjcsKgIGFyZSByZWFsbHkgY29tcGxpY2F0ZWQsIGVzcGVjaWFsbHkgYWJv
dW50wqANCg0KSW52YWxpZCBPcGVyYXRpb24gRXhjZXB0aW9uLg0KDQo8L2Rpdj48ZGl2PkFuZMKg
DQoNCmZwX3N0YXR1cyBjYW4gbm90IHJlcHJlc2VudCBhbGwgdGhlwqANCg0KSW52YWxpZCBPcGVy
YXRpb24gRXhjZXB0aW9uIGZsYWdzLjwvZGl2PjxkaXY+V2hhdCBJIG5lZWQgdG8gZG8gdG8gcmVw
cmVzZW50IGFsbCB0aGXCoA0KDQoNCg0KSW52YWxpZCBPcGVyYXRpb24gRXhjZXB0aW9uDQoNCjwv
ZGl2PjxkaXY+PGJyPjwvZGl2Pi0tIDxicj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfc2ln
bmF0dXJlIiBkYXRhLXNtYXJ0bWFpbD0iZ21haWxfc2lnbmF0dXJlIj7CoCDCoCDCoCDCoMKgIOat
pOiHtDxicj7npLw8YnI+572X5YuH5YiaPGJyPllvdXJzPGJyPsKgIMKgIHNpbmNlcmVseSw8YnI+
WW9uZ2dhbmcgTHVvPGJyPjwvZGl2PjwvZGl2Pg0K
--0000000000002409c605a49bb1d5--


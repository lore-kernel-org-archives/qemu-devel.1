Received: from eggs.gnu.org ([2001:4830:134:3::10]:46039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fkwVO-00080Y-2A
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 15:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fkwVK-0006pm-0J
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 15:09:54 -0400
Received: from mail-by2nam05on0713.outbound.protection.outlook.com
	([2a01:111:f400:fe52::713]:35359
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fkwVJ-0006pR-Bv
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 15:09:49 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 1 Aug 2018 19:09:28 +0000
Message-ID: <BN7PR08MB486890D7BB35AC51348F574AC62D0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-8-git-send-email-aleksandar.markovic@rt-rk.com>,
	<4bc391e5-9aac-57c6-7173-0fdd7a25bccc@vivier.eu>,
	<BN7PR08MB4868ECFD24601E06677D4C55C62D0@BN7PR08MB4868.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB4868ECFD24601E06677D4C55C62D0@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 07/76] elf: Remove duplicate
 preprocessor constant definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

Hi again, Laurent.

Did you mean to move the comment from THE CURRENT to THE RIGHT position, as=
 displayed here:

QEMU's elf.h:

/* MIPS architecture level. */  <--- THE CURRENT POSITION
#define EF_MIPS_ARCH            0xf0000000 <----------------- duplicate

/* Legal values for MIPS architecture level.  */
#define EF_MIPS_ARCH_1          0x00000000      /* -mips1 code.  */
#define EF_MIPS_ARCH_2          0x10000000      /* -mips2 code.  */
#define EF_MIPS_ARCH_3          0x20000000      /* -mips3 code.  */
#define EF_MIPS_ARCH_4          0x30000000      /* -mips4 code.  */
#define EF_MIPS_ARCH_5          0x40000000      /* -mips5 code.  */
#define EF_MIPS_ARCH_32         0x50000000      /* MIPS32 code.  */
#define EF_MIPS_ARCH_64         0x60000000      /* MIPS64 code.  */
#define EF_MIPS_ARCH_32R2       0x70000000      /* MIPS32r2 code.  */
#define EF_MIPS_ARCH_64R2       0x80000000      /* MIPS64r2 code.  */
#define EF_MIPS_ARCH_32R6       0x90000000      /* MIPS32r6 code.  */
#define EF_MIPS_ARCH_64R6       0xa0000000      /* MIPS64r6 code.  */

/* The ABI of a file. */
#define EF_MIPS_ABI_O32         0x00001000      /* O32 ABI.  */
#define EF_MIPS_ABI_O64         0x00002000      /* O32 extended for 64 bit.=
  */

#define EF_MIPS_NOREORDER 0x00000001
#define EF_MIPS_PIC       0x00000002
#define EF_MIPS_CPIC      0x00000004
#define EF_MIPS_ABI2            0x00000020
#define EF_MIPS_OPTIONS_FIRST   0x00000080
#define EF_MIPS_32BITMODE       0x00000100
#define EF_MIPS_ABI             0x0000f000
#define EF_MIPS_FP64      0x00000200
#define EF_MIPS_NAN2008   0x00000400
#define EF_MIPS_ARCH      0xf0000000 /* MIPS architecture level. */ <--- TH=
E RIGHT POSITION



> From: Aleksandar Markovic
> Sent: Wednesday, August 1, 2018 8:51 PM
>=20
> Hi, Laurent.
>=20
> > From: Laurent Vivier <laurent@vivier.eu>
> > Sent: Monday, July 30, 2018 6:49 PM
> >
> > Le 30/07/2018 =E0 18:11, Aleksandar Markovic a =E9crit :
> > > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> > >
> > > Remove duplicate preprocessor constant definition for EF_MIPS_ARCH.
> > >
> > > The duplicate was introduced in commit 45506bdd.
> > >
> > > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > > ---
> > >  include/elf.h | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/include/elf.h b/include/elf.h
> > > index 934dbbd..c8aaa2a 100644
> > > --- a/include/elf.h
> > > +++ b/include/elf.h
> > > @@ -33,7 +33,6 @@ typedef int64_t  Elf64_Sxword;
> > >
> > >  /* Flags in the e_flags field of the header */
> > >  /* MIPS architecture level. */
> > > -#define EF_MIPS_ARCH            0xf0000000
> > >
> > >  /* Legal values for MIPS architecture level.  */
> > >  #define EF_MIPS_ARCH_1               0x00000000      /* -mips1 code.=
  */
> > >
> >
> > You should move the comment "MIPS architecture level" where the other
> > EF_MIPS_ARCH is defined (see glibc or system elf.h).
> >
> > Thanks,
> > Laurent
>=20
> The comment "/* MIPS architecture level */" was present both before and a=
fter the commit 45506bdd. The scope of this patch is to rollback a duplicat=
e preprocessor definition originating from the commit 45506bdd. This means =
that moving/modifying comments should not be in this patch. Can you please =
clarify for me what additional changes you suggest (but these should defini=
tely be in a separate patch)? Do you want to sync this segment of QEMU's el=
f.h (copied below) with glibc corresponding section from its elf.h (also be=
low)?
>=20
> QEMU's elf.h:
>=20
> /* MIPS architecture level. */
> #define EF_MIPS_ARCH            0xf0000000 <----------------- duplicate
>=20
> /* Legal values for MIPS architecture level.  */
> #define EF_MIPS_ARCH_1          0x00000000      /* -mips1 code.  */
> #define EF_MIPS_ARCH_2          0x10000000      /* -mips2 code.  */
> #define EF_MIPS_ARCH_3          0x20000000      /* -mips3 code.  */
> #define EF_MIPS_ARCH_4          0x30000000      /* -mips4 code.  */
> #define EF_MIPS_ARCH_5          0x40000000      /* -mips5 code.  */
> #define EF_MIPS_ARCH_32         0x50000000      /* MIPS32 code.  */
> #define EF_MIPS_ARCH_64         0x60000000      /* MIPS64 code.  */
> #define EF_MIPS_ARCH_32R2       0x70000000      /* MIPS32r2 code.  */
> #define EF_MIPS_ARCH_64R2       0x80000000      /* MIPS64r2 code.  */
> #define EF_MIPS_ARCH_32R6       0x90000000      /* MIPS32r6 code.  */
> #define EF_MIPS_ARCH_64R6       0xa0000000      /* MIPS64r6 code.  */
>=20
> /* The ABI of a file. */
> #define EF_MIPS_ABI_O32         0x00001000      /* O32 ABI.  */
> #define EF_MIPS_ABI_O64         0x00002000      /* O32 extended for 64 bi=
t.  */
>=20
> #define EF_MIPS_NOREORDER 0x00000001
> #define EF_MIPS_PIC       0x00000002
> #define EF_MIPS_CPIC      0x00000004
> #define EF_MIPS_ABI2            0x00000020
> #define EF_MIPS_OPTIONS_FIRST   0x00000080
> #define EF_MIPS_32BITMODE       0x00000100
> #define EF_MIPS_ABI             0x0000f000
> #define EF_MIPS_FP64      0x00000200
> #define EF_MIPS_NAN2008   0x00000400
> #define EF_MIPS_ARCH      0xf0000000
>=20
>=20
> glibc's elf.h:
>=20
> /* Legal values for e_flags field of Elf32_Ehdr.  */
>=20
> #define EF_MIPS_NOREORDER       1     /* A .noreorder directive was used.=
  */
> #define EF_MIPS_PIC             2     /* Contains PIC code.  */
> #define EF_MIPS_CPIC            4     /* Uses PIC calling sequence.  */
> #define EF_MIPS_XGOT            8
> #define EF_MIPS_64BIT_WHIRL     16
> #define EF_MIPS_ABI2            32
> #define EF_MIPS_ABI_ON32        64
> #define EF_MIPS_FP64            512  /* Uses FP64 (12 callee-saved).  */
> #define EF_MIPS_NAN2008 1024  /* Uses IEEE 754-2008 NaN encoding.  */
> #define EF_MIPS_ARCH            0xf0000000 /* MIPS architecture level.  *=
/
>=20
> /* Legal values for MIPS architecture level.  */
>=20
> #define EF_MIPS_ARCH_1          0x00000000 /* -mips1 code.  */
> #define EF_MIPS_ARCH_2          0x10000000 /* -mips2 code.  */
> #define EF_MIPS_ARCH_3          0x20000000 /* -mips3 code.  */
> #define EF_MIPS_ARCH_4          0x30000000 /* -mips4 code.  */
> #define EF_MIPS_ARCH_5          0x40000000 /* -mips5 code.  */
> #define EF_MIPS_ARCH_32         0x50000000 /* MIPS32 code.  */
> #define EF_MIPS_ARCH_64         0x60000000 /* MIPS64 code.  */
> #define EF_MIPS_ARCH_32R2       0x70000000 /* MIPS32r2 code.  */
> #define EF_MIPS_ARCH_64R2       0x80000000 /* MIPS64r2 code.  */
>=20
>=20
> Regards,
> Aleksandar

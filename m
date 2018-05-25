Received: from eggs.gnu.org ([2001:4830:134:3::10]:57733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fM6z6-0006Ca-R4
	for qemu-devel@nongnu.org; Fri, 25 May 2018 03:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fM6z5-0005Bv-Fp
	for qemu-devel@nongnu.org; Fri, 25 May 2018 03:17:56 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:38752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fM6z5-0005Bk-6G
	for qemu-devel@nongnu.org; Fri, 25 May 2018 03:17:55 -0400
Received: by mail-ot0-x242.google.com with SMTP id n3-v6so4998230ota.5
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 00:17:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55782969-dd50-ae80-8006-ed53c3d48ca5@vivier.eu>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-28-git-send-email-mjc@sifive.com>
	<55782969-dd50-ae80-8006-ed53c3d48ca5@vivier.eu>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 25 May 2018 19:17:54 +1200
Message-ID: <CAHNT7NtKt4iX5Vh=sc3T7cfo36XPK0G=p1_mM=2A3zNp-ggWXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 27/30] elf: Add RISC-V PSABI ELF header
 defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Michael Tokarev <mjt@tls.msk.ru>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <Alistair.Francis@wdc.com>

On Wed, May 23, 2018 at 6:44 PM, Laurent Vivier <laurent@vivier.eu> wrote:

> Le 23/05/2018 =C3=A0 02:15, Michael Clark a =C3=A9crit :
> > Refer to the RISC-V PSABI specification for details:
> >
> > - https://github.com/riscv/riscv-elf-psabi-doc/blob/master/riscv-elf.md
> >
> > Cc: Michael Tokarev <mjt@tls.msk.ru>
> > Cc: Laurent Vivier <laurent@vivier.eu>
> > Cc: Richard Henderson <richard.henderson@linaro.org>
> > Cc: Alistair Francis <Alistair.Francis@wdc.com>
> > Signed-off-by: Michael Clark <mjc@sifive.com>
> > ---
> >  include/elf.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/include/elf.h b/include/elf.h
> > index 934dbbd6b3ae..d363ba85a688 100644
> > --- a/include/elf.h
> > +++ b/include/elf.h
> > @@ -1285,6 +1285,14 @@ typedef struct {
> >  #define R_IA64_DTPREL64LSB   0xb7    /* @dtprel(sym + add), data8 LSB =
*/
> >  #define R_IA64_LTOFF_DTPREL22        0xba    /* @ltoff(@dtprel(s+a)),
> imm22 */
> >
> > +/* RISC-V specific definitions.  */
> > +#define EF_RISCV_RVC 0x0001
> > +#define EF_RISCV_FLOAT_ABI_SINGLE 0x0002
> > +#define EF_RISCV_FLOAT_ABI_DOUBLE 0x0004
> > +#define EF_RISCV_FLOAT_ABI_QUAD (0x0006
>                                    ^
> Typo here -------------------------|
>

Thanks! My mistake.

The original patch had only EF_RISCV_RVE, which is the define we need for a
subsequent patch, however I decided to add the remaining flags from the
spec and indeed there was a paren in the spec.

I'll respin this as a separate patch.

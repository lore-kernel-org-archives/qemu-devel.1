Received: from eggs.gnu.org ([2001:4830:134:3::10]:51797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fM8z1-00013h-Tr
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fM8z0-00026f-Cd
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:25:59 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:46615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fM8z0-000266-5t
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:25:58 -0400
Received: by mail-ot0-x243.google.com with SMTP id t1-v6so5313366ott.13
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 02:25:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4926fd94-b29b-8dad-bbdb-e19729bfa39f@vivier.eu>
References: <1527232960-51123-1-git-send-email-mjc@sifive.com>
	<4926fd94-b29b-8dad-bbdb-e19729bfa39f@vivier.eu>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 25 May 2018 21:25:57 +1200
Message-ID: <CAHNT7NvTAh9iWPvJaaH+Jr8wbtyp5JOvDCaGvnMqugwHvRfy1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] elf: Add RISC-V PSABI ELF header defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-trivial@nongnu.org, RISC-V Patches <patches@groups.riscv.org>, Michael Tokarev <mjt@tls.msk.ru>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <Alistair.Francis@wdc.com>, Jim Wilson <jimw@sifive.com>

On Fri, May 25, 2018 at 7:53 PM, Laurent Vivier <laurent@vivier.eu> wrote:

> Le 25/05/2018 =C3=A0 09:22, Michael Clark a =C3=A9crit :
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
> > index 934dbbd6b3ae..bd0493f43d19 100644
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
> > +#define EF_RISCV_FLOAT_ABI_QUAD 0x0006
> > +#define EF_RISCV_RVE 0x0008
> > +#define EF_RISCV_TSO 0x0010
> > +
> >  typedef struct elf32_rel {
> >    Elf32_Addr r_offset;
> >    Elf32_Word r_info;
> >
>
> from glibc (and binutils), I have:
>
>   /* RISC-V ELF Flags */
>   #define EF_RISCV_RVC                    0x0001
>   #define EF_RISCV_FLOAT_ABI              0x0006
>   #define EF_RISCV_FLOAT_ABI_SOFT         0x0000
>   #define EF_RISCV_FLOAT_ABI_SINGLE       0x0002
>   #define EF_RISCV_FLOAT_ABI_DOUBLE       0x0004
>   #define EF_RISCV_FLOAT_ABI_QUAD         0x0006
>
> Perhaps you can also define EF_RISCV_FLOAT_ABI_SOFT and EF_RISCV_FLOAT_AB=
I?
>

Will do. I'll align them also.

Anyway:
>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>
>
Thanks for checking glibc and binutils. I'll update to add the extra
definitions before I make a PR. Thanks!

Michael.

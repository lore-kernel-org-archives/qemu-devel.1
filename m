Received: from eggs.gnu.org ([2001:4830:134:3::10]:32907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <malbarbo@gmail.com>) id 1eZi2B-0004t9-Fx
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <malbarbo@gmail.com>) id 1eZi2A-0000OO-Em
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:57:03 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Qo8uQ10FHP7XfuC+sgb4i8e_fxo7EvZGtVVWddqpxVA@mail.gmail.com>
References: <20180111183714.22834-2-malbarbo@gmail.com>
	<CAFEAcA9Qo8uQ10FHP7XfuC+sgb4i8e_fxo7EvZGtVVWddqpxVA@mail.gmail.com>
From: Marco A L Barbosa <malbarbo@gmail.com>
Date: Thu, 11 Jan 2018 16:56:58 -0200
Message-ID: <CAHpsRN8rkMpcNmwwjpDFD3LDogZzCUqbitH-fHHWomc+GupLKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Add AT_SECURE auxval
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <Laurent@vivier.eu>

Thanks Peter,

Signed-off-by: Marco A L Barbosa <malbarbo@gmail.com>

On Thu, Jan 11, 2018 at 4:52 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 11 January 2018 at 18:37, Marco A L Barbosa <malbarbo@gmail.com> wrote:
> > ---
> >  linux-user/elfload.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> This is missing your Signed-off-by: line, which we need to be
> able to accept the patch.
>
> (I've also cc'd the linux-user maintainers.)
>
> > diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> > index 20f3d8c2c3..32a47674e6 100644
> > --- a/linux-user/elfload.c
> > +++ b/linux-user/elfload.c
> > @@ -1354,7 +1354,7 @@ struct exec
> >                                   ~(abi_ulong)(TARGET_ELF_EXEC_
> PAGESIZE-1))
> >  #define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE-1))
> >
> > -#define DLINFO_ITEMS 14
> > +#define DLINFO_ITEMS 15
> >
> >  static inline void memcpy_fromfs(void * to, const void * from, unsigned
> long n)
> >  {
> > @@ -1786,6 +1786,7 @@ static abi_ulong create_elf_tables(abi_ulong p,
> int argc, int envc,
> >      NEW_AUX_ENT(AT_HWCAP, (abi_ulong) ELF_HWCAP);
> >      NEW_AUX_ENT(AT_CLKTCK, (abi_ulong) sysconf(_SC_CLK_TCK));
> >      NEW_AUX_ENT(AT_RANDOM, (abi_ulong) u_rand_bytes);
> > +    NEW_AUX_ENT(AT_SECURE, (abi_ulong) qemu_getauxval(AT_SECURE));
> >
> >  #ifdef ELF_HWCAP2
> >      NEW_AUX_ENT(AT_HWCAP2, (abi_ulong) ELF_HWCAP2);
> > --
>
> For the content, Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> thanks
> -- PMM
>



-- 
Marco A L Barbosa
http://malbarbo.pro.br
--

Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B5BC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 863BD2086A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="golW2RMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863BD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8rA6-0003Tm-Nt
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 14:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuanzi@google.com>) id 1j8r9N-0002ic-Ay
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:54:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuanzi@google.com>) id 1j8r9M-0007Tm-0s
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:54:49 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuanzi@google.com>) id 1j8r9L-0007TD-Pz
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:54:47 -0500
Received: by mail-oi1-x241.google.com with SMTP id v19so441715oic.12
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 11:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bHIo6qnClAR+iMy8cEUG59UjFII6pb5wsYL2Zu81ya4=;
 b=golW2RMrG2tBH5CFfsuC3nF96GE0R414iFqOoCGCPh2GlAXux1DQopS6iJHq0NiH1M
 wLL97MAJtSq5mspzT1XgN1ipod+NXbAvVLzOWCf5F5/X2klIA6V0HGrjXyck6qgZ62sx
 Wls9KtJ2chugzE69vxtHk7NKQjuBGAUjGRAc2owLnO+yBVMrgI11CA6TU3fOnaqyfF9Z
 e9Zxau6VplOgB7aVWT/bHAV2MNh5boOpCPyZMhMbz5Dxr8gtxMgrT9T2rwdGYmBfKuvw
 OSCHJtGx/FY570S/8CbbEKhpXKZJ0zdAwJoFKfOGohDAVkoBR+pfPjfXqlznwtINrmUU
 zdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bHIo6qnClAR+iMy8cEUG59UjFII6pb5wsYL2Zu81ya4=;
 b=AGRJtvCc30qgOSQVQPl7UJZ7lfNkvZDFg9fq/YfO3UplpnByJcj1/nI5fgmQwAicbt
 zppFO+3zpzIdcl1BfLQOcIyNe6uM+MWvCRGNcHWXEnjfx1UNODKkWPY0ac0MwZqDyxmz
 nd1N52/Mm9rPnZe/wuPDixtvDfuYrGkGaLuC7dpYLFWKk08Qen/5UA7SH2KnXlVVaH4k
 8hNXCiCFviBq9Et8fGGXqNHTo6ia2Nc2cbhmyNl2RWkD/rJyuh2/r/ZRgYkiguLfTE0s
 tBY/dhQewkRSlA7FcJIOa/yaWN/l20CZwoTCbA+la0SFmbxbFn2AmxUt3dB+d9N0GtBS
 SbwA==
X-Gm-Message-State: ANhLgQ2zzEIIE6CFtsYtx1rcuk1WeSWef4r2G/cBsIQ65De5XJpXw2Pa
 tC0I/OwnSeJEvnjff/a/YVle6YNh8rz4tKzKmXaAWA==
X-Google-Smtp-Source: ADFU+vt2BKi8l6Bj7HvIygAC65sbB7DzWuBdotVZvhkMn2k5MK/loisUC/ECMhlBhFFqIj3emiCGq2j+pqhFbNIaAoY=
X-Received: by 2002:aca:62c4:: with SMTP id w187mr76148oib.38.1583178876049;
 Mon, 02 Mar 2020 11:54:36 -0800 (PST)
MIME-Version: 1.0
References: <20200221202857.126170-1-yuanzi@google.com>
 <f9ef0046-9d0f-c53d-bf58-417df31705a6@vivier.eu>
 <CADjx4C+YyTL9W0us5-vvGdeXyiHKcSZt2odV_p3+E4NCLTYSSg@mail.gmail.com>
 <66e63949-7224-8bed-afb5-d914ac5969bc@vivier.eu>
In-Reply-To: <66e63949-7224-8bed-afb5-d914ac5969bc@vivier.eu>
From: Lirong Yuan <yuanzi@google.com>
Date: Mon, 2 Mar 2020 11:54:21 -0800
Message-ID: <CADjx4CL3kXtc4ZvCz7Z+pL5=pMr-e9AcGg1o9+TYt7yh0zB34w@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Add AT_EXECFN and AT_EXECFD auxval
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Riku Voipio <riku.voipio@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

On Mon, Mar 2, 2020 at 10:31 AM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 02/03/2020 =C3=A0 19:18, Lirong Yuan a =C3=A9crit :
> > On Mon, Mar 2, 2020 at 6:39 AM Laurent Vivier <laurent@vivier.eu> wrote=
:
> >>
> >> Le 21/02/2020 =C3=A0 21:28, Lirong Yuan a =C3=A9crit :
> >>> This change adds the support for AT_EXECFN and AT_EXECFD auxval.
> >>
> >> Why do we need AT_EXECFD?
> >>
> >> AT_EXECFD is normally only used with binfmt_misc so I don't see any us=
e
> >> cases for it with QEMU.
> >>
> >> For AT_EXECFN, according to kernel commit
> >>
> >>   651910874633 execve filename: document and export via auxiliary vect=
or
> >>
> >> It sould be like readlink("/proc/self/exe",), and thus I think we shou=
ld
> >> use realpath() like we have in syscall.c for TARGET_NR_readlink:
> >>
> >>  8843     case TARGET_NR_readlink:
> >> ...
> >>  8854                 char real[PATH_MAX], *temp;
> >>  8855                 temp =3D realpath(exec_path, real);
> >> ...
> >>
> >> Thanks,
> >> Laurent
> >>
> >>>
> >>> Signed-off-by: Lirong Yuan <yuanzi@google.com>
> >>> ---
> >>>  linux-user/elfload.c | 13 +++++++++----
> >>>  1 file changed, 9 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> >>> index f3080a1635..7e0f3042f1 100644
> >>> --- a/linux-user/elfload.c
> >>> +++ b/linux-user/elfload.c
> >>> @@ -1568,7 +1568,7 @@ struct exec
> >>>                                   ~(abi_ulong)(TARGET_ELF_EXEC_PAGESI=
ZE-1))
> >>>  #define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE-=
1))
> >>>
> >>> -#define DLINFO_ITEMS 15
> >>> +#define DLINFO_ITEMS 17
> >>>
> >>>  static inline void memcpy_fromfs(void * to, const void * from, unsig=
ned long n)
> >>>  {
> >>> @@ -1888,11 +1888,14 @@ static abi_ulong loader_build_fdpic_loadmap(s=
truct image_info *info, abi_ulong s
> >>>      return sp;
> >>>  }
> >>>
> >>> -static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
> >>> +static abi_ulong create_elf_tables(struct linux_binprm *bprm,
> >>>                                     struct elfhdr *exec,
> >>>                                     struct image_info *info,
> >>>                                     struct image_info *interp_info)
> >>>  {
> >>> +    abi_ulong p =3D bprm->p;
> >>> +    int argc =3D bprm->argc;
> >>> +    int envc =3D bprm->envc;
> >>>      abi_ulong sp;
> >>>      abi_ulong u_argc, u_argv, u_envp, u_auxv;
> >>>      int size;
> >>> @@ -2032,6 +2035,8 @@ static abi_ulong create_elf_tables(abi_ulong p,=
 int argc, int envc,
> >>>      NEW_AUX_ENT(AT_CLKTCK, (abi_ulong) sysconf(_SC_CLK_TCK));
> >>>      NEW_AUX_ENT(AT_RANDOM, (abi_ulong) u_rand_bytes);
> >>>      NEW_AUX_ENT(AT_SECURE, (abi_ulong) qemu_getauxval(AT_SECURE));
> >>> +    NEW_AUX_ENT(AT_EXECFN, info->file_string);
> >>> +    NEW_AUX_ENT(AT_EXECFD, bprm->fd);
> >>>
> >>>  #ifdef ELF_HWCAP2
> >>>      NEW_AUX_ENT(AT_HWCAP2, (abi_ulong) ELF_HWCAP2);
> >>> @@ -2870,8 +2875,8 @@ int load_elf_binary(struct linux_binprm *bprm, =
struct image_info *info)
> >>>  #endif
> >>>      }
> >>>
> >>> -    bprm->p =3D create_elf_tables(bprm->p, bprm->argc, bprm->envc, &=
elf_ex,
> >>> -                                info, (elf_interpreter ? &interp_inf=
o : NULL));
> >>> +    bprm->p =3D create_elf_tables(bprm, &elf_ex, info,
> >>> +                                (elf_interpreter ? &interp_info : NU=
LL));
> >>>      info->start_stack =3D bprm->p;
> >>>
> >>>      /* If we have an interpreter, set that as the program's entry po=
int.
> >>>
> >>
> >
> > Hi Laurent,
>
> Hi Lirong,
>
> > I added support for AT_EXECFD because I thought it might be useful to
> > implement all types that getauxval could take as an argument.
> > Would you prefer that it be removed?
>
> I think providing the AT_EXECFD to the target binary could make it think
> it has been run directly by binfmt_misc (as an interpreter itself), and
> that is not the case (qemu is run by binfmt_misc and is the interpreter).
>
> So I would prefer you remove it.
>
> > For AT_EXECFN, there are two questions that we considered:
> > 1) What should it return?
> > Since QEMU is emulating running the guest program, the function should
> > return the file name of the guest program (info->file_string), rather
> > than the QEMU program itself, which we get from
> > qemu_getauxval(AT_EXECFN).
> >
> > 2) Should it return the full path or as is?
> > We tested the behavior of getauxval with a simple test program on
> > Linux, and it turned out that it returned file path as is. For
> > example,
> > $ ./test
> > getauxval(AT_EXECFN): ./test
> > $ /usr/local/home/tmp/test
> > getauxval(AT_EXECFN): /usr/local/home/tmp/test
>
> If you have compared the result with the real one it's fine for me.
>
> Resend tou patch without the AT_EXECFD part and it will be good.
>
> Thanks,
> Laurent
>

Hi Laurent,

Thank you so much for the review! :)

Resent the v2 patch without AT_EXECFD:
http://patchwork.ozlabs.org/patch/1247861/

Thanks,
Lirong


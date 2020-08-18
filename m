Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E22C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 21:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032CE206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 21:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X74Aj3MH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032CE206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k89Oc-0006oW-7m
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 17:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aladjev.andrew@gmail.com>)
 id 1k89Ny-0006Ow-0h
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 17:43:14 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aladjev.andrew@gmail.com>)
 id 1k89Nv-0006BN-US
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 17:43:13 -0400
Received: by mail-pl1-x641.google.com with SMTP id f10so9820481plj.8
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PCD59d29WIiC84VhIihOkT4O9NqbJNxzbijtttnHBfQ=;
 b=X74Aj3MH10ws2l3qymu1DFVjKdgRCAGYPUzW6wFT6+/4o9PYTfgFHFBOtEL0IHJ1qK
 Yvg3HxWimDOVtYw5nEOtw8vyEYQpVnzjRGWnTFHiB2wsTd5COS1Yz74EmC7LOZc15ZVV
 4hvVnERB07n5XSV7uBQ0cy5aMUMmyvAmlgFJm8fLNhJt6pDZpF6Lb1Ak/zW1lHAI7KXq
 dbEI7lBdnHvlZRW3z/jSyUfqrvqFaDigkJFZtksJaEd0Dha8tqiO8lit5D5206CUUZbT
 1FvuJoHWoIz4JstA2gNh7RcrcZTFaSG+AjnjwZM6tnITNUze/QbnDFguAAiM5KZ2q7jL
 JDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PCD59d29WIiC84VhIihOkT4O9NqbJNxzbijtttnHBfQ=;
 b=DAQL/+vnEjhZeitIFNjrcFBtbKt+gk02Gda8tMQJPWyB4KcHqb5h/8GGEKziWXJKwL
 MxAUbJaxvDQwIf/8mdgxymi3IZctwMgF4BXh1p+ZJ5TcET9W6A7uhvoo49YtcDtv+vgw
 csNLWjY1a9vDNsQk2U6+EEUyM94r4nK49YMFEV+XQmSLEvjSK0NTv/aFMj6LNacynpud
 aHfhxf5UuN2JBZaYTccgaka2QtmorfxwmGOYIjRooDERQnamIaOmKzzkPEbGXVGynTE6
 2SRjLi1CY8wbC/7wG+UxMiZpLCwZEv5IXnDwyBm42a3XYsclotXcp7OEBC9e1AUpMpLw
 bEDw==
X-Gm-Message-State: AOAM530V4crVppbzRsnqBbZKHgZpzfmrKEJjSK8iIzrtFcDZQnf4Wn8a
 9InFT9UklCJSDAa8LCIfkV/XdbqXGJN7BzKcTmD1Zq7k4pFS0Q==
X-Google-Smtp-Source: ABdhPJyeOcOaFMEp0odNsERLwHBRN2kgrQQctvz78VS+ZAOZbgmAr81sPLCZ05UOjf0Hx8rnKXLMIvOwY6891Gp7iA8=
X-Received: by 2002:a17:902:523:: with SMTP id
 32mr16146477plf.176.1597786990444; 
 Tue, 18 Aug 2020 14:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200817235712.10957-1-aladjev.andrew@gmail.com>
 <6caa924e-364d-4e5c-f494-424dc81d8ada@vivier.eu>
In-Reply-To: <6caa924e-364d-4e5c-f494-424dc81d8ada@vivier.eu>
From: =?UTF-8?B?0JDQvdC00YDQtdC5INCQ0LvQsNC00YzQtdCy?=
 <aladjev.andrew@gmail.com>
Date: Wed, 19 Aug 2020 00:42:59 +0300
Message-ID: <CAMw0szJznjSp_3-hj_JQEQd_nkOWgwkrZ7jXLJ8j2_3GPW2Uvg@mail.gmail.com>
Subject: Re: [PATCH 1/3] linux user: make execfd global (like exec path) and
 keep it open
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="000000000000fe089405ad2dc5a7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=aladjev.andrew@gmail.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fe089405ad2dc5a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello. I want to explain situation we have in qemu today.
It looks simple, but gives complex problems.

Please open "linux-user/main.c":

execfd =3D qemu_getauxval(AT_EXECFD);
if (execfd =3D=3D 0) {
  execfd =3D open(exec_path, O_RDONLY);
  if (execfd < 0) { ... }
}
...
close(execfd);

We may take AT_EXECFD and than close it.
After that AT_EXECFD will store closed fd.
Kernel doesn't block closing of AT_EXECFD.

Same problem exists in linux-user/syscall.c:

if (is_proc_myself(pathname, "exe")) {
  int execfd =3D qemu_getauxval(AT_EXECFD);
  return execfd ? execfd : safe_openat(dirfd, exec_path, flags, mode);
}

We are providing AT_EXECFD value for user and he closes it.
Than we are providing same AT_EXECFD value once again.
This fd has already been closed.

I've just re-analyzed patch and agree with you that dup/clone will be
broken.
We shouldn't provide global execfd.
So these patches are wrong.

I am going to create new patches tomorrow.
It will block closing of AT_EXECFD and remove additional AT_EXECFD usage.
I will try to add several tests for this functionality.

Thank you.

=D0=B2=D1=82, 18 =D0=B0=D0=B2=D0=B3. 2020 =D0=B3. =D0=B2 18:23, Laurent Viv=
ier <laurent@vivier.eu>:

> Le 18/08/2020 =C3=A0 01:57, Andrew Aladjev a =C3=A9crit :
> > User opens /proc/self/exe symlink, than kernel should create
> /proc/self/fd/<execfd> symlink. We should be able to detect both exe and
> fd/<execfd> symlinks to provide common behaviour. The easiest solution is
> to make execfd global and keep it open. This solution looks acceptable
> because exec_path is already global.
> >
> > Signed-off-by: Andrew Aladjev <aladjev.andrew@gmail.com>
> > ---
> >  linux-user/elfload.c |  3 ++-
> >  linux-user/exit.c    |  7 +++++--
> >  linux-user/main.c    |  2 +-
> >  linux-user/qemu.h    |  1 +
> >  linux-user/syscall.c | 18 ++++++++++++++----
> >  5 files changed, 23 insertions(+), 8 deletions(-)
> >
> > diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> > index fe9dfe795d..dfaf937ab9 100644
> > --- a/linux-user/elfload.c
> > +++ b/linux-user/elfload.c
> > @@ -2363,6 +2363,7 @@ void probe_guest_base(const char *image_name,
> abi_ulong guest_loaddr,
> >
> >     IMAGE_NAME is the filename of the image, to use in error messages.
> >     IMAGE_FD is the open file descriptor for the image.
> > +   WARNING: IMAGE_FD won't be closed.
> >
> >     BPRM_BUF is a copy of the beginning of the file; this of course
> >     contains the elf file header at offset 0.  It is assumed that this
> > @@ -2632,7 +2633,6 @@ static void load_elf_image(const char *image_name=
,
> int image_fd,
> >
> >      mmap_unlock();
> >
> > -    close(image_fd);
> >      return;
> >
> >   exit_read:
> > @@ -2666,6 +2666,7 @@ static void load_elf_interp(const char *filename,
> struct image_info *info,
> >      }
> >
> >      load_elf_image(filename, fd, info, NULL, bprm_buf);
> > +    close(fd);
> >      return;
> >
> >   exit_perror:
> > diff --git a/linux-user/exit.c b/linux-user/exit.c
> > index 1594015444..f0626fc432 100644
> > --- a/linux-user/exit.c
> > +++ b/linux-user/exit.c
> > @@ -28,12 +28,15 @@ extern void __gcov_dump(void);
> >
> >  void preexit_cleanup(CPUArchState *env, int code)
> >  {
> > +    close(execfd);
> > +
> >  #ifdef CONFIG_GPROF
> >          _mcleanup();
> >  #endif
> >  #ifdef CONFIG_GCOV
> >          __gcov_dump();
> >  #endif
> > -        gdb_exit(env, code);
> > -        qemu_plugin_atexit_cb();
> > +
> > +    gdb_exit(env, code);
> > +    qemu_plugin_atexit_cb();
> >  }
> > diff --git a/linux-user/main.c b/linux-user/main.c
> > index 75c9785157..27644a831a 100644
> > --- a/linux-user/main.c
> > +++ b/linux-user/main.c
> > @@ -49,6 +49,7 @@
> >  #include "crypto/init.h"
> >
> >  char *exec_path;
> > +int execfd;
> >
> >  int singlestep;
> >  static const char *argv0;
> > @@ -629,7 +630,6 @@ int main(int argc, char **argv, char **envp)
> >      int target_argc;
> >      int i;
> >      int ret;
> > -    int execfd;
> >      int log_mask;
> >      unsigned long max_reserved_va;
> >
> > diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> > index 5c964389c1..f99be78d42 100644
> > --- a/linux-user/qemu.h
> > +++ b/linux-user/qemu.h
> > @@ -156,6 +156,7 @@ typedef struct TaskState {
> >  } __attribute__((aligned(16))) TaskState;
> >
> >  extern char *exec_path;
> > +extern int execfd;
> >  void init_task_state(TaskState *ts);
> >  void task_settid(TaskState *);
> >  void stop_all_tasks(void);
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 945fc25279..5741c72733 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -7613,8 +7613,7 @@ static int do_openat(void *cpu_env, int dirfd,
> const char *pathname, int flags,
> >      };
> >
> >      if (is_proc_myself(pathname, "exe")) {
> > -        int execfd =3D qemu_getauxval(AT_EXECFD);
> > -        return execfd ? execfd : safe_openat(dirfd, exec_path, flags,
> mode);
> > +        return execfd;
> >      }
> >
> >      for (fake_open =3D fakes; fake_open->filename; fake_open++) {
> > @@ -7872,8 +7871,19 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
> >          return ret;
> >  #endif
> >      case TARGET_NR_close:
> > -        fd_trans_unregister(arg1);
> > -        return get_errno(close(arg1));
> > +        {
> > +            int fd =3D arg1;
> > +            if (fd =3D=3D execfd) {
> > +                /*
> > +                 * We don't need to close execfd.
> > +                 * It will be closed on QEMU exit.
> > +                 */
> > +                return 0;
> > +            }
>
> Why do you prevent the user to close it?
>
> It's his own responsability if he breaks something.
>
> And for instance, doing that breaks a call to dup() if it was done on
> purpose.
>
> Except that, the patch looks good.
>
> Thanks,
> Laurent
>

--000000000000fe089405ad2dc5a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello. I want to explain situation we have in qemu today.<=
div>It looks simple, but gives complex problems.</div><div><br></div><div>P=
lease open &quot;linux-user/main.c&quot;:</div><div><br></div><div>execfd =
=3D qemu_getauxval(AT_EXECFD);<br>if (execfd =3D=3D 0) {<br>=C2=A0 execfd =
=3D open(exec_path, O_RDONLY);<br>=C2=A0 if (execfd &lt; 0) { ... }<br>}<br=
></div><div>...</div><div>close(execfd);</div><div><br></div><div>We may ta=
ke AT_EXECFD=C2=A0and than close it.</div><div>After that AT_EXECFD will st=
ore closed fd.<br></div><div>Kernel doesn&#39;t block closing of=C2=A0AT_EX=
ECFD.</div><div><br></div><div>Same problem exists in linux-user/syscall.c:=
</div><div><br></div><div>if (is_proc_myself(pathname, &quot;exe&quot;)) {<=
br>=C2=A0 int execfd =3D qemu_getauxval(AT_EXECFD);<br>=C2=A0 return execfd=
 ? execfd : safe_openat(dirfd, exec_path, flags, mode);<br>}<br></div><div>=
<br></div><div>We are providing=C2=A0AT_EXECFD value for user and he closes=
 it.</div><div>Than we are providing same=C2=A0AT_EXECFD value once again.<=
/div><div>This fd has already been closed.</div><div><br></div><div>I&#39;v=
e just re-analyzed patch and agree with you that dup/clone will be broken.<=
/div><div>We shouldn&#39;t provide global execfd.</div><div>So these patche=
s are wrong.</div><div><br></div><div>I am going to create new=C2=A0patches=
 tomorrow.</div><div>It will block closing of=C2=A0AT_EXECFD and=C2=A0remov=
e additional=C2=A0AT_EXECFD usage.</div><div>I will try to add several test=
s for this functionality.</div><div><br></div><div>Thank you.</div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=B2=
=D1=82, 18 =D0=B0=D0=B2=D0=B3. 2020 =D0=B3. =D0=B2 18:23, Laurent Vivier &l=
t;<a href=3D"mailto:laurent@vivier.eu">laurent@vivier.eu</a>&gt;:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Le 18/08/2020 =C3=A0 01:5=
7, Andrew Aladjev a =C3=A9crit=C2=A0:<br>
&gt; User opens /proc/self/exe symlink, than kernel should create /proc/sel=
f/fd/&lt;execfd&gt; symlink. We should be able to detect both exe and fd/&l=
t;execfd&gt; symlinks to provide common behaviour. The easiest solution is =
to make execfd global and keep it open. This solution looks acceptable beca=
use exec_path is already global.<br>
&gt; <br>
&gt; Signed-off-by: Andrew Aladjev &lt;<a href=3D"mailto:aladjev.andrew@gma=
il.com" target=3D"_blank">aladjev.andrew@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 linux-user/elfload.c |=C2=A0 3 ++-<br>
&gt;=C2=A0 linux-user/exit.c=C2=A0 =C2=A0 |=C2=A0 7 +++++--<br>
&gt;=C2=A0 linux-user/main.c=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 linux-user/qemu.h=C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 linux-user/syscall.c | 18 ++++++++++++++----<br>
&gt;=C2=A0 5 files changed, 23 insertions(+), 8 deletions(-)<br>
&gt; <br>
&gt; diff --git a/linux-user/elfload.c b/linux-user/elfload.c<br>
&gt; index fe9dfe795d..dfaf937ab9 100644<br>
&gt; --- a/linux-user/elfload.c<br>
&gt; +++ b/linux-user/elfload.c<br>
&gt; @@ -2363,6 +2363,7 @@ void probe_guest_base(const char *image_name, ab=
i_ulong guest_loaddr,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0IMAGE_NAME is the filename of the image, to use in =
error messages.<br>
&gt;=C2=A0 =C2=A0 =C2=A0IMAGE_FD is the open file descriptor for the image.=
<br>
&gt; +=C2=A0 =C2=A0WARNING: IMAGE_FD won&#39;t be closed.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0BPRM_BUF is a copy of the beginning of the file; th=
is of course<br>
&gt;=C2=A0 =C2=A0 =C2=A0contains the elf file header at offset 0.=C2=A0 It =
is assumed that this<br>
&gt; @@ -2632,7 +2633,6 @@ static void load_elf_image(const char *image_nam=
e, int image_fd,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 mmap_unlock();<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 close(image_fd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0exit_read:<br>
&gt; @@ -2666,6 +2666,7 @@ static void load_elf_interp(const char *filename=
, struct image_info *info,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 load_elf_image(filename, fd, info, NULL, bprm_buf)=
;<br>
&gt; +=C2=A0 =C2=A0 close(fd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0exit_perror:<br>
&gt; diff --git a/linux-user/exit.c b/linux-user/exit.c<br>
&gt; index 1594015444..f0626fc432 100644<br>
&gt; --- a/linux-user/exit.c<br>
&gt; +++ b/linux-user/exit.c<br>
&gt; @@ -28,12 +28,15 @@ extern void __gcov_dump(void);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 void preexit_cleanup(CPUArchState *env, int code)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 close(execfd);<br>
&gt; +<br>
&gt;=C2=A0 #ifdef CONFIG_GPROF<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _mcleanup();<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 #ifdef CONFIG_GCOV<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __gcov_dump();<br>
&gt;=C2=A0 #endif<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_exit(env, code);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_plugin_atexit_cb();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 gdb_exit(env, code);<br>
&gt; +=C2=A0 =C2=A0 qemu_plugin_atexit_cb();<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/linux-user/main.c b/linux-user/main.c<br>
&gt; index 75c9785157..27644a831a 100644<br>
&gt; --- a/linux-user/main.c<br>
&gt; +++ b/linux-user/main.c<br>
&gt; @@ -49,6 +49,7 @@<br>
&gt;=C2=A0 #include &quot;crypto/init.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 char *exec_path;<br>
&gt; +int execfd;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 int singlestep;<br>
&gt;=C2=A0 static const char *argv0;<br>
&gt; @@ -629,7 +630,6 @@ int main(int argc, char **argv, char **envp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int target_argc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; -=C2=A0 =C2=A0 int execfd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int log_mask;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 unsigned long max_reserved_va;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/linux-user/qemu.h b/linux-user/qemu.h<br>
&gt; index 5c964389c1..f99be78d42 100644<br>
&gt; --- a/linux-user/qemu.h<br>
&gt; +++ b/linux-user/qemu.h<br>
&gt; @@ -156,6 +156,7 @@ typedef struct TaskState {<br>
&gt;=C2=A0 } __attribute__((aligned(16))) TaskState;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 extern char *exec_path;<br>
&gt; +extern int execfd;<br>
&gt;=C2=A0 void init_task_state(TaskState *ts);<br>
&gt;=C2=A0 void task_settid(TaskState *);<br>
&gt;=C2=A0 void stop_all_tasks(void);<br>
&gt; diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
&gt; index 945fc25279..5741c72733 100644<br>
&gt; --- a/linux-user/syscall.c<br>
&gt; +++ b/linux-user/syscall.c<br>
&gt; @@ -7613,8 +7613,7 @@ static int do_openat(void *cpu_env, int dirfd, c=
onst char *pathname, int flags,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (is_proc_myself(pathname, &quot;exe&quot;)) {<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 int execfd =3D qemu_getauxval(AT_EXECFD);=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return execfd ? execfd : safe_openat(dirf=
d, exec_path, flags, mode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return execfd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 for (fake_open =3D fakes; fake_open-&gt;filename; =
fake_open++) {<br>
&gt; @@ -7872,8 +7871,19 @@ static abi_long do_syscall1(void *cpu_env, int =
num, abi_long arg1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case TARGET_NR_close:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 fd_trans_unregister(arg1);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return get_errno(close(arg1));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd =3D arg1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd =3D=3D execfd) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We do=
n&#39;t need to close execfd.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* It wi=
ll be closed on QEMU exit.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Why do you prevent the user to close it?<br>
<br>
It&#39;s his own responsability if he breaks something.<br>
<br>
And for instance, doing that breaks a call to dup() if it was done on<br>
purpose.<br>
<br>
Except that, the patch looks good.<br>
<br>
Thanks,<br>
Laurent<br>
</blockquote></div>

--000000000000fe089405ad2dc5a7--


Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A5CC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 02:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79EF420796
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 02:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNIOzzqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EF420796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF7LE-0006Ny-KD
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 22:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kF7Kb-0005yN-6g
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 22:56:33 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:37742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kF7KY-0006jz-Mi
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 22:56:32 -0400
Received: by mail-lf1-x142.google.com with SMTP id z19so6719836lfr.4
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 19:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=B+5C/oT4uUtKVDwxcRqBvIb9Ymd96Yvc+qflk8lMatc=;
 b=BNIOzzqQdGkNa6dXmv3w+B61BPc+KbPEH8/GL8HPtHW7806jjaGR1If39R5fCCL+og
 pj1xyvZXg1EvAJwqVyAOy6Vhc0TBAG8geQWJuTJOSyV7OYDeKvvsM/hx/1CcyNjbrtby
 YB1vAqrQJ3mTQzSq2LjzfoMSZXqifgX5r1Vf44CcGKmiSH6WX2u917dQ5tDjC2vUFKRM
 IQ+K5lxlgfdh2yVYbaSB8RtXG3kOGeoM+mBl7xj6KAjRnaupgsDvVtN0B0C0BrLylinE
 vdg/l0hhqJZ4bEjfp/6JbHwMTbY14qfwi4AUuLerRQGooD/DXp1tKVzdqLrNfLAIUn76
 BkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=B+5C/oT4uUtKVDwxcRqBvIb9Ymd96Yvc+qflk8lMatc=;
 b=svBRRz+IPuN62fxNq8xRk8el9TpIubhMWi+atUZ2LFoGMNK/U9FqP9H2j3DKnoLZoV
 HX9nT/njaZ45DXInc4AbXglpYE/AAsp8FUCkxPbnH/pYgQbQpbRm7pDR29Z3zLzBXk3A
 IZ82RfB7JCZ6Dqf4um+Sjl1Z0iEnc5ID9ZEXFmKwUKIcC98UE9kbuQFvRgtjE7GH55tZ
 rEspUc2ZBgeCpTuSnBha0kwNxudrzDhn53pBwUlSxJUhSZj8SIfi5zN54JKPyzu+t4h8
 ChKYcpMol+jsJJtBVjbqYwoo+RpfHEpu57mr0lwz0dPLeNsWPHoSKsPgi/6iDfWF7eLx
 Dchw==
X-Gm-Message-State: AOAM533joQdpAxkU33J5tPwyjT3MJwR/5ZipL4uqGv+6q1Z04jclDrAs
 0zdXNtBzRuaBhimIlrilcdFZ2+zh00E4Z2otUnM=
X-Google-Smtp-Source: ABdhPJww7rA1j/l/2333D0ExJeyttk+WXBwdDTZf2TloKylQuccZ1gvCNDXCFXz0Ga6dGUiB17cUPvT5vduZZnykDbo=
X-Received: by 2002:a19:c68f:: with SMTP id w137mr7616962lff.213.1599447388269; 
 Sun, 06 Sep 2020 19:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200906175344.5042-1-pbonzini@redhat.com>
 <CAFEAcA8qvZAqYHwnrkxWb8NGhgE6h=gKrXBHTDNLk+0YDxfzfQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8qvZAqYHwnrkxWb8NGhgE6h=gKrXBHTDNLk+0YDxfzfQ@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 7 Sep 2020 10:56:17 +0800
Message-ID: <CAE2XoE-nog-Y=7kku1NH2BcdG04+5FptcQxwoMXf2ZC=ytLDFw@mail.gmail.com>
Subject: Re: [PULL v2 00/46] Next round of Meson bugfixes and cleanups
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000006a2ee005aeb05dc4"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x142.google.com
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
Reply-To: luoyonggang@gmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006a2ee005aeb05dc4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2020 at 2:35 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Sun, 6 Sep 2020 at 18:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The following changes since commit
> 227de21ed0759e275a469394af72c999d0134bb5:
> >
> >   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20200903' int=
o
> staging (2020-09-05 15:30:41 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 6264b35324d3766d3c2ff369c4e8ecba8bd5b571=
:
> >
> >   meson: remove linkage of sdl to baum (2020-09-06 19:50:57 +0200)
> >
> > ----------------------------------------------------------------
> > meson related:
> > * convert unit tests
> > * bugfixes for mtest2make
> > * miscellaneous bugfixes
> > * dead code removal and configure cleanups
> > * oss-fuzz fixes
> > * msys fixes
>
> Build failure, Windows (this is the second "uint" type usage
> I've seen today...):
>
> ../../tests/test-vmstate.c: In function 'int_cmp':
> ../../tests/test-vmstate.c:884:5: error: unknown type name 'uint'
>      uint ua =3D GPOINTER_TO_UINT(a);
>      ^
> ../../tests/test-vmstate.c:885:5: error: unknown type name 'uint'
>      uint ub =3D GPOINTER_TO_UINT(b);
>      ^
>
I've already fixes this issue, that patch can be quenued

> Makefile.ninja:5443: recipe for target
> 'tests/test-vmstate.exe.p/test-vmstate.c.obj' failed
> make: *** [tests/test-vmstate.exe.p/test-vmstate.c.obj] Error 1
> make: *** Waiting for unfinished jobs....
> ../../tests/test-util-filemonitor.c: In function
> 'test_file_monitor_events':
> ../../tests/test-util-filemonitor.c:620:17: error: too many arguments
> to function 'mkdir'
>              if (mkdir(pathsrc, 0700) < 0) {
>                  ^
> In file included from
> /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/unistd.h:10:0,
>                  from
> /home/petmay01/qemu-for-merges/include/qemu/osdep.h:93,
>                  from ../../tests/test-util-filemonitor.c:21:
> /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/io.h:280:15: note:
> declared here
>    int __cdecl mkdir (const char *) __MINGW_ATTRIB_DEPRECATED_MSVC2005;
>                ^
>
>
>
> Build failure, OpenBSD:
>
> In file included from ../src/hw/arm/nseries.c:30:
> In file included from
> /home/qemu/qemu-test.yhbDti/src/include/hw/arm/omap.h:24:
> In file included from
> /home/qemu/qemu-test.yhbDti/src/include/hw/input/tsc2xxx.h:14:
> /home/qemu/qemu-test.yhbDti/src/include/ui/console.h:11:11: fatal
> error: 'epoxy/gl.h' file not found
> # include <epoxy/gl.h>
>           ^~~~~~~~~~~~
> 1 error generated.
> gmake: *** [Makefile.ninja:1735:
> libqemu-aarch64-softmmu.fa.p/hw_arm_nseries.c.o] Error 1
>
>
>
> Odd warning on most but not all of the builds, though they went on to
> complete OK:
>
> make: Entering directory '/home/peter.maydell/qemu-freebsd/build'
> /home/peter.maydell/qemu-freebsd/tests/Makefile.include:144: warning:
> overriding recipe for target 'check-block'
> Makefile.mtest:1345: warning: ignoring old recipe for target 'check-block=
'
> config-host.mak is out-of-date, running configure
> cross containers  no
>
> NOTE: guest cross-compilers enabled: aarch64-linux-gnu-gcc cc
> aarch64-linux-gnu-gcc cc
> /usr/bin/python3 /home/peter.maydell/qemu-freebsd/meson/meson.py
> --internal regenerate /home/peter.maydell/qemu-freebsd
> /home/peter.maydell/qemu-freebsd/build --backend ninja
> The Meson build system
> Version: 0.55.1
> [etc]
>
>
> x86-64 clang build failed at the link stage (this is config we've
> talked about before with
> '../../configure' '--cc=3Dclang' '--cxx=3Dclang++' '--enable-gtk'
> '--extra-cflags=3D-fsanitize=3Dundefined  -fno-sanitize=3Dshift-base
> -Werror'
> but where the clang++ doesn't work because the right libstdc++ happens
> not to be present):
>
> Linking target qemu-alpha
> libcommon.fa.p/cpus-common.c.o: In function `cpu_list_add':
> /home/petmay01/linaro/qemu-for-merges/build/clang/../../cpus-common.c:80:
> undefined reference to `__ubsan_handle_type_mismatch_v1'
> /home/petmay01/linaro/qemu-for-merges/build/clang/../../cpus-common.c:80:
> undefined reference to `__ubsan_handle_type_mismatch_v1'
> libcommon.fa.p/cpus-common.c.o: In function `cpu_get_free_index':
> /home/petmay01/linaro/qemu-for-merges/build/clang/../../cpus-common.c:68:
> undefined reference to `__ubsan_handle_type_mismatch_v1'
> /home/petmay01/linaro/qemu-for-merges/build/clang/../../cpus-common.c:68:
> undefined reference to `__ubsan_handle_type_mismatch_v1'
> /home/petmay01/linaro/qemu-for-merges/build/clang/../../cpus-common.c:67:
> undefined reference to `__ubsan_handle_type_mismatch_v1'
>
> libcommon.fa.p/cpus-common.c.o:/home/petmay01/linaro/qemu-for-merges/buil=
d/clang/../../cpus-common.c:67:
> more undefined references to `__ubsan_handle_type_mismatch_v1' follow
> collect2: error: ld returned 1 exit status
>
> thanks
> -- PMM
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000006a2ee005aeb05dc4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 7, 2020 at 2:35 AM Peter =
Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Sun, 6 Sep 2020 at 18:56, Paolo Bonzini &lt;<a href=3D"mailto:pbonz=
ini@redhat.com" target=3D"_blank">pbonzini@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The following changes since commit 227de21ed0759e275a469394af72c999d01=
34bb5:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0Merge remote-tracking branch &#39;remotes/rth/tags/pull-tc=
g-20200903&#39; into staging (2020-09-05 15:30:41 +0100)<br>
&gt;<br>
&gt; are available in the Git repository at:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://gitlab.com/bonzini/qemu.git" rel=3D"nor=
eferrer" target=3D"_blank">https://gitlab.com/bonzini/qemu.git</a> tags/for=
-upstream<br>
&gt;<br>
&gt; for you to fetch changes up to 6264b35324d3766d3c2ff369c4e8ecba8bd5b57=
1:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0meson: remove linkage of sdl to baum (2020-09-06 19:50:57 =
+0200)<br>
&gt;<br>
&gt; ----------------------------------------------------------------<br>
&gt; meson related:<br>
&gt; * convert unit tests<br>
&gt; * bugfixes for mtest2make<br>
&gt; * miscellaneous bugfixes<br>
&gt; * dead code removal and configure cleanups<br>
&gt; * oss-fuzz fixes<br>
&gt; * msys fixes<br>
<br>
Build failure, Windows (this is the second &quot;uint&quot; type usage<br>
I&#39;ve seen today...):<br>
<br>
../../tests/test-vmstate.c: In function &#39;int_cmp&#39;:<br>
../../tests/test-vmstate.c:884:5: error: unknown type name &#39;uint&#39;<b=
r>
=C2=A0 =C2=A0 =C2=A0uint ua =3D GPOINTER_TO_UINT(a);<br>
=C2=A0 =C2=A0 =C2=A0^<br>
../../tests/test-vmstate.c:885:5: error: unknown type name &#39;uint&#39;<b=
r>
=C2=A0 =C2=A0 =C2=A0uint ub =3D GPOINTER_TO_UINT(b);<br>
=C2=A0 =C2=A0 =C2=A0^<br></blockquote><div>I&#39;ve already fixes this issu=
e, that patch can be quenued =C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
Makefile.ninja:5443: recipe for target<br>
&#39;tests/test-vmstate.exe.p/test-vmstate.c.obj&#39; failed<br>
make: *** [tests/test-vmstate.exe.p/test-vmstate.c.obj] Error 1<br>
make: *** Waiting for unfinished jobs....<br>
../../tests/test-util-filemonitor.c: In function &#39;test_file_monitor_eve=
nts&#39;:<br>
../../tests/test-util-filemonitor.c:620:17: error: too many arguments<br>
to function &#39;mkdir&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mkdir(pathsrc, 0700) &l=
t; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
In file included from<br>
/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/unistd.h:10:0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /home/pe=
tmay01/qemu-for-merges/include/qemu/osdep.h:93,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../../te=
sts/test-util-filemonitor.c:21:<br>
/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/io.h:280:15: note:<br>
declared here<br>
=C2=A0 =C2=A0int __cdecl mkdir (const char *) __MINGW_ATTRIB_DEPRECATED_MSV=
C2005;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
<br>
<br>
<br>
Build failure, OpenBSD:<br>
<br>
In file included from ../src/hw/arm/nseries.c:30:<br>
In file included from /home/qemu/qemu-test.yhbDti/src/include/hw/arm/omap.h=
:24:<br>
In file included from<br>
/home/qemu/qemu-test.yhbDti/src/include/hw/input/tsc2xxx.h:14:<br>
/home/qemu/qemu-test.yhbDti/src/include/ui/console.h:11:11: fatal<br>
error: &#39;epoxy/gl.h&#39; file not found<br>
# include &lt;epoxy/gl.h&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~<br>
1 error generated.<br>
gmake: *** [Makefile.ninja:1735:<br>
libqemu-aarch64-softmmu.fa.p/hw_arm_nseries.c.o] Error 1<br>
<br>
<br>
<br>
Odd warning on most but not all of the builds, though they went on to<br>
complete OK:<br>
<br>
make: Entering directory &#39;/home/peter.maydell/qemu-freebsd/build&#39;<b=
r>
/home/peter.maydell/qemu-freebsd/tests/Makefile.include:144: warning:<br>
overriding recipe for target &#39;check-block&#39;<br>
Makefile.mtest:1345: warning: ignoring old recipe for target &#39;check-blo=
ck&#39;<br>
config-host.mak is out-of-date, running configure<br>
cross containers=C2=A0 no<br>
<br>
NOTE: guest cross-compilers enabled: aarch64-linux-gnu-gcc cc<br>
aarch64-linux-gnu-gcc cc<br>
/usr/bin/python3 /home/peter.maydell/qemu-freebsd/meson/meson.py<br>
--internal regenerate /home/peter.maydell/qemu-freebsd<br>
/home/peter.maydell/qemu-freebsd/build --backend ninja<br>
The Meson build system<br>
Version: 0.55.1<br>
[etc]<br>
<br>
<br>
x86-64 clang build failed at the link stage (this is config we&#39;ve<br>
talked about before with<br>
&#39;../../configure&#39; &#39;--cc=3Dclang&#39; &#39;--cxx=3Dclang++&#39; =
&#39;--enable-gtk&#39;<br>
&#39;--extra-cflags=3D-fsanitize=3Dundefined=C2=A0 -fno-sanitize=3Dshift-ba=
se<br>
-Werror&#39;<br>
but where the clang++ doesn&#39;t work because the right libstdc++ happens<=
br>
not to be present):<br>
<br>
Linking target qemu-alpha<br>
libcommon.fa.p/cpus-common.c.o: In function `cpu_list_add&#39;:<br>
/home/petmay01/linaro/qemu-for-merges/build/clang/../../cpus-common.c:80:<b=
r>
undefined reference to `__ubsan_handle_type_mismatch_v1&#39;<br>
/home/petmay01/linaro/qemu-for-merges/build/clang/../../cpus-common.c:80:<b=
r>
undefined reference to `__ubsan_handle_type_mismatch_v1&#39;<br>
libcommon.fa.p/cpus-common.c.o: In function `cpu_get_free_index&#39;:<br>
/home/petmay01/linaro/qemu-for-merges/build/clang/../../cpus-common.c:68:<b=
r>
undefined reference to `__ubsan_handle_type_mismatch_v1&#39;<br>
/home/petmay01/linaro/qemu-for-merges/build/clang/../../cpus-common.c:68:<b=
r>
undefined reference to `__ubsan_handle_type_mismatch_v1&#39;<br>
/home/petmay01/linaro/qemu-for-merges/build/clang/../../cpus-common.c:67:<b=
r>
undefined reference to `__ubsan_handle_type_mismatch_v1&#39;<br>
libcommon.fa.p/cpus-common.c.o:/home/petmay01/linaro/qemu-for-merges/build/=
clang/../../cpus-common.c:67:<br>
more undefined references to `__ubsan_handle_type_mismatch_v1&#39; follow<b=
r>
collect2: error: ld returned 1 exit status<br>
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000006a2ee005aeb05dc4--


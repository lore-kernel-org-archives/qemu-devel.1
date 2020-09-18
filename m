Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE27C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B64E208B8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cL2/n7Ar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B64E208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJC8V-0005d7-A2
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJC3S-00080T-54
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:47:43 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130]:41399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJC3N-00006Y-OC
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:47:41 -0400
Received: by mail-lf1-x130.google.com with SMTP id y17so5267719lfa.8
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=3LeMBHHu2V07Xh/rGMIzXds/sl4S4tUGe0lzni/zGs8=;
 b=cL2/n7Ar5nQA2wXoKg59OMHxBVYHkRk+RcQDeLYU0sLd61AXkHx5HfPoDzcS2xF4jS
 zg+YMr4z3pVIXNFK5v/0mQwGfr9IFQfQd//JXnH+kd2iocfV8UkmlX0e17tFYLtbCuTj
 ya/GnGYPrDh9nXQbUAtPrvbr4vks3JFJ9jU51aVZJe7qDiUZHr1uO206g3M2ZVOE3Q2O
 N+7n40H7vpMfTLIQdlcZcStoQ6XlZ3Qf62N//PT2VSqmAVdbYL0hvupecoj6v5q/uoWn
 Iw+cJnci3jKeW+3yyKXamhOerOPsZz58hFrg1MB1ANZK3GARU3iMx1mWFNPJHtr0UwCq
 LbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=3LeMBHHu2V07Xh/rGMIzXds/sl4S4tUGe0lzni/zGs8=;
 b=QZf5BA94SE9FUk/ews7LO9P30rZeLXi6rejf93wzGo9NYnyBovZ8keVQfFsu0h4311
 dPUdQ4A9nlZApvT/ljCNd8yKR8rmP5sAj58QHglPbVYxX0u2jhkbLY8hhIeCeZsKHJVx
 WhHS8FwVD2mhkniJI0RKiRD0hMbNz3mwmmp7CRvYb2RYp8SQqhtvaVyzcl035Dfl2W7z
 5dxUcG0jE0rSZtZ54R2osFOPdmKOAmSMLqw5HhIFjfEOvOTYVys72Oi/y8lHaYEZtbzJ
 CkmEb80/2EiRlLFigbwAOsmZPVdkGXUITqXUUp70RQHWY60ncvZzxpyVbCC7qkzWcxKz
 b/Pw==
X-Gm-Message-State: AOAM532StIbV032zxQx+SYwlIQrcbzietzUf+6D6HT5P6BaKfQA2ISSV
 yQUDY+gAARz0YtS+gKIwmjr1B5Fb8bciMdeL5HY=
X-Google-Smtp-Source: ABdhPJxyti/I6N2x7OARcY7sLyw6QXVnLhZPJ+3zAanngDjjzMLgQqtaG8qm44KAtSnz84vfYzUb4Lp8D2oPROgyn88=
X-Received: by 2002:a19:9141:: with SMTP id y1mr9726490lfj.554.1600418851110; 
 Fri, 18 Sep 2020 01:47:31 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 18 Sep 2020 16:47:20 +0800
Message-ID: <CAE2XoE-xcBTt-eRgj1U-NMcGewpSV0Vk8Y3_9wnZ++K7qCgLtw@mail.gmail.com>
Subject: How to convert fowlloing code from configure to meson.build
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000001cc3c205af928db3"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x130.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001cc3c205af928db3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

##########################################
# iconv probe
if test "$iconv" !=3D "no" ; then
  cat > $TMPC << EOF
#include <iconv.h>
int main(void) {
  iconv_t conv =3D iconv_open("WCHAR_T", "UCS-2");
  return conv !=3D (iconv_t) -1;
}
EOF
  iconv_prefix_list=3D"/usr/local:/usr"
  iconv_lib_list=3D":-liconv"
  IFS=3D:
  for iconv_prefix in $iconv_prefix_list; do
    IFS=3D:
    iconv_cflags=3D"-I$iconv_prefix/include"
    iconv_ldflags=3D"-L$iconv_prefix/lib"
    for iconv_link in $iconv_lib_list; do
      unset IFS
      iconv_lib=3D"$iconv_ldflags $iconv_link"
      echo "looking at iconv in '$iconv_cflags' '$iconv_lib'" >> config.log
      if compile_prog "$iconv_cflags" "$iconv_lib" ; then
        iconv_found=3Dyes
        break
      fi
    done
    if test "$iconv_found" =3D yes ; then
      break
    fi
  done
  if test "$iconv_found" =3D "yes" ; then
    iconv=3Dyes
  else
    if test "$iconv" =3D "yes" ; then
      feature_not_found "iconv" "Install iconv devel"
    fi
    iconv=3Dno
  fi
fi

##########################################
# curses probe
if test "$iconv" =3D "no" ; then
  # curses will need iconv
  curses=3Dno
fi
if test "$curses" !=3D "no" ; then
  if test "$mingw32" =3D "yes" ; then
    curses_inc_list=3D"$($pkg_config --cflags ncurses 2>/dev/null)
      $($pkg_config --cflags ncursesw 2>/dev/null)"
    curses_lib_list=3D"$($pkg_config --libs ncurses 2>/dev/null)
      $($pkg_config --libs ncursesw 2>/dev/null)
      -lpdcurses"
  else
    curses_inc_list=3D"$($pkg_config --cflags ncursesw 2>/dev/null)
      -I/usr/include/ncursesw:"
    curses_lib_list=3D"$($pkg_config --libs ncursesw 2>/dev/null)
      -lncursesw
      -lcursesw"
  fi
  curses_found=3Dno
  cat > $TMPC << EOF
#include <locale.h>
#include <curses.h>
#include <wchar.h>
int main(void) {
  wchar_t wch =3D L'w';
  setlocale(LC_ALL, "");
  resize_term(0, 0);
  addwstr(L"wide chars\n");
  addnwstr(&wch, 1);
  add_wch(WACS_DEGREE);
  return 0;
}
EOF
  IFS=3D'
'                           # turn off variable value expansion except for
splitting at newlines
  for curses_inc in $curses_inc_list; do
    # Make sure we get the wide character prototypes
    curses_inc=3D"-DNCURSES_WIDECHAR $curses_inc"
    IFS=3D'
'                           # turn off variable value expansion except for
splitting at newlines
    for curses_lib in $curses_lib_list; do
      unset IFS
      if compile_prog "$curses_inc" "$curses_lib" ; then
        curses_found=3Dyes
        break
      fi
    done
    if test "$curses_found" =3D yes ; then
      break
    fi
  done
  unset IFS
  if test "$curses_found" =3D "yes" ; then
    curses=3Dyes
  else
    if test "$curses" =3D "yes" ; then
      feature_not_found "curses" "Install ncurses devel"
    fi
    curses=3Dno
  fi
fi


seems that need compile a program, but I didn't found a demo
--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000001cc3c205af928db3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>##########################################<br># iconv =
probe<br>if test &quot;$iconv&quot; !=3D &quot;no&quot; ; then<br>=C2=A0 ca=
t &gt; $TMPC &lt;&lt; EOF<br>#include &lt;iconv.h&gt;<br>int main(void) {<b=
r>=C2=A0 iconv_t conv =3D iconv_open(&quot;WCHAR_T&quot;, &quot;UCS-2&quot;=
);<br>=C2=A0 return conv !=3D (iconv_t) -1;<br>}<br>EOF<br>=C2=A0 iconv_pre=
fix_list=3D&quot;/usr/local:/usr&quot;<br>=C2=A0 iconv_lib_list=3D&quot;:-l=
iconv&quot;<br>=C2=A0 IFS=3D:<br>=C2=A0 for iconv_prefix in $iconv_prefix_l=
ist; do<br>=C2=A0 =C2=A0 IFS=3D:<br>=C2=A0 =C2=A0 iconv_cflags=3D&quot;-I$i=
conv_prefix/include&quot;<br>=C2=A0 =C2=A0 iconv_ldflags=3D&quot;-L$iconv_p=
refix/lib&quot;<br>=C2=A0 =C2=A0 for iconv_link in $iconv_lib_list; do<br>=
=C2=A0 =C2=A0 =C2=A0 unset IFS<br>=C2=A0 =C2=A0 =C2=A0 iconv_lib=3D&quot;$i=
conv_ldflags $iconv_link&quot;<br>=C2=A0 =C2=A0 =C2=A0 echo &quot;looking a=
t iconv in &#39;$iconv_cflags&#39; &#39;$iconv_lib&#39;&quot; &gt;&gt; conf=
ig.log<br>=C2=A0 =C2=A0 =C2=A0 if compile_prog &quot;$iconv_cflags&quot; &q=
uot;$iconv_lib&quot; ; then<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 iconv_found=3Dye=
s<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>=C2=A0 =C2=A0 =C2=A0 fi<br>=C2=A0=
 =C2=A0 done<br>=C2=A0 =C2=A0 if test &quot;$iconv_found&quot; =3D yes ; th=
en<br>=C2=A0 =C2=A0 =C2=A0 break<br>=C2=A0 =C2=A0 fi<br>=C2=A0 done<br>=C2=
=A0 if test &quot;$iconv_found&quot; =3D &quot;yes&quot; ; then<br>=C2=A0 =
=C2=A0 iconv=3Dyes<br>=C2=A0 else<br>=C2=A0 =C2=A0 if test &quot;$iconv&quo=
t; =3D &quot;yes&quot; ; then<br>=C2=A0 =C2=A0 =C2=A0 feature_not_found &qu=
ot;iconv&quot; &quot;Install iconv devel&quot;<br>=C2=A0 =C2=A0 fi<br>=C2=
=A0 =C2=A0 iconv=3Dno<br>=C2=A0 fi<br>fi<br><br>###########################=
###############<br># curses probe<br>if test &quot;$iconv&quot; =3D &quot;n=
o&quot; ; then<br>=C2=A0 # curses will need iconv<br>=C2=A0 curses=3Dno<br>=
fi<br>if test &quot;$curses&quot; !=3D &quot;no&quot; ; then<br>=C2=A0 if t=
est &quot;$mingw32&quot; =3D &quot;yes&quot; ; then<br>=C2=A0 =C2=A0 curses=
_inc_list=3D&quot;$($pkg_config --cflags ncurses 2&gt;/dev/null)<br>=C2=A0 =
=C2=A0 =C2=A0 $($pkg_config --cflags ncursesw 2&gt;/dev/null)&quot;<br>=C2=
=A0 =C2=A0 curses_lib_list=3D&quot;$($pkg_config --libs ncurses 2&gt;/dev/n=
ull)<br>=C2=A0 =C2=A0 =C2=A0 $($pkg_config --libs ncursesw 2&gt;/dev/null)<=
br>=C2=A0 =C2=A0 =C2=A0 -lpdcurses&quot;<br>=C2=A0 else<br>=C2=A0 =C2=A0 cu=
rses_inc_list=3D&quot;$($pkg_config --cflags ncursesw 2&gt;/dev/null)<br>=
=C2=A0 =C2=A0 =C2=A0 -I/usr/include/ncursesw:&quot;<br>=C2=A0 =C2=A0 curses=
_lib_list=3D&quot;$($pkg_config --libs ncursesw 2&gt;/dev/null)<br>=C2=A0 =
=C2=A0 =C2=A0 -lncursesw<br>=C2=A0 =C2=A0 =C2=A0 -lcursesw&quot;<br>=C2=A0 =
fi<br>=C2=A0 curses_found=3Dno<br>=C2=A0 cat &gt; $TMPC &lt;&lt; EOF<br>#in=
clude &lt;locale.h&gt;<br>#include &lt;curses.h&gt;<br>#include &lt;wchar.h=
&gt;<br>int main(void) {<br>=C2=A0 wchar_t wch =3D L&#39;w&#39;;<br>=C2=A0 =
setlocale(LC_ALL, &quot;&quot;);<br>=C2=A0 resize_term(0, 0);<br>=C2=A0 add=
wstr(L&quot;wide chars\n&quot;);<br>=C2=A0 addnwstr(&amp;wch, 1);<br>=C2=A0=
 add_wch(WACS_DEGREE);<br>=C2=A0 return 0;<br>}<br>EOF<br>=C2=A0 IFS=3D&#39=
;<br>&#39; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # turn off variable value expansion except for =
splitting at newlines<br>=C2=A0 for curses_inc in $curses_inc_list; do<br>=
=C2=A0 =C2=A0 # Make sure we get the wide character prototypes<br>=C2=A0 =
=C2=A0 curses_inc=3D&quot;-DNCURSES_WIDECHAR $curses_inc&quot;<br>=C2=A0 =
=C2=A0 IFS=3D&#39;<br>&#39; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # turn off variable value exp=
ansion except for splitting at newlines<br>=C2=A0 =C2=A0 for curses_lib in =
$curses_lib_list; do<br>=C2=A0 =C2=A0 =C2=A0 unset IFS<br>=C2=A0 =C2=A0 =C2=
=A0 if compile_prog &quot;$curses_inc&quot; &quot;$curses_lib&quot; ; then<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 curses_found=3Dyes<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break<br>=C2=A0 =C2=A0 =C2=A0 fi<br>=C2=A0 =C2=A0 done<br>=C2=A0 =C2=
=A0 if test &quot;$curses_found&quot; =3D yes ; then<br>=C2=A0 =C2=A0 =C2=
=A0 break<br>=C2=A0 =C2=A0 fi<br>=C2=A0 done<br>=C2=A0 unset IFS<br>=C2=A0 =
if test &quot;$curses_found&quot; =3D &quot;yes&quot; ; then<br>=C2=A0 =C2=
=A0 curses=3Dyes<br>=C2=A0 else<br>=C2=A0 =C2=A0 if test &quot;$curses&quot=
; =3D &quot;yes&quot; ; then<br>=C2=A0 =C2=A0 =C2=A0 feature_not_found &quo=
t;curses&quot; &quot;Install ncurses devel&quot;<br>=C2=A0 =C2=A0 fi<br>=C2=
=A0 =C2=A0 curses=3Dno<br>=C2=A0 fi<br>fi<br><br><br>seems that need compil=
e a program, but I didn&#39;t found a demo<br>--<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A=
<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--0000000000001cc3c205af928db3--


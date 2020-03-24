Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9105C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 03:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9790C206F8
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 03:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J81SYJeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9790C206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGZtC-0001mP-M2
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 23:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mansourweb@gmail.com>) id 1jGZsY-0001HV-EN
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 23:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mansourweb@gmail.com>) id 1jGZsX-0005oe-BD
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 23:05:22 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235]:35642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mansourweb@gmail.com>)
 id 1jGZsX-0005mF-1e
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 23:05:21 -0400
Received: by mail-lj1-x235.google.com with SMTP id k21so954373ljh.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 20:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=DA3Q5ahjIi30UFgxVvMm5UwJQUNOEj1hO5CditOqKiU=;
 b=J81SYJeQxp69tPcIZ2xfzRWMEnQtbQLR2sWfpLIhS32fLnVRJPpoe0RchUj/xnoLCy
 d82pBw18YtH9MgS0uy0XUv32Tz1UlcRS9nZ47WnmOT5rc0gdoWOBGtZDZKh2zOl8HJnM
 gMIei0KogKr8senaKIHAdihuEvyeEpWHtQu9wQVnM26LZCkjp54xExXySnwhVZ2k3sNP
 A3mnHgvs0TGCchsJV+WrL/h/ukC3R5htdoRCbCWPwC9Uaaa5mixRWXEWcrVzQSfl3u6U
 wOIG8BmwB60YLTvRhH/ik24npBV+qg9avo45U6L2oLZW4qAYeHjzEMoXSvC9+TKkPX9K
 Y9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=DA3Q5ahjIi30UFgxVvMm5UwJQUNOEj1hO5CditOqKiU=;
 b=cMpKt+SshEfLesrmGc+CRt+D1cE3sSlskXzOkShQhMNt0VU0y9wJeKBCTs2TY1levX
 pVW46xwHTKg7rnZQfbE0+vQRZZnnsy5DjobCLK4DThYleR1wf9qLiDugCsqfC6b2pzq/
 I5ytoBiHiAD1+3yBUoz/nklBITybLUmAVTQyQEKB9W+hCcDBFnGrgIor3DthXb1YI6cw
 XWsiqfsgSnoNSCKXDdGGcqHYGfzEpKzB97KNBhVFzCmwwq9IdbidM5ptrec9v9FmJYIK
 1ElTJhiMnXbdF9ZOEnARG4M4iU7h4BUGCNQLmUpUnfjn9DN8O4vmC6I6REPCpWuLqbM9
 7vhQ==
X-Gm-Message-State: ANhLgQ17iS42uhLfoqBHR0gl8T6KykuznbqzwifmlfI6SIdSc0MX35ev
 STrLD8k0WeUhbE6nQTdpRGzq46X2vREW2y8eC8puaAWGlz4=
X-Google-Smtp-Source: ADFU+vtzo2emaeePgt7bd9Ci4SjAYbHr2uZ9aRKWUy1iOQldw6pacpDHrEcaoOJUDcpQjaNtUcQG0NOgYjrzvkCWXpw=
X-Received: by 2002:a2e:9b87:: with SMTP id z7mr15788284lji.197.1585019119049; 
 Mon, 23 Mar 2020 20:05:19 -0700 (PDT)
MIME-Version: 1.0
From: Mansour Ahmadi <ManSoSec@gmail.com>
Date: Mon, 23 Mar 2020 23:05:08 -0400
Message-ID: <CAGT9xrCJSy6yQ48p3hCRuwgV7t8vPS7eo+83_pOiPp0gDOfvvQ@mail.gmail.com>
Subject: Potential Null dereference
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000008da10905a19105a0"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::235
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

--0000000000008da10905a19105a0
Content-Type: text/plain; charset="UTF-8"

Hi,

Nullness of  needs to be checked here:
https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/block/commit.c#L221

pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),...

While it is done at 2 other locations:
https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/block/backup-top.c#L113
https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/block/mirror.c#L1477

if (bs->backing == NULL) { return}

Thanks,
Mansour

--0000000000008da10905a19105a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div class=3D"gmail_default" style=3D"font-family:gar=
amond,serif;font-size:large">Hi,</div><br></div><div><div class=3D"gmail_de=
fault" style=3D"font-family:garamond,serif;font-size:large">Nullness of=C2=
=A0 needs to be checked here:</div><div class=3D"gmail_default" style=3D"fo=
nt-family:garamond,serif;font-size:large"><a href=3D"https://github.com/qem=
u/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/block/commit.c#L221">h=
ttps://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/b=
lock/commit.c#L221</a><br></div><div class=3D"gmail_default" style=3D"font-=
family:garamond,serif;font-size:large"><br></div><div class=3D"gmail_defaul=
t" style=3D"font-family:garamond,serif;font-size:large"><table class=3D"gma=
il-highlight gmail-tab-size gmail-js-file-line-container" style=3D"box-sizi=
ng:border-box;border-spacing:0px;border-collapse:collapse;color:rgb(36,41,4=
6);font-family:-apple-system,system-ui,&quot;Segoe UI&quot;,Helvetica,Arial=
,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;;font-s=
ize:14px"><tbody style=3D"box-sizing:border-box"><tr style=3D"box-sizing:bo=
rder-box"><td id=3D"gmail-LC221" class=3D"gmail-blob-code gmail-blob-code-i=
nner gmail-js-file-line gmail-highlighted" style=3D"box-sizing:border-box;p=
adding:0px 10px;line-height:20px;vertical-align:top;overflow:visible;font-f=
amily:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;f=
ont-size:12px;white-space:pre;background-color:rgb(255,251,221)"><span clas=
s=3D"gmail-pl-c1" style=3D"box-sizing:border-box;color:rgb(0,92,197)">pstrc=
py</span>(bs-&gt;<span class=3D"gmail-pl-smi" style=3D"box-sizing:border-bo=
x">exact_filename</span>, <span class=3D"gmail-pl-k" style=3D"box-sizing:bo=
rder-box;color:rgb(215,58,73)">sizeof</span>(bs-&gt;<span class=3D"gmail-pl=
-smi" style=3D"box-sizing:border-box">exact_filename</span>),...</td></tr><=
/tbody></table></div><div class=3D"gmail_default" style=3D"font-family:gara=
mond,serif;font-size:large"><br></div><div class=3D"gmail_default" style=3D=
"font-family:garamond,serif;font-size:large">While it is done at 2 other lo=
cations:</div><div class=3D"gmail_default" style=3D"font-family:garamond,se=
rif;font-size:large"><a href=3D"https://github.com/qemu/qemu/blob/c532b954d=
96f96d361ca31308f75f1b95bd4df76/block/backup-top.c#L113" style=3D"font-fami=
ly:Arial,Helvetica,sans-serif;font-size:small">https://github.com/qemu/qemu=
/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/block/backup-top.c#L113</a><=
/div><div class=3D"gmail_default" style=3D"font-family:garamond,serif;font-=
size:large"><a href=3D"https://github.com/qemu/qemu/blob/c532b954d96f96d361=
ca31308f75f1b95bd4df76/block/mirror.c#L1477">https://github.com/qemu/qemu/b=
lob/c532b954d96f96d361ca31308f75f1b95bd4df76/block/mirror.c#L1477</a><br></=
div><br></div><div><span class=3D"gmail-pl-k" style=3D"box-sizing:border-bo=
x;color:rgb(215,58,73);font-family:SFMono-Regular,Consolas,&quot;Liberation=
 Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre">if</span><span =
style=3D"color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;Libe=
ration Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre;background=
-color:rgb(255,251,221)"> (bs-&gt;</span><span class=3D"gmail-pl-smi" style=
=3D"box-sizing:border-box;color:rgb(36,41,46);font-family:SFMono-Regular,Co=
nsolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-spa=
ce:pre">backing</span><span style=3D"color:rgb(36,41,46);font-family:SFMono=
-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12p=
x;white-space:pre;background-color:rgb(255,251,221)"> =3D=3D </span><span c=
lass=3D"gmail-pl-c1" style=3D"box-sizing:border-box;color:rgb(0,92,197);fon=
t-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospac=
e;font-size:12px;white-space:pre">NULL</span><span style=3D"color:rgb(36,41=
,46);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,=
monospace;font-size:12px;white-space:pre;background-color:rgb(255,251,221)"=
>) {<span class=3D"gmail_default" style=3D"font-family:garamond,serif;font-=
size:large"> return}</span></span><br></div><div><span style=3D"color:rgb(3=
6,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Me=
nlo,monospace;font-size:12px;white-space:pre;background-color:rgb(255,251,2=
21)"><span class=3D"gmail_default" style=3D"font-family:garamond,serif;font=
-size:large"><br></span></span></div><div><span style=3D"font-size:12px;whi=
te-space:pre"><span class=3D"gmail_default" style=3D"font-size:large;backgr=
ound-color:rgb(255,255,255)"><font color=3D"#000000" face=3D"garamond, time=
s new roman, serif">Thanks,</font></span></span></div><div><span style=3D"f=
ont-size:12px;white-space:pre"><span class=3D"gmail_default" style=3D"font-=
size:large;background-color:rgb(255,255,255)"><font color=3D"#000000" face=
=3D"garamond, times new roman, serif">Mansour</font></span></span></div><di=
v><br></div></div>

--0000000000008da10905a19105a0--


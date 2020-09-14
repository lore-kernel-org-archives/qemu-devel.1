Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61D2C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:01:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0880C207EA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaMGyyCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0880C207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHiUE-0000xL-Sa
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHiTL-0008Ut-5q; Mon, 14 Sep 2020 03:00:19 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d]:39480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHiTI-0008N9-SE; Mon, 14 Sep 2020 03:00:18 -0400
Received: by mail-lf1-x12d.google.com with SMTP id q8so12225071lfb.6;
 Mon, 14 Sep 2020 00:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=qsZaEQFTA87OCcYezDiCCFgnMg39x1XIW2QopauHcAQ=;
 b=EaMGyyCuWem0OqrO9C+OI3+3GVYka6JGBzZINz/IepUgz6h/t3g0p6bwdiGBtlpCEV
 HnkrorhAjBDSrFFtnapvZt4r5EGf70+k8XaxxYIb82zZg9Nsss/Biy1eV5TAGbEYTH1V
 WCgbuvUziALbTO1ENqCyMXTG+lm9BLF4yQLyorV1SCOHKtQcqxQoeonqOxmKKSP6IROQ
 069pLOl3eTxFdmnPcIJ/MvGC233br18cF9WCix4CccP4Fa1UqzFrvNrbwF3KdHVaKQ3g
 CLyGxbY9rPlk55uvlrh63eAv8lIMRY7RgJ78efAUPip82wRO0zG1SBfWw9KgyL0PvaxL
 Dc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=qsZaEQFTA87OCcYezDiCCFgnMg39x1XIW2QopauHcAQ=;
 b=Dd1KN0knGKeikqk9CYznt3CFoBxFNgfri6s+CXg79dQZBIzam0fVHZ8ADBed6PiOg+
 68qGIZ3EfTJA1Ttd5ARH6A7XKzq0CrqwG3nJuE48W6K7GkwLrrQklKIyutjgbw4d+FSJ
 VxIskknCmYg6A8bPQoeM2UGL8VhglLLEVR4IaNQVsaDULayurpR50kCi7YuoApmt7A8q
 4R7k9pDo7ktkH+DyHvDntmno6YKTYSKr0lvzIuLig3sMdXPHxqvi6lA8mnAwdHcpExAJ
 hauQsXZJyzvavtTA2x1mX/glhI7s1HE8nfrmHu5xGLNOGFGv5nAGhnUx4UOLKrZjfsnx
 ZkaA==
X-Gm-Message-State: AOAM530MFrnbCNY3MDInHOemd/A1wYQBvEC3SckToi0Ya/qy+p0TcHDu
 hO4V6rJK3XU6z0JW8kFKidGs5YpuDRLzmg370M+qq9bk8AeWV8iTYSE=
X-Google-Smtp-Source: ABdhPJz0Vw/h3S84gPHxYfF/L22ARfuwjl0f1EMqlB/1Hu2RAmDy7JxSiBKQknzXitVN6WZGsuhLB0YSWk7/ZCOGk8c=
X-Received: by 2002:a19:383:: with SMTP id 125mr4144391lfd.356.1600066814584; 
 Mon, 14 Sep 2020 00:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <159995200078.32613.13010807520146021847@66eaa9a8a123>
In-Reply-To: <159995200078.32613.13010807520146021847@66eaa9a8a123>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 14 Sep 2020 15:00:05 +0800
Message-ID: <CAE2XoE-DBhv-SZe8N9RELh-5n0zzGQBm89mhH+=KGFWR10Dprg@mail.gmail.com>
Subject: Re: [PATCH v8 00/27] W32, W64 msys2/mingw patches
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000019ab0705af40969a"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x12d.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000019ab0705af40969a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2020 at 7:07 AM <no-reply@patchew.org> wrote:
>
> Patchew URL:
https://patchew.org/QEMU/20200912224431.1428-1-luoyonggang@gmail.com/
>
>
>
> Hi,
>
> This series seems to have some coding style problems. See output below fo=
r
> more information:
>
> N/A. Internal error while reading log file
>
>
>
> The full log is available at
>
http://patchew.org/logs/20200912224431.1428-1-luoyonggang@gmail.com/testing=
.checkpatch/?type=3Dmessage
.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
I also have a question about this,  This series seems to have some coding
style problems, but where
to find the logging, seems the logs of patchew are failed(out of disk)


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000019ab0705af40969a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sun, Sep 13, 2020 at 7:07 AM &lt;<a href=3D"mai=
lto:no-reply@patchew.org">no-reply@patchew.org</a>&gt; wrote:<br>&gt;<br>&g=
t; Patchew URL: <a href=3D"https://patchew.org/QEMU/20200912224431.1428-1-l=
uoyonggang@gmail.com/">https://patchew.org/QEMU/20200912224431.1428-1-luoyo=
nggang@gmail.com/</a><br>&gt;<br>&gt;<br>&gt;<br>&gt; Hi,<br>&gt;<br>&gt; T=
his series seems to have some coding style problems. See output below for<b=
r>&gt; more information:<br>&gt;<br>&gt; N/A. Internal error while reading =
log file<br>&gt;<br>&gt;<br>&gt;<br>&gt; The full log is available at<br>&g=
t; <a href=3D"http://patchew.org/logs/20200912224431.1428-1-luoyonggang@gma=
il.com/testing.checkpatch/?type=3Dmessage">http://patchew.org/logs/20200912=
224431.1428-1-luoyonggang@gmail.com/testing.checkpatch/?type=3Dmessage</a>.=
<br>&gt; ---<br>&gt; Email generated automatically by Patchew [<a href=3D"h=
ttps://patchew.org/">https://patchew.org/</a>].<br>&gt; Please send your fe=
edback to <a href=3D"mailto:patchew-devel@redhat.com">patchew-devel@redhat.=
com</a><br>I also have a question about this,=C2=A0

This series seems to have some coding style problems, but where=C2=A0<div>t=
o find the logging, seems the logs of patchew are failed(out of disk)<br><b=
r><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=
=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>=
Yonggang Luo</div></div>

--00000000000019ab0705af40969a--


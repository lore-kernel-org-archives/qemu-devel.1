Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FDFC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C9622211
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlB9rXem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C9622211
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIws5-0003sd-0L
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIwqo-0002US-6S
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:33:38 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d]:38077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIwqm-0001DG-7L
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:33:37 -0400
Received: by mail-lj1-x22d.google.com with SMTP id w3so2596806ljo.5
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 09:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=mQYVawQ0VFAISaJtKpdgpTqbQkmgDRGuUIri3CgmjiM=;
 b=ZlB9rXemFbA7y9pDrY8yQtOi+w/B1L6/pbNJN8baxXqRp8OnQMlwvKxoO++KDytSY8
 UX55EKmO9TSEt0qyIb8byC4gJCUWAB5W4LYChviCXGEzuYNgmjH/WLfyhod+2vrD96Q9
 p6YCeGoIWuk4SRQsnCcy2iTNWMNH9/tI5qL8GKOgEwOsj5O74l4LU4S+Rm2suV0x6ZRn
 jlsZwY4X6/w9lvNTwgw3RMus9YGcjPxqoyOuRyLdt+8k1e+UIy/kTptiUMMacq2GUM+u
 16HcTc2EsGptSc6HxtZUaTA0fWQ3Bq11G/yaQJhPWXVTQ2z//X66GfQ9CGUYoxuitvK7
 Zgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=mQYVawQ0VFAISaJtKpdgpTqbQkmgDRGuUIri3CgmjiM=;
 b=UduuNsH1rBKG4K5yOkMEEb6C4ZX9M8fD25h1CkHbWSzuhCLepYqYUmb0QT/oLPkQd5
 qSGvMJvLzwhcoSPMCPGcp+kOZoFb0xLqZKGE1ninBuxYHpFBzlCZNbq+b5sG1nW80rXo
 f8liIlYgxbmHHyGFy0M35jr9IlLy8n1yi2Rh1s7MJUdgRNzxwHhuNl+PuK66yzHqRTTh
 CAlr8LK5SkUYuSsm/mhbIr1iT0igmu8GqPXivy2YxdR0eDhvb2fEJhUas1GjZTLbQFHL
 q7PJ2DqdDU/ouzWut52LfrKaJpG9qJIGnFlytOZhK/Zam6DMtVtYejAkj/i2AkujWG8a
 hlsQ==
X-Gm-Message-State: AOAM533yNOCffV0kqyW7VgBHaHEualMLlXnn8gJqx/O9bHfguCtfT81m
 lP8DP0tbJ5fn3p2M40AeT4Y5QhaNuNvZIS/gwIw=
X-Google-Smtp-Source: ABdhPJxv8hulfdBgYI7LADd+1B/VFJLRMhzqiAgHxQ05PXbBZzznpnWAVq8txHuzA0R6vFGXCGYQJHHAcykY7X1yKnY=
X-Received: by 2002:a2e:854c:: with SMTP id u12mr10247988ljj.120.1600360413954; 
 Thu, 17 Sep 2020 09:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200916114731.102080-1-thuth@redhat.com>
 <CAFEAcA8VyUYJnE3aji6zPQGPD-K+iVGwVNbygYypr+NpSzZBPw@mail.gmail.com>
 <7c21af54-342f-2a29-f700-3b1d3bbd5bc6@redhat.com>
In-Reply-To: <7c21af54-342f-2a29-f700-3b1d3bbd5bc6@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 18 Sep 2020 00:33:16 +0800
Message-ID: <CAE2XoE9xKJzfRUxQit+EFXii=q8XxUQUbcTMYJY-wkRUeZJkuQ@mail.gmail.com>
Subject: Re: [PULL 00/24] qtests, unit tests and Cirrus-CI fixes / improvements
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fc95da05af84f1e5"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22d.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fc95da05af84f1e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2020 at 11:29 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 17/09/2020 17.14, Peter Maydell wrote:
> > On Wed, 16 Sep 2020 at 12:47, Thomas Huth <thuth@redhat.com> wrote:
> >> ----------------------------------------------------------------
> >> * Fix "readlink -f" problem in iotests on macOS (to fix the Cirrus-CI
tests)
> >> * Some minor qtest improvements
> >> * Fix the unit tests to work on MSYS2, too
> >> * Enable building and testing on MSYS2 in the Cirrus-CI
> >> * Build FreeBSD with one task again in the Cirrus-CI
> >> ----------------------------------------------------------------
> >
> > After merging this one I tried installing GNU sed on my local
> > box so it could run the iotests, but they fail like this
> > because they assume readarray, which doesn't exist in
> > OSX bash
> Ok, sounds like I should respin my patch here:
>
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg04476.html
>
> ... and could you install a newer version of bash via homebrew on your
> system?
What's the reason to exclude these list on win32? That's didn't optimize
the time much, and indeed they can be
compiled.
--target-list-exclude=3Di386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu"

>
>  Thomas
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000fc95da05af84f1e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Thu, Sep 17, 2020 at 11:29 PM Thomas Huth &lt;<=
a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br>&gt;<=
br>&gt; On 17/09/2020 17.14, Peter Maydell wrote:<br>&gt; &gt; On Wed, 16 S=
ep 2020 at 12:47, Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth=
@redhat.com</a>&gt; wrote:<br>&gt; &gt;&gt; -------------------------------=
---------------------------------<br>&gt; &gt;&gt; * Fix &quot;readlink -f&=
quot; problem in iotests on macOS (to fix the Cirrus-CI tests)<br>&gt; &gt;=
&gt; * Some minor qtest improvements<br>&gt; &gt;&gt; * Fix the unit tests =
to work on MSYS2, too<br>&gt; &gt;&gt; * Enable building and testing on MSY=
S2 in the Cirrus-CI<br>&gt; &gt;&gt; * Build FreeBSD with one task again in=
 the Cirrus-CI<br>&gt; &gt;&gt; -------------------------------------------=
---------------------<br>&gt; &gt;<br>&gt; &gt; After merging this one I tr=
ied installing GNU sed on my local<br>&gt; &gt; box so it could run the iot=
ests, but they fail like this<br>&gt; &gt; because they assume readarray, w=
hich doesn&#39;t exist in<br>&gt; &gt; OSX bash<br>&gt; Ok, sounds like I s=
hould respin my patch here:<br>&gt;<br>&gt; <a href=3D"https://lists.gnu.or=
g/archive/html/qemu-devel/2020-09/msg04476.html">https://lists.gnu.org/arch=
ive/html/qemu-devel/2020-09/msg04476.html</a><br>&gt;<br>&gt; ... and could=
 you install a newer version of bash via homebrew on your<br>&gt; system?<d=
iv>What&#39;s the reason to exclude these list on win32? That&#39;s didn&#3=
9;t optimize the time much, and indeed they can be <br>compiled.<br>--targe=
t-list-exclude=3Di386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu&quot;<br=
><br>&gt;</div><div>&gt; =C2=A0Thomas<br>&gt;<br><br><br>--<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=
=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></di=
v>

--000000000000fc95da05af84f1e5--


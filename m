Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7B8C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 16:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370982074A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 16:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbCS449D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370982074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTotk-0000Uc-9g
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 12:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kToso-0008UT-GJ
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 12:16:38 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:33575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTosm-0001c8-Gv
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 12:16:38 -0400
Received: by mail-lf1-x142.google.com with SMTP id l2so7315059lfk.0
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 09:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=9Y0HtsfBeeQcdJ1Dgb0HIIz4VB9d9dSewLp/ZzTCgCU=;
 b=PbCS449Dksd+FwFaxCiHI4RvEQuLdgv8E++3CVrgWndr1fUAYu977A2DMiwsihwfIQ
 acY1jeVY/1+Js7x5EhzyLwQuEgsfEGi/HnW0va5BxptoySdVHWEqVDerb7o5O6SpTsqs
 ihcUOEwd8QLjoH1V7m1IDV+O95Or/I4rmflhr7awqQBnXAknSeFJZvlREH/9THqucxjX
 ODwqbjGPzo58GUK6IzzlWBPUbuciEmIMTJ9h5jxvlVjtENFz9KF6Ul6MaYBA5m8m6DjJ
 aNsclA5HdN8khmmfOXKOA72lr6XbK3pMF8ky7LSk4bzuIaZxfbaw9D+IeGqqnQOcAHKM
 WA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=9Y0HtsfBeeQcdJ1Dgb0HIIz4VB9d9dSewLp/ZzTCgCU=;
 b=L3qj+ZZLWrLHMK7elxImp0fsdY1bhBgB8jV8IcimPPgnoo6ueHdA4N+JqQpfAeUpOB
 9wAJ4V2ugSB6Se2jYVUOr70gWS7WprqxJ19RPronkAhmmEOdiUKr7Q98BCoxhuDeHwKe
 2ZCTDsmFYBDBZ1yEw11P7BobZY3ptNjjGlLC2IXkSZjTB4inbugE5TxmK5Tw2VBzGFXO
 Ygy+wDKMyq37JuLNDZEMzECxAiVqkxvbeh2Pkl8Xwp2x8KuhrcG+kFyd/jQQ7JSw0AG+
 PX0Q9LF3XOO1NRgyxTW1UyNXLyOSNOBmL4al8ivHzD4SHob+j/fi3kLgVSD57h2H2G1u
 CW4A==
X-Gm-Message-State: AOAM531mA3PFeKA5x9FakZvotUiJm5xzUjD1dlu6pjDtP0x7XC+Y2alT
 1CElh3tMPCGmJIMfrOWK3TCiHy6+4jYfu9SFefw=
X-Google-Smtp-Source: ABdhPJxPMH1U6SAVXJ2KqQYM2rOsH/uvAYfKp89jGhp2/OW+JOGQq5OMNMhcKO/MIa/qa9wF9yXy1axmZtx9vefsF9o=
X-Received: by 2002:ac2:54ab:: with SMTP id w11mr2976424lfk.50.1602951393768; 
 Sat, 17 Oct 2020 09:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201016155331.1613089-1-pbonzini@redhat.com>
 <CAFEAcA_ZW2mq3ygzCjuphW2kkdOy4fcTzDObcyQTw0BJJgspZw@mail.gmail.com>
 <ecd2b5bf-0c3c-fa58-ce4d-3d4d55274424@redhat.com>
 <CAFEAcA_HDoheozjRjcAKy3eEJ94cBgU29FDftMe2yn=SdMKHMA@mail.gmail.com>
 <03d83be5-db1a-3856-5243-66b0f7bdc724@redhat.com>
In-Reply-To: <03d83be5-db1a-3856-5243-66b0f7bdc724@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sun, 18 Oct 2020 00:16:23 +0800
Message-ID: <CAE2XoE_jDSbTC5KiKZErBRn+Jxxfv_zCZ6CEOS7O0ST8hUbvCA@mail.gmail.com>
Subject: Re: [PULL v2 00/22] Build system + misc changes for 2020-10-16
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006afaf605b1e03470"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006afaf605b1e03470
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2020 at 11:37 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 17/10/20 16:39, Peter Maydell wrote:
> > On Sat, 17 Oct 2020 at 14:38, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> >> OpenBSD and NetBSD call the ninja package "ninja-build" unlike FreeBSD=
.
> >>  I'm sure I had used the right name but well I didn't.  I'll send a v3=
.
> >
> > OpenBSD built OK but meson produces this new warning:
> >
> > Library iconv found: NO
> > ../src/meson.build:531: WARNING: iconv required for curses UI but not
> > available, disabling
>
> Hrm, the curses test was not plainly converted from shell to meson (guys
> please do *one* thing per patch, things are already complex enough!);
Oh, sorry for that,
> and it is messed up in more ways than I had first noticed (of which the
> most blatant is using /usr/include/ncursesw as a library path).  I'll
> fix everything up and resend this pull request when I'm done.
>
> I'm not sure if that will remove the warning or not, but I'll check (and
> if it does remain, it'll be of the "useful" kind which documents some
> unexpected dependency between options).
>
> Paolo
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000006afaf605b1e03470
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sat, Oct 17, 2020 at 11:37 PM Paolo Bonzini &lt=
;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<=
br>&gt;<br>&gt; On 17/10/20 16:39, Peter Maydell wrote:<br>&gt; &gt; On Sat=
, 17 Oct 2020 at 14:38, Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat=
.com">pbonzini@redhat.com</a>&gt; wrote:<br>&gt; &gt;&gt; OpenBSD and NetBS=
D call the ninja package &quot;ninja-build&quot; unlike FreeBSD.<br>&gt; &g=
t;&gt; =C2=A0I&#39;m sure I had used the right name but well I didn&#39;t.=
=C2=A0 I&#39;ll send a v3.<br>&gt; &gt;<br>&gt; &gt; OpenBSD built OK but m=
eson produces this new warning:<br>&gt; &gt;<br>&gt; &gt; Library iconv fou=
nd: NO<br>&gt; &gt; ../src/meson.build:531: WARNING: iconv required for cur=
ses UI but not<br>&gt; &gt; available, disabling<br>&gt;<br>&gt; Hrm, the c=
urses test was not plainly converted from shell to meson (guys<br>&gt; plea=
se do *one* thing per patch, things are already complex enough!);<div>Oh, s=
orry for that,=C2=A0<br>&gt; and it is messed up in more ways than I had fi=
rst noticed (of which the<br>&gt; most blatant is using /usr/include/ncurse=
sw as a library path).=C2=A0 I&#39;ll<br>&gt; fix everything up and resend =
this pull request when I&#39;m done.<br>&gt;<br>&gt; I&#39;m not sure if th=
at will remove the warning or not, but I&#39;ll check (and<br>&gt; if it do=
es remain, it&#39;ll be of the &quot;useful&quot; kind which documents some=
<br>&gt; unexpected dependency between options).<br>&gt;<br>&gt; Paolo<br>&=
gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<b=
r>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincer=
ely,<br>Yonggang Luo</div></div>

--0000000000006afaf605b1e03470--


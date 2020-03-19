Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3303DC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05972070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4vGFt/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05972070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF0Rj-0006Iy-2D
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 15:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jF0Qv-0005QX-Jt
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jF0Qu-0007Mv-9e
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:02:21 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jF0Qt-0007Kk-Vn
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:02:20 -0400
Received: by mail-ot1-x344.google.com with SMTP id a2so3527789otq.9
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=WYCYHRZfsxh0D83TZydyST+LA0c9WFcYGxWqQrHvI+4=;
 b=n4vGFt/wb0x98IJr/aBHfJcDU4uWniS92PkDhKjOXumvU5M5POENGSUcmnp4+624kg
 NZWyXoJUs5puutjyihmzrD2XxBPiHG4v82+VoYf1BPHcdwBX+FamHX0iNm3RdPH8nfYt
 7Xg0s9XKxbr0bCPobH8p3Tx5athgAIjWtMN2taqH6qZu5lzZjlQogZme8KFfkanoX4oc
 FPRgnTnaV0v5h0BfWWh1H227ZWfCiAjq1csctAtb0OcmkTqPN4WFuiX3GAhamJ6UlPiw
 RoPbeQ+m425n29hNff/hWo4f3mkfZ2FLPkHtfwGl0JK9WN0gpvarjP5RyFmMA9wNNLn/
 9d3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=WYCYHRZfsxh0D83TZydyST+LA0c9WFcYGxWqQrHvI+4=;
 b=SXSxgkkuewPVp+qPM6u7yqTLwXMPGThYoe6NVmYID1rfiHAUPA1CeWf4vUMyLQBpoz
 4pZtoihbUQLn6VJ3MFO+KuOeqGGX/+L0Y5ODo/WFiqIsT2jrWjnOXanUbwiSsswdg6Bj
 4sZmlBl3Lilrtm6sPLkEkBDvAPUqwAro+9v2wT5RG1yzZprwmGw38c6wKaQ1RFtWPsaU
 g0ir4GJ30cuU/FBJnltuK5y+TrOfzg7ei73SuMNAWu26Os9p3FB9P0AxBB5mDPGWdpxh
 CIovs9NugW4a1RqJv80W6tzgwPK2LuDz99uLm05PupxGLG/VFXQJ7tTETU/NtDlPg3gZ
 URuw==
X-Gm-Message-State: ANhLgQ16JOn0qxL/SKrWJu2qv0ST/s04Om/UgUhHfirvKkMjADyLA3Fd
 /hHLdqRh96U6cTE69Ksw/IzEDQxQlt4XRZYa3SY=
X-Google-Smtp-Source: ADFU+vuoWfcQR0c1EBHNmefbd8PmgS2zAbWyOU+l7XydHZ6qqFp/1cAhwbRX/IKJlnTezrYriXSlGfdJpZG7aMSpyPc=
X-Received: by 2002:a05:6830:4008:: with SMTP id
 h8mr3657117ots.295.1584644538758; 
 Thu, 19 Mar 2020 12:02:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4044:0:0:0:0:0 with HTTP; Thu, 19 Mar 2020 12:02:18
 -0700 (PDT)
In-Reply-To: <b400bf37-3364-cb31-991d-443970e6309f@vivier.eu>
References: <1579227117-6310-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <994d96ac-ce43-9ff5-7212-eda6e12264fb@vivier.eu>
 <CAL1e-=jOUxOKHFdVa06TpDwsbicKyGrn8mJ=dJtRcaAX6sFriQ@mail.gmail.com>
 <b400bf37-3364-cb31-991d-443970e6309f@vivier.eu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 19 Mar 2020 20:02:18 +0100
Message-ID: <CAL1e-=gew7ReO-Q_KZHiRkh5mC2UPphFOsJDsWW0+q+SMOHVXg@mail.gmail.com>
Subject: Re: [PATCH 0/4] linux-user: Fix some issues in termbits.h files
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="000000000000d4020f05a139ce30"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d4020f05a139ce30
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, March 19, 2020, Laurent Vivier <laurent@vivier.eu> wrote:

> Le 19/03/2020 =C3=A0 17:24, Aleksandar Markovic a =C3=A9crit :
> >> I think we should first introduce a linux-user/generic/termbits.h as w=
e
> >> have an asm-generic/termbits.h in the kernel and use it with all the
> >> targets except alpha, mips, hppa, sparc and xtensa.
> >>
> >> I think this linux-user/generic/termbits.h could be copied from
> >> linux-user/openrisc/termbits.h (without the ioctl definitions)
> >>
> >> Then you could update the remaining ones.
> >>
> >
> > I agree with you, Laurent, that would be the cleanest
> > implementation.
> >
> > However, I think it requires at least several days of meticulous
> > dev work, that I can't afford at this moment. May I ask you to
> > accept this series as is for 5.0, as a sort of bridge towards
> > the implementation you described? It certainly fixes a majority
> > of termbits-related bugs, many of them remained latent just
> > by fact that XXX and TARGET_XXX were identical. The most
> > affected targets, xtensa, mips and alpha should be cleaned up
> > by this series wrt termbits, and for great majority of issues
> > are cleaned up for all platforms.
> >
> > I just don't have enough time resources to additionally
> > devote to this problem.
>
> ok, but I need to review and test them, I don't know if I will have
> enough time for that. I will try...
>
>
OK, thanks!

Aleksandar



> Thanks,
> Laurent
>

--000000000000d4020f05a139ce30
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, March 19, 2020, Laurent Vivier &lt;<a href=3D"mailto:l=
aurent@vivier.eu">laurent@vivier.eu</a>&gt; wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">Le 19/03/2020 =C3=A0 17:24, Aleksandar Markovic a =C3=A9crit=C2=
=A0:<br>
&gt;&gt; I think we should first introduce a linux-user/generic/termbits.h =
as we<br>
&gt;&gt; have an asm-generic/termbits.h in the kernel and use it with all t=
he<br>
&gt;&gt; targets except alpha, mips, hppa, sparc and xtensa.<br>
&gt;&gt;<br>
&gt;&gt; I think this linux-user/generic/termbits.h could be copied from<br=
>
&gt;&gt; linux-user/openrisc/termbits.h (without the ioctl definitions)<br>
&gt;&gt;<br>
&gt;&gt; Then you could update the remaining ones.<br>
&gt;&gt;<br>
&gt; <br>
&gt; I agree with you, Laurent, that would be the cleanest<br>
&gt; implementation.<br>
&gt; <br>
&gt; However, I think it requires at least several days of meticulous<br>
&gt; dev work, that I can&#39;t afford at this moment. May I ask you to<br>
&gt; accept this series as is for 5.0, as a sort of bridge towards<br>
&gt; the implementation you described? It certainly fixes a majority<br>
&gt; of termbits-related bugs, many of them remained latent just<br>
&gt; by fact that XXX and TARGET_XXX were identical. The most<br>
&gt; affected targets, xtensa, mips and alpha should be cleaned up<br>
&gt; by this series wrt termbits, and for great majority of issues<br>
&gt; are cleaned up for all platforms.<br>
&gt; <br>
&gt; I just don&#39;t have enough time resources to additionally<br>
&gt; devote to this problem.<br>
<br>
ok, but I need to review and test them, I don&#39;t know if I will have<br>
enough time for that. I will try...<br>
<br></blockquote><div><br></div><div>OK, thanks!</div><div><br></div><div>A=
leksandar</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
Thanks,<br>
Laurent<br>
</blockquote>

--000000000000d4020f05a139ce30--


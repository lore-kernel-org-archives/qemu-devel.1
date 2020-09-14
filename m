Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB1FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349F8204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9f0DmSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349F8204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHiOv-0005Tx-4s
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 02:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHiO7-0004Zi-Ja; Mon, 14 Sep 2020 02:54:55 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:45805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHiO6-0007eG-0j; Mon, 14 Sep 2020 02:54:55 -0400
Received: by mail-lf1-x144.google.com with SMTP id z17so12150475lfi.12;
 Sun, 13 Sep 2020 23:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=I9fWzwv/TuxbKhu5rrnZXSIlX0XUO8DlQp+5IcGKFKE=;
 b=H9f0DmSRUR85BBoo+izVW7W8b67fcQNgjHV/DP/D2yJjJpBwNs5zWX9vbtHlRhF2z+
 qRDeAs1y1p1wM23v1uz6+WCTLXqhBr0SjFWm9CaWNjXiOZoLyezrM8+z/JeYL1OQLVw4
 0cbWJfAnL12FimQDL1HoljoNLwr3nmqnXe0wZWFa07X/SVztSyaU4HciLxPeX88s6tG7
 gn1lOvNm9uLRMZ2CII7J8imxrPFDAbcXrM7QS6t9PmJKeElGNGWCZBd5ePAFm6oj5HAD
 p9e5jBxpD4HpxR+w58CVUNdMMNtd05XDXF31jKJoRG+8YB21jcGzazxE2aPi5nDXvG07
 iKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=I9fWzwv/TuxbKhu5rrnZXSIlX0XUO8DlQp+5IcGKFKE=;
 b=YzWcFfbX/ONq3ggUbsqMPNLdVpvSuZJhKnZfthgwAY7rNVUb6maVg7z6/VzBDynxl0
 dlkPGU6ozGz28HXH94LxR0+End7fmUUbkS+WmzPzxEPGjHOsA4nQ1Hzu3Of8sPdcxATE
 CxTUu0ZgT1+Pv2L3vOTFtMMd/0w5oFwi4BgFzZcIKK9G4IMjHVNQHsRO4lvhPxpc8T2h
 F6b/eO1BCCGO+33rbcFMciU83j6b/3Jb0lFDvhevgx+Ez+1na1VTVOXc9G6tG4EMxT/+
 FOKV9PI4ztTGHimxgHYwQhvdeuWT9POyOwp/0YBI5LB5WTlNAEIKIRSRR+K7KH1VV4zM
 m1aA==
X-Gm-Message-State: AOAM531QWavjUZUGSYPVhj8tLqK9uzvIQ29tY21g+eYF8vmtjV0z/Bdb
 aYbZSojOIdmFnJg0h+pzrIx8CggG08OnBX1EwIs=
X-Google-Smtp-Source: ABdhPJzUSP59xUsUpIerex4i/IUTybzrORV4bRme51HqOGVzrkpJq+SYAki2vquy6MYHCWVZHS8hIIlj4j4N9ZIYcqQ=
X-Received: by 2002:a19:560a:: with SMTP id k10mr3537359lfb.599.1600066491492; 
 Sun, 13 Sep 2020 23:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <276a137d-d863-2465-1fe2-599e5772a1a8@redhat.com>
 <CAE2XoE8WrE1_e1VR1VSG7vWWX9nsbp2iRwZvOur1ouGrbC+Rqw@mail.gmail.com>
 <98ea8ecd-afb4-c2de-214e-b94dcdbd6c8b@weilnetz.de>
In-Reply-To: <98ea8ecd-afb4-c2de-214e-b94dcdbd6c8b@weilnetz.de>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 14 Sep 2020 14:54:41 +0800
Message-ID: <CAE2XoE-7=T5NtZjZQ4zAP3nj34uVajr84=18Bn3Yi4OMGScFDw@mail.gmail.com>
Subject: Re: [PATCH v8 00/27] W32, W64 msys2/mingw patches
To: Stefan Weil <sw@weilnetz.de>
Content-Type: multipart/alternative; boundary="000000000000d7b3ed05af408240"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x144.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d7b3ed05af408240
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 2:38 PM Stefan Weil <sw@weilnetz.de> wrote:
>
> Am 14.09.20 um 08:27 schrieb =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo):
>
>
> Thanks, I am learning how to submit patches properly, in old days,  when
I am using pull request on github have no such problems. easy to follow up
>
>
> May I also ask you to send text-only e-mails? Your HTML e-mails are
really hard to read.
>
> Thanks,
>
> Stefan Weil
>
>
Sorry, I am using gmail to send, I'll review the email format in latter
messages


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000d7b3ed05af408240
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Sep 14, 2020 at 2:38 PM Stefan Weil &lt;<a=
 href=3D"mailto:sw@weilnetz.de">sw@weilnetz.de</a>&gt; wrote:<br>&gt;<br>&g=
t; Am 14.09.20 um 08:27 schrieb =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo):<=
br>&gt;<br>&gt;<br>&gt; Thanks, I am learning how to submit patches properl=
y, in old days, =C2=A0when I am using pull request on github have no such p=
roblems. easy to follow up<br>&gt;<br>&gt;<br>&gt; May I also ask you to se=
nd text-only e-mails? Your HTML e-mails are really hard to read.<br>&gt;<br=
>&gt; Thanks,<br>&gt;<br>&gt; Stefan Weil<br>&gt;<br>&gt;<div>Sorry, I am u=
sing gmail to send, I&#39;ll review the email format in latter messages</di=
v><div><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<b=
r>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincer=
ely,<br>Yonggang Luo</div></div>

--000000000000d7b3ed05af408240--


Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53F5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:58:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B5C206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfQRWZwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B5C206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssnC-0001Wt-1G
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsseW-0002rO-6y
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:49:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50573
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsseU-0007tz-JZ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594147749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mcIBbbNp6MkqqzKMP2EUPSx/4Lp2CssnF6segfvEJiY=;
 b=hfQRWZwMzbEGjCxeLho9tejTXuHYUgrAfvMTdlTtUgiHZ13OvphS9THcpa//35C5nA1rep
 49bH5Clw+vSouyW2g2lKiI8/vjJ0XiZDjaa+0IUGbW/gqZX44J/qIwGUsD3D/9mMJRdq2u
 NHfga8M1qFJLJ2FYZ5/61Bvfhp2qJ4o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-R3yv1P3RNlO6hAVzj2U8ow-1; Tue, 07 Jul 2020 14:49:06 -0400
X-MC-Unique: R3yv1P3RNlO6hAVzj2U8ow-1
Received: by mail-ed1-f72.google.com with SMTP id da18so55198346edb.13
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mcIBbbNp6MkqqzKMP2EUPSx/4Lp2CssnF6segfvEJiY=;
 b=eMkz5vDMMujTVsegGI0pcRTpyeINND6sOAlFQPpJCcYMhjaKhG7SnATLSi+02s7IES
 sMHyVVyRi8qJiyJB47L2EV4u4zeZfmuSB1+4eRKdD5mvbHkDsBnVU5utp4/exuCBjnjf
 OIa0Vgcg1ZmARBvh40coFCPckHKRtPCDw8AhUEa6Cz1gFqv5iU5IbnL6dPj/WOyfkktu
 hKJBOUv3VPzkCbrMp2CGprlRLFvPz5714xI9v+wP4W3gnz9hDQrlNljtUDE2UNswGn2y
 SsWK1xf314fkmeRfWUfYYeqiXTfWPOZbbZRbge6onLvSwnK6UwHc+lFyhHF8ASRqTEfQ
 VoyA==
X-Gm-Message-State: AOAM531etfVtfWWkNNZIiIioLUGexJ718FIp3EupzIFyTqk91FqM9NXB
 mYTV2lKafx1m2plmBKEQQ6TU1W6isaJb9kYyFNVvd3HHtAb057P8hLkrcKvIq1qn8Y1i8ZAAUtY
 LfJR4V4FIHjy3qlim8TYzMeSco7YEjzo=
X-Received: by 2002:a17:906:7d90:: with SMTP id
 v16mr22612051ejo.27.1594147745111; 
 Tue, 07 Jul 2020 11:49:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnP3yibEgJDYoBhejsCgeq5BfHnfa5qyyeNilP8HfDm21Zro9e7Z36QVBAVFlTqG3SohJVxotM2BSQoYBOqlM=
X-Received: by 2002:a17:906:7d90:: with SMTP id
 v16mr22612039ejo.27.1594147744918; 
 Tue, 07 Jul 2020 11:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200706164155.24696-1-pbonzini@redhat.com>
 <CAFEAcA-F1FGde+=c3iS3wcRWG+i0RgYj5-jwafn0sX6EEYEsWA@mail.gmail.com>
 <CAFEAcA_9Yh02ecxuYR0cGJHkf1dzNT7ain7Nv01a+QL2wnrQAA@mail.gmail.com>
In-Reply-To: <CAFEAcA_9Yh02ecxuYR0cGJHkf1dzNT7ain7Nv01a+QL2wnrQAA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 7 Jul 2020 20:48:53 +0200
Message-ID: <CABgObfZxSzbkdkY_qsLDwahz+6UegAiykuud38TJ7FPeUwAdxg@mail.gmail.com>
Subject: Re: [PULL 00/53] Misc patches for QEMU 5.1 soft freeze
To: Peter Maydell <peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000000e47c905a9de72ae"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000e47c905a9de72ae
Content-Type: text/plain; charset="UTF-8"

Il mar 7 lug 2020, 20:42 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> Also it broke my working tree, in the sense that when I
> rolled back to current master incremental-rebuild didn't
> work but instead failed with:
>
> make: *** No rule to make target '/home/ubuntu/qemu/Kconfig', needed
> by 'aarch64-softmmu/config-devices.mak'.  Stop.
>

The latter is unfortunately expected. I am curious about the s390 failure
and especially the x86 link failure which might be a semantic conflict. I
will try to reproduce them locally.

Paolo

>
> thanks
> -- PMM
>
>

--0000000000000e47c905a9de72ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 7 lug 2020, 20:42 Peter Maydell &lt;<a href=3D"=
mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Also it broke my working tree, i=
n the sense that when I<br>
rolled back to current master incremental-rebuild didn&#39;t<br>
work but instead failed with:<br>
<br>
make: *** No rule to make target &#39;/home/ubuntu/qemu/Kconfig&#39;, neede=
d<br>
by &#39;aarch64-softmmu/config-devices.mak&#39;.=C2=A0 Stop.<br></blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">The latter is u=
nfortunately expected. I am curious about the s390 failure and especially t=
he x86 link failure which might be a semantic conflict. I will try to repro=
duce them locally.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=
</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--0000000000000e47c905a9de72ae--



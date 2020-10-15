Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE24C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CA520714
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqAgvn6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CA520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTB15-0003HK-Ql
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 17:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTB04-0002WT-7t
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTB01-0003j0-Hd
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602798083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T/4Awa8HkjNeXy16CMVxMoHPpY8ytDUVR2Tlwb7RGew=;
 b=fqAgvn6Y3VHCbglGSqI23BC77Gx93tYmaL6Lssgg08uhRc1fgjnKlhQ9PcBOXX/1lXkFLN
 nyuI5+nbCqpErmX/39XvCNCqksu1EB0P8p8WONUG8EzTYLX4D1mpt8hZZDlgnxTAOECW3g
 8TUOiIi5ieD+BWuq23HBQIrroERlfR0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-0uhx6LUsMQaaPqetgcRKEg-1; Thu, 15 Oct 2020 17:41:20 -0400
X-MC-Unique: 0uhx6LUsMQaaPqetgcRKEg-1
Received: by mail-ej1-f71.google.com with SMTP id p19so81389ejy.11
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 14:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T/4Awa8HkjNeXy16CMVxMoHPpY8ytDUVR2Tlwb7RGew=;
 b=kNFXqa7kwMItvRQpOHcDxBE9vpfcPLdLIzIYBSy9/c4TY58xlpKny3gA+wmNYNU15z
 7kyZNYKd5gSKv3feixTYOQUWTpfz4UF22FJUccWK/v0p0U+98tDEvUHUoJzEAMaGC7qt
 uWqpXCYqDHHik4Rpo1ndniIOaj+bBS0Ln+UX+xOavJ6z1W86ODORb3g1PqdJrZSqHH7L
 klHfjB6lf5E2K5hKUSqzZ2xrlm4JhvFwdL9YnUbz/8XHw5UTFe4C81KRFXqC498TbyCx
 RXOib08uQ6MYtk+rx/inddLnOjrMP2ibOoYBhhQBNgsNzoWF0b+JkNGT//XBUwSs8eil
 sWXQ==
X-Gm-Message-State: AOAM530mg59SpVBdgpb/kvK6n7JKT1vuUY4FMoI9SsieHmnP0Q/MKikA
 iVcNR5SL/PFpSu0rkzr3G7CuwS6+O+W3pBvI9J07q5tpSH62gk0DR+pCfB0pNv+WHhIRs8K/VGT
 LW+yeEVX1TUOU2P3LolB6FFy0NFFO4/w=
X-Received: by 2002:a17:906:cc83:: with SMTP id
 oq3mr391375ejb.71.1602798079109; 
 Thu, 15 Oct 2020 14:41:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlu+G3gzPR+LVGtpt4iOWVCGv8f2worXuaTUKtRqBBr54A5TIjlSytIFPN0KNh6drgE1aRAUA+ZtcJR/zVe1Y=
X-Received: by 2002:a17:906:cc83:: with SMTP id
 oq3mr391350ejb.71.1602798078857; 
 Thu, 15 Oct 2020 14:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201014135416.1290679-1-pbonzini@redhat.com>
 <CABLmASGJOFbYUhSAbKhc9s1G00Jh0vN--WaFPtaoHqsL2WuvbQ@mail.gmail.com>
 <44d3eccf-3c64-82cd-b5b2-641de6960ab5@redhat.com>
 <CABLmASE55n6h=fr8UrKOHdu1Z_P-46a9t4L0KaRxvvf0hob01w@mail.gmail.com>
 <214e983c-b9e8-d03d-099e-d8fe506e6a7b@t-online.de>
 <3ea54584-e67c-579e-9f5f-900611d072a1@ilande.co.uk>
In-Reply-To: <3ea54584-e67c-579e-9f5f-900611d072a1@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Oct 2020 23:41:07 +0200
Message-ID: <CABgObfaWkeiLEuigNoL3pmK05fKMbyEjtPG3SV2B4p6ZxEiQDQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] build: replace ninjatool with ninja
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000023290205b1bc8267"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 qemu-devel <qemu-devel@nongnu.org>, Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000023290205b1bc8267
Content-Type: text/plain; charset="UTF-8"

Il gio 15 ott 2020, 20:49 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
ha scritto:

> Is there any reason why
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg06997.html still
> can't be
> merged?
>

Because it's not the right approach. There is no reason why building
firmware cannot be done with cross compilers, so moving those directories
to Meson (not because Meson can't handle them; more specifically, the issue
is tying the firmware build to the QEMU build system) is going in the wrong
direction.

The "Canadian cross" scenario, where you build on Linux a mingw GCC but the
compiler is s390, is not even enough to describe the complexity in the case
of QEMU, because there are multiple firmware for different machines.

However we already have all the infrastructure to do such builds, we just
don't use it for the firmware. So, instead of the patch you recalled above,
the tests/tcg machinery should be extended into something that can be
reused for firmware. As an aside, orchestrating this multi-compiler part of
the build is what the Makefiles will keep on handling for the foreseeable
future. As an aside to the aside, tests/tcg is more than underdocumented
and I forget everything about it 5 minutes after looking at it.

This is not something that I will be able to work on anytime soon. But
still I don't think that going in the wrong direction is a good idea, even
if temporarily.

Paolo


>
> ATB,
>
> Mark.
>
>

--00000000000023290205b1bc8267
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 15 ott 2020, 20:49 Mark Cave-Ayland &lt;<a href=
=3D"mailto:mark.cave-ayland@ilande.co.uk">mark.cave-ayland@ilande.co.uk</a>=
&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Is there any reaso=
n why <br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg06997.h=
tml" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu.org/=
archive/html/qemu-devel/2020-09/msg06997.html</a> still can&#39;t be <br>
merged?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Because it&#39;s not the right approach. There is no reason why buil=
ding firmware cannot be done with cross compilers, so moving those director=
ies to Meson (not because Meson can&#39;t handle them; more specifically, t=
he issue is tying the firmware build to the QEMU build system) is going in =
the wrong direction.</div><div dir=3D"auto"><br></div><div dir=3D"auto">The=
 &quot;Canadian cross&quot; scenario, where you build on Linux a mingw GCC =
but the compiler is s390, is not even enough to describe the complexity in =
the case of QEMU, because there are multiple firmware for different machine=
s.</div><div dir=3D"auto"><br></div><div dir=3D"auto">However we already ha=
ve all the infrastructure to do such builds, we just don&#39;t use it for t=
he firmware. So, instead of the patch you recalled above, the tests/tcg mac=
hinery should be extended into something that can be reused for firmware. A=
s an aside, orchestrating this multi-compiler part of the build is what the=
 Makefiles will keep on handling for the foreseeable future. As an aside to=
 the aside, tests/tcg is more than underdocumented and I forget everything =
about it 5 minutes after looking at it.</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">This is not something that I will be able to work on anytim=
e soon. But still I don&#39;t think that going in the wrong direction is a =
good idea, even if temporarily.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div></div></div>

--00000000000023290205b1bc8267--



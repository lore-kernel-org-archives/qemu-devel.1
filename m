Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22B1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 21:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65156206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 21:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HisNGb7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65156206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5FYh-0006IS-Kk
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 17:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <briannorris@chromium.org>)
 id 1k5FXn-0005o6-58
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 17:41:23 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:36991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <briannorris@chromium.org>)
 id 1k5FXk-0000ww-Rd
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 17:41:22 -0400
Received: by mail-qk1-x743.google.com with SMTP id b14so9889866qkn.4
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 14:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HZsO2dv2rRsgN3EEvMixhb+Ya1sVBBTAm9B5fRuTNpo=;
 b=HisNGb7E0XH4cAGAwzh6SDhhQEN97ulMXS04Oiffb6B9Ik9OIY6pLiYTa6jt+gKlpU
 fiGXdGbwiQJSNVmVqJNP0mfld0tPVA6OAJqEV2d4+NIf7ogVLByw3AflrhMBHriqG3hH
 kb4ea2mNZQ2S3ombELmdctCdQIG6ARoJtHBU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HZsO2dv2rRsgN3EEvMixhb+Ya1sVBBTAm9B5fRuTNpo=;
 b=TGboMtH/+vcX5Yh4FAjJET9SMXXz8zTrNQoV3KU2afOflNAxn67wG85XsLPRfOlg09
 3Dce7ECptc8oAHXGpfcUUjYzvW/3tvSu1NQVWzO3mqKA901ZLDOPBvlahmsQyKuxPCm7
 H8CC0IB9LorGQYaHlzeJSP2ub6SMJ8AcsRg2XG+mubjf+83R6s0NSh8u88iJB6EWT67a
 7i+UuZM6ociVkm4LPTx7AMS6xReZWGFSB7x+8MOJCFFL2lDX+OJqEpiQ3U5fASOkKG38
 yFL1BWwqS/mH5tYWiiP7W13cVlm3fwVGHq/d0jTgh6Dh2TfxrSbLWfbug3EaZzYL1NJF
 MiNg==
X-Gm-Message-State: AOAM532f9mF23bgV6agVHhzrjwyfPFFzeI1a9ot64ZZlQogu2ijeeFO/
 iBDJjKqkRQD+JOxmbtv2fD1mxgqy+9g=
X-Google-Smtp-Source: ABdhPJzoJq+ZJsMQiH+R1hcjx0n445TZOnOeAL/ZiU94AawsLLjlPzdwhfpOBarFFzNwzegx8bJgjA==
X-Received: by 2002:a37:a0d1:: with SMTP id
 j200mr28912988qke.212.1597095677594; 
 Mon, 10 Aug 2020 14:41:17 -0700 (PDT)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com.
 [209.85.219.54])
 by smtp.gmail.com with ESMTPSA id 9sm16389688qtg.4.2020.08.10.14.41.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 14:41:16 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id x6so5012311qvr.8
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 14:41:15 -0700 (PDT)
X-Received: by 2002:a0c:ffc6:: with SMTP id h6mr31027956qvv.251.1597095675423; 
 Mon, 10 Aug 2020 14:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200615225827.183062-1-joe.slater@windriver.com>
 <CAFEAcA_ZU_w7PaYFVVaW1vzGySOLaNaThVcNQFNmd_GV-hG6Qw@mail.gmail.com>
 <CAFEAcA8BtVkBbHtLt-kB-AcZnN9YWtBahKTQ0wSvHWojF9CinQ@mail.gmail.com>
 <CAMxuvaxUqrq77_io9j6k7EU91vm7iEEBaTwLNsKd9YJ9NVR7rw@mail.gmail.com>
 <20200808013531.GA166030@google.com>
 <CAFEAcA__4GwKKe9rY4ut41f-S-u_AnSkdwHvSX0YoaPwjO3ARw@mail.gmail.com>
 <CAMxuvaw1Rpah2ErvGQWdD+K+KU=PFpfyNnM-95s5UUSXY6zj6Q@mail.gmail.com>
In-Reply-To: <CAMxuvaw1Rpah2ErvGQWdD+K+KU=PFpfyNnM-95s5UUSXY6zj6Q@mail.gmail.com>
From: Brian Norris <briannorris@chromium.org>
Date: Mon, 10 Aug 2020 14:41:02 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMFw_-EH0Rt7AfLRHxent3o0ephp+GehZQkKbUioHMhBw@mail.gmail.com>
Message-ID: <CA+ASDXMFw_-EH0Rt7AfLRHxent3o0ephp+GehZQkKbUioHMhBw@mail.gmail.com>
Subject: Re: [PATCH 1/1] os_find_datadir: search as in version 4.2
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=briannorris@chromium.org; helo=mail-qk1-x743.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Joe Slater <joe.slater@windriver.com>, "MacLeod,
 Randy" <randy.macleod@windriver.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 10, 2020 at 12:29 AM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> On Sat, Aug 8, 2020 at 7:34 PM Peter Maydell <peter.maydell@linaro.org> w=
rote:
> > On Sat, 8 Aug 2020 at 02:35, Brian Norris <briannorris@chromium.org> wr=
ote:
> > > Add one more to the pile! Chrome OS noticed this when upgrading to
> > > 5.0.0:
> > >
> > > https://bugs.chromium.org/p/chromium/issues/detail?id=3D1114204#c8
> > >
> > > I'd love to see this applied to a release.
> >
> > It's just missed 5.1, unfortunately :-(
> >
> > Marc-Andr=C3=A9, did you want to review it ?
>
> I tried an alternative approach, and ack his version instead:
>
> https://patchew.org/QEMU/20200716141100.398296-1-marcandre.lureau@redhat.=
com/
>
> (I am going to do this in this thread instead)

FWIW, you already provided your Review a month ago:
https://lore.kernel.org/qemu-devel/CAJ+F1CJmMV6pY6r0P6ukNZA_q+w6yLvAxekGnus=
gXYuuip6gZA@mail.gmail.com/

But I see you've now repeated it ;)
https://lore.kernel.org/qemu-devel/CAJ+F1CJdHo7R9rnmoD1cLEzsYLFsFVVjcAr5Ucs=
YFgfcW3z2LA@mail.gmail.com/

In any case, thanks! We'll likely carry this patch in Chrome OS, until
it gets applied to a proper release.

Regards,
Brian


Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBFAC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A632320663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JGbZ1SYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A632320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEaAR-0000Vp-SC
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 10:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEa9Q-00083s-Bm
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEa9L-0004S6-A7
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:58:32 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEa9L-0004KF-3X
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:58:27 -0400
Received: by mail-ot1-x342.google.com with SMTP id a6so25700179otb.10
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nkXtkiR13VRPgpVNrGEHjZ3vwjLjd2T2olItcQ6v2Is=;
 b=JGbZ1SYy1UNsdF5eCBU3pl88jkm4UVzWubLyZQSs1nGLG8rJY9AFbv5B9Oi5OViKPf
 txhworzD1qO3PhyXO9dTOJrmeFwAc3SnhViRkORGdnldhNKaCBogglCk72urRkyeRcze
 muA1gOd9GpdRmXnH7Mtth2m9TIjYkHPt5I/xdc4eQT2EvZXcA2o2NHqc2sRJOm1ZmnTw
 puglum/lDoOv2L7NfS6ZbcSVfffnWTLl9CB56GoUePepMfm4TNVla+sENUEgPoMyb3RT
 F6mlXc1ogodpcCcKP4BoOq2114owQYvU3hjoEY5sFZ1LfevhS1Fb0DXrwjaycgRWuKHX
 3OOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nkXtkiR13VRPgpVNrGEHjZ3vwjLjd2T2olItcQ6v2Is=;
 b=hrvDsk3gOC20oeKHQ96Aq0bCvf5nhURMZv8YHF5BRw4wL0Njv5u2YAP15wL1Yrp9jw
 e/a81hNtJFe1Rp+rx1uN7IfUSt0Lf/LT8ncd+tj74XFy6kOacNcQbXTsjKan2V98ro9B
 Dk3njkcOGopL+BJkomdF5HKBNZ3GWsWmq8+YpAyVgGWupABhuUosavzcSEa7tMEf4pOj
 l++Fdp7iTRDqBl/kmyPjVZApj37z6AErjGrvmgGKyMFgS/ZsHSVozlVBv2YL2ShW9di3
 NO2o0FNPr2pD+Im2v6rE+AxJK5uy6mjJtBaqBu0vdzXI2PG+H9xwErn8/OMgSEFxDFZk
 DTCA==
X-Gm-Message-State: ANhLgQ3EFZK+laTJGKvkZcrJYDelVtpAv6+IomZv583Qkp+MdBE7EgGs
 oll1nwjfXAwaEavvRsfVW/B835saT/tqyVIQnkz1og==
X-Google-Smtp-Source: ADFU+vse+lRtcL6v0ZeI6Jkqb5U32Xu41HaW2NA/dF64GCkgMVEVVVN0MkcVDXe8NZz7gHwZ54pxqpC/Yidj6kP5Yaw=
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr4192034otm.91.1584543505511; 
 Wed, 18 Mar 2020 07:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
 <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
 <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
 <0c3ae5aa-36c3-a809-4a42-159348f44780@huawei.com>
 <CAFEAcA8_RkECOT=YJ3ML0wxBrKiqVw=CssORU=jyryfcNueB0w@mail.gmail.com>
 <871rq08tn9.fsf@dusky.pond.sub.org>
 <eca27715-554d-2c2e-5e58-ffd01abb654c@ilande.co.uk>
 <e1ae65dd-f9cd-b0ee-0ea6-f3c2b010fdab@redhat.com>
 <87tv2p8y5j.fsf@dusky.pond.sub.org>
 <3f512e33-5875-eee4-bbe8-61e7b313743d@redhat.com>
 <87mu8g3kgj.fsf@dusky.pond.sub.org>
 <bd83fe53-6541-b04d-04d9-76ddd29e2b99@redhat.com>
 <875zf1ak9e.fsf@dusky.pond.sub.org>
 <d94927af-eb46-f704-6658-e3f321c4d8ed@redhat.com>
In-Reply-To: <d94927af-eb46-f704-6658-e3f321c4d8ed@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Mar 2020 14:58:14 +0000
Message-ID: <CAFEAcA-ZChuFvEBQHCcXrNWLKq6w8MabH+eKS2p-iBCXpOGu9g@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pan Nengyuan <pannengyuan@huawei.com>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>, Euler Robot <euler.robot@huawei.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 at 13:22, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Here are some random thoughts about it:
>
> - object initialization should cause no side effects outside the subtree
> of the object
>
> - setting properties can cause side effects outside the subtree of the
> object (e.g. marking an object as "in use"), but they must be undone by
> finalization.
>
> - realization can also cause side effects outside the subtree of the
> object, but if unrealization is possible, they must be undone by
> unrealization. if an object is realized and unrealization is not
> possible, finalization will never run (and in that case, side effects of
> realization need not be undone at all).

- if realization fails then any side effects caused by the partial
realize must be undone before returning the failure.

(I bet we don't always get this right, especially in cases where
a subclass has to call a parent class realize method...)

thanks
-- PMM


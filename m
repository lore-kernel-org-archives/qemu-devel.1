Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9173AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6DA2077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LzK+mjA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6DA2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugtv-0001uZ-8w
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iuep8-0007hR-VG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iuep7-0006oW-Rn
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:55:14 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:41889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iuep7-0006nU-KR
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:55:13 -0500
Received: by mail-ot1-x334.google.com with SMTP id r27so3159263otc.8
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=0lU4XZZ9pzTu1CVQtIxWfRKfMYGst4KXpXQ/urIN9FQ=;
 b=LzK+mjA5pd/lbwmdSJdoWpjka5M4WSse2b4lm51VELc7nbebg3tjDVBn3UZ0Bss9fF
 fBAv4HTsQgBXA7TfN3pvzjZHK9hKKnG6h/N6biJYwwlLL6IJ/T5mHNuSUJ2DZ01bkWkT
 YEy7mDifzed9+AEfLJEXjVan1k8JprLY9Ki+cv1Kn6U9sEF1w+VSqa+ONz7EQ/bIRPjU
 QIqL5F34sENgfh6EJAC0R+hYytMm41by4Hxi1neOoMRQN9uCt6kk4UlYib75pP95GwxW
 voFoqpT5+U9s6JX61GOzx+JL8WBjDqk9BT6pGgwkUheGCw/WndykiubqKtskQ/unXXmH
 O1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=0lU4XZZ9pzTu1CVQtIxWfRKfMYGst4KXpXQ/urIN9FQ=;
 b=gGHbA3W3bCY55fIrvEOgn00Gf1QA1qllB3HQLFRN5QY8otXoWnuGAsDab2CoyxiPNu
 nnUutoYdhKSl7/UBOXZUx/VTNLKufLEPeSPt0+0RAZKJyKJUsBwzK0tZt0I7JglwQFzm
 WdxZ220+uRpMOJt/SVxYiDGwLSaWlBSlim4ULY7USCyWmBJbCoNpVGMR2dY+OdK5eFWB
 NTs9BI5bDTx8scFRgutun/fFFHPg+Gu4yrijNMSM3PKaM0ak0KKVnFeAXBpRk9WWRJkz
 KmcoEdI6rDsfWaxZpXQDy71BwE90nmQvfyo25GQmj2o77P5fuik5po14OfgkNPRprJ/b
 Se1w==
X-Gm-Message-State: APjAAAW7sPv+RWrt548vEH1kBjV/4+etkXSoLGewi3a0B6YegA2BI58/
 OztiGynC69RqFQHyzvlnMTwxG6IHxMCmLzVBw3guVACcnwU=
X-Google-Smtp-Source: APXvYqx9logockbtqnhxSc1zVKAsOP+xUoO5EG6kki51IrtVFZCsqUeiO6vCMmBYELwqH4emYUJvMi6gyPnyjFs+TGg=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr5925336otd.91.1579794912498; 
 Thu, 23 Jan 2020 07:55:12 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-HPAXpeWcJOvyJM3hdFR86u4HyovAAB8qmoZaye-P3Vg@mail.gmail.com>
In-Reply-To: <CAFEAcA-HPAXpeWcJOvyJM3hdFR86u4HyovAAB8qmoZaye-P3Vg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jan 2020 15:55:01 +0000
Message-ID: <CAFEAcA-1QcPEVDodRFFKQ_WdSR-avKp2rZw39KFhO_hh3y=Lxg@mail.gmail.com>
Subject: Re: 5.0 release schedule proposal
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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

On Mon, 6 Jan 2020 at 15:29, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Here's a suggested set of dates for the 5.0 release:
>
> 2020-03-17 softfreeze
> 2020-03-24 hardfreeze/rc0
> 2020-03-31 rc1
> 2020-04-07 rc2
> 2020-04-14 rc3
> 2020-04-21 release, or rc4
> 2020-04-28 release if we needed rc4
>
> (I'm at a conference week of 23-27 March, so possibly rc0
> might get a little delayed if I'm not able to handle
> pullreqs while away, but usually the big rush is for
> softfreeze so I think this should be OK.)
>
> NB: Easter is 10th-13th April, so between rc2 and rc3.
>
> Any opinions/suggested tweaks/etc?
>
> Of course if somebody else wants to do this release cycle
> they can set the dates :-)

Ping? Any opinions? In the absence of complaints I'll just
go with this set of dates...

-- PMM


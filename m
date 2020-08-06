Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4C9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 16:09:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B8E623132
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 16:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kC7xJtwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8E623132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3iSH-0007ua-FK
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 12:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3iRE-0007Sr-F8
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 12:08:16 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:44638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3iRC-00016o-Jp
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 12:08:15 -0400
Received: by mail-oi1-x235.google.com with SMTP id h3so19750527oie.11
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gkyW8eHcJw+pqfZgFew1VKQf5XKBMT/BT9kwvQ8nni0=;
 b=kC7xJtwQW44pw3JZiBoO9Mvyo5hfFvnitD/GMoPj9QOsGdHnfOlKPeImgWz5Ahvrgd
 5L4HoprgY07OO3ZY9QLzf7qnZokgXumV/fGFfxKdyyy34unVT70iczfZo+GNk1gdfj2D
 DOqv0csbUFfERcN1d5HSXdLjhxEwxF0mXzD9F38dYbkRSddkGbvGaDybmG9VAXiuZT4I
 csWxAn3cWgRDXKFTce6QW3Om79GflCBT5Wi7heDxjc3C8o6koCrYdseDZlydVU+O9zae
 oz2EFpLFb5CbP6CIA+s5sqj7ZFesX6bY7tuIYYTS/AyfPjJVhiKLD+x5GSd3ae0blrKa
 3xCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gkyW8eHcJw+pqfZgFew1VKQf5XKBMT/BT9kwvQ8nni0=;
 b=fSQzeF2EsmG7+lrVTix/UXbTlMOA1eEZhSOQvsf/5ejvMrYDXhDfDAgoQsZpbaaWJG
 qVlUXcYV14PgouID4tP0ZwoNWdXcsQGGIURNnOkTbWXkWXJr/GAqCOjnkrdRVySvN9SY
 9m4MqPUjguD7ZjDtPnC/a5yDv75LrYltwdoiVmwl6gDFP2xmuOvxa2y7BQPi51ZeTmVB
 KhmB44LxyxxWR2wjZLYPwCmVe32a65H0fjP4jtBose520Viq/oGEnEclNEixdEpLMvVA
 LPVYhMctkpgwwFzmK7Hya1KoJ2wZZpl0De/dHikl6iEHFo+BfxvM/1H2NCHmNuGfvMWm
 lDqw==
X-Gm-Message-State: AOAM532zXKDd14O1KzJ/5ZeZWLP7ENs3oXncx2pw6XQ27mKE7QHXb5uU
 2o7HHI0jYyUPzHKQeAgi5aJCjui85udugSc0nHY+SA==
X-Google-Smtp-Source: ABdhPJzY6mWYFJfYLDuEBt0bb/QSUbJqSpWr6Gr8hxX+M7EcCS74Q+0AU3otwGdXHs/2GHqdcDf9vdGf5TkicXXu4xA=
X-Received: by 2002:aca:4a96:: with SMTP id x144mr7627627oia.163.1596730092883; 
 Thu, 06 Aug 2020 09:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAFubqFvm=k0FyELUd=rYK7CO=Dxns-jVxy4UGqfGfXPFNT1cFw@mail.gmail.com>
 <20200729101851-mutt-send-email-mst@kernel.org>
 <CAFubqFtJLpp0eceOKXkhuTd6Rb2xviymx6hr-qkTc9Bw1ffWtw@mail.gmail.com>
 <20200806014525-mutt-send-email-mst@kernel.org>
 <CAFEAcA_+GN8acwnHkEixLS6d-pQePSZBzp1PiXYV3ZXLE9Rxcw@mail.gmail.com>
In-Reply-To: <CAFEAcA_+GN8acwnHkEixLS6d-pQePSZBzp1PiXYV3ZXLE9Rxcw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Aug 2020 17:08:01 +0100
Message-ID: <CAFEAcA8ZE+OCeYj3O-x3H1GfUsYwLvzSLLp-rUqg1AqHYosZhw@mail.gmail.com>
Subject: Re: Adding VHOST_USER_PROTOCOL_F_CONFIG_MEM_SLOTS to 5.1 release notes
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x235.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 13:22, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 6 Aug 2020 at 06:50, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Peter, can you pls allow Raphael wiki access? I don't remember how it's done ...
>
> Anybody with an account can create a new account for somebody
> else via the https://en.wikipedia.org/wiki/Special:CreateAccount

Wrong link, obviously :-) I meant
https://wiki.qemu.org/Special:CreateAccount

-- PMM


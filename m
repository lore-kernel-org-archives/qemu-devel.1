Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDBEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:22:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C46722CF6
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDLk25qU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C46722CF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ev6-0001wH-Ku
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 08:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3euZ-0001Vs-7E
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:22:19 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:36761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3euX-0002Q8-Ge
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:22:18 -0400
Received: by mail-ot1-x32f.google.com with SMTP id x24so11858090otp.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 05:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vofTkXNCIB+MzLrKaqJX/yuQ5xQTKXXr/nZs/+pIscU=;
 b=VDLk25qUH5DTRl3x6E1kCyzAk+1OypYaPqIytNN+mextpSTKmcKrBGsAmVq6umSkW7
 uTeTOXJ3a6fHPTVuZWAPNNEo/AU16NE/8U4YSjj9W/n0rzsOkhH4BXbjtywC7pEsJ0wN
 ob/SVEwpu1oKb7JMIvzBddQcxHoJ3Q5BE9Ik8/DpMj4fsgQQhrL3lVqxmOd93YwXfhje
 fhQ3rwcqWU5XJvCnxrGfouYFpoE3V0jz43pXgYft10CwIie1u71ygMpywKt+MOxNEXzF
 M683kaZZJcEnmN747Z/sugF91gLZXFqwYqLzuRwMzWlVYC0Sdt3h3+SCY5uGMa4DtNBA
 5fCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vofTkXNCIB+MzLrKaqJX/yuQ5xQTKXXr/nZs/+pIscU=;
 b=ueRLrBfahJ1vtWVlgj84oOoiJwW7mzq9hzSYmtvBlvKEH1iSEwSJZOQj8pQvMQCrDS
 2ZBQTkVB3Sdvlk8Jprs1a0Lln35Wxjv7/6vbtfrhgg+IY6tsrdzLwAeKaQJoM0Be6Gk4
 j8t8OE943ICAb306aa0LYO6lLvlpj+Ryqpg4LKGLv0gfhm0x3FTfIpefKNrAH39ifINu
 qGhu5qo/WLBQFMl9f7THJXoBddLp4FBfhfmqKrYgL8DfL/CrJRxLXr9stBNKONAFhYYV
 747gJQe3B1sYB7hImIDm6Yx/tUlTqLp9AuIq5CxOayUrCCu0W+4awvs0iDuVvJcnjW8W
 6/zw==
X-Gm-Message-State: AOAM532W+LhHVvlTIFME2r2HLyRZBVbpLTad+8Nsk9Dl4qFkb+aeYKz0
 WtAUpfGc6gfRcBhjJVuLhBsTpmivCJ3gq4xHKKmlXQ==
X-Google-Smtp-Source: ABdhPJx/mP20P9uOBgPAHfVk3a4YMfRaYCCXDhNAssYOCVbbcTWo/NgFl/YVIvLAUWt1YMhPf0GDlfg6hS/doUxbvjw=
X-Received: by 2002:a9d:39c2:: with SMTP id y60mr6899082otb.91.1596716536064; 
 Thu, 06 Aug 2020 05:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAFubqFvm=k0FyELUd=rYK7CO=Dxns-jVxy4UGqfGfXPFNT1cFw@mail.gmail.com>
 <20200729101851-mutt-send-email-mst@kernel.org>
 <CAFubqFtJLpp0eceOKXkhuTd6Rb2xviymx6hr-qkTc9Bw1ffWtw@mail.gmail.com>
 <20200806014525-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200806014525-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Aug 2020 13:22:04 +0100
Message-ID: <CAFEAcA_+GN8acwnHkEixLS6d-pQePSZBzp1PiXYV3ZXLE9Rxcw@mail.gmail.com>
Subject: Re: Adding VHOST_USER_PROTOCOL_F_CONFIG_MEM_SLOTS to 5.1 release notes
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32f.google.com
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

On Thu, 6 Aug 2020 at 06:50, Michael S. Tsirkin <mst@redhat.com> wrote:
> Peter, can you pls allow Raphael wiki access? I don't remember how it's done ...

Anybody with an account can create a new account for somebody
else via the https://en.wikipedia.org/wiki/Special:CreateAccount
page. (It's only not self-sign-up because we were bombarded
with spam accounts.)

Raphael, what username would you like?

thanks
-- PMM


Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A832C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 00:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B752085A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 00:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="C8PfRk9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B752085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34280 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdOOu-0003FG-DU
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 20:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44303)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jimw@sifive.com>) id 1hdOOH-0002kR-Bm
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jimw@sifive.com>) id 1hdOOG-00043H-Bg
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:23:53 -0400
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44]:34834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jimw@sifive.com>) id 1hdOOG-00042g-7O
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:23:52 -0400
Received: by mail-vk1-xa44.google.com with SMTP id k1so3215135vkb.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 17:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A6mctPLzy4WhUPbX0sqvg3Eh1vC+ctMC4CWRi22Z9h0=;
 b=C8PfRk9jcz0FhKUSCQjvEYA9AXAq9OJ82QdHcfC7Elw6BAmUF94T4IaBipovkn4xS7
 yAQO0SMgGuG2L4UsSQp/W2rtiytg5x5wYZaW5MqoO/IchcVuexCTO8ktccxYi8fvk0O5
 rRnzUj0rzLEydOvuC0XvvsMbA1bNZLwyZPRbHZCIUxnrrhUPwZTymtrwbcVdo0ZoCR8f
 62Hy/owlV/6V3I7ESqltz3XpehsGNPjeaT0jpV/mMEVodJKZX5Nbx0yBCTG1/Mome7bp
 q/ezxtl2imamRBH626KHsQXTXmFpQEgKPp0X5d1OpOnoClu46kfSccuymc2TN4LZeTvb
 A9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A6mctPLzy4WhUPbX0sqvg3Eh1vC+ctMC4CWRi22Z9h0=;
 b=K9VhSvaEFbXsgMwAxao+CkSWtlOBvsz164SojvwAZ3yn4p3sbDkdexeO2fNOO9b3oI
 MsbYR4Q11uEiwgfxIFN/7EImsLrCsm5fLi7YWcaEDy3Ln69atkn75D9FXbEE5s6734sv
 k4aKkWESeAHXlbxazqfgSxGlazo2wh84DiyTggVWq64388fdio8iJre8O8nZELK8rWDQ
 YP5pSX4yf59915tyxX9LQL50Syl253Zd4VVErjI8tv8KpTSR4LF7bwpWrDMRaCyfRSft
 BPabCtwrDAKyBMNv87SNJYRpN6bWnWzjAJitR2vi3a5fQT117TMR72OL5al82RldNWCD
 JchA==
X-Gm-Message-State: APjAAAW9qKzQ36anj+zUpkufmneZXxSPlwNKOet6/ZNBZfLBCkZK+jLj
 2VvxvHdg9OX39e76MlZOeforVWYdLo+X8nhzukwoEg==
X-Google-Smtp-Source: APXvYqxMdPPGmtJmk2BVuLSqIJmKGApMT4D2/TV2Y0OFrohZjvrmVZx2f+lsIe3MeKhAap2ERmXZxrKx95BLRq2fYUI=
X-Received: by 2002:a1f:17d2:: with SMTP id 201mr576876vkx.50.1560903831470;
 Tue, 18 Jun 2019 17:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <1559903719-7162-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1559903719-7162-4-git-send-email-aleksandar.markovic@rt-rk.com>
 <121c4da9-bf13-0da3-39a9-22891dabcb5c@sifive.com>
 <CAL1e-=iArKHT+pVe5uT1v800=pGuMLB=SGpuBAZouq5-0ekfGA@mail.gmail.com>
In-Reply-To: <CAL1e-=iArKHT+pVe5uT1v800=pGuMLB=SGpuBAZouq5-0ekfGA@mail.gmail.com>
From: Jim Wilson <jimw@sifive.com>
Date: Tue, 18 Jun 2019 17:23:40 -0700
Message-ID: <CAFyWVaafcxiVMK7xTMus-z2Y0nq8DWYxzbZzbxB7G63DNUJkcg@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a44
Subject: Re: [Qemu-devel] [PATCH v10 3/3] linux-user: Add support for
 statx() syscall
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
 "lvivier@redhat.com" <lvivier@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 18, 2019 at 4:13 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> I am waiting on him to send a new version of the series. Meanwhile you can send strace patch to the list, and I can even incude it in my series after and together with Aleksandar's patch, if you don't object.

I submitted it the usual way, so it is on the mailing list now.  If
you want to include it with your patch series that is fine.
https://lists.nongnu.org/archive/html/qemu-devel/2019-06/msg04087.html

Jim


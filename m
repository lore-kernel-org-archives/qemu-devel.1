Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A47C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 18:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA495215A4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 18:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkHsEzbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA495215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inS2S-00029T-VQ
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 13:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1inS1m-0001NQ-JO
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 13:50:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1inS1l-00052i-2B
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 13:50:30 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:37777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1inS1k-0004y0-Qw
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 13:50:28 -0500
Received: by mail-ot1-x32e.google.com with SMTP id k14so62252591otn.4
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 10:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BtdziEX1a5/ByrHx79DDm2iYiQK+ndf19aKHFR/b/ts=;
 b=dkHsEzbpo8lQUs23D283AWyZjnQuqStZ4W6LUpom5ED7wNGS+Ow2G2c2GAySevbkkw
 y0MwFiZa3zURbIzipf1guYZLWzawFUEi2gyFDMHLhHHfPu/aqj7wN5X5oFBFEk54ZXgn
 O5ZOqibOUrkTNtUGgpgHRrlLsHYjzDSdYUlMaBDLPAYNsKErgwvaMC547Aq2N6xwSpVa
 DV2GDaGVAsfnUPofZowO0t3EDmpsG/px9eub1pWoRTPLyhMmheEOJuWiR+xrmZ9fPZny
 DsizxvS5SD7mjcYwqX21dc/mZtvL4RK4ZLn6o4U4wz/ANISpxt7Zly9A5j+42pDR+o6O
 tBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BtdziEX1a5/ByrHx79DDm2iYiQK+ndf19aKHFR/b/ts=;
 b=gOYYns+jE3UlINC9UXeQMk6lNmV1WmnTpygrQU41R8shXIj4dipm6AhBOZXsLY9tcp
 bFrfJbQbFyF6eBKls+YWK9UgLPK7Av9O9iA+CJb6xT1T2LQ+ANvTx5+Hayvlt9AJSUcU
 uFma+4AqVUxnGSGYetbZYSUY9vkd5STCu6OOATzYhrpopQk12GKlWnrkCqkBvv4Ib2k1
 r7JPKBCUq0drr2erfVi9NCo+k51gxl2NKUQtqbGR6HgUy3Mn2UsZ02Z24Hzvk+M4lQWW
 t308ZxnN69JI3DkdYYYR1+vPmrILcG/TWbbaLJJkdBrVxHAT9a7WkTlFzL7EGE1LTm7A
 chbw==
X-Gm-Message-State: APjAAAXNGEUTbaAGwMy1HaAmLhFMFBdZ3KobxE0dVWi3BzeRYSYQ61Tt
 ONjFsqF8SOhyLMBFavuISZUMDYRBzPGe/cNErJYwoQ==
X-Google-Smtp-Source: APXvYqznBIWdo62PJ01WOGCFzyY4M9vmm9IKwHagw2HjG0KRWCp377o6QPJsnvdMIalNjGxMTROZej8llbu3HCzSpF0=
X-Received: by 2002:a9d:8cb:: with SMTP id 69mr81602304otf.221.1578077427881; 
 Fri, 03 Jan 2020 10:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20191220102520.1637190-1-stefanha@redhat.com>
In-Reply-To: <20191220102520.1637190-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jan 2020 18:50:17 +0000
Message-ID: <CAFEAcA-=4NTz9nXJ7LRjsGOBENviXLMxYRF9u+SR8EYbs=K=UQ@mail.gmail.com>
Subject: Re: [PULL 0/3] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Dec 2019 at 10:25, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit aceeaa69d28e6f08a24395d0aa6915b687d0a681:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-12-17' into staging (2019-12-17 15:55:20 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 725fe5d10dbd4259b1853b7d253cef83a3c0d22a:
>
>   virtio-blk: fix out-of-bounds access to bitmap in notify_guest_bh (2019-12-19 16:20:25 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM


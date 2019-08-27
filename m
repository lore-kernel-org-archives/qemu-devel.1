Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D8CC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD7D20679
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6pMTaWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD7D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2iX5-00025J-U5
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 16:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2iWH-0001O4-Bl
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2iWG-0001qJ-8A
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:56:49 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:42487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2iWG-0001oz-0Q
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:56:48 -0400
Received: by mail-ot1-x32b.google.com with SMTP id j7so532375ota.9
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 13:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YJH9ZD6A0rIR5bduPL2ZOxFIFP7ARlTu/eSspUxWsSc=;
 b=b6pMTaWjNk4ERzlgKRHO8EAaD65LRdr+y4hbZvIaeSZf3C2W2fM4kPXBHhfRYFtreR
 eBVfOOFIbc6Au2HK5RvEze2FBYGolzZ9BUbAgStRV2Jhp0MqpRKs9TR/h7DV0dupxyN7
 +eFXfJDm04NPRlEWiUNqCSPTeBp7HGAgXHyLFZMV+JqQpcjvlqW7/NLuElJMGTfIjAbz
 olh/9nkrZOstPRpo1zk3W8gl6STxU3MNefi7YB2ZFD5+STvesrmTZozuLRAfcUnaHjZn
 XLl+H+4fjwlilTupejjq7qFF7+SToCX4nBYVSZzp76dTFNQiZLp7EIlFhbI5pBG9rfOg
 8YNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YJH9ZD6A0rIR5bduPL2ZOxFIFP7ARlTu/eSspUxWsSc=;
 b=EPvoovx0UnRQh/Jf0ggR/+6HpQFMRJzO6kkhlFT88+ZVUjS+h6JkjFaqC0t/Vp708R
 duDYuFdS7DwTJszUI56ZAEzbbGw0aAuVZ/j43kVmKpmRB7tCUVdNGyaF8xZKTpCJbxR4
 C3aC5YjcbGr+XBG5tDplWhzyhxPCmDwxlcNJq3KCWQld3yZXQtLj0/mheW0dYDf89Sz0
 mhu4YybkRtrOBq0AG7T3koBgIOl7ygtmXKWgrYE1yB+8cTqJbU8gZbbuXeHcqZW6aO2+
 e5LEWjyChCGj2QfxJj2dNlUjHSwAXiyjOb1i/FPagaF32P0QkfGzH1K0SonLZ5yjZcwD
 fUKw==
X-Gm-Message-State: APjAAAU2F/yJaKlVGB+ktnI6pVPUhZ0zGfX24/MHbLqu2+FLuVSwptXa
 Zc6SujiG2NCoUJXCn1ibcvg+f7G7Esn9V+0ul3IUFg==
X-Google-Smtp-Source: APXvYqxG5EfsYgtw1RjcLZYGIoO3cPu6CpYsrnBLCfFkS+O6NBM3tp2s7Aa+AZvi0fdWeEeOAA63WazKrLSu57Qj/tY=
X-Received: by 2002:a05:6830:1015:: with SMTP id
 a21mr515331otp.232.1566939405960; 
 Tue, 27 Aug 2019 13:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAJzA9zP0GnZ17_YSxUhAGFrD_fCM-R=rxEVN5y9V-5-5zTsnVw@mail.gmail.com>
 <a7c948d1-1c2d-aee6-96a3-bf146004fd07@redhat.com>
In-Reply-To: <a7c948d1-1c2d-aee6-96a3-bf146004fd07@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 21:56:34 +0100
Message-ID: <CAFEAcA-Faa7j+Dv0L5KPDDwuEvaRMNYNeUNzB8p=ceD3vhyzDw@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] GSoC project: API Documentation Generation links
 and comments
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Gabriel Barreto <sbarreto.gabriel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Aug 2019 at 21:52, John Snow <jsnow@redhat.com> wrote:
> - For theming, I'm a fan of the RTD theme, because I think it makes the
> TOC tree stand out better and makes for nicer browsing than the default
> alabaster theme. Maybe when there's a better over-arching TOC laid out
> with better organization we could see which themes the list likes best.

FWIW, for the in-tree doc generation I opted for Alabaster
(though I prefer RTD's look as well) because Alabaster doesn't
require shipping any fonts, whereas RTD does, and it seemed
easier to sidestep any questions about whether a font file in the
docs was mere aggregation or not. For "putting docs up on the
website" this doesn't apply so much, I think. Awkwardly, the
two themes aren't completely drop-in replacements, though:
I found that some of the tweaks needed for stuff like the
sidebar to come out the way I wanted were theme-specific.

thanks
-- PMM


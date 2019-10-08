Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E70AC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 10:00:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57BD3206C2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 10:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1Evn/sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BD3206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHmIA-0001yy-JX
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 06:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHmFP-000820-M8
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHmFO-0006R2-5M
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:57:39 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:43695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHmFN-0006Qb-RB
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:57:38 -0400
Received: by mail-ot1-x332.google.com with SMTP id o44so13508783ota.10
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 02:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D13pewKTt+ou6RsTveVPxMhhdKYqgZRQ7EBE92YklA0=;
 b=K1Evn/sm/vZzctXgRmtWfCkocKd5tQZy+i+9n+mI4az8FS0BTrC578ddsv2nPp9H6W
 jjdASF6RtwIbAA+wvXZLP8FNP2WFT325BCPlcpeyyowZducqXe/+yF4gZ4O8CqkSbbAS
 d4+87PEKUcinSYcDVWDK/3lnGT87m7INRAUoQ3U7JjD30/pNSzBKG2WfNr45cPg8N+UY
 SonErEeZIcPCfrxceWzMzTQnFXyuEePL535S/SDqw+E/oXyrlkljei7roINqby457ct5
 svuj/ZamA2muMOmOxdgc6QNiT6dVvCP9ejTcgEi7MMeLuFbqu+CWMdg77pyFnk9X/8U5
 23QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D13pewKTt+ou6RsTveVPxMhhdKYqgZRQ7EBE92YklA0=;
 b=EPF2vnCwXqhC0jrwUrfWGDCAKmkzwJXtuJtWhpnet75fSQoCpx0KTEZmFE9PycoFsc
 2Z2v/UZAe5y04bXspO+wtQ5iT4iSHwCqIsr+KObU33MFPe/W3+Cn5vVSBZwVeZAnH2ns
 gYN9HdekmP77wGPaYkzw4LmKzf57m5pBMlSRSgq1S4NF9qHv0ltCy43XXhssMACpUpZT
 St8P5PjzZNn30UMk+y0GtI+Hr35pRrrZ+qzkJdL1aqZ5BQoe2tQyvsXIzCNt+c3POZlI
 icejPRbHiJp84/q4K9JdUEoYbqBgW1Q93/iZ/NSmRVXLX3W7jVTj4nCsOlsPQfXS4KDR
 lRuQ==
X-Gm-Message-State: APjAAAVRT9/TZ9GCW54933uaJ3Xea2ubmKJTfqB2XMEGOeMnCR1aaB7j
 Nh0xFQIT5Bt3klA2yKR2TKTUkVkq0w1qlf2ddi1n+Q==
X-Google-Smtp-Source: APXvYqz2+hY1D57BGw/9vwSwt7Fj6hmKAVQbirx9ww7vAMPNsw71S48blexMhD6eRU16LTIcEyrWc7eKrN/fQJoXLwA=
X-Received: by 2002:a9d:6d0a:: with SMTP id o10mr23091886otp.221.1570528656761; 
 Tue, 08 Oct 2019 02:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_1EC21D026D3BC78502F7A9F0@qq.com>
In-Reply-To: <tencent_1EC21D026D3BC78502F7A9F0@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2019 10:57:26 +0100
Message-ID: <CAFEAcA_22nLqOkQii--M3avUiCfQZKSeqWCQR1SQOEhZYraYNQ@mail.gmail.com>
Subject: Re: gdbstub and gbd segfaults on different instructions in user
 spaceemulation
To: Libo Zhou <zhlb29@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Oct 2019 at 10:50, Libo Zhou <zhlb29@foxmail.com> wrote:
>
> Is there any follow-up guys? Help would be appreciated.

Not really. You're using a locally modified QEMU that
you appear to be trying to get to support some non-standard
variant CPU, so you're on your own for trying to debug
it beyond the sort of general suggestions I already
gave you, I'm afraid.

thanks
-- PMM


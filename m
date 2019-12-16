Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3754FC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 20:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41CD21739
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 20:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2+3BBs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41CD21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igx5u-00059C-1Y
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 15:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igx4w-0004ct-S1
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igx4v-0003VV-My
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:34:54 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igx4v-0003Uc-FZ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:34:53 -0500
Received: by mail-pf1-x441.google.com with SMTP id 4so6240131pfz.9
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 12:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XCC7stTVTPqEOXjJsdhrzBgXhuSzPIpaqhhH2ELhDGE=;
 b=z2+3BBs+BGWk7WZJGmja6i944LfmY0VVAcFE6YxfCNLfi5ZuOfc4jYPNT27paCear6
 1i9QaCvAbdXJHl6V6OfnTXOuIAkoD5K8M64G7bpjFedqoPX19ElqZS0onBGSsvGTRz4q
 fp1be/BNdSYG9SonFptFIPjdQ32y20yBlTPd/TNq3Ff6GfNMpltAgkO8O93Csv5bnWQJ
 kKtuSHS+JdcKtpOVBgWQ8d5Z4LIb70X07LbrJtIB3mrfTm6Dt09HVfCFN29KN6cHioVh
 FUVnhM2eTcDMHCC2CufXCOw1LHpUonJC2Qz6AsZWcv+Kc8I3lLVi1Mod+JvIl2ifYSXf
 qW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XCC7stTVTPqEOXjJsdhrzBgXhuSzPIpaqhhH2ELhDGE=;
 b=K4vt+wMQY9JOlsaK4s1HZVLGpys22s9Lok/2AiyZcWDD/Vk2naw7+6+MpLa4qMwOv3
 23IoaJ3WdJDfxH9v7Ie/PJgbj2zBhC825tSGM5VtLt99y+BAPT72tGqyxRxYeNO8OFZA
 nOIrImtWjpFgynttZUaTPHToDuKLaEkyOHNJSgJ6fAa5cxGIL8J9GSMaBr6R9mHmZLxE
 K01JjaiuFOOlO5dEfjfPIIOlcRRZaEZBRS03DgzbHqUfWZDNAAnjEWfWO+L0JkwlHHic
 5BR0NxqhmuUCX3Dno3mZt36CVGrAuI5kAVLspMRbzK4DGfvt1YgaFGeH5PPyx3KmIoId
 R3bw==
X-Gm-Message-State: APjAAAXodjKJCJvT9oleWULhgOOGaVY/J9Ict1ERdCPdOv2F3e1cn81j
 mYS7cTv4zY/MVUQczXk+lMp73w==
X-Google-Smtp-Source: APXvYqwGH780pi69nJcuTpFSfc8FKotfoajmbGyyM7B1Vt31zfAtotZmAqqjd+1PzSkoC0nbEP1swQ==
X-Received: by 2002:a63:480f:: with SMTP id v15mr20378690pga.201.1576528492009; 
 Mon, 16 Dec 2019 12:34:52 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id j3sm23734381pfi.8.2019.12.16.12.34.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 12:34:51 -0800 (PST)
Subject: Re: [PATCH v9 05/13] accel: adding TB_JIT_TIME and full replacing
 CONFIG_PROFILER
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-6-alex.bennee@linaro.org>
 <f7038a5e-ac42-bf7f-9191-13fc80eba7c8@linaro.org> <8736dnc2v0.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c4ebdbf8-f729-5dc2-0cd3-254e1f920493@linaro.org>
Date: Mon, 16 Dec 2019 10:34:47 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8736dnc2v0.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/13/19 11:49 AM, Alex Bennée wrote:
> I'm going to split this patch up into more sub-commits to do each piece
> one at a time. To make it easier can I drop CONFIG_PROFILE support
> before the re-factoring so I don't need to keep both modes compiling
> during the transition?

Certainly.

> I think if we can get away with not using atomics this count can go back
> to being inline with the main opc loop. If we aren't using atomics is
> there really such a big cost to just doing it unconditionally?

I shouldn't think so.


r~



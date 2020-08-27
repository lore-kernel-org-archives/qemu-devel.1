Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE23C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3851B2075B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei0JAUCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3851B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBF3V-0004cM-HX
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 06:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBF2z-0004Cv-V1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:22:21 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:35099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBF2y-0002AA-5K
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:22:21 -0400
Received: by mail-lj1-x243.google.com with SMTP id i10so5824458ljn.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 03:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=muVWfejl9VqC+AzHI89x+JUeyD665htdnMBJJGYDHVQ=;
 b=Ei0JAUCdtX88AstkOiZyFPUGYyLABKJPmpKn41S1HoRDU4Mv+/iarPYvVu/Mz5U0by
 DtIXbbuxoRozve3uPDQY+eI+1D/J29Fs9RkvUUq1C8vwPSZ+nL0mWb7bUAJ7J4PoNSOR
 fMQOl1YNmectdQowmmUE2tBfJWx1DgzVMNbTKqdKTkldHubXUkfT70YIChk4zPazTpYv
 ZMLSUBX7aVPKOTNPqSaBeL2BTRxD2ZKErCVV5IcxDKHPG9G86qttTUxlw3E5Tc38vl/q
 qFQXljWcKwzzjj/swU8rVKikphRTFxU7lAEb8YBNfmjn82RBF5lRFCW3IPXquYQRNptl
 YGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=muVWfejl9VqC+AzHI89x+JUeyD665htdnMBJJGYDHVQ=;
 b=JhvVWXTWUfFL0HvMmR3wKHrUTQ0mLnLgN/07HOgbJ4ule/T0cjKtDNQndEV/8WqufC
 vVdNdOudMUEgDWV7cslNJTdwqMy5ycAj9N9xo5z2CUG2/wjJqtq59v3h89HwUJddovZw
 tury/D9Z3RIixOcmBNIEZ5+eyDsb5CERzYMZJYBNSBCsmC+rgkQBjo0YF6Kil7xpkxOb
 wc7i86z+99xF2+11Uxd184sO/TJvyPY8MoOWSS4pVoNKjXGUTt2vnrAYnAo57gzA+4xI
 PVVqIZlQKtE/IYl/+xvvgZixwixLf9PsKIceXwPwx6Ps/ycmtnrwAgOoSvNZYIZ0DI/4
 KmYA==
X-Gm-Message-State: AOAM533Jqo/z0pPDPn39P+STfOc4CrTJWZFOuTPYC0kkbsY05iynFeMb
 m74MGgX7TBu/rjdI1WA2F+g=
X-Google-Smtp-Source: ABdhPJwUUaw8VJPhk6j1D/WMxVSq1+iVW11sCWpe83NCS4KnpQDuMnnp3AZ49KhcsU2DtTJMSXr5Yw==
X-Received: by 2002:a05:651c:1050:: with SMTP id
 x16mr8709201ljm.457.1598523738219; 
 Thu, 27 Aug 2020 03:22:18 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id k23sm377253ljk.37.2020.08.27.03.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 03:22:17 -0700 (PDT)
Date: Thu, 27 Aug 2020 12:22:17 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 00/77] target/microblaze improvements
Message-ID: <20200827102217.GN2954729@toto>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200827091128.GK2954729@toto>
 <1628c0ac-db22-ef9d-22e2-6a167ceaaf55@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628c0ac-db22-ef9d-22e2-6a167ceaaf55@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.066, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 03:01:57AM -0700, Richard Henderson wrote:
> On 8/27/20 2:11 AM, Edgar E. Iglesias wrote:
> > So a first general regression is that opcode 0 no longer
> > traps as an illegal instruction (seems to be treated as an
> > add with all r0).
> 
> Oops, will fix.

Thanks. Here's another issue, it seems some branches are jumping
to the wrong address.

This is a disasm from a failing case:

0x00000000ffd033a0:  brlid      r15, -636       // 0xffffffffffd03124
0x00000000ffd033a4:  or r0, r0, r0

0x00000000ffa73124:  Address 0xffa73124 is out of bounds.


0x00000000ffa73128:  Address 0xffa73128 is out of bounds.

This one is from a working one:

0x00000000ffd033a0:  brlid      r15, -636       // 0xffffffffffd03124
0x00000000ffd033a4:  or r0, r0, r0
--------------
0x00000000ffd03124:  imm        -40
0x00000000ffd03128:  lwi        r3, r0, 268
0x00000000ffd0312c:  imm        -40
0x00000000ffd03130:  lwi        r4, r0, 256
0x00000000ffd03134:  srl        r3, r3
0x00000000ffd03138:  bsrli      r4, r4, 23
0x00000000ffd0313c:  andi       r3, r3, 1
0x00000000ffd03140:  rtsd       r15, 8
0x00000000ffd03144:  and        r3, r4, r3



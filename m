Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1969C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1196206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzFdD905"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1196206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifTUf-00053a-LA
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ifTSs-0003il-Qs
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:45:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ifTSr-0003x4-RS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:45:30 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ifTSr-0003sc-Kz
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:45:29 -0500
Received: by mail-pg1-x542.google.com with SMTP id l24so1622936pgk.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 10:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZYEW0jxj8WRJdyQx2fgXWu4l83kuuVhZh2OTn/mfqr0=;
 b=FzFdD905kroORW8YR7L13J6jNulCSFsK5YKTj3eR6d4v14PJ+ZvlXJ3Vth7wEi69Oa
 9CM/cQg2NfZoeyPA3GW0x55B9jVpE1I9gL1dEun7xC8jdJE5dpXwMersTHHp+/+YOUtV
 wiXDB5ZoS6caVAD6BAsP2IKG/C4uC3+WlaeQjFo6e1XHG/+w03tq+d1ERhmdUlaoYVKb
 jZb+w7hpGfWg7WpWhsuVv1bscdpHqc1VS1ayfIlBL3weRcDZmm4JfnN/erWeYyARYZ7e
 A4LO/7EM3nMrwf0kTuUmeoQL2oitZ6CPA0n+N1CqGqFBUNkhTSmqdJ3FisB1eIJIdsKt
 hE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZYEW0jxj8WRJdyQx2fgXWu4l83kuuVhZh2OTn/mfqr0=;
 b=nABSmtQV+0+sGhSSRCQb1ikN+g7E7J1xKhD66B9HzfqfMxXFnuPErpLqDirQGDXP29
 h0Z5zI0SiEYZ89h7iZee+xNenB11g92lrv6A+Jkrpb+6MmxuSUPaSpMWq3TS22fcbYJi
 PKtpAOOAZHb2MyvqOIAuPud9hhpFuOCE+PbYkj3NqXnkiOrc3EVOBFvxa4RCCjbU8Ts8
 i5MKDK/n5csf5MxlS5WDvmnHmqK1qy/KxCVkSjJltIIwxdLy6m2U4uwTEzEIbPM5zGFl
 AhzcZMocZwBwSjW4/SsrdM/yfmXZxOi7TEVJ8TSO5cnJLat1W5EXyy4PFQWW/pffKieU
 6LlA==
X-Gm-Message-State: APjAAAU5w7PjRuPd7UZeF78Yfg0GlvErmFNSmHOF73naVvOXLJ1f+M5t
 RJW+AokXFQnAJXHws0jzh+EtnSboNLtm3CwbEQ4=
X-Google-Smtp-Source: APXvYqyMUX2DDmoefyQTcctQyRadIqd90kh8lfHkyHGDp/KIdRT5T05DsUei+p4ZQDApNtWPDmZJtpn1bqEeQRpkcPo=
X-Received: by 2002:aa7:9192:: with SMTP id x18mr11455493pfa.125.1576176325703; 
 Thu, 12 Dec 2019 10:45:25 -0800 (PST)
MIME-Version: 1.0
References: <20191212040039.26546-1-richard.henderson@linaro.org>
 <20191212040039.26546-2-richard.henderson@linaro.org>
In-Reply-To: <20191212040039.26546-2-richard.henderson@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 12 Dec 2019 10:45:13 -0800
Message-ID: <CAMo8BfJNJ-APWhfUyaVs838GVEBRG8LE2Ep45capDn1LgyMDEg@mail.gmail.com>
Subject: Re: [PATCH 01/28] target/xtensa: Use probe_access for itlb_hit_test
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

On Wed, Dec 11, 2019 at 8:00 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We don't actually need the result of the read, only to probe that the
> memory mapping exists.  This is exactly what probe_access does.
>
> This is also the only user of any cpu_ld*_code_ra function.
> Removing this allows the interface to be removed shortly.
>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/xtensa/mmu_helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max


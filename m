Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF9BC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 20:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FF12053B
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 20:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knHDETbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FF12053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpdfs-0003kv-Fl
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 16:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jpdf3-0003Ip-1e
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 16:12:21 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230]:41550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jpdf1-0002wu-5Z
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 16:12:20 -0400
Received: by mail-lj1-x230.google.com with SMTP id 9so15787855ljc.8
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 13:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1Xg1NIrMEk4W8lfBfrzbxwUu/pb5jwRxlrvup1aTuYc=;
 b=knHDETbkCi9o8/h5FiZbXmAemL1ZI6Rv2bfYAbyuSj7fUqUN5rlJu8/av7tmQaVGJK
 CCv7gUa6zfyjTvL22a1rmk/ujIJeYwIqVLHrIBAGC71lk1e19x6WemUyh8grcw5xCAvK
 LRR7Vue84bvj9XiQqWxcn4JrNrE46Mt4FiAYyI6cgbSl3YxkgSPVPVeYhmKoK8AaQ8W8
 tQffso43oHgDB9ciRmX1SAzrnU3xWMeN4tV9Kws/9XHnQSaFyZlIUyQihexzqn52Vu8w
 EZIKGQoRPtxNpXeGw7AIXL94r4aNw7sUiU7BWvUKfsEy0HQgOUFbaJoGHItccwMIIyL3
 nWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1Xg1NIrMEk4W8lfBfrzbxwUu/pb5jwRxlrvup1aTuYc=;
 b=o0Ndfo5w59PIMnaVwIUzwh48OwQh0RX8d3YgyO3UnjUI24ek6inJVfjYdlM6EKgh4q
 FOtzywvDrqHpdoduoayrRc6K9KzVYL3hrbx0hBtoyENpxJdukGJJW3URbG8Gbgixovd8
 lXPh+0vU33QVZjWIbbQRLNdHOaKL8m+2f0wK7PsO74SKzG6u78qpcuOUO+KZQuHXI+wL
 l9Yd+jSTOW0A6HKqfUz2iE+pUzjMgHKuctSFHzMHeza0iy58kYqgf+ruykyy1ZHCo1IN
 7sSD8KVjJ0ak4xamWIdLP1PSovLRNl+MZma6MhuxHcXTFMxmB6y8cNzVO77HtHHUBFoZ
 aXhA==
X-Gm-Message-State: AOAM530KlkQaPoclgLWKlN5j0+Q7y+KK2AYSVVCibW+dVEWR2zxvfHyY
 fw6n1xaVE0/5fuY+dpoiAEWiKGLjHX72tNehfkQ=
X-Google-Smtp-Source: ABdhPJzv4nMU2XehSB/s/bfaaViXZjFA5pklMdZ21cyg6k5B7k6XxIFNHi6qghFcKlshyJlS5gnMN4uHnf1heZoIEC4=
X-Received: by 2002:a2e:a30f:: with SMTP id l15mr6378554lje.228.1593375136483; 
 Sun, 28 Jun 2020 13:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVWSvWOQVorXuC4HQbjSN=Tu+TDsc=mr1CUCL1cvJQS9Q@mail.gmail.com>
 <CAHiYmc4Zbeo6A144PhXA_EmfPv6k4wpDr+=By3pUOp9-yeaFMA@mail.gmail.com>
In-Reply-To: <CAHiYmc4Zbeo6A144PhXA_EmfPv6k4wpDr+=By3pUOp9-yeaFMA@mail.gmail.com>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Sun, 28 Jun 2020 22:11:40 +0200
Message-ID: <CALTWKrU92absFofVFo_n-BAiwmO-jJNT40mKTHu383_rL6wu4g@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#1] Measuring
 Basic Performance Metrics of QEMU
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x230.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 28, 2020 at 7:20 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> Now, thinking longer about topN scripts, I think one really missing
> thing is number of invocations (or calls, whatever term you prefer)
> for any function in the list. This data must be possible to obtain
> using callgrind_annotate (most likely by using --tree option). With
> perf, i don't think this is possible, given that perf works based on
> sampling.
>
> You don't need to start working on it right now, or work on it at all
> - this is more like a brainstorming suggestion from me. You can make
> improvements and correction all the way towards the end of the
> project, on Aug 31st.
>
> At the end of the project, perhaps you can publish a "Master Project
> Report" - a pdf that is basically a sum of all your reports produced
> during the project. That would be a nice reading!
>
> Regards,
> Aleksandar
>

Thanks Mr. Aleksandar for always sharring your thoughts and suggestions.
I will consider this for an updated version of the report.

Regards,
Ahmed Karaman


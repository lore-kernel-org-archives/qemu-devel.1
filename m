Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E48C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 16:20:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCDB322202
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 16:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWM4ZThv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDB322202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb4TU-00048g-Pm
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 11:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb4So-0003is-Mo
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 11:19:46 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529]:46676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb4Sm-0002Xu-Vt
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 11:19:46 -0500
Received: by mail-ed1-x529.google.com with SMTP id t11so1817591edj.13
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 08:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oN9OQFym7O5MXn5HwIx0K857oypcAsC25S2AkjjW1f0=;
 b=WWM4ZThvpDczlIjvihc+LG8gA8M0x/WTWRJ/poAea3s9odFvQRUJ/nZkiWeFcRiDmv
 XzJcgmaiB/W1E8KJTzkCVrKFOdJnHp6ju4kPJwDsTrKy2Ko57L8a6d4YtUPSCF7w33Xe
 QKbVNF0TlpwoLAaskouS5kJGJBuVPaf5ItRv/o2yxUnlF06833WOb5ZQSHtGUwxzrrXT
 9Eqm2klyyCA8pOX9OPMJ6PJp/mqNuTg//hGhVaRVJdNp08uKLZwmw7fPYG0c1CA9O0No
 A2Fl4GihWgkecnFZUoOuWj4DL39fA+g/UeclKJ2LhWxdeJqDJvzjVACx2IfT84S7S3Y4
 DTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oN9OQFym7O5MXn5HwIx0K857oypcAsC25S2AkjjW1f0=;
 b=I8uL2QFtZ4WsBWpKcVvZ2P19u1ZzQHgy6D8Iclsymn8XRV5CM/g+PJCDQy/SeXcr0d
 RwUky3vdZY4sQnHaDKDs0rpdtjxfTeug5MJcjiaYJM7591jgy405IQ2fJ/vUkE9Nm3I2
 aH+k2lS6GX30RWjBKfgsgI7lfNEg6L8Qt4PbBwsCwrn1CMSU7etymTcicZvHvI1QdUGW
 /C71kjoO5GGYWtJE0rv8oaMhiwfiYvdsLEXbCacRY1V83XmfrTq9IwQM0fLCKeU7oZZj
 LWXjdnnxhI8OmQlePYmhcWAOyrn71zcmQk7JwAYFFOg3zbXJvWRKuB8kS/bccZpxKHmw
 Jv5w==
X-Gm-Message-State: AOAM532SqjlbVA9KeQWv1dBf+8Ji5kpOQDXPhv6UFlrBY9U1Gw857QZd
 ZMYBEXv14Y0urH0JYm1NmBR3GHnTq4lYee/Sf3jaLw==
X-Google-Smtp-Source: ABdhPJy92la7BEygKjmWRuyPxBpGxD1RIARCa92qquxKSDcVOg6XhncCJ5khHPwL3sHC0jjtyagt9eNHC6qg5jdiwqU=
X-Received: by 2002:aa7:db8a:: with SMTP id u10mr1366070edt.204.1604679583194; 
 Fri, 06 Nov 2020 08:19:43 -0800 (PST)
MIME-Version: 1.0
References: <20201105154208.12442-1-ganqixin@huawei.com>
 <CAFEAcA9QMBqF0Bm44q4m1d=QaPVBJodH9rwuYhGx5H6zy6ULcg@mail.gmail.com>
 <87d00qk51l.fsf@dusky.pond.sub.org>
 <CAFEAcA-_5vRbsi5fFpyLV2OyDX5TVrpAx7_Z43wqvb1zhQO_8w@mail.gmail.com>
 <37c519e4-d72b-944c-ed70-038f9c606be9@redhat.com>
 <CAFEAcA_a=vBjLM8_-KDkYfFuTLDW6cMsQ48or70uwwVusW2q7w@mail.gmail.com>
 <87zh3ufoy4.fsf@dusky.pond.sub.org>
In-Reply-To: <87zh3ufoy4.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2020 16:19:31 +0000
Message-ID: <CAFEAcA-3a8gYRPzk4jzv3QfLAw3tL74LoFTMy+VhXZA3QdOfPg@mail.gmail.com>
Subject: Re: [PATCH] scripts/checkpatch.pl: Modify the line length limit of
 the code
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gan Qixin <ganqixin@huawei.com>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Nov 2020 at 16:08, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Personally I just don't think checkpatch should be nudging people
> > into folding 85-character lines, especially when there are
> > multiple very similar lines in a row and only one would get
> > folded, eg the prototypes in target/arm/helper.h -- some of
> > these just edge beyond 80 characters and I think wrapping them
> > is clearly worse for readability.
>
> The warning's intent is "are you sure this line is better not broken?"
> The problem is people treating it as an order that absolves them from
> using good judgement instead.
>
> I propose to fix it by phrasing the warning more clearly.  Instead of
>
>     WARNING: line over 80 characters
>
> we could say
>
>     WARNING: line over 80 characters
>     Please examine the line, and use your judgement to decide whether
>     it should be broken.

I would suggest that for a line over 80 characters and less than
85 characters, the answer is going to be "better not broken"
a pretty high percentage of the time; that is, the warning
has too many false positives, and we should tune it to have fewer.

And the lure of "produce no warnings" is a strong one, so
we should be at least cautious about what our tooling is
nudging us into doing.

thanks
-- PMM


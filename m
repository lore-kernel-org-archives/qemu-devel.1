Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DF3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277FF20719
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfLoz2JR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277FF20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb2YH-0004fL-St
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 09:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb2XO-0003mi-HY
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 09:16:22 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:39321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb2XM-0000jE-K1
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 09:16:22 -0500
Received: by mail-ej1-x630.google.com with SMTP id s25so2146046ejy.6
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 06:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2r+AQ2dd4LfTfleMslIR2TLv1KRDqDqrZHe13NS9LSw=;
 b=sfLoz2JR1utr6LgMj+mAB80a2PcGzR3WVFDX7NkrgF6Ndq+3qpvjFAWza84XR7jISb
 eC5vqZVkIYWePnpKVgrGAyYfDbxoG/we113UqIoLEVzaAz4mcY4A7G8lHejyq04Ev3JM
 9Pw0E9xHzwB91OCXDZvDytXDy4DQWGeM6U/J7y+Ol7xt5W0gu9/LBTB4yFsKnnMj/yqK
 vokNvjTUPJ4cZXafoN1Mh2gUQfGakphk2jNjhjAvOV7CfCyLEsxL5oVWmdu8YWyvbiMd
 baF/s2D+1HCdhAVCt68uh0R3v1EhK+lGpsxTVKL0eliOWyhDvaldn2iIZJRbXcOR/PUL
 SEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2r+AQ2dd4LfTfleMslIR2TLv1KRDqDqrZHe13NS9LSw=;
 b=BhGw3YRh9V/GIjSYrSiQ3z7YoVfcXAtoxG25k/lMHi0MZP0lj05FQGjvB6czQQwF8K
 ER4N1TUUJrhJNQeI+aGrKJGZHA/UBQ1gtfR5Lmr6SLZBuLkl45hUKTGHFlFMTxdkvGCQ
 x0FvdftNzhl7MucNUt+Wg9yjLIT2NBWi3yzPT+bhkK7IxUdc0gJzqQmos1qCrF/LQhnn
 3qltC8WXiqHQJTmLhjfsPw9mj0qG0eU6nZbdzBHeD3ABLpaX/Wse7iKElb9XPp84kgyy
 FRt1Ny9JJ3BSvh1vbCz+4mSIh4QYn+06/fE2aNMgrFPlq4K7+CO7df0f446KmpegSR4X
 M/Bg==
X-Gm-Message-State: AOAM533CKdnNR+XaY5YLnXGRJKTBt4cFvplBHNZkf40FDNCN5c+QQe/Y
 1241ftM9iLntQi2d9/rB0N6FleNLtZTa3tH27umXlA==
X-Google-Smtp-Source: ABdhPJwyq3j31Jt+miM0WDUYjRd6q6P9UMAVEHB5eluBsM6Xk0KWI1BCAfdTZMYl75geYp6YWVZdfUNr20IEM9AFkGo=
X-Received: by 2002:a17:907:9e3:: with SMTP id ce3mr2267791ejc.4.1604672178854; 
 Fri, 06 Nov 2020 06:16:18 -0800 (PST)
MIME-Version: 1.0
References: <20201105154208.12442-1-ganqixin@huawei.com>
 <CAFEAcA9QMBqF0Bm44q4m1d=QaPVBJodH9rwuYhGx5H6zy6ULcg@mail.gmail.com>
 <87d00qk51l.fsf@dusky.pond.sub.org>
 <CAFEAcA-_5vRbsi5fFpyLV2OyDX5TVrpAx7_Z43wqvb1zhQO_8w@mail.gmail.com>
 <37c519e4-d72b-944c-ed70-038f9c606be9@redhat.com>
In-Reply-To: <37c519e4-d72b-944c-ed70-038f9c606be9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2020 14:16:07 +0000
Message-ID: <CAFEAcA_a=vBjLM8_-KDkYfFuTLDW6cMsQ48or70uwwVusW2q7w@mail.gmail.com>
Subject: Re: [PATCH] scripts/checkpatch.pl: Modify the line length limit of
 the code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gan Qixin <ganqixin@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Nov 2020 at 14:08, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> Can we keep the error please? Maybe 132 is the next display logical
> limit once we increased the warning from 80 to 100.
>
> I understand hardware evolved, we have larger displays with better
> resolution and can fit more characters in a line.
> I am a bit wary however functions become heavier (more code into
> a single function). Maybe this checkpatch change should go with
> a another one warning when a function has more than 80 lines,
> excluding comments? (Even 80 is too much for my taste).

Personally I just don't think checkpatch should be nudging people
into folding 85-character lines, especially when there are
multiple very similar lines in a row and only one would get
folded, eg the prototypes in target/arm/helper.h -- some of
these just edge beyond 80 characters and I think wrapping them
is clearly worse for readability. If we don't want people
sending us "style fix" patches which wrap >80 char lines
(which I think we do not) then we shouldn't have checkpatch
complain about them, because if it does then that's what we get.

thanks
-- PMM


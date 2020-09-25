Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C29C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC37D204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wY1+RFp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC37D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLvQw-0006Lg-Jv
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 17:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLvPv-0005hF-BL
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 17:38:11 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:45714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLvPt-0003wc-Oi
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 17:38:11 -0400
Received: by mail-ej1-x644.google.com with SMTP id i26so534169ejb.12
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 14:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qiGb//oDAxegjzWi4l225eupyaeESjhjYIpkUNf7baY=;
 b=wY1+RFp5WZFZPFcJT8ZC+Lw3/I91KEt4rg5w25/h6WMKYY2IAMUFJ4W53WwGGb6Vij
 IOydW5lIYWv/Y4pQbCrIOQkfux8VSs07Ihe4Wiq+r0wIthZw5nXKqeeNo+p4XgWGvGN6
 Cw9D4jH2UJD4D3lbmob/18xv+QcT+hB7xZlPenW4BQMrknJa67MvJHQ7ZX7hNbAxbXNy
 jxgZKREJnkxiZSbm+he5izF0prlAXXM+yycQj6WUNtn/14IiHuaqI/XuB3N+Tdn0LzjO
 g+6tufSsAGGUjabpMqdzdANA0hIUb9lLIoN0ciB/C4BVsE5jxjpR9y8ZN/chCzQSVREU
 LD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qiGb//oDAxegjzWi4l225eupyaeESjhjYIpkUNf7baY=;
 b=mUk20pNB9fucUYn/8TdsjfiVafPUoiWsTlgZSu0pjWr+KUOxyNgkdbytjZYXLTCbsv
 QF+T2Fa7jFt4re0loiw5kDKqNWcnFXHuK90DXPXWcJew2owNUABPsdpMkPLK9jl+qsWD
 2OiLB30fLdgU0Basfy0K4Az2InWCyaykp01TriuDjnhlrwga6VH8aNmMWip9053Uw/Dl
 /hkDowGKk8wSgNk+4XUk2/Cw12rko4fpNrpHX/insMO50ObMv0JWgmqCrJ0ZIIGzSYjU
 InQYoGxw6rY/ugiRKnF4lUOOfNUpM8HSnozjth6BRYUPqkZhWaT8QhUSzJdgrOeKPimM
 pKrQ==
X-Gm-Message-State: AOAM531L81oMznaOa3CjT81dmlr3sNJ67FtejIg4dgApVp+Qa6XWXEse
 sNuwIJgGdiVeqhkJbt4bGn23rq6gTP/yJV51os/zdLtT7gG+NTKp
X-Google-Smtp-Source: ABdhPJwLhWynzPCZuveWca0mTQqonMLztahRj4hsLGIBsRG0mRas5rtoKhQDLLFxtGioKTdkcg2vnpygIWvtIUqZ0DY=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr4994944ejv.56.1601069887764; 
 Fri, 25 Sep 2020 14:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <160106193961.10465.12078546060105198824@66eaa9a8a123>
In-Reply-To: <160106193961.10465.12078546060105198824@66eaa9a8a123>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Sep 2020 22:37:56 +0100
Message-ID: <CAFEAcA8uWY+MCDToz9an+zsrMVrctkBmgpMV82iUR2ZZOgA3Vg@mail.gmail.com>
Subject: Re: [PATCH v6 00/21] Convert QAPI doc comments to generate rST
 instead of texinfo
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Sep 2020 at 20:25, <no-reply@patchew.org> wrote:

> In file included from ../src/qapi/qapi-schema.json:78:
> ../src/qapi/migration.json:1747:1: unexpected de-indent (expected at least 13 spaces)

This is yet another mis-indented line in a change to the QAPI
doc-comments (commit 4c437254b807). It hit master in the
latest migration pull after I'd sent out this patchseries
but before patchew got round to testing..

thanks
-- PMM


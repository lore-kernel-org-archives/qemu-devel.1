Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DB5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2742075D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0carylU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2742075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzsN-0007SL-T5
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzrn-0006w1-DA
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:55:39 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:46212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzrl-0006jl-I1
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:55:39 -0400
Received: by mail-ot1-x32b.google.com with SMTP id n24so9696646otr.13
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K5DvJoOrRLyu5LahzgFXop71HKHgfXuE/+mfhqn1DX8=;
 b=s0carylUeLcDFIYBm3XD1LhpsbA9rrDZQPm7PlXLFFnaW1BrHnKRClm3pf7iSKJtbK
 npKGqOMW6lYyYlKKXZYE8xChDU8eSLjWtim42IsOKAtgTcJ10Y4rKxjlxsfG/42Ar6X2
 sQIrLqU0J10Ji6KVJhQrDh/1AIlO/CAnhP/cxY14cG0JzQuj6E1KUWuMjwc9SpngL08K
 sN0364GNBFf9zNfqg576VZc13tbH3hegcFHoHZlDD3Qn6dfPBKdPTKpQhW7nlgX/TzEW
 1Oz19sxOUD3uiAVQjgcTkmm/EBnaCc/3vPWQGehjW+n+L/qXALVZIGZt5y8gKQ961JRH
 sdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K5DvJoOrRLyu5LahzgFXop71HKHgfXuE/+mfhqn1DX8=;
 b=KQ0hEx/MRfwavbg3nFgTJqQqbiMBq/0VOVnK8alYTvs7UjSdhKBV7PgIBBPxzTrkWY
 TFXogg7dAiltQJzA5pC9WrEnikgdgaWogXWSoxHdqQt5t2RbNR1BN1REpA/Z4GzxIW1w
 9ZfRZfgvBoZbKhsmNXxfJ89+cIc8DKvLZOdA6HW4dD0RjkEnQIgkl7t9KqaI1ZuZnQoF
 v81qb0S/jukzifr2QCYT87Ojbzg8e5Q48vd0hTamLxjdtb6O/FgXm76l1QoB5o2V7RKc
 XzAaZimzXgku07P+jiWqHc4thz+uwMZKVu6uxKQNtaII7NOXaW5YxPUlaj9PY654PBq3
 hmJQ==
X-Gm-Message-State: AOAM533PXgFlkO+LQbabHgr8rT3c2RUSgJOfD3h5ZYNdYmg96lVg9w3d
 fVxmv8xpe+2ZQGXwlhIut3Tz1mXx9na1YejXNx7jjg==
X-Google-Smtp-Source: ABdhPJwHMlPmg767bcz81BZGfjh6WeqXbEO/j595vlXPbxBwDd2ltf0gLx3KnBq/5Rv/MPDCKHH6Q4WNEDPQTZclTks=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr67304005ota.91.1594652135962; 
 Mon, 13 Jul 2020 07:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200704163927.28188-1-philmd@redhat.com>
 <20200704163927.28188-4-philmd@redhat.com>
 <CAFEAcA8v2rEC0T_=D1Bat9DQJ=YS57fRUDDQyFdxJsEB=OEPMw@mail.gmail.com>
 <17fd7aea-cc7e-c17a-5748-88dd0d106317@redhat.com>
In-Reply-To: <17fd7aea-cc7e-c17a-5748-88dd0d106317@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2020 15:55:24 +0100
Message-ID: <CAFEAcA8=zLbv6yVxuED_kNgrWGVtmoE++ORHp6SGOdo6Mo2yMg@mail.gmail.com>
Subject: Re: [PULL 3/5] softmmu/vl: Let -fw_cfg option take a 'gen_id' argument
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32b.google.com
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 at 15:50, Laszlo Ersek <lersek@redhat.com> wrote:
> Ugh, I should have noticed that in review. I'm sorry.

No worries, catching this kind of thing is what static
analysers are for :-)

-- PMM


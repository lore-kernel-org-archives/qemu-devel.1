Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AE8C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB2421D20
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGPyQTua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB2421D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLUSK-0002I2-V1
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLU98-0000UO-59
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:31:02 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:35059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLU8x-0007yg-HL
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:31:01 -0400
Received: by mail-ed1-x543.google.com with SMTP id i1so4038962edv.2
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IRNkYVVdTJqkW+fzx2E7a2yoazXAtLwAc86CU6vEGFs=;
 b=MGPyQTuaiXAursdR6NGhnruLTGZuEUY7Qt5lOZgQ9HqGGKLdYxI7hcRudjXb/4rboQ
 W4XfRn6bF3o+KlhPDsleaLV61pClVZ5UoLkRNqGVTrkrAV37x6gFLNbAzC/Vgz0dgXEm
 4FXghu1nC2s0KP6LXAsPB2We7ix+db9Yi4yjVBk7PvEdoXdn2Akc0jWKVJj0DJHAc/Rt
 Ns98vNBl8P+1vBTJ2HZVfWt9NrVKiKAI72BLN0pVbpJMQKDRlG/fSp0dZVVdGrlbOtjK
 HKeNlLhZE9iA0j7Kn6dyeTmwhNA/CQc2c5sXueH3jiFMcLE+lVmpvZq3HASLcMTuRoxD
 E5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IRNkYVVdTJqkW+fzx2E7a2yoazXAtLwAc86CU6vEGFs=;
 b=lpQ5mtPpasBuahK9LvLUhNK2cAVPWdpzoUmf8+GOC4VUvls4pLQyoaXk1YTYFBrEys
 UGhHwkHdU1fVaXXQhHkr+JH+1tn1ME45k4HJuyQPZMhYQ/mNoMGCs+hNhm9p7JkF0YL4
 6wyCQJ7DqlxAhe2XYpiTput1edtEqaO22b/zynffj2ArIfnUc8oNENm8T+3LnnKRSzNP
 jESeA+eH+klT/8q5tsONInvrxSW+K69cK5e/zOI7rCM7M6hCoA6MDo13dVLxPKbmfJSb
 RH3FFxG2cs6pUvQIuo/HeYP6Ak5a/1JaE01OT/6ckR177nqJkLtxLLUO0e/ACDoH03VL
 KdnA==
X-Gm-Message-State: AOAM531Sv5OdxhAXzs6BIo40L5Eldd2GXfJ6yv0pA7+XhNtaJ6Rxx/vs
 ZZcZPYbI2Oj/3p2lQR9klTHPBh1+EZN9Je2yjGGvLg==
X-Google-Smtp-Source: ABdhPJzI2VDaf9EHh2dDsXwX7zu0ZWAKavLPwUekQEZqcabQ/ov0v0F46RwRmeXSGD++Ruk4KGAKLUt17pfZ72JEbDI=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr817833edm.100.1600965048820; 
 Thu, 24 Sep 2020 09:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-10-peter.maydell@linaro.org>
 <875z8t913t.fsf@dusky.pond.sub.org>
 <CAFEAcA_X6gA7XTAXwcCLa-08UWpwg_AhBVKyTfsDrq53R4rH0A@mail.gmail.com>
In-Reply-To: <CAFEAcA_X6gA7XTAXwcCLa-08UWpwg_AhBVKyTfsDrq53R4rH0A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Sep 2020 17:30:37 +0100
Message-ID: <CAFEAcA-7BW-FabdC4YmnKbG0D9yUfbBcxOeFeKHac05qkUn9cQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/20] docs/sphinx: Add new qapi-doc Sphinx extension
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Sep 2020 at 19:06, Peter Maydell <peter.maydell@linaro.org> wrote:
> (I've just noticed that with Sphinx 1.6, which we still have
> to support, the file/line info isn't passed through, so you get:
>
> Warning, treated as error:
> /home/petmay01/linaro/qemu-from-laptop/qemu/docs/interop/qemu-qmp-ref.rst:7:Bullet
> list ends without a blank line; unexpected unindent.
>
> The plugin has code borrowed from kerneldoc.py which is
> *supposed* to handle the older API Sphinx 1.6 used, but it
> looks like it's broken. I'll have a look and see if it
> is fixable, but possibly we may have to live with people
> developing on old distros getting suboptimal errors.)

Tracked down the cause of this -- it turns out that if you
feed nested_parse_with_titles() bogus rST then in some
cases it will detect the error with a line number that's
one off the end of the input text, eg on the 2 lines:
0: * a bulleted list
1: a misindented line

there's a syntax error here where line 1 is misindented,
but at least Sphinx 1.6 wants to attribute the error to a
nonexistent line 2, which then doesn't match in the
input-lines-to-source-info mapping for the fragment
and so gets reported for the next level out (the .rst file).
It just happened that the syntax error I used to test the
file/line reporting this time around was one of this kind.
I assume Sphinx 3 either gets the line attribution more
accurate or is not using the same mechanism for finding
the input line in the source mapping.

The fix is just to always add a blank line at the end of
every .rst fragment we hand to the Sphinx parser, which
doesn't affect the generated output and does sidestep this
issue.

thanks
-- PMM


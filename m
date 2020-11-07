Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6095C388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 19:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6290720723
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 19:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHiWX580"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6290720723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbTkT-00055o-F7
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 14:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshavardhan.unnibhavi@gmail.com>)
 id 1kbTjb-0004eb-5r
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 14:18:47 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f]:40068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <harshavardhan.unnibhavi@gmail.com>)
 id 1kbTjZ-0006j8-Fe
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 14:18:46 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id n142so4296815ybf.7
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 11:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=Tj4BxS9nK3wv5eSO1zfu1Ff45lUdwRFIHFiq3PhRDZM=;
 b=CHiWX580JgqXkiKPKi2/kxUq0S0pOpyFXAKboy4feneB6sNX+XSXFDJ53CGmr5KTR7
 2yrcRdUruqzqnafGxkD4Efy4A0q5UNjxon1dif+vl2TCqyuVT0qG0Fwz5MwGHSfaqq3B
 xKjb2+WDeyEvC7wX6TUK7SV/bs+Yv75nUEl4mFKGkrVlY2XlXYgqSrnr2EO+xPk6ivAy
 gnIOgjBp8Op9+8QxYnJlBGtsKe8VY9MTnG2VH+3XRUGPHJpWDivpGnETLeLhOTlxuSLl
 juiz6K2k6pC0WyV+m8nDeLv4KHOmYNPo8JXltiCXy6P2ldFE8/b3zR7WuvkuONpQDJ+s
 xtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Tj4BxS9nK3wv5eSO1zfu1Ff45lUdwRFIHFiq3PhRDZM=;
 b=jmDukM/5Z5kb4798s0eKunPxIWK8M4dYPM4fzzbwpUj06Vll6VsSIIfJ4u5j6oGPln
 vmZkfwJ4jOtjlnaTRBycsaMU8wu7Katl5DhbPizFslXMdwRfh/wrRMfIPCt5O/OUtE5n
 WPrLwpGOtTpKP2cYpkb27Y5Ugs4pQ324jCiJP+2Hq4jecZglCoFopHi5c2j6d7kWITg5
 zlwN3QNqmCoxjIm3g5Bl+Z0mw4V7jn87jjSHkPog21uBUahKtmEPlVaq6gBzxFPH44/O
 Er+C7WAhKZxTgMjh24Rk43yBF0TRf2/L99WhlkZjEWC3423yLolU7FQhzZ0sgRVcJte2
 t+RA==
X-Gm-Message-State: AOAM533BHhfMQi369uogzDLufSuNglTMRrzD8EzZF9caHMpigxv3/HP3
 wVzr5aA/d6DBBPBvbPnR/+8bTf+xR8TLyTuQpzWu/c/5KpQ=
X-Google-Smtp-Source: ABdhPJwcuUBUjWZDbQlKUoJXqbFKNa9DFNiYCZ3IwyeEvVMAx2nXglrYeAiF0xrX2YPwcxMTwAAcR9as+7H8uuvORe4=
X-Received: by 2002:a25:cf55:: with SMTP id f82mr3742980ybg.69.1604776723944; 
 Sat, 07 Nov 2020 11:18:43 -0800 (PST)
MIME-Version: 1.0
From: Harshavardhan Unnibhavi <harshavardhan.unnibhavi@gmail.com>
Date: Sat, 7 Nov 2020 19:18:33 +0000
Message-ID: <CA+8xkr4ABLeYam6EPBdMKkX=HB3gik079zxUyo1TF91sCXmoQg@mail.gmail.com>
Subject: Qemu first time contribution
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=harshavardhan.unnibhavi@gmail.com; helo=mail-yb1-xb2f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I am looking to contribute code to QEMU, a software I have enjoyed
using for my own projects. I want to contribute to developing a
specific component in the project. I was looking for possible project
ideas and came across this page:
https://wiki.qemu.org/Google_Summer_of_Code_2020 . Is it ok to start
working on a project I pick from here? For example I am interested in
the " TCG Plugin Cache Modelling"  and "NVMe Emulation Performance
Optimization".

If not do you maintain a list of components(or issues) that require
some work or new features to be added?

Looking forward to your replies.

Best,
Harsha


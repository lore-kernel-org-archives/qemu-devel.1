Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E832FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC00207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UeyWGJ1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC00207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb791-0004FM-TR
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jb78L-0003oB-8K
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:38:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jb78K-0003ll-7t
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:38:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id i15so496396wrx.10
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/GNcN075GdwmdoctQb83i/+HE0a+7IJ5sWNf4AQtdWA=;
 b=UeyWGJ1uGlfKyqZMSB9RyUltOzFb5JsiiADGvBmfDcFle+3LZLUjrF4yegzZOE9eBE
 rX5krJbRASX4SgMNbT5ZxIJKIsNFLTHjQO2V/dgAbLliqxTqrNjKJsE5jtmATAuT4pSh
 yrS/E47C8LKwf9uOe/3vl0x6OxCi7DowiMrgRPpFDb3tbKRKZDias8UxSkY3QcBoVxi6
 nt9oEh2I2tMsCL6na0kTH9C3vxx4XPcoearcoFrm1vFw/e44zFExAzA6dOqNLMbD0NlH
 EbLACRGhy9n99mQAsQgLOPMjASd3XEdemM3hcpD9Xheve3ZDk5+DvptMthXXm768eICN
 CWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/GNcN075GdwmdoctQb83i/+HE0a+7IJ5sWNf4AQtdWA=;
 b=GIU+8RvLqfWU2ZZ1vEZVvnfx/W0RjMMMZbmf/sZDKsFLTVWAEcXMEYr5W7CMF6qL9U
 qVjCMPG1LxqOkTDyiFQvA47wHoAA4N2zAkqJy9LLPZ074WzMP935ycXxj7U0QhQZ+4s4
 gQNkUC2TR/w46pHpXYduG00vQPAF8mL7iwgjno9Q3JZV08mPjS5EWNzz00qCmD8AnmoV
 eaIbb+gbbTM3CPQB6fa/zUdNBhnwcIbqhXQ1YeEYyOwMKk0XcvowGYlEOnUZ//XY1ab6
 TFPMr309/6rmUeOvZJ/T0sgpxL/ctzw5YpDUSPs2LJMQBbFyjHlGtLgJRIT+q7SOdY9s
 1mNw==
X-Gm-Message-State: AOAM531cic9GNGwTnB7HxnlchLoBg9DO5yPGqmQdG3kAXct2Q91ID/zq
 eYO9uFJet1Wur3E7Se7xX96ejA==
X-Google-Smtp-Source: ABdhPJwxu/wFD0yrd5vn2hFNMvgwgingVqkKb5awStCYWEftIKrOECU0a7Ve9bm/QWgW/Kx5mSCW6g==
X-Received: by 2002:adf:db46:: with SMTP id f6mr294744wrj.80.1589913510447;
 Tue, 19 May 2020 11:38:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q74sm631840wme.14.2020.05.19.11.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:38:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A94F01FF7E;
 Tue, 19 May 2020 19:38:28 +0100 (BST)
References: <20200519162144.10831-1-ahmedkhaledkaraman@gmail.com>
 <a0f3967f-e125-d888-bc6d-44414edbfd5b@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/2] Update use_goto_tb() in hppa and rx targets
In-reply-to: <a0f3967f-e125-d888-bc6d-44414edbfd5b@linaro.org>
Date: Tue, 19 May 2020 19:38:28 +0100
Message-ID: <87r1vfhisb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: ysato@users.sourceforge.jp, qemu-devel@nongnu.org,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>, aleksandar.qemu.devel@gmail.com,
 stefanha@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/19/20 9:21 AM, Ahmed Karaman wrote:
>> The issue arose because the page crossings check in use_goto_tb()
>> function is required only in the system mode. Checking it in both modes
>> causes an unnecessary overhead in the user mode.
>
> It is not only required in system mode.
>
> You can see failures in user-mode if you modify executable pages, or chan=
ge
> their permissions with mmap.  Such as if the guest program contains a
> JIT.

If we kept better track couldn't we just tb_flush() if a new +x region
gets mmaped? I guess that would be sub-optimal compared to having a
translation cache per mmap region.

--=20
Alex Benn=C3=A9e


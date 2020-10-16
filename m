Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DF4C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D48207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pmvz+cHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D48207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTSHK-0000BM-1W
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 12:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kTSFo-0007p4-CF
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:06:52 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kTSFm-0006fS-7e
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:06:52 -0400
Received: by mail-wm1-x342.google.com with SMTP id e23so2948074wme.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=7ku0Gva7D3sTMkjXgfpGSE1IoTHzYKFNJPHpLObE8tQ=;
 b=Pmvz+cHQ0EotTkrFYFC4RcVR70P65dklHXhNgfwF3SLWyTr+/os25Y7lnO4JEFVLVV
 CqxYBvNvKuX7zB8spPJbPbSQH3S40itfCfCrsYlAyzVEktp5/3CSEGim6g83SsrGysrQ
 7u9cLLjMy0oVndoDH7CMnafsdxLnWUzfUWMViSUfWaR6Lw3mA9GFj4YLYn3yfrldEdqo
 YV4JEER+R4SBlzC0Nsiq+aXN4j3rwU+il4TopCqwosKDXIC9xB/byjUCg79GSvYk3zQc
 xUBEBbiz0ltHcNZLEdfB5TfBnwqGrifgd81Qc9/fRGMbJ8o64iqckOTcfVnAX5CD6IfO
 xDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=7ku0Gva7D3sTMkjXgfpGSE1IoTHzYKFNJPHpLObE8tQ=;
 b=AXnA3ch4kGwSrrqIAGJaDJOnOHZDvMarTitws5tUIMf8t6fQGgERM0am2hl6j8As2v
 MvNlQch8K9U69DVv6vuxIX3qSlwIUiCy7LLNblWAJNzwzegvRHxasbDQsMSmZnZaBJtP
 2zLIipNlIa2ApA1AKlmpu5t/Z7OUpWjk3v/Q+s7r3/JfoP5tzuBfQqroJeldLkbY/ztK
 uAstL6H9IYg1vMBGyXDVvDkcOam6Psq4l2b0p3cSl7Jmij84oN0BLzu5NGabAbwnCMfd
 uvFlkQcC9Gj42emZOp6/9lkAwe0EnNC0HB1Ye5F/NHnljDuoc4JlGho1Qni6nh8lCx/r
 9l9A==
X-Gm-Message-State: AOAM533ENzi1N/5eQfZ5hMCBreckUhhhM6Zm+DoOTnCxK6/oeDmKoOGH
 xsv8rKi3isOVEjcDkjqygZVMLQ==
X-Google-Smtp-Source: ABdhPJzvitgeFE6Ay3VDDnJzkI4hX/7tSe6vtVkqfHwFcKNiIVQUVyo3fk4L5NdDSI0h/YtSPmWVMg==
X-Received: by 2002:a1c:9952:: with SMTP id b79mr4676563wme.144.1602864408329; 
 Fri, 16 Oct 2020 09:06:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s2sm3340699wmf.45.2020.10.16.09.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 09:06:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 69D121FF7E;
 Fri, 16 Oct 2020 17:06:46 +0100 (BST)
References: <20201016143509.26692-1-chetan4windows@gmail.com>
 <20201016144243.26817-1-chetan4windows@gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Chetan Pant <chetan4windows@gmail.com>
Subject: Re: [PATCH 6/30] semihosting: Fix Lesser GPL version number
In-reply-to: <20201016144243.26817-1-chetan4windows@gmail.com>
Date: Fri, 16 Oct 2020 17:06:46 +0100
Message-ID: <87zh4mupd5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Chetan Pant <chetan4windows@gmail.com> writes:

> There is no "version 2" of the "Lesser" General Public License.
> It is either "GPL version 2.0" or "Lesser GPL version 2.1".
> This patch replaces all occurrences of "Lesser GPL version 2" with
> "Lesser GPL version 2.1" in comment section.
>
> Signed-off-by: Chetan Pant <chetan4windows@gmail.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e


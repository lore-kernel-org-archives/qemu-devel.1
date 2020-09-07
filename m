Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BA1C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 13:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E40B215A4
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 13:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EqAanGGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E40B215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFHLu-0002qV-1e
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 09:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFHLG-0001xs-4b
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 09:37:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFHLE-00015M-Bv
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 09:37:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id j2so15850335wrx.7
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 06:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2Uu4HcVB4PmenlCHWDHB8J724rlykWo3EkObtx23RXI=;
 b=EqAanGGH8fHp1Oqj22UoJ0ltyt3h4ds3nkSC9l2y1nMOFDtdL5y32olaE6y17jtO4e
 Z4oLaFfv+6s63lFiQd3ZCF14uHvme/WWX1ea406kkZ/zPHykQoOLYFtwcLrladqtde+u
 ave+++IvWi1oY3+gT52huA+9mjXx8eDeVDffLubZC+bTCCUr35a7C6UMn0mLobVzxBbL
 uN1f6W7+XE112dm263MTpbLsY4FPmFn31rSnxqUNDYUFLIPeHj32PAJ0QozRE8mZbmoH
 aO4ov7PKMy4dEYNMYUzyNdC6MC/Ryndk+nlHKYk8yVGiHKkUvTaUYhLwmLWVwCSjhL8K
 UU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2Uu4HcVB4PmenlCHWDHB8J724rlykWo3EkObtx23RXI=;
 b=sVdbl9LSbD5CTiTf0OZlQnK25KapKE9HWiDHCLy9gYhUSUMI/lON80FUgCjpnr/o8n
 P9doFuCSQvxYIhh0fp/envWQstNA82dZPUsppMk6X54njFpN67n3siMqGosnGsK4mc1w
 4gWUH/y9MplshHI+Ypm/Dr1jy1Cy55LNlLo0S98IWZeX4apKrUzJ+Xqi8ESKDqw6zaGQ
 huBmyFdUTlIoTNRxGLT2PMSBXmlKab0JB98NErkC/iRAEjEF7Y791SSIGbq1faY3d+bk
 nLk31dUM3VtLBwwOmuggmUIJNUboCmCqA3pslcHbZuTdr8f68COt7fiSq+U7CdSdH48c
 +kZQ==
X-Gm-Message-State: AOAM531pPTK1yDi9jh29JZQVyhH3jq+AKzsDs9Pd75vZgFR7hCfR2SCM
 4F4SYciiLDifZqnoE6Hp5AeK0Q==
X-Google-Smtp-Source: ABdhPJxb9W13TN3g6vSr+fZICzw+lDiRC2y73QDUg4BHTTGtrTclkF8zfN1aTnnjzinGzv9DjEqKqA==
X-Received: by 2002:a5d:4645:: with SMTP id j5mr21300517wrs.230.1599485870870; 
 Mon, 07 Sep 2020 06:37:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s17sm29393412wrr.40.2020.09.07.06.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 06:37:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F1B911FF7E;
 Mon,  7 Sep 2020 14:37:48 +0100 (BST)
References: <159903454714.28509.7439453309116734374.stgit@pasha-ThinkPad-X280>
 <159903460499.28509.244825487566769241.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH v3 10/15] replay: flush rr queue before loading the vmstate
In-reply-to: <159903460499.28509.244825487566769241.stgit@pasha-ThinkPad-X280>
Date: Mon, 07 Sep 2020 14:37:48 +0100
Message-ID: <87pn6xr9lf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:

> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>
> Non-empty record/replay queue prevents saving and loading the VM state,
> because it includes pending bottom halves and block coroutines.
> But when the new VM state is loaded, we don't have to preserve the consis=
tency
> of the current state anymore. Therefore this patch just flushes the queue
> allowing the coroutines to finish and removes checking for empty rr queue
> for load_snapshot function.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e


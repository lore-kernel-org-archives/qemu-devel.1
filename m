Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E69C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC3C20780
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CngEstAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC3C20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnlHj-0005on-Qt
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnlGK-0004VE-LG
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:55:04 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:46115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnlGI-0008Cd-Tq
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:55:04 -0400
Received: by mail-ot1-x336.google.com with SMTP id g7so17052376oti.13
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zD3njsbT0sPyVPIqvLMStHoa6QCd8N0bPvJXUZNNY+A=;
 b=CngEstAKIZ9wmfuJ2cflyxFIE3lFomGJBm5MC9fxI0fK4Mz90IniSGHP32YktGcV1s
 6Bxv3mqfsBGM0GTwHun8/QcS84ldNCpxFgbrX16mcxBw+QKILO3Ctp44lyW9ATIvN2el
 3nyNiCqA97ydXCw6jdNiQTpu5fBD49cFtzW9oRXc5kOw1QbUe0mzLYNqTUCgz1QXNIrZ
 4J8PSUD0WBItQ9IRSz6aEcjVkIzTt6YWky/fLy42lp/eMyGAeBACaV6ydwFheT5Bbsbt
 pOgEIBOdodnTIKX6hGGLSLKfoBkiaGmSg39FHskYYJJzQuzOZd0bC/ftq/oyYBPJLey1
 1o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zD3njsbT0sPyVPIqvLMStHoa6QCd8N0bPvJXUZNNY+A=;
 b=R5l5teGk2oUpGeNMHM1vUq/AiTKVKZN87/AgrEDB1+7kN+bcoyGHLo+ylu+IiIyuJG
 jeUIhZv9QcySm176MzyK4NpMUKchPY7CSL+w6KJS1/+YdaBJoo91h7UYorriMNg+qGrT
 WhCiBocTDeMMvxI5ZSCoYVSsEI1IIiE0cs4HvJ3NvSHDIisH3djczC5ObqKDQlVx8gRW
 FhcHak9ljwctfQ8MURz1BPkBxfZX9nRKmKniyrFPxM/NPKU+PI0Ya/wwFGyArORXzscA
 4W85gOuIrb9DqhsV4sc2qBrgrFm8lBCtxtfWBahmGAm8LlXzv5sXqIrg1zYB4hYBXcYl
 wHQg==
X-Gm-Message-State: AOAM533dcE5gLcCFPafwLNOJjNdkYisR9ayJy8PDEvt61jHhqr0rRNgp
 5pzbl/wnpoX/0ykn+NKXlK3b3rfswKAQHpHjq6ktHQ==
X-Google-Smtp-Source: ABdhPJyMvevdMvq3SLdGy+v6K2/9EKhR+poSw3UQvbYVzf7QHdKeAoJOU/5fUctH7R52nMJm7tMZhdVFzOHS05CUIB0=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr4847781oth.135.1592927701168; 
 Tue, 23 Jun 2020 08:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200522023440.26261-1-richard.henderson@linaro.org>
 <20200623144446.4243-1-alex.bennee@linaro.org>
In-Reply-To: <20200623144446.4243-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2020 16:54:49 +0100
Message-ID: <CAFEAcA8LvhhWihVHc_09ZRzZKv8tiWFfd2MfT7ZawJpU3UktyQ@mail.gmail.com>
Subject: Re: [PATCH] risu: don't do a full register compare for OP_SIGILL
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 16:07, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> OP_SIGILL means we have an unexpected invalid operation. If this is a
> load or store the register state may be un-rectified pointing at the
> memblock so would be invalid. In this case just compare the PC and
> make sure the other end also faulted at the same place.

In case of mismatch of the PC do we still print the full register dump?

thanks
-- PMM


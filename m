Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B4EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA5321527
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yI0Fym38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA5321527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmHV8-0002ye-CQ
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 09:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmHUU-000234-73
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:55:34 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmHUS-0001Oj-HI
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:55:33 -0400
Received: by mail-oi1-x242.google.com with SMTP id d67so8501288oig.6
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 06:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1EzHJztIDOyvbULr5Zv+UekoPb8XqsgsZrIk8Ndaa5o=;
 b=yI0Fym38fJvkBpjJZMPMxkrY6ob9DLg9fqhk8mhS8RJmyALsFS4wVXY/njtRMQ8ptY
 2qISFMqx4F8fjBeg+xuvBQNNOG1Ng+uPdL108mUOdpZAptioMUEFpieh0oYq+QbDd1SH
 CuuuqTGxOQpXKqfATypC/Kyw7j3KLDDRMhYYngf2u/srCrHpmA1EEJaZ8p6vC/KFf4uw
 z0bKCpi1gaeTyvp5iLKRCaUyQbRxRKbRVGJmOYKApu7e9OV53oQPFcPRtqkWAW4emRlh
 h+yJw7WX5oij1ky0NY9cnulXExrtA7LCYbGfNAG3AWUImDKkhE0kJV7DBb8yOk9b1ztc
 v6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1EzHJztIDOyvbULr5Zv+UekoPb8XqsgsZrIk8Ndaa5o=;
 b=PLRya4pCeQmJUBpETDECtAMxglW33jph6h1y6GA9+GCfkvIwayDMewn+YyFz3lfPjM
 gOrZoyea0wiwn0cJkrsRp4C9BaMIO4y3tlUvlX74mjFAmdRXYZ0fbcPmbrBm2okBPbfh
 +/BPkK07/gsypWg4VM1yTGY9DSkso8hKM7cRKLItdLImJJS4U+34+3L2h9olv0OI0IQS
 YVNPdz8nZLyz1oMSoQjYSoaOBIXBV4JHEas2tSOF4wQCh/pM0RWyG8rZdSnkRR48S7x9
 yub8lmRxndk/LFNsws2GuVkIWLwEv072IVrjNxynC4TBFcquBORpfYyFeBrZsZtu0AAE
 f+4w==
X-Gm-Message-State: AOAM533K6n9yatBo6QXSEMMh7z0TtwK04WNEZY43fcA9/LoCGHC13QOH
 jsx9g3KPbVPfSwL4vMx7ddh9j/+HBwHA1pcJ+S6vqw==
X-Google-Smtp-Source: ABdhPJx6wPDeGPwCpAFVNUVKHxHhNULRFrdO6czkj/fwIyuEzobIyjIrnknHKEHf5GqosSIo5cTDBoJOYFeQc+WCOPk=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr3080689oia.163.1592574931344; 
 Fri, 19 Jun 2020 06:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-28-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 14:55:20 +0100
Message-ID: <CAFEAcA_UCd8p9fS25nLqC6dOuaH6_hYR61NshTmrp3fpBqML+A@mail.gmail.com>
Subject: Re: [PATCH v7 27/42] target/arm: Add helper_mte_check_zva
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 02:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use a special helper for DC_ZVA, rather than the more
> general mte_checkN.  Leave the helper blank for now.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Helper does not appear to be blank :-)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


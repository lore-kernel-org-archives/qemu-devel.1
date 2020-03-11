Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE005C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 03:47:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 968D9215A4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 03:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZigIDMAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968D9215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBsLC-0007qd-NS
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 23:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBsKO-0007DJ-Ts
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 23:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBsKM-0007UR-Pr
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 23:46:39 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:46029)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBsKM-0007Rg-IA
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 23:46:38 -0400
Received: by mail-pg1-x52e.google.com with SMTP id m15so396609pgv.12
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 20:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7aFFhA+otSlffaV4rPfn2s1GH+BPYE0xZYGnj0MMnOg=;
 b=ZigIDMALa88e9tHmJuLYqC1QOk0gCio0sWOG6ggpcu3TX/jYSBQjqnft17CjTKBb3N
 H51EuDC+H8j4Vqdg40qQCOrASIpTUdRHDHQRggvErerfQU+ksosDROZgxkbrRuLV41Fv
 SB7J12T0EwgkJqiu+qc3Sby8Rw/SBhlZl+UOuuLDHh8CaDJ/16eRt1H4TKOIiSJi2oqX
 wWKnbp0yOuypBL1aBhq0atTqR49MYqnzTdZJvfmVCJfTb1KMT33CNycbxcIAYOBTT6rN
 a8tN6NRgzpvLNx/hvaNOgo4DDLKuo9XICLsymO9lyrxswmDHfmG2pTmQo61l84lbTAz/
 3qqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7aFFhA+otSlffaV4rPfn2s1GH+BPYE0xZYGnj0MMnOg=;
 b=UIcRpFdOm3d/sz9hCEGMthbux7FdDOppeJZeVN0Qakm+5stgZxTR0k4FLJeCws341B
 3RkSGd5ocENnv/x3uGC7UrrgWhAOFTT7d0JauEm8F8u5zgbvNBxcpqSjVMsBzwxGGmre
 rJLWDOapy4lb65rhePFHK+Bj00z6YWVSAhgK1OOlUh6jN3d8T+3hZ4HL4hEJl3hM4t41
 0DjJyJN0QMGMEjLeJ1jWDh9uP1NUa1kpouDl0AU6c82FAdQaJG++ShhX2zdUyYoDz7o3
 Kd+7P6oucDuu5VyZa2mmygxS8Q+ogy0AiIRhScZbmUtmbRBS989PDn7G6czRPztZPGdv
 clSw==
X-Gm-Message-State: ANhLgQ2WPwYo/gmJ+hdLsHDhMa4aEH+7IF1q7o4oXm0N4+QbHs5H/okR
 SOj4JeiGiaY+Fz89tYRkBQ3qLP1Z0UU=
X-Google-Smtp-Source: ADFU+vt5c3MkyuMB/7Di7ggCIgRVl97+sDr/cpgR4zjpOCX3Q2C0bIC0vsRwZVm9SgWm22/EEXaWQg==
X-Received: by 2002:a62:446:: with SMTP id 67mr780910pfe.109.1583898395482;
 Tue, 10 Mar 2020 20:46:35 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 h29sm46671572pfk.57.2020.03.10.20.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 20:46:34 -0700 (PDT)
Subject: Re: Questions about pollute the mail list archives
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, Alistair.Francis@wdc.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <a17be147-3e03-b79f-1008-11734c03cfdf@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <528c86c4-aad5-78c2-c710-7a09ddc5230d@linaro.org>
Date: Tue, 10 Mar 2020 20:46:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a17be147-3e03-b79f-1008-11734c03cfdf@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52e
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/10/20 7:19 PM, LIU Zhiwei wrote:
> Is it serious?

It isn't ideal.  I would eventually try to review via your branch, and find a
copy of the patch to reply, or send a reply to the cover letter if no copy of
the patch arrived.

> Is there any way to clear it in the mail list archives?

No.

> Can I send it again to the mail list?

Yes.

To avoid confusion I would label it v4, even if there are no changes since v3.

I would recommend using the --batch-size and --relogin-delay options to
git-send-email.  I don't know exactly what parameters you need, but choosing
small batches and long-ish delays should mean that the whole patch set trickles
out over the course of an hour or two.  Patience is something that computers
are good at.  :-)


r~


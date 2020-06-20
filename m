Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5705EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1D12376F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NI1z8haX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1D12376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmmsW-0008Rt-Ae
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 19:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmmrt-0007sM-MK
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 19:25:49 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:36538)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmmrr-00053g-WD
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 19:25:49 -0400
Received: by mail-pl1-x631.google.com with SMTP id j4so5768625plk.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 16:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aYWN/IrKxxHeww+rGye1j4UEFZHcphjQ1biTlGEPwcI=;
 b=NI1z8haX54MQBmlrpxde4xQ2oVpBNraViJili8FGdBM7iVI9Ow/D3Sng8H8+7Wmzn3
 PNMzSBR2yuXS6AQiOCsu67eTX50Cm4fogfaXlg+orEe6lnbWFcT8WtuEHK+8fo/KlKr5
 qvavjXqBVcLUPZ8V2rvUUpu2ZZcnsD9hp4p/Qla+8qU4HgMuAjpAa87U+JfAqThXdZaM
 DUHPgwS1BlW2kfhpwqv/nGkl0rzzLACgcvy6/7JDMx8m95bef574k4qH9nYTTou7X3Jd
 tjz3+G5nswx1diXaVLAw8l466+QjytVjCSo5QP2xXQuAnWUDliYK+hfM63qFrPMmynfi
 FBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aYWN/IrKxxHeww+rGye1j4UEFZHcphjQ1biTlGEPwcI=;
 b=Mb4pf6opbE7Ek6Ek+JSNFxQlXTNAfZFe4IZ/+TZ9mV9hn672FWQgv8JHdFaEx4fGAN
 cOl/TQlpa+8CcJWSq1QhzuWAswk4ib4T8tyPCL1V6bqG+VnEiJnJpQppftB8C6Oaicu6
 dTE+7YvWsIzdQWbeMnI7TNbqASxtN6BHryWZY8UVbGHTaTVFgHjOn2c1W0OQ//u8Yc+D
 KO0Qj3F9ejo2ErFIEe2Xp4ZfYan+Qzu2FIl9oD0RVrb7by4GBl/7E8Fh2u2BG44q9z0g
 BVbUEWitEnyAoclHodwYHtUNEAqVVkCjqo7xgxzl4sHQJba6jtvJ8KWr4g9LkpQsTLU9
 ut9A==
X-Gm-Message-State: AOAM531nAAFruYkBYxX1V30ArCQkfFbP1go1mf9FhzGQbaRCbSyKrtWr
 cvI2Qu372rn1XShaKM/l90unRA==
X-Google-Smtp-Source: ABdhPJx2X3xRNhl1c+Pkp8gDctcytaMJINDkeHkv4hd800au7/CfvnkDnxdWYQVb+l4nhqFJQETBUg==
X-Received: by 2002:a17:90b:238d:: with SMTP id
 mr13mr11034753pjb.19.1592695545595; 
 Sat, 20 Jun 2020 16:25:45 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u21sm9396782pfn.123.2020.06.20.16.25.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jun 2020 16:25:44 -0700 (PDT)
Subject: Re: [PATCH v2] docs/devel: add some notes on tcg-icount for developers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200619170930.11704-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7611429f-ec38-554d-3aec-e4a2f456a1ea@linaro.org>
Date: Sat, 20 Jun 2020 16:25:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619170930.11704-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/20 10:09 AM, Alex Bennée wrote:
> +TCG has long supported a feature known as icount which allows for
> +instruction counting during execution. This should be confused with

should not be

> +cycle accurate emulation - QEMU does not attempt to emulate how long

--- for em-dash, iirc, and (technically) no surrounding spaces.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC33C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D6F21897
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mxogOyS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D6F21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAbVo-0004X5-3B
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAbUU-0003xf-Gc
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAbUR-0006Sl-7O
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:03:32 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAbUK-0006Fe-LJ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:03:26 -0400
Received: by mail-pf1-x441.google.com with SMTP id q5so118876pfg.13
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oU5L0M4kTws7EHCALeGQeFy97C/PQVHAj3q/wslO8Xk=;
 b=mxogOyS2cw2WZy5KKRSq3GisVmVOci7dTDtBTCStqA6kKdNQPGSVdbZuYXSWBeOIVq
 iBKMUQ4+OE/eQOCCYYZaPzoOuan0+1fDRz0tHkNIzLL/Kf1z8kYc+fbjcdjZ9kJ5jZlD
 2tvGdRcALkgITMDVtVaeSpwMAoQ6F2GqVfoO1Wcy037F+panRptNs1wMWm5SV9BANJcU
 62tYS5Dhy+NK+TTowc7sp3lzVxM3ilgj37M9+vxIG10DCoihSctI2ez74TfDRJh5KGBZ
 2HsmpR4XWPYO7SdADMHWf04W7hHcmkzsSDkcXjUqgY0M4zepPoHcbqqvyHK7q826AFtR
 oBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oU5L0M4kTws7EHCALeGQeFy97C/PQVHAj3q/wslO8Xk=;
 b=Ct+rO6ZFpcNgVQPgoxMdeETQkRmJ6unjgWHibj3VwxQWNQ31zvKxpy5XlQI3t+Rd8a
 bTzByYfkefGOHdFte9U67UQ/1oEtoWVr+D+hr6qpGPk8g5JtLsa2t0vUa9co3Z2PzuEC
 Ok0u1F5oyixrEHA88RJKOGD5J+LCgtSb3BXYv62xNiXhQ1JKJMJqJSIX0XDYEP5atymy
 7LW0CVqySvinpy8lW7VIQgMXilUDByc81f5GiazhuMVV9ELDtTGN2JVw0BUa0luaVOlY
 YLnyu0S3rQRXn4fF7+AtltPJH9H0MCYUPcA9z2dXggOsIVfGdPKW56L7OvJowqGFkYUu
 a0Rg==
X-Gm-Message-State: APjAAAVY5Jyv28m47xJivlZ2YJN4h/ejAEzQVo+n6868azTpYEiXrRIw
 cMAxNMLp9vhUVVvFhJBBUgFutA==
X-Google-Smtp-Source: APXvYqxnzfU5CKzrA03jgppGoutcnBt5CbLzBOmccX5cRjklWSoSrjAKkr6/ZPRicQ/UwZyQqj1HRw==
X-Received: by 2002:a63:1b66:: with SMTP id b38mr4423432pgm.54.1568818999278; 
 Wed, 18 Sep 2019 08:03:19 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q20sm8587254pfl.79.2019.09.18.08.03.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Sep 2019 08:03:18 -0700 (PDT)
To: "Paul A. Clarke" <pc@us.ibm.com>, qemu-devel@nongnu.org
References: <1568817081-1345-1-git-send-email-pc@us.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9a8aa255-e324-0b93-d145-44c4eaaa86ec@linaro.org>
Date: Wed, 18 Sep 2019 08:03:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568817081-1345-1-git-send-email-pc@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3 1/2] ppc: Add support for 'mffscrn',
 'mffscrni' instructions
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/19 7:31 AM, Paul A. Clarke wrote:
> From: "Paul A. Clarke" <pc@us.ibm.com>
> 
> ISA 3.0B added a set of Floating-Point Status and Control Register (FPSCR)
> instructions: mffsce, mffscdrn, mffscdrni, mffscrn, mffscrni, mffsl.
> This patch adds support for 'mffscrn' and 'mffscrni' instructions.
> 
> 'mffscrn' and 'mffscrni' are similar to 'mffsl', except they do not return
> the status bits (FI, FR, FPRF) and they also set the rounding mode in the
> FPSCR.
> 
> On CPUs without support for 'mffscrn'/'mffscrni' (below ISA 3.0), the
> instructions will execute identically to 'mffs'.
> 
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> ---
> v3:
> - Fix v2 change which cleared inadvertently clearned DRN.
> - Remove FP_MODE, use FP_DRN and FP_RN explicitly instead.
> - I did not remove the FPSCR_DRN[012] or FP_DRN[012] defines, as it's
>   clearer to me that it's a 3-bit field, but am happy to respin if that
>   is preferred.
> v2:
> - Add DRN to returned FPSCR value.
> - Add DRN defines to target/ppc/cpu.h.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


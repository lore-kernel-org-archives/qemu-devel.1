Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB3AC47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 21:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73FD215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 21:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p5u96RbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73FD215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGVHs-0001SM-OX
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 17:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iGVGY-0000bz-I6
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 17:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iGVGX-00021t-CL
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 17:37:34 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:36828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iGVGX-00021f-5a
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 17:37:33 -0400
Received: by mail-pf1-x435.google.com with SMTP id y22so4690889pfr.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 14:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GZbPIm+LOAsILtfX5N5DgONEVfM/710JduBihv1Wirw=;
 b=p5u96RbRxkA958mlVJtyM0JFqTSn61B5+YJBjyOr12SUp0gHRxzsMifCLUt7Qt4D7+
 0+VMneWIzULvSLMAfZx6lSWYtzSNDKn1WXDhUtzDrYsdxoiL5lMNJ0pjJQjTVfxDLsr7
 F5xXnznISoE+HGne/pzYQg7plFbDISUm/Jo9fxS2/3qkxMYEeY/zxyqtM3aYqtFG6FWg
 tjiYP9JoPt7fqG066ySlKiaHJQbf8N0sZv7ZF3RJGl4rfN1cxXe8RRtgEQVHYQgZlWhB
 QxM8hrM9k63ILqGApGN4TGNVjf5l+5VxBuXk60zDKcphZMy32vCV+3hUiyqrrpLPskg9
 JD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GZbPIm+LOAsILtfX5N5DgONEVfM/710JduBihv1Wirw=;
 b=ecMznuZS05vchA0uAaa4HE35DpQE3Z5Y3eqGwk/vC7IeUomHSKem8Atf82rGuV0rxx
 GctVZBbjrYvM1dwbqHZVzKzx5TG+wpYCa2yQQ5w74bFw3Bnw0/uE5BeelhRDxcqgeNv6
 ZfjcL6NipsrFQ3GmmRal1hHkIwPDozrIJysKEivxrd9zyFuBwAYu4z2oZ814f+Uzv0fq
 tlPkzf662ZyYXOjTeEm3xilw0J1B74XDKKy1LoRl1zXHfLzkLdFSxXbfHC/2tV01eMox
 U79NIIinJbvyeNxosvxXLHlvceIVH0VfZ3Hq1oY+/TqaFrx6kB/e9Bu9dz4RGXUbgcSy
 KR1w==
X-Gm-Message-State: APjAAAXxUKkFeC/fFRCRJgIoPRSn2z2ySu7/3Vw/wEXhmOqBSgWf2m1w
 v/4EQpd838VtHCTl8boY92xzwA==
X-Google-Smtp-Source: APXvYqz7LN5Dc5mHXXAmDOuHmcTKij2We5ZF/eSUfbcluxWhSGn2KOwfaIYxaotD7wmFSK4CWqbrjA==
X-Received: by 2002:a62:fc8c:: with SMTP id
 e134mr19801378pfh.132.1570225051526; 
 Fri, 04 Oct 2019 14:37:31 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id m22sm6442871pgj.29.2019.10.04.14.37.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Oct 2019 14:37:30 -0700 (PDT)
Subject: Re: ptimer use of bottom-half handlers
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA8HGEdHs74-m3Wa7RHU_ZE5g9kEidP-9Z69zhsMkCPRZQ@mail.gmail.com>
 <CAFEAcA_sTc+EcDU-=kwLTLRL_ZoiXReRCfy1XeDj+4p02B3e8w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1e07100a-5ce1-ac18-7324-0e1eab950903@linaro.org>
Date: Fri, 4 Oct 2019 14:37:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_sTc+EcDU-=kwLTLRL_ZoiXReRCfy1XeDj+4p02B3e8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::435
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/4/19 10:40 AM, Peter Maydell wrote:
> So we should probably cause that to happen in the new scheme
> (conceptually, something like "the trigger callback is
> implicitly considered to be called from within a tx begin/
> commit block, so (a) it doesn't need to do begin/commit itself
> and (b) if it does something resulting in a repeat trigger
> the second call will happen after it returns, not recursively" ?)

That sounds plausible.


r~


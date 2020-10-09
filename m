Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35523C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FDB322248
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RUOKjdWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDB322248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQs1d-0000Vh-AU
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 09:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQrzm-000889-Vs
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:59:39 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34129)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQrzj-0004AC-9U
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:59:38 -0400
Received: by mail-oi1-x244.google.com with SMTP id n2so10131465oij.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 05:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eqj9VFqJO8hK+lND1A4VurpbYJWP9Rcslrgga9pgPvo=;
 b=RUOKjdWF8x9/Xn3to1cxfC9BEcv0VXXIhNUrdsC/IKtSx8r18hq3a1Rac7qYTVq54k
 fPYMyVaBzXX/2G/jAY/bM4n44LBqJIZ89k7uBjY0E/H81XTLXAEyK35tfe6oAWQNXr+x
 +7dFpZeEg+QN/P1VyqJmT7ULfv9orWkV2L+GrYZOz5c8BItz+U7UhNETENObnYruyMQa
 BMPYs10G65LnRUWW8F1V8peCcSkYwUE78vSfUuEifWi1oaSvnqO6Kb2hb91PAbOv3y2N
 +3zq6hSd7RSkWEh/EmjI62Hs91g4BD3y7x0zojMXEAfrl5cM6S/C/evcnQdj9RKGqqie
 SgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eqj9VFqJO8hK+lND1A4VurpbYJWP9Rcslrgga9pgPvo=;
 b=VShR0aWBdufVIIvaXjmTb8tGx4jyc9ttTXVQAG0Jbn3o57Zo3jDSkh1AEsD2gUnamO
 ZcSBzU+wzW9KPRaDPjtKErCWRqHuKxiNEN+lmA622FIeesxENb8yhYN7wZ4dySeuBAtG
 zViEBww+NfXB/sBfkusQJLEPZ84gKneIpZftst/CtxOscr+u3GPIucooD0uwb9404lZD
 AJpzCpXBvh5edU2hUQoX1i/pXp6qIjciITb3SX7Vihw6IZc072gkPC32No8HsinBtoWa
 00ovmbkHx3ZGBvXEvYTLC4baX71dU+O+RcBaP3kjoawpyfKfM4718GN8vb5LMXlZCo+C
 CmSA==
X-Gm-Message-State: AOAM5314zaIdcb1NyLeYsImZQ/8gWdcpgZJJzFm2/UUS4bf9nG3UWhW/
 eWsu5PRTT3k76zpXQMmXZJeqSQ==
X-Google-Smtp-Source: ABdhPJxq2ikX19hoo1dw0FV20URbSzPxJDjjUM1KilN1A+tpVagu+CNk4k+9HtMSGaIqlpwl4GdoPA==
X-Received: by 2002:aca:3fc4:: with SMTP id m187mr2374948oia.59.1602248373367; 
 Fri, 09 Oct 2020 05:59:33 -0700 (PDT)
Received: from [172.24.51.127] (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id j10sm2918824ota.56.2020.10.09.05.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 05:59:32 -0700 (PDT)
Subject: Re: [RFC PATCH v3 26/34] Hexagon (target/hexagon) macros referenced
 in instruction semantics
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-27-git-send-email-tsimpson@quicinc.com>
 <75d5275b-76e5-38a5-f9a3-f36d1ee08c74@linaro.org>
 <BYAPR02MB4886F48B7E22A43984D78A13DE0B0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <b77feb32-9170-0c19-8147-5a195a227cca@linaro.org>
 <BYAPR02MB488658CFC0440D56F13F68D0DE0B0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <7f0ae43c-97a0-3337-eac7-938a2f244d3d@linaro.org>
 <BYAPR02MB4886A2E28C56A059B9F54942DE0B0@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b609e70e-aa24-f724-43ba-8898bc8e956f@linaro.org>
Date: Fri, 9 Oct 2020 07:59:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB4886A2E28C56A059B9F54942DE0B0@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.208,
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 3:54 PM, Taylor Simpson wrote:
> I'll reach out to the architects and ask if there is a case where doing the store first could be a problem - and also about the priority of exceptions.

Of course there are cases where doing the store first will cause problems.

> This may or may not be possible.  We already have to reorder to put .new consumers after the producers, and we have to keep the change-of-flow instructions in the original order.  So, I'm reluctant to go down this path worrying that there will be a long tail of corner case bugs to engineer out.

Well, do as you like, I suppose, but I think the merging thing that you were
trying to do is just as fraught with peril.


r~


Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1FDC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 16:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC62206DA
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 16:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VzI2xc0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC62206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7L9z-0006LN-FR
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 12:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k7L8f-00055o-H7
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 12:04:05 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k7L8W-0007Ve-8c
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 12:04:04 -0400
Received: by mail-pg1-x541.google.com with SMTP id j21so6886110pgi.9
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2020 09:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PXR4V/LO22UgutNOKF1l3mFxmnP52T/nrIabjldRxW4=;
 b=VzI2xc0i2Nhpab+W8e3Sp1oztRkRd/DbMbmCRThcEC9sDsEKBRHjTEZt9RCSfVvo+u
 UN3r4dw0wYc3O9zztAq055hfjqfRCpy/39L5dPf62sGoGTmRs2SZ9ynIw66v773AhoEx
 9bGxY1vpUkb00fBS/v25atglV7M4xp8lBfNhQrNSz0bBZx9Atei5EQmQAlq5046JympX
 NxPuNFxszwsGwbl0f/YXqcK5ReiU/FINXzuXdV6uyTtK6ZsOeYFed/m8yUSa1b0Byzf1
 COV+zNtReKhAUW0ohM+dHerJMe7uqlvIkvdBNwTE3QgmJo0YYbgWNcAPw3TY6t/34qnW
 YE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PXR4V/LO22UgutNOKF1l3mFxmnP52T/nrIabjldRxW4=;
 b=QIbG+HycJfwVyTcknKPC/lmQ6jO4Vnxq25A1u2Zs0/PdK1Oh7l97Kez3mcO+Mlk3N0
 vi39RJOy+xBx0cHKNufnt0/vtnTeyKdkCKV+glXnjEYIZOPoMkknSkdVHS8ovm5puuCC
 tb8keFBVYBOGMwD7h+mUmSMU7IwpxbFmEGyJno4bF1YJQI/KMO2LqKkZkV1gjrL1mGhH
 oi0n958aT1kgH6S/6GFneu/oG9uG+KpSQu6yOy2fZD2kx1AS/lsKHF4W2Ugb9nEOu1tz
 GTn3Udvpe6Y6X9XB0wqhxDxoJmpWw/OhV2eq0+jgijSLxmtd2HU5TSsd9/QhOo79XVXK
 A7oQ==
X-Gm-Message-State: AOAM531w/AczaEjN32hEfh8OVLTo01QJlQlumyi30qWyMp7WrbYasZPV
 8gZqIEGf05NHepkIG8skcsmTrA==
X-Google-Smtp-Source: ABdhPJzoybWvFRycPngXGP3jug1VtNye1vJLAR782bwRZWL4os5tR/nxOCvj3h5OogOXcYVQYS1xtw==
X-Received: by 2002:a65:4148:: with SMTP id x8mr7351037pgp.245.1597593834685; 
 Sun, 16 Aug 2020 09:03:54 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id e26sm15877025pfj.197.2020.08.16.09.03.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2020 09:03:53 -0700 (PDT)
Subject: Re: [PATCH v4] qapi/opts-visitor: Fixed fallthrough compiler warning
To: Rohit Shinde <rohit.shinde12194@gmail.com>, qemu-devel@nongnu.org
References: <20200816023127.22268-1-rohit.shinde12194@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9abbbc9d-b5d5-fdd1-e6ff-c89071189f7f@linaro.org>
Date: Sun, 16 Aug 2020 09:03:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200816023127.22268-1-rohit.shinde12194@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: armbru@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/15/20 7:31 PM, Rohit Shinde wrote:
>          /* range has been completed, fall through in order to pop option */
> -        __attribute__((fallthrough));
> +        /* fallthrough */

(1) Any patch should not be relative to your own v3.
(2) The previous line already contains the words "fall through",
    so what is it that you are trying to fix?


r~


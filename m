Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B659C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 04:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E8D24699
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 04:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ChE1v3Sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E8D24699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8cWF-0002jg-LO
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 23:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8cVf-0002FX-FG
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 23:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8cVe-0000xT-JR
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 23:16:51 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8cVe-0000xM-D2
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 23:16:50 -0500
Received: by mail-pl1-x643.google.com with SMTP id j7so3671310plt.1
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2020 20:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PkV16aBIntMWzqckBcGEO3l8/fhILzhcN5gScf3Hd44=;
 b=ChE1v3Smh5FMD5Ms89SMMbtTxErGorOPVFEC0k61UVkdK6kGy1El0qLn1yZMTJs/WA
 r10wgyHbv9iGMvOVm/9EIe+fCf8HFcM/bZpxZykMF8coWWgMW3DY341WWfdBJ6YzN2kJ
 OFV3xwi16fyAzTZJ5imnHN23xcE9GdW02fTEpDFc07l2qEdviKMA1sAtBpc3kk1z6X2j
 1MJigkEUk7lKetWeNkfzyd9wd5OiX1OKDoVvLVcqkt5mhiq4XLmmwFBJ+56stlLbw5ce
 +bhczp/ZEZWUG/vNIS5ap8VayffadjqfYMUNfjjKbKpldVxYp9M4GUzsSvsre0hSL4Cl
 A3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PkV16aBIntMWzqckBcGEO3l8/fhILzhcN5gScf3Hd44=;
 b=WAkrjj4zKczZVIAMFtSwecz8J4AUIPKs4Hf8j9J2t3rym0CExK/aGB53jl/wyAxUjk
 W03zA0cZknk21GVCSSGtrpDfwb5+9E7v5BXCETIvvdGs9TbZfduph0c/CASpXLcBTvKd
 jVocMD9RnybHCn5V7iEJwX4rslgVE/rbF7FkLXqEELmDRzxmTuQb5zc2InTlHVUAia+W
 jdIkPBNb8G4XHqM8BWKKnaieMqM5x4q03NUz+mvFIyBb8BgM03hj9zmZzLIvBZW3dOkS
 fOAe/DOvQ2yzm/qJC6g0MP3s+iIfLAslBZQnPpB6iNbHqBUmWf/YOYzG02Jn8BxREnIs
 iwJw==
X-Gm-Message-State: APjAAAX+KzLrQu9KBGHnF8AM1EXYjz5veOJIv+AZmVbNh1H+3JfxOWRH
 R9fpj5gsJ0JaAuKn3xz1iW4gPw==
X-Google-Smtp-Source: APXvYqyxzS5evz04tbURFG+iQcl+BIeI0v2Mo2e5HEfpt3EnLBqjrQwUSl6lqKUIhnQhE8a4YTR8Fg==
X-Received: by 2002:a17:902:fe91:: with SMTP id
 x17mr15515600plm.250.1583122609611; 
 Sun, 01 Mar 2020 20:16:49 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 k1sm16846683pgt.70.2020.03.01.20.16.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Mar 2020 20:16:48 -0800 (PST)
Subject: Re: [PATCH v2] i386: Fix GCC warning with snprintf when HAX is enabled
To: Julio Faracco <jcfaracco@gmail.com>, qemu-devel@nongnu.org
References: <20200301191708.18035-1-jcfaracco@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <848ae3b4-18ec-958c-19e5-6d57d7641b14@linaro.org>
Date: Sun, 1 Mar 2020 20:16:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200301191708.18035-1-jcfaracco@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/1/20 11:17 AM, Julio Faracco wrote:
> -    snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
> +    assert(vm_id < 0);
> +
> +    if (snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d",
> +                 vm_id) < 0)
> +        return NULL;
> +

And the assert is opposite.  You didn't even smoke test.


r~


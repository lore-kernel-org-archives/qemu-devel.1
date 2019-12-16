Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED0AC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 20:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9964206D8
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 20:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVlQwiXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9964206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igwuG-0001f8-VS
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 15:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igwte-0001Cc-W8
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:23:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igwtd-0000e8-QU
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:23:14 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:45244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igwtd-0000cc-J4
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:23:13 -0500
Received: by mail-pj1-x1043.google.com with SMTP id r11so3489911pjp.12
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 12:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AkgkOOtsz9GjG7aUzTcoRLGbdb372ppd5/6o/GBDfuc=;
 b=cVlQwiXyxTWgQUFCddj7U7wKnG+jWQlEhHgwBOmhDNqNXzmwj50Ay95JWWi09yVh8H
 rAiaLUsSckTRyWXFO01xod2uRvF1iLSk3MlwWGI9Qkh2fcCAWP7u6EB4J+iCizkzRCQ1
 MT6E68bwQDdLpOXwAeG67NP7Mz6KmdGiNgxP6ECvvVFzBopqpORpfcnRf3wkUiw1XnWy
 DBMH3/xIO21FTwb6+D5mF5R3RzCIjy48jPOi+7WIMZJ3ltVvfbVBIsnktuC462fBu6Kv
 MxGTg1O0yYwXw735ngu5uTUlgJyKUvkIWvaXDj+pf7oFx35M+8Ap0zdtZd04qIo5tyBQ
 fLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AkgkOOtsz9GjG7aUzTcoRLGbdb372ppd5/6o/GBDfuc=;
 b=n/APH3w1XX45Dxj7jDZgCww1iYNtipIazpBWF/r0oPIq8dRWLdjR/Tja5mMm+aAGHE
 Y7SKtCbSL3if5K2cB74rY0jnJikxr6GEy31Bva22n8eg2EAvzXSoEEL6Qnui+tOJ+01W
 zSAGIe0wAu18IVNc0AYSU4du76yUuX9jWRMOAeaiftnSz3Bf64fpP3E+9EPzdgiIVMHE
 KdaKOKjmAnPUEJPIzk3zPZYYsXui+rdoNGK/Y/mo0RsWYaNRkShh03RqCMKjUuv1VH5+
 7ST/QtSDtjHOWqSRRHCcIIMXAZ0cFA+5eZMsRkmiKlF1O3/WhJgG49OZUWV1/nfg41XX
 H5QQ==
X-Gm-Message-State: APjAAAWfnvwg9JVIc7cnGjDI8zGBL2g/F419CoxypDqnsn/EpAsS3PkQ
 KNtriZn8dc1Ejed9UrohuROCnQ==
X-Google-Smtp-Source: APXvYqxbsmYWyJ3YanraDOAH9bswgUGW4uQOBuem+6yoq7V0UmD3txfELyF+8qZIjT4XhMyjuv2RMg==
X-Received: by 2002:a17:90a:d145:: with SMTP id
 t5mr1300631pjw.57.1576527791999; 
 Mon, 16 Dec 2019 12:23:11 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d38sm21481516pgd.59.2019.12.16.12.23.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 12:23:11 -0800 (PST)
Subject: Re: [PATCH 0/2] target/s390x: Implement LOAD/STORE TO REAL ADDRESS
 inline
To: Cornelia Huck <cohuck@redhat.com>
References: <20191211203614.15611-1-richard.henderson@linaro.org>
 <20191216180409.6a753390.cohuck@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a8665c3d-7329-18c9-767c-ba145defa71b@linaro.org>
Date: Mon, 16 Dec 2019 10:23:07 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216180409.6a753390.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/16/19 7:04 AM, Cornelia Huck wrote:
> On Wed, 11 Dec 2019 12:36:12 -0800
> Richard Henderson <richard.henderson@linaro.org> wrote:
> 
>> Found while working on other parts of cputlb,
>> this cleanup can be split out independently.
...
> Should I take these via the s390 tree, or do you plan to merge them via
> another path?
> 

Please take them via s390.


r~


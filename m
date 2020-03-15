Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AB1C10F29
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 21:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF482051A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 21:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDzCmAr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF482051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDapV-0005wj-1S
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 17:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDalP-0004Xf-53
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDalO-0006Yc-0w
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:25:38 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:39811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDalN-0006Ra-Ov
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:25:37 -0400
Received: by mail-pj1-x102a.google.com with SMTP id d8so7416078pje.4
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 14:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MUcEBsSuXczOzzty2CIjEtppGu/xDozx81iytz6hNEc=;
 b=JDzCmAr9QRSycWFIXYD83KT/s0Go0DQzgkQ5TmZcADit5BzMCIY8IyU7jtSSfOqDbl
 b+Wq1tz6kWPqP9miRIZgzCXklQBXVis6DtH8MQoS36ATfd1XYomzZZomT38EBTVlcZIw
 xUQsG20YENG/qf5i+JKRMy99Tn3xYaJLlLcGbQfO5M1GErHV1HU/prJKTnGjyn42ozLJ
 nEW0S+PoBRd9EnZZiee2SbDjeswly+JWzTcOgBZYqDZZ209ORfCyGV67CtWm3XRa7G5H
 M7PeN08UwOLVnxaoBHSmqGkbZWDLW9r5fDMe4t40F3iMBxSbQ/z0sqdSNasjVeNlod9H
 Tugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MUcEBsSuXczOzzty2CIjEtppGu/xDozx81iytz6hNEc=;
 b=gqrSJKblZX33CUXrfZQX7rlGjY3UJTtBiiptXONl8mr7cDBZD7+n4Z65RpoT1WuDAy
 2SRxHQ93+RL8JMkQ8PkunpwWlYpP0OLcHJW/e4rp2F4uAm3hkY15NDE/Nd4EkAkTZoeH
 RHbGwU7l+H0XjXpzQgV1iUYvR61EUv3KpCuQ3JB5UaM2Dgmepm2JVHtkGCxS3xImOvt1
 VN/FpSX829w5i2m9lqmRrbgzw/cIwL92ppHO5TGvaBwowTgiHZBTjFRhw9T9UHOfga0g
 4339jK0GfLReLtW1kU28f0QOz/CWmx2GgLiz0rZD2ZgDsZnGjmzYREmcPyISvrqfFlAh
 Zgww==
X-Gm-Message-State: ANhLgQ2v4WYjKPFSmcOhO8y5O/ObEEuMCULg0b1Y2ts6gw+ykP4UPuf4
 Nzfs98CGcq0B0bbzWWb//TUoZQ==
X-Google-Smtp-Source: ADFU+vtBroDpA6Etn4dlj3wpnsoVtc4rjEpXowXKEZP5slrVc8Bpz5yQ4KOkQAQHOzISWbq3V+HMnQ==
X-Received: by 2002:a17:90a:8d81:: with SMTP id
 d1mr21929630pjo.63.1584307536399; 
 Sun, 15 Mar 2020 14:25:36 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 a31sm46540440pgl.58.2020.03.15.14.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 14:25:35 -0700 (PDT)
Subject: Re: [PATCH 1/9] hw/core/qdev-properties: Use qemu_strtol() in
 set_mac() handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200313184607.11792-1-philmd@redhat.com>
 <20200313184607.11792-2-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1037ec70-ff39-b195-a374-7cace38e9761@linaro.org>
Date: Sun, 15 Mar 2020 14:25:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313184607.11792-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102a
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 11:45 AM, Philippe Mathieu-Daudé wrote:
> +        if (qemu_strtol(str + pos, &p, 16, &val) < 0 || val > 0xff) {
> +            goto inval;
> +        }

This is doing more that *just* using qemu_strtol, it's also validating the
input.  I don't think you need to adjust the patch, just improve the commit
message.  With that,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


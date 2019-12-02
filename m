Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A1AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 02:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C06020881
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 02:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NKlNgjFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C06020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibbfp-0003lV-HN
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 21:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibbed-0002p9-Pw
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:41:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibbec-0008RF-JJ
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:41:39 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibbec-0008QU-Bd
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:41:38 -0500
Received: by mail-pl1-x644.google.com with SMTP id s10so15572693plp.2
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 18:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=c13Wjzos1EtGKKvew52DvMGXElPNobtTinpSlmyukJA=;
 b=NKlNgjFQi6sOk7HkO8p4H2g/ovKzfs0J94FjBbxdCd36Y4m9tvWePzC7/XYhvTgFi8
 qmPC+NHbeOAXw9kVJubX6e5o6GjZ0HmTFmhPFgO7Pk4alsSBHA1HbOlIEzwrjxkxZ9OB
 PCVcEq4WuFMTaE+2FFTLuOb1GIETNMrcvAeQdV6Sx/5MfDbQYcNUBvCP2RmbC2rK79/h
 bywxmJON8h3vF3aSfXsf3MmyqUDg/bPeETBaUpRRdRpJhtGsWwqdC9QPrZnfPapPwHwv
 dSwMlmHgbBDhUp/XflIn99HfTwF4tZjTqoc3oKQFd8HYQlBLKl1kb+8xHKzJXPWnRe7n
 PZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c13Wjzos1EtGKKvew52DvMGXElPNobtTinpSlmyukJA=;
 b=h+rXUAh/izhOOtI+ibqabRmHO99kxAP3OOp6QMKgwxEA0iXYoYz+cgV8XM+dS8hqZR
 i+2yUtgSZVicaECxbbPAccO8yq87CLFjhXW6HmhAdOtMwW9Cw3gKuyeIMSuI3+qKdKkw
 tZsvhVnGr3fFQIb9n3WaOJL62WaGwNmb8J6DIsNl3q3zhAM7H0zVcdmQWAn+0Ffc2NbY
 LXPaek+hfF2JY1FjD5Rgl8W5JWwy9jnw1fcT+CKO3u/QmEB73YDpq4rRNU3Vna2w/zLH
 4ilkFWYiJjElqZGnfQqR8/nDiVqmDyZ1AUkxmbuMo7OujCdUtSbrFwnCwN9G5AXyidhM
 HTeQ==
X-Gm-Message-State: APjAAAVDT0+6khJXSWcSXZmNT8l1A5yTs06vWqox3P6dNTxCbKG/rWcu
 fE+cTT4XrgxCBf+YNIZFzJdugQ==
X-Google-Smtp-Source: APXvYqwwdN0t6YJZkt+82dxh4n2UojMRsqoLnEp3XQMKtVLZEuJURDc98DpQCtzq6wkNWU0nnDswHg==
X-Received: by 2002:a17:90b:d85:: with SMTP id
 bg5mr6202738pjb.99.1575254496974; 
 Sun, 01 Dec 2019 18:41:36 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id u18sm16530275pgi.44.2019.12.01.18.41.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 18:41:36 -0800 (PST)
Subject: Re: [PATCH v2 11/14] target/arm: default SVE length to 64 bytes for
 linux-user
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-12-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9362663d-6452-39aa-2a8d-1cfd853d7faa@linaro.org>
Date: Sun, 1 Dec 2019 18:41:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191130084602.10818-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, luis.machado@linaro.org,
 alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/30/19 8:45 AM, Alex Bennée wrote:
> The Linux kernel chooses the default of 64 bytes for SVE registers on
> the basis that it is the largest size that won't grow the signal
> frame. When debugging larger sizes are also unwieldy in gdb as each
> zreg will take over a page of terminal to display.
> 
> The user can of course always specify a larger size with the
> sve-max-vq property on the command line:
> 
>   -cpu max,sve-max-vq=16
> 
> This should not make any difference to SVE enabled software as the SVE
> is of course vector length agnostic.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/cpu64.c | 3 +++
>  1 file changed, 3 insertions(+)

6 is the largest size that doesn't grow the signal frame.
I imagine 4 was chosen because that's the only real hw atm.

> +        /* Default sve-max-vq to a reasonable numer */
> +        cpu->sve_max_vq = 4;

I also agree that we should match the kernel, but this is not the right way.
Changing max vq is not the same as changing the default vq.

You should change the value of env->vfp.zcr_el[1] in arm_cpu_reset(), and the
user can increase the length with prctl(2) as they would be able to on real
hardware that would have support for longer vector lengths.

Also, I don't think you should mix this up with gdb stuff.


r~


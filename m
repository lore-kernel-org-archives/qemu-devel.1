Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB66DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 19:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B1620717
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 19:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvPYSour"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B1620717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyK1j-0003wt-IK
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 15:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyK1B-0003X9-SH
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 15:03:05 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:34927)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyK1A-0002t5-3F
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 15:03:05 -0400
Received: by mail-pj1-x1042.google.com with SMTP id f16so1892595pjt.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 12:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ue/2ebaCIx/F1wkGkedFCgz6RLwZSyvf7VAJ/9l598A=;
 b=xvPYSourg409J3Wd9NqUEF/nAJTkNI9WwAnpadFovVnn0mjCcCxI8MMfAt+Q7KtMzH
 XdMwsz4n2ixmpwTQGiSPLA+W448XIjHdvzqlJ/xTVfTufU+89jCQEQ04yg1uGohc3TJs
 bDkUHxX+5HUYAfTRzZkF3VcFAUe7+JCht7WncpP65+zx+jR9CfvmiCPd3gO7i6e1ydzH
 J7nhPHIiJofpnGIOEBPoYQWRbYBfy1slwEGoUP9dY5TEHhCE/e4GM1oBLWhQqkXxIaAy
 gO2QvP6sq5iNHaIwnF1l59rU9lx5SkrNE9PsjSmenMp5bAXeAxgJ/8CqyvxXQsq0vWgQ
 /n3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ue/2ebaCIx/F1wkGkedFCgz6RLwZSyvf7VAJ/9l598A=;
 b=Jzes2Xm9bUST+OMP9C2J3tGXx3FNjzSsgIJZ/MOkKucLJn8+gtBSY2VJNu5e2ZCfur
 mpvbJdNDPACnjrkGHJTAlVvFfzpuIWtJg+HvFRCcYjCWVAq4bJZqmifO1aGAFnyEJUct
 Ifr6XnSVsJzr4iyzXNEWtzP9foCGKmTTjH8NXA0OEgGmB6GkV3AheAcXbKo0tp6a1D+G
 Apall7lP5FIF3r6dYVIZvJfRd9/LIEfWbAaPwdy7JZFRQoANuSQsj3ETyqZDBWJc2Inu
 dLuFeum3pFgrFRxIJdRn8GdD+k7rnE9WL4n2AUvysbp7Tq/s0557MMnqqUsJaIi220vJ
 5yHw==
X-Gm-Message-State: AOAM531jNXeSVsU7tpQ+W/BITXoXRzQzmKrdEy9yzybE+ytEM7kpQsqG
 eUlnmFhD6oiVpDXp+Cf4+LrvhQ==
X-Google-Smtp-Source: ABdhPJxeuTCRZej1ucLC91C1Yr9RkDIQkgdDdwi+P2KeGNgQgvFU45g37IvEbJM8ys2iaVNTT4sLXA==
X-Received: by 2002:a17:90a:d684:: with SMTP id x4mr773577pju.62.1595444582318; 
 Wed, 22 Jul 2020 12:03:02 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 f93sm411315pjk.56.2020.07.22.12.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 12:03:01 -0700 (PDT)
Subject: Re: [PATCH v2 06/12] accel/tcg: better handle memory constrained
 systems
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-7-alex.bennee@linaro.org>
 <5d26e26f-55f7-5b74-bb9e-b97ea1040c05@linaro.org> <87ft9jtsw5.fsf@linaro.org>
 <20200722163722.GS2324845@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0efbcac2-d2f4-de96-63a1-ba7cd485a1e6@linaro.org>
Date: Wed, 22 Jul 2020 12:02:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722163722.GS2324845@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: fam@euphon.net, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, f4bug@amsat.org,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 9:44 AM, Daniel P. Berrangé wrote:
> OpenStack uses TCG in alot of their CI infrastructure for example
> and runs multiple VMs. If there's 4 VMs, that's another 4 GB of
> RAM usage just silently added on top of the explicit -m value.
> 
> I wouldn't be surprised if this pushes CI into OOM, even without
> containers or cgroups being involved, as they have plenty of other
> services consuming RAM in the CI VMs.

I would hope that CI would also supply a -tb_size to go along with that -m
value.  Because we really can't guess on their behalf.

> The commit 600e17b261555c56a048781b8dd5ba3985650013 talks about this
> minimizing codegen cache flushes, but doesn't mention the real world
> performance impact of eliminating those flushes ?

Somewhere on the mailing list was this info.  It was so dreadfully slow it was
*really* noticable.  Timeouts everywhere.

> 
> Presumably this makes the guest OS boot faster, but what's the before
> and after time ?  And what's the time like for values in between the
> original 32mb and the new 1 GB ?

But it wasn't "the original 32MB".
It was the original "ram_size / 4", until that broke due to argument parsing
ordering.

I don't know what CI usually uses, but I usually use at least -m 4G, sometimes
more.  What's the libvirt default?


r~


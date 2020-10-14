Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728FDC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A0121D81
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YWqEyuZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A0121D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSn5y-00010V-6I
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 16:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSn4j-000070-Oh
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:08:42 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSn4i-0007No-1Y
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:08:41 -0400
Received: by mail-pg1-x543.google.com with SMTP id j7so338145pgk.5
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 13:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CRawDl3KT8n2gFVfE7ekiG1dsDR86z3UYgtTwgQRylU=;
 b=YWqEyuZ1ywvI/PnD5D+v8gTACuIF8K/kQ5/+TKcVpM4NGidvkWzbCPgs3DEk1tmAGI
 kzNTP4s4PKvCKAoGsfG6vT+/VoausaxDaAtoxqyCHq8LxSUfCxfU+Iel5VxpFuanKZ3b
 F0uYyQBbHZu4yIy4hM3yEw29moN5Iyq9pdItl2ZcBgMyUPkrsUCxBYXt0pciogs81qQw
 FYqIrmbk8zEvuruGtjqCx6cMvc18WWkQNvuJhAV3wuFN2UB0ABgHMvQM19uSV/1kqppH
 dImQu1ZV39cvdDCX40BPAf2g5yFJwmcMpW+qTyShebMOwsREZnIpvJ7ZJ165ESWC1r+M
 aqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CRawDl3KT8n2gFVfE7ekiG1dsDR86z3UYgtTwgQRylU=;
 b=kcpUG9arZFtPMTCOHwdVc+iwbww2jS9eRNJGHq7oVov9cTHhVKJLSH9nclnLofjjdA
 Fj/qpaGbmPH6q2+yW/Qf+lyg7Cb+gb9qkD1YI2jJNpH0w0j765G1er5RsDKEiwSXFCbH
 /rUy8eamwLH+utlOP6D9S2Mc0594JreibkCKoo1YUw8GBa/PMuaR9qc2SNCsN15iRfOH
 uybsZAw+my+S/g+R/zJwn2yjqVvoRfR9RwVtWu1ZEP5oczrLbsaLNh7JtolDO5SI0t9o
 vK2AZFZsyGIoNDH4Pn4feb5G1SigvhQUyxUCCzJxrUHu1WxWaGY2BGwSZACZTDVE+Vc0
 jqDg==
X-Gm-Message-State: AOAM533R4XkS12UqKTl0p1Rbir/0/9ebA9NMyL0VgmKmOpIH4ws4zBMj
 pxKP3nv1DxRXAje4QWh/x0twOD2nx2KCbg==
X-Google-Smtp-Source: ABdhPJy+Fil5OPqWoWXImO9UmcXgIHsXeJsphk4WRD/PUG3q4GiEO9lbYYK5lXH5qbNoq0M2CGb4GQ==
X-Received: by 2002:aa7:96b9:0:b029:155:6332:e1c7 with SMTP id
 g25-20020aa796b90000b02901556332e1c7mr890993pfk.35.1602706117815; 
 Wed, 14 Oct 2020 13:08:37 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k3sm438932pff.71.2020.10.14.13.08.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 13:08:36 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] accel/tcg: split tcg_start_vcpu_thread
To: Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201014192324.6390-1-cfontana@suse.de>
 <20201014192324.6390-3-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a3c48dd0-643b-a433-08b7-cdd637f2752d@linaro.org>
Date: Wed, 14 Oct 2020 13:08:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014192324.6390-3-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 12:23 PM, Claudio Fontana wrote:
> +++ b/accel/tcg/tcg-cpus-mttcg.h
> @@ -10,14 +10,4 @@
>  #ifndef TCG_CPUS_MTTCG_H
>  #define TCG_CPUS_MTTCG_H
>  
> -/*
> - * Multi-threaded TCG
> - *
> - * In the multi-threaded case each vCPU has its own thread. The TLS
> - * variable current_cpu can be used deep in the code to find the
> - * current CPUState for a given thread.
> - */
> -
> -void *tcg_cpu_thread_fn(void *arg);
> -
>  #endif /* TCG_CPUS_MTTCG_H */

Hum.  Do we really need to create these headers in the previous patch?  Because
now we have an empty one.

Why not just put all of tcg-cpus-*.h into tcg-cpus.h?

Otherwise this looks ok.


r~


Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89FEC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F02B20848
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUliOTh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F02B20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTSse-0007HA-4J
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 12:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTSr2-0006Dx-8i
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:45:20 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTSr0-0003rK-Mi
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:45:19 -0400
Received: by mail-wm1-x343.google.com with SMTP id q5so3656684wmq.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BVe6dmrf13VdE0U3JvZftNSBBYuiKnOd5m37uC4wBTs=;
 b=bUliOTh4mnzjkcoiWio6JYR/maUIJG+hiA0hsEpJjDRcFTrFwrbI9FEkKVrxS7LZSw
 oPHUPP1EnTDolOMUKhKzV+UptpDtRL/jrjvphMjbjmyRK9mf8YD9Vhv1Ujpufcx1YjDm
 T9njvrqW1flBfPTKwUU3WLdwq0fTZDx8lbGdpMtC/78JpDe7znXvlQ8PCxYyRII5Vr0u
 D68qh46Y4PhU1nbd4nCO9/CxqlRfqPSnocvMXL9QMB7wgNCfRxM9Bwli7pbjnJf433fG
 2/14tF3bIMF+gKTGwXp+q14lwoJVnwrYMK8rWkkuA2Qum9HEmrBEOV1lsCRRQTr4ONLm
 JA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BVe6dmrf13VdE0U3JvZftNSBBYuiKnOd5m37uC4wBTs=;
 b=J7/VFVlWBmmgeokuxQEFtoW+u9bVZ0fxwW51aEV3oI8rx+dnPlwUMX46QJZO1+2u7u
 zKwn3rlbR+Lk5Z4l8VNm9K6nFIV/9QYWEr/zv1RSyRMmUmFLktjHrxvnwWlTDDlE+1N4
 hmDIRbGyodOULBsNojDeBtABWMPneXUo6DuiitcQ+DhFDKmloXv/LFW8W4fkdHtAil9i
 b+Ja7sVIjAA3JbCzzywDirqlTr/9F4s++6BASm46BjMY7cuAkEoV/S9hjl9Xaded2V5L
 Mtg96kroO+TuCUZTQqKsNQnHF/z8EJUwA52oCVeAVzJaCI2oVbe/iu8fbWDjsYKnbWxY
 U7uw==
X-Gm-Message-State: AOAM533HtWBpVpFRZDwdpa883s/RSCbk47b4j2hmMt56DjWgEabGoCcB
 sTBAZeXVjMCTQ5EFmVQMK20=
X-Google-Smtp-Source: ABdhPJwG03a9qHWvr/3C7r3VWsj+Hbn/M0fuXcwoSKoXJEuziVc6DGK8MsxBua6B5bYo+AVWC0UhZQ==
X-Received: by 2002:a1c:e283:: with SMTP id z125mr4898765wmg.154.1602866715165; 
 Fri, 16 Oct 2020 09:45:15 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id t13sm3458338wmj.15.2020.10.16.09.45.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 09:45:14 -0700 (PDT)
Subject: Re: [PATCH v4 00/21] hw/mips: Set CPU frequency
To: qemu-devel@nongnu.org
References: <20201012095804.3335117-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <86bde443-c6d7-ffea-8091-5a2677277778@amsat.org>
Date: Fri, 16 Oct 2020 18:45:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012095804.3335117-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 11:57 AM, Philippe Mathieu-Daudé wrote:
> Since v3:
> - Introduced mips_cpu_create_with_clock() helper (Huacai)
> - Added R-b tags
> 
> Since v2:
> - Renamed "clk" -> "clk-in"
> - Renamed "cpuclk-out -> "cpu-refclk"
> 
> Missing review: patches 7, 10-13, 15-21
> 
> ~~~
> 
> All the MIPS cores emulated by QEMU provides the Coproc#0
> 'Count' register which can be used as a free running timer.
> 
> Since it's introduction in 2005 this timer uses a fixed
> frequency of 100 MHz (for a CPU freq of 200 MHz).
> While this is not an issue with Linux guests, it makes
> some firmwares behave incorrectly.
> 
> The Clock API allow propagating clocks. It is particularly
> useful when hardware dynamicly changes clock frequencies.
> 
> To be able to model such MIPS hardware, we need to refactor
> the MIPS hardware code to handle clocks.

Thanks, series applied to mips-next.


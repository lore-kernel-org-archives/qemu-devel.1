Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A95C433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 04:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA69B20757
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 04:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WyTabbqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA69B20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kElxe-0007km-T8
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 00:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElx8-0007KN-WA
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 00:06:55 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElx7-0005sh-F3
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 00:06:54 -0400
Received: by mail-pl1-x642.google.com with SMTP id x18so2938737pll.6
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 21:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/xtIOGvQcb5i3z8/Hq4ZTqvsLiBDn22bSG1f+IO2s/c=;
 b=WyTabbqC27hIMwsoz4OhdIbUfwxlu6Pql5nlpsWus09hWt2HXXuLCjqv/UluwigbKN
 /WVcyFh6u1IA0JN4WVWUaKdJ20o64Ab86yvAqQkTSXcdy2+CFauuz54RdL9bpZnRpgFM
 V7RKLWNIHRlLF7XYoM87+ru1sHLr0j8gSFYf4BBi/oxWgpPoEP+u1xvr5LhzSx7XLvDQ
 noCbNO9vRApd1VfdmAGsKYTIslOrD8RKvgDfYrIVc1qAiXffr4xdJ5JILsStZecBwgJG
 1FkW59MshNfCL0ja8umC6vC1F6A0NH6hWh8yeoDURuTc+szrFUmN3WQB6gIIoRtjXBOO
 e0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/xtIOGvQcb5i3z8/Hq4ZTqvsLiBDn22bSG1f+IO2s/c=;
 b=t70rfojoVg7++pmVg6TlllZTV7COWutQ5HNDhGh+W0BZ23RCQFedK+0KnaYKxk2Rm0
 cVfTSbXhyCxBpu3D+Ht0keZC8+KyLd6phOpgp6quYNP3I0+3ro0t1N/LOjhbDTaFYYyI
 dZCLSTzAPZrhsk0Wh5tlaTBIQncTgFHYAn16rhqW75wCkhNVadew2qmQ2PPFkPiWVfcd
 fRO2/i6Wq41Oi4cgY3KAlZTL7M2VZ8GLBiH48xfFicVpFsCtxsIDi00jC00DevJF6nU0
 RJ542fWM/ZcxZoc0tyJM/ttPYYC65o0PRlQMC20j8CgwPn3bTo0zb4YCxDlsBDsBkZSa
 oHeg==
X-Gm-Message-State: AOAM530BBKPKO/l07nl/umZX7jw1IruqtV/Mv2QxFcLiLc3O/ZH0kM37
 uOsecFaxiJxUmaIbxT3sgBRv4Q==
X-Google-Smtp-Source: ABdhPJxSUXDJOgy6sQv6jKXYypveQ/19S2quB/WBeX5D0Zq9Z4LEeiJsjHP/uznnCSE+vLec5sH9Nw==
X-Received: by 2002:a17:90b:f0b:: with SMTP id
 br11mr15477172pjb.191.1599365212148; 
 Sat, 05 Sep 2020 21:06:52 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id e142sm11662459pfh.108.2020.09.05.21.06.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 21:06:51 -0700 (PDT)
Subject: Re: [PATCH 1/3] pci: Let pci_dma_rw() propagate MemTxResult
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200904162620.657726-1-philmd@redhat.com>
 <20200904162620.657726-2-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc46091d-fa27-fdf1-7f92-935ef5179fd8@linaro.org>
Date: Sat, 5 Sep 2020 21:06:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904162620.657726-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 9:26 AM, Philippe Mathieu-Daudé wrote:
> dma_memory_rw() returns a MemTxResult type.
> Do not discard it, return it to the caller.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/hw/pci/pci.h | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



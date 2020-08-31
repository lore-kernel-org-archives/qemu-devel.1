Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059ECC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC1D52083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iPsWc6iQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1D52083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCre8-0000ro-Ve
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCrdU-00008r-09
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:46:44 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCrdQ-0004uI-Vo
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:46:43 -0400
Received: by mail-pg1-x542.google.com with SMTP id 31so1448542pgy.13
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DAMvSkP3ycghdbPfao8tjevb03zNd12UoRVFNvmY36E=;
 b=iPsWc6iQv7QsltWoK3+ijsoP1moLRxpImZEue8X7GtJcystyO4zIlXWNfSM09ZyQ1W
 KObxSCIK7DAYzLxueNwh479O9PGvts2PRq+Med7mv8vZPKxH0ZomSiDXToUuH41rwCdy
 HSgc9DmDv4pc65o9X2pjCaVgXOuZ1KymoXli/ujb7Zs/2637Sms3Omh3BEv2CTFga1/S
 kV+TW/21x1hCGafCNv2ekSBaKal/Ov6PYK52e9NjGNPjv9OfKuMsh5smsTmethxyZf8f
 5CkZicR9T2CRI2shE+gRFuf1OKVugZezEDrlXXddGN4iPXttG0yLvfBDbXWxZ4AGJejO
 DFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DAMvSkP3ycghdbPfao8tjevb03zNd12UoRVFNvmY36E=;
 b=A056my5Rxdgl914noirg5o3uaHvarYU/9d4tjRl/CCxaKHEiQRXpki7sBNPj7CUV9A
 TfMqPaLcxv0b0NXKmMloZcov5nut0v+dQFaD/dA9mWRyTZ+IhVX2gzfUinqcWb906Ci5
 EKFe1ifpr0N9ay97qc+idHHdveuupJzK+A77+UYhItgX3+KjD4pGlA3y+Ohdce10ZxJR
 he6KIMuITEpAhMG6V6WS7Zw+Cpw1F/5WLl+XOSbn1Rl32eIajJuFojAN+EWtNZpGnRii
 KPdCJdksy24O0EqklRhwolm3Ygtyekg7u7UVKmrZPJWwMrpb/Fu3U8UHJKdk8E+XCiQW
 7uHQ==
X-Gm-Message-State: AOAM531eSfnVAIogb0yCWY5RbtXewH7KS+LZo5S+WGwTTPi2sTUIG87o
 76Vz9elwQIihWHiiC8GiRR/c3g==
X-Google-Smtp-Source: ABdhPJwVMWj8oUCpSfve9TEoH3FHJ80jj1Hv+2mD0LUDgJqyvyFzzmUWM1IPifEPUU//Q9eLHkn1CA==
X-Received: by 2002:a62:444:: with SMTP id 65mr2964961pfe.86.1598910399504;
 Mon, 31 Aug 2020 14:46:39 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gm3sm535739pjb.31.2020.08.31.14.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 14:46:38 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] target: rename all *_cpu_exec_interrupt functions
 to *_cpu_exec_interrupt_locked
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200819182856.4893-1-robert.foley@linaro.org>
 <20200819182856.4893-7-robert.foley@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0ef04de1-4dd0-e432-d1c1-b5672d276e1b@linaro.org>
Date: Mon, 31 Aug 2020 14:46:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819182856.4893-7-robert.foley@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Michael Rolnik <mrolnik@gmail.com>, peter.puhov@linaro.org,
 Stafford Horne <shorne@gmail.com>, alex.bennee@linaro.org,
 Richard Henderson <rth@twiddle.net>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>, pbonzini@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/20 11:28 AM, Robert Foley wrote:
> The rename of all *_cpu_exec_interrupt functions to
> *_cpu_exec_interrupt_locked is preparation for pushing the BQL lock
> around these functions down into the per-arch implementation of
> *_cpu_exec_interrupt.  In a later patch, which pushes down the lock,
> we will add a new *_cpu_exec_interrupt function, which grabs the BQL
> and calls to *_cpu_exec_interrupt_locked.
> 
> This patch is part of a series of transitions to move the
> BQL down into the cpu_exec_interrupt per arch functions.  This set of
> transitions is needed to maintain bisectability.
> 
> The purpose of this set of changes is to set the groundwork
> so that an arch could move towards removing
> the BQL from the cpu_handle_interrupt/exception paths.
> 
> This approach was suggested by Paolo Bonzini.
> For reference, here are key posts in the discussion, explaining
> the reasoning/benefits of this approach.
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00784.html
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg01517.html
> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B6FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 21:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FACD206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 21:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XTP5oUdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FACD206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhKDS-0000ur-Ou
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 17:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhKCp-0000TI-Io
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 17:48:51 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:35496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhKCo-0002sE-8J
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 17:48:50 -0400
Received: by mail-pj1-x1033.google.com with SMTP id 5so3374749pjd.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 14:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QHf9Tc1gTOD/j2PaHR0BkW59sh90LvXJykQFduX9Efc=;
 b=XTP5oUdiwQvTpbH3zG3rPIl6WMtmq4Wityhn83V7OvA7D17Xx6QUDF9B13dLwaIP7h
 KCafJ1aDrhWi7eYkgW/JSMq5DU1P44upyLh31hsMLXnk58kH4TB5FjQc129cgSCgtHuN
 kGIzXfUH5i7vOufzE7pFjVymIRTMp+fX23rZ79zBLd2RY8M/qhX6+mmRKO1+sYHD6iew
 huN6R/r6pxHNlyVAXwdvtCoObiy9b/A5Jn0PnHW8YQq7Tgc2ZGIn3LARqNwjRRDicFkg
 CzuEqU4gCO/1wl1sT/bbgLIJNoQFk9NPC3GamL5cDumn7ZBKR4yw8h6euVk7mOOpx91h
 KLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QHf9Tc1gTOD/j2PaHR0BkW59sh90LvXJykQFduX9Efc=;
 b=KV+7MSH2kFcsfCzMulh5DAnR/XrB/Uh8NwGjn3qpTQ49mJqVrHtruL0b/6V5OBktUk
 wGJ5DPercLMD+9IZKZChpLWDRpAhaDrzoRhbdqk/i3zZXhLooOoJF2UHDyPAM6bFEvON
 RwgeDMX5yjTYS0uHqTO6X/62kXqRlQ07CeaY5ggbF9thxUuMv8HD4TRZwMvcgaKBSY1t
 n3yWiDQptZH8my3RKK9RzGWCr1Q5rXyvLmujyuoMn4mrcL88N0fTwUmpxxxk9PltojR7
 hDq1esfdX0MJo+K/OBLlKVITiCvFMcP0emX+2hwXoWASS0QRANrB8VK/vj7iLIiINJVU
 6b0Q==
X-Gm-Message-State: AOAM533bSqc9WFBJ2nSBt0bPn8Nj0hWZCSizXdFSwcuyVOTdgFqZXSf4
 KgR8/b2A6CkifjkLYAxNPH6tsb3h8Oo=
X-Google-Smtp-Source: ABdhPJx/qdDyfl0+lQQUwLzN5w6wxCjypluc1EUjE5bzPAKRm5iqa3hhuOA3PFJVPL9V/LQdp19f4g==
X-Received: by 2002:a17:902:6bc8:: with SMTP id
 m8mr11814413plt.138.1591393727377; 
 Fri, 05 Jun 2020 14:48:47 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x2sm505802pff.103.2020.06.05.14.48.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 14:48:46 -0700 (PDT)
Subject: Re: [PULL 00/19] Linux user for 5.1 patches
To: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20200605114700.1052050-1-laurent@vivier.eu>
 <CAFEAcA9f3jLSnf=M_V4tuWjjY12QFqzp5_PvkdbG38AmEK6dAw@mail.gmail.com>
 <67f3b206-6bf1-65c3-1054-3aded4c69a23@vivier.eu>
 <CAFEAcA_TFYV=+f=NNib4dO2WTxaaN4wjwcdQPie2biAs2REk-g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0e188008-88dd-e6b3-a4b4-321bdbc39ba6@linaro.org>
Date: Fri, 5 Jun 2020 14:48:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_TFYV=+f=NNib4dO2WTxaaN4wjwcdQPie2biAs2REk-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 1:32 PM, Peter Maydell wrote:
> On Fri, 5 Jun 2020 at 20:20, Laurent Vivier <laurent@vivier.eu> wrote:
>> I was thinking this kind of problem would be detected by the travis-ci
>> builds, but in fact ppc64 and s390 builds don't build other architecture
>> linux-user targets.
> 
> That's an unfortunate gap in the CI -- we should ideally cover
> the whole tree with at least one big-endian platform.

Indeed.  Hopefully we can do this with our pending gitlab setup.

For travis, IIRC we only build this restricted set because we had problems with
timeouts on those machines.


r~


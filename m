Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D5DC2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05843217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MgplZrtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05843217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu643-0003np-Tx
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu63H-0003HR-Rp
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu63G-0001mR-5n
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:47:31 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:37564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu63F-0001m4-Uk
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:47:30 -0500
Received: by mail-pl1-x62a.google.com with SMTP id c23so2264544plz.4
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MliXOR5x4h1aRAplXfvSH1AtPLog78KEmRRoa2nUfiA=;
 b=MgplZrtPfKjQGZKmbTYXLZgkyiHpvX0FSMLLwUD/h8zA3iwfgc0mIlJnNMFNQiwhgD
 uHBUVykkwhGzQ2TBVTxkPbqWFEyFLIPyh+olHE36qHl1lUc+PvNZkmc5nQWOIx6E2cRA
 jZ2yoI5UHNwmAhVBG4Bgq3qRH/b2Gc5zEZ4NW553b6AzXRE0aHJrylYhVxcjBQmYkTXT
 Q2aMi6si9/DdGizK0ymg0bIHWhzG2KxKTEUFT5VuqoHUeAd+of6nBs4CpEtNyfDV8Zk9
 YeRTWgIscVFhIGBhrF/MaxX3N41om++lR4oyap0uRU7OcQBDo5doK7FmPxx1UzZd06/U
 RhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MliXOR5x4h1aRAplXfvSH1AtPLog78KEmRRoa2nUfiA=;
 b=PUnTnL5dfOgWsK1RdwLT866+tiVcu4KBMQohurNnO2MWJXeLnxdQ0Abwl5jBmi7lbm
 FYjPEsMN53VFcXlBU+PsutMfau0o5A9dVeLuvdRkuKYxb7D33UnGFpEbQbhgH2V4grSI
 3gcOK01y+zYerLTHXUH8int4r5oP5R3+SW8Qq5crccmeMrd2NiJmGPApWMazJvCGRHt+
 73Mm6AOASw4ho9YAI6PoiPC13Cl95COL3HbNTZ+MlL2/NHASeaJFVfKkvmaQubklrXmq
 PMB6RdWGDndiRZ3KPMextvWHy6XDmtwqo55F9AH4Ich6C3iJk25B9p8aK8GAChKYZMCe
 iVmg==
X-Gm-Message-State: APjAAAW5NrCwPAA7rP4xYbav0ePlCbj5kMmbERceCPe8y2kIsi9PcbSW
 22hMIO7RAWOIjQ5Eivwk+ATQ4Q==
X-Google-Smtp-Source: APXvYqwTus6oiPmJEQU+SK5eFdNucEadC2JgetCfQpotCIcXBlp+6ger31ZB3oJtzB8/wXQ6bYEyaQ==
X-Received: by 2002:a17:90b:30c8:: with SMTP id
 hi8mr395975pjb.73.1579661248641; 
 Tue, 21 Jan 2020 18:47:28 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id a10sm784031pjq.8.2020.01.21.18.47.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 18:47:27 -0800 (PST)
Subject: Re: [PULL 00/11] target/hppa patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20200122023256.27556-1-richard.henderson@linaro.org>
Message-ID: <b7c91905-f1bb-a3ea-e39c-08a27b2ff36e@linaro.org>
Date: Tue, 21 Jan 2020 16:47:24 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122023256.27556-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62a
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 4:32 PM, Richard Henderson wrote:
> The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd40:
> 
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-20200121' into staging (2020-01-21 15:29:25 +0000)
> 
> are available in the Git repository at:
> 
>   https://github.com/rth7680/qemu.git tags/pull-pa-20200121
> 
> for you to fetch changes up to a66cfb7306b7cf7a023e11536fdd942f3f9276b9:
> 
>   target/hppa: Allow, but diagnose, LDCW aligned only mod 4 (2020-01-21 15:51:54 -1000)
> 
> ----------------------------------------------------------------
> Improve LASI emulation
> Add Artist graphics
> Fix main memory allocation
> Improve LDCW emulation wrt real hw

Ho hum.  Cancel this.  It breaks the hppa boot-serial test.


r~


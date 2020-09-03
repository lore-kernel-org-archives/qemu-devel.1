Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC50C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 02:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FC220758
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 02:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ITeGvdXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FC220758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDekP-0008DL-6N
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 22:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDejo-0007oZ-6s
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 22:12:32 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:39643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDejl-0007RI-D5
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 22:12:31 -0400
Received: by mail-pg1-x52d.google.com with SMTP id v15so819824pgh.6
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 19:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9AxJW4VDtMNfYXk3SPFaN4TQjzI3mPNBIWg5NL5kjKQ=;
 b=ITeGvdXjqExKBdxMaQRdlN660tJAjmI9FWSyE2d+jMmLUedzZskiZRzvUVWTKH1npw
 HT+EwxuUUuF/YVhgtd4/ggGhGu0DMCLZ361tffQrvU4ADO3D1THZynqJVfBXRpBgaUZD
 rPX3qaaYNt0eIqOoGcbZv2faCRmp9pnmvK9CI5OD/B9TGKDkkMUNgyGFT78oivOzA8+3
 HHR6zQ3BpOCXc9VCbpxybg2b2IMQSxvRotRvvASwAjJyV0GeGJZ0toji1a104I7rhy5t
 Ai/o+20/tTcNeXgrUC9iHCXAGuiPs+sbvfJkH6GvcXhliD5ZUBUYClMctmDcgq0DWn5j
 wu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9AxJW4VDtMNfYXk3SPFaN4TQjzI3mPNBIWg5NL5kjKQ=;
 b=REIgtgjzO7TKLQN+EVjgru5RzE+iiEIW9LF82KwSfvTi++m+0VifxRgPmQfzO4Krhr
 iLWVUEk1/Th09kYqQa360gjHhs9xt2wpc6IPdG/L0s1txo/9XVEmCmr3pYHwB1+FsvtA
 wK5X5S4jOGrHHBgIr4XFN75VWpC2jyKzm5CHT1cy1vJjjeteBmlfXdCRXZ0ZnXoLxnqd
 dAm4gXsBacLQuUKiM0hyeF9bodz7Il3PiJ1/QRKnQ6/g/bdOx2ausgg2i8RIqy+ZGhGu
 5spaRNqXQztny0TYTJCF2rqjXNgn34IDE4dpPCEZCuX1yOse/bqnRLq27dq+9GL7dDa2
 13PQ==
X-Gm-Message-State: AOAM533p/RvmssbjychzmRPF8DqsjDTyGYwGtO98je+ntM4V+VlB0Oo+
 2kPv1I+g88RIpVi/9ggl/54shQ==
X-Google-Smtp-Source: ABdhPJw/FybIYSwYnyf9NEsijGclvM5JDc+iEWQS3JsL+d0mGBhqisI650tH3jiZ0pQCTYq0q5mnOQ==
X-Received: by 2002:a17:902:9f82:: with SMTP id
 g2mr1283651plq.254.1599099147721; 
 Wed, 02 Sep 2020 19:12:27 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id n67sm623257pgn.14.2020.09.02.19.12.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 19:12:26 -0700 (PDT)
Subject: Re: [PULL v2 00/76] target/microblaze improvements
From: Richard Henderson <richard.henderson@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200901152054.922595-1-richard.henderson@linaro.org>
 <3eb9a404-b856-6337-680c-462a765e2b42@redhat.com>
 <ca9d4e58-3545-ca8e-6862-26efe81a0cc7@linaro.org>
Message-ID: <36e36e04-cc04-163d-58ec-10314ed53999@linaro.org>
Date: Wed, 2 Sep 2020 19:12:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ca9d4e58-3545-ca8e-6862-26efe81a0cc7@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.324,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 4:11 PM, Richard Henderson wrote:
> On 9/2/20 12:09 PM, Thomas Huth wrote:
>> On 01/09/2020 17.20, Richard Henderson wrote:
>>> Version 2.  Serves me right for not testing 32-bit host
>>> when I knew there was a patch that mattered.
>>
>>  Hi Richard,
>>
>> I'm afraid, but I think this PR broke the
>> tests/acceptance/replay_kernel.py:ReplayKernel.test_microblaze_s3adsp1800 acceptance
>> test:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/716158589#L176
>>
>> Could you please have a look?
> 
> That's odd.
> 
> Doesn't replay rely on migration (or at least VMStateDescription) to do its
> job?  Microblaze doesn't implement that, so how could this have worked before?
> 
> I admit that I don't often run check-acceptance, because I rarely see a clean
> bill of health, even for stuff I'm not working on.
> 
> Looking into it...

Ah, in this case it's all about the icount setting.

So the log recorded by replay=record is indeed useless for input to
replay=replay, but not relevant.


r~


Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7B8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D73C6206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DaIS7kIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73C6206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1ZHP-0004ys-65
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 13:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1ZGh-0004Qp-ND
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:56:31 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:37192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1ZGf-0002ay-Dz
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:56:31 -0400
Received: by mail-pj1-x1034.google.com with SMTP id lx9so8212295pjb.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 10:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MI0Bdz/CXN3HQeCnNcDPC9blrrXV7ibmK7ZZMdb1z14=;
 b=DaIS7kIecGIj7J4wp6gpDBEbmHMcPzpf5YW3rnH2C48wPrk5uJHcWicZ+26d0TNhQx
 EqZ5tskdUGDege3+T1Umy8489xt/zuXLXUrq1pCXO67aD2aknUfJSlCFbbLAMoVAX4IL
 iD4bY7dexrRa16w5LHAV4OKE3sc9HCFP+oGjfe2WpmCFaFy+sdM5hB0NF8pXnX8QEkWc
 Fj5LTxIEC/ume3mLPE/mh8IM0Qfn3vHJG4MU1WHHE9rZya2r2KH+156V4THn62EoKWHa
 I0U6QJ+yRJVF1iCXrmX1ECplh1iZgGeZcl6IttS0eVbPkkKy58OZGr+xzGwmY4xdMFSf
 Csgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MI0Bdz/CXN3HQeCnNcDPC9blrrXV7ibmK7ZZMdb1z14=;
 b=jd2D5/5pAE11miwVT6yPqSN/Lu8FZLYGBvvvpsJJAbMEbtKMw1YnQ+DVZtxzF1tFtf
 J16kuWcqC9ql2VIx9arQqc1A0WLCkVoafPhb/oUJ+Hbej/wJmukixNMjXyntotqJ8HlJ
 43s/sZ0UBxarBj65N4b0Wn/obCEvZ8vJCyvgdNRtWyXJG7SGyMas09iSn/FoygcDAApF
 MBOffUlJ2NxxIJqmnzlE4KBJWwaUosl3AYT8KPGHXggCBb6IHze6LtMSCeO1ugeLHOwR
 6AG/Qq60iqqYxvXhK3vkwZDggY6Gl8sFafI7gzSsuFdYP20WrSIFJQd9vsSSu7MUlZvc
 0u8A==
X-Gm-Message-State: AOAM533ItZU2syjRbnUt1FeFHbRAYRlSweWcp0QoGniXA3W1CYixQU9B
 DCvJ+gIct7aSPRkXXLsRG70c9hju0Tw=
X-Google-Smtp-Source: ABdhPJw+Fz2uDkVPXUmqbZHD3OV0BUD/EWr5Xr4dT4zZinKVDzTW9Df2vQA8TLpZbTyAqr5gEgKHfg==
X-Received: by 2002:a17:90a:7c04:: with SMTP id
 v4mr5458406pjf.191.1596218187716; 
 Fri, 31 Jul 2020 10:56:27 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10646556pfc.202.2020.07.31.10.56.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 10:56:26 -0700 (PDT)
Subject: Re: Differing PAC behavior between Qemu and Arm FVP
To: Peter Maydell <peter.maydell@linaro.org>,
 Derrick McKee <derrick.mckee@gmail.com>
References: <CAJoBWHzJq-51dBxP8pniQPd7fy7J+jU2gHwZOkn-NRJzc5uNiQ@mail.gmail.com>
 <CAFEAcA9XmXhp+Crx09k++Ryd3jSL8U36FSMvw6X73sBFEmiofw@mail.gmail.com>
 <CAJoBWHypu+nJ4L3fE-tQzr_EWf294THGQkovTrn+j5iQ+b4MyA@mail.gmail.com>
 <CAFEAcA_H5V4EzaDy0C2j8VBYHtPu25vNj0SXuYLbypj6-m9M-Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <52ca846b-5b0f-6366-da1f-277d73b3374f@linaro.org>
Date: Fri, 31 Jul 2020 10:56:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_H5V4EzaDy0C2j8VBYHtPu25vNj0SXuYLbypj6-m9M-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/20 1:23 PM, Peter Maydell wrote:
> On Thu, 30 Jul 2020 at 21:06, Derrick McKee <derrick.mckee@gmail.com> wrote:
>>
>> Hi Peter,
>>
>> I just got a SIGILL trying to execute a stg instruction with the QEMU version later in this thread, but the same instruction works correctly on the FVP.  Are you sure that all the MTE functionality is present in the master head?
> 
> I would recommend that you cc qemu-devel and Richard on
> these emails...

Yes, I'm sure all of the MTE functionality is there.

You'll need to submit a bug report with more details than that.


r~


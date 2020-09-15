Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE48AC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387A123CD1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R23Jcsdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387A123CD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBx1-0002TA-86
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 10:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIBw1-0001cB-4b
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:27:53 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIBvz-0001kj-DQ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:27:52 -0400
Received: by mail-pl1-x641.google.com with SMTP id k13so1434761plk.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VNsd3psgt5eYap/Ic+GhNKyXytK0iv9IYIrAwwIz+lU=;
 b=R23JcsdhKpnau1EW6kjMbI1TYd8qVSHN7vo7QALMbilvSpHvaEKiGW1003zp1tBncV
 yRm1Kf9qbEis8mvZPIuz/1UtD8QtrGry5Ed37X3pR7rkH4NBbshRd8k0Kq3AIZvplYv+
 MuvOrkvFL5ZG1dtiT4mDnFk0MnRoMaefq83+6NTJdLc8Ku4UtjbJof4z6cgdamqtFwws
 D2WZo570hk8obJ6ZHUbcC8Izmtmz1sK2jX8T2LAMKeAr89i+4jrM8dT81116F1w2vl5k
 A/ApYyqIM7Ksj9JgcPVzJQcBemX3nrSIQcrgYDgb24Z4fApTE7TvXD4QBIghnb15Y4au
 etXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VNsd3psgt5eYap/Ic+GhNKyXytK0iv9IYIrAwwIz+lU=;
 b=hkqBnlBK37U/nMKufmMRck+++U4DSAdbdTw/7uAJlqpEE7FdBmNewnZ0XIaTz8GTVw
 rBZ+l1njhg2l/Wy/GYtz4tBI4lZXgYpeB+vhs3DW+x2VsPJUIall8aJFbPqoeDkhYErW
 HH6NAhku3me0j0Ht4FnD27DHEnJKaN3GtyBImoXybdEcHvyPnezKdm4PQaVKFJYaYDwl
 hxOd9ehLzZJwkhAWf/5z4zQubv/jXAzoB7Or63YLii8uVEiHefC9mGA6iicpfcfHJkm8
 bZ1MCjeHvhgJi/GzEKF/c/Mdv0Ep+njElE5pG/PAo6kRoK5IPM8UWGLu7AzWoRGqcX/d
 yfSg==
X-Gm-Message-State: AOAM531G1VT0fAX73WyoEZh2iJ9o02nSQlkR5OuGI476+SxvAhSyU3Pt
 B1BykfgvDGxSwYSUaGZp7GCBDg==
X-Google-Smtp-Source: ABdhPJximSD3BLq+fsmtKCrLAf3YRxhs93eIMrKymAzbJu47BLEDLUM/s8O5E3nlQTcIU/9ofxLNbQ==
X-Received: by 2002:a17:902:eb05:b029:d1:8c50:b1bc with SMTP id
 l5-20020a170902eb05b02900d18c50b1bcmr18972961plb.35.1600180068451; 
 Tue, 15 Sep 2020 07:27:48 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h12sm13796024pfo.68.2020.09.15.07.27.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 07:27:47 -0700 (PDT)
Subject: Re: [PATCH v2 01/10] capstone: Convert Makefile bits to meson bits
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
 <20200914230210.2185860-2-richard.henderson@linaro.org>
 <eced490f-0250-3516-5d75-c6c3ff6e97be@linaro.org>
 <CABgObfbWzf7DLgx23+yMqYqnMUaiJ=0WKaW4zvzkA4u5T9fQXQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4813770a-34a4-72ce-17f7-7ea451a7af99@linaro.org>
Date: Tue, 15 Sep 2020 07:27:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABgObfbWzf7DLgx23+yMqYqnMUaiJ=0WKaW4zvzkA4u5T9fQXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: thuth@redhat.com, luoyonggang@gmail.com,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 11:27 PM, Paolo Bonzini wrote:
> Looks good. Can you just add a "# Submodules" heading above the test?
> 
> I would also like to remove the "yes" value (that is, the default fails if the
> internal copy is not there) but it can be done later for all submodules.

Unless you simply plan to rename {no, yes} to {disabled, enabled}, as for the
Feature objects, why?

That seems to be the only sensible value for --enable-foo, without the =system
or =git specifiers.  We *should* fail if no system library nor internal copy is
present.


r~


Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326E4C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 00:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 614BA207EA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 00:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gSTxHZ8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614BA207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK9X2-0004YG-7D
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 20:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK9WA-00047D-CB
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 20:17:18 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK9W8-00047S-GA
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 20:17:18 -0400
Received: by mail-pg1-x542.google.com with SMTP id u13so7416111pgh.1
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 17:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=HmI/g+flIsgcW5Dc0JcldOlIZS1l55x9lSH86Kyh7aE=;
 b=gSTxHZ8l/IW5hCCj+u9y+HxPYqxBn09V5vkzVSQJVhvP5GOIN6N3Hid2/ql0O2/xnB
 6amkzYTdsGOGlfS20DJdrz3/PFtue5+CaX1TkYVTq8MnuvuyevE//RBc7jIPJyEelrSc
 Tfr3TPs2HoFE0ntXv1z8+EgZ6f+SLg+pNij7uzvFVB8kCLOO8raiGJHKOXHA6bcP8O/b
 Fw3jn98HHbng0kb8IwUBcRywQ3CJI1Iq4tusXc/wMVmaD8gfanaHedBfHEPjAGumlgx2
 NKFuORHYcAdepD+nda6a5DZDTiNpefw45oAjx/3P0y6fLYVMmLriKvuw2KlzArqcJAB0
 fFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HmI/g+flIsgcW5Dc0JcldOlIZS1l55x9lSH86Kyh7aE=;
 b=TKsQMirP4904PbKf3UpData4e5GFBap2L1PeEJU9EZlTzS5Ma2qPYJJx7wNQYnU1fd
 7nGTFeJN1WkxhLFxk2VH+cKs24AblNIncebuVx72KWgvXHPGf/ljSBTLDVZ+o12h4vpQ
 rbuEO1p8byl9WH6eL37dVh5ehHrL3OxbkCjOGksIEIPOfk/kvcZ+At/nbUpfvMd2Yq0M
 BoqoYTcE2gRdDlFHLWCs1Ol1u0dPqW9kknmMLl5IUo0MEozhnlO+A5sn8NGq5LAxhIqD
 1/reo9NmGpOfKVKzT7J+NozliAep0r7IIt4KrKf8fhRsP74dDrVNKJwGWmnvQ7OEkBzU
 olTg==
X-Gm-Message-State: AOAM533hC2lSjFhBCWfu3tg7Wqq3PLflW3LuMVHga+jHPGSrQ0c3aqul
 2iHIrDOR0y9FBpfKokuUdennEsE4cOWmeQ==
X-Google-Smtp-Source: ABdhPJz0pnzk6reD7/xo8V8T0HvQnTsXZZaUdpHVEzTdtp8goPmc0uFPP/JcM+Z17oz++kCxMya5cQ==
X-Received: by 2002:a17:902:c692:b029:d0:90a3:24f4 with SMTP id
 r18-20020a170902c692b02900d090a324f4mr41683491plx.12.1600647434268; 
 Sun, 20 Sep 2020 17:17:14 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a3sm10014000pfl.213.2020.09.20.17.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 17:17:13 -0700 (PDT)
Subject: Re: [PATCH 4/9] configure: move accelerator logic to meson
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200920130708.1156310-1-pbonzini@redhat.com>
 <20200920130708.1156310-5-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b3aa323a-2a32-8ff3-9d8f-6575e623866c@linaro.org>
Date: Sun, 20 Sep 2020 17:17:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200920130708.1156310-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/20 6:07 AM, Paolo Bonzini wrote:
> Move to meson the code to detect the presence of accelerators, and
> to define accelerator-specific config-target.h symbols.
> 
> The logic for now is duplicated in configure because it is still
> in use to build the list of targets (which is in turn used to
> create the config-target.mak files).  The next patches remove it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



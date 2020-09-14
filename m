Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDF3C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 23:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DFA20897
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 23:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZv9ptkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DFA20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHxck-000379-W4
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 19:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHxYK-0006Iu-44
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 19:06:28 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:39633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHxYI-00072b-Jb
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 19:06:27 -0400
Received: by mail-pf1-x430.google.com with SMTP id n14so797318pff.6
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OriDBIGkROMsURVmetfKb6fkuOKnfVmdSbXOrcL+9Ws=;
 b=NZv9ptkTu8dzx+JrJ9bal5ek9MNeNXuPbHOVEGJqvcPu+paef5lor2+ObSHL6eF5kE
 gZrmbIndMjk41/mnCoCF2LYcU/cCkFoSBQVIMtnH4Zxc3wEiYc3BzeT18DULjWqKXH6U
 1tMYXTqn+QG+WQrr8pQvxb5TNNxjM9FzakKPMVDLU1Aa8Nl+hXqIq8pYggqz+vf9tc8g
 p991AmHkgCkS0l4N6iu76lhhP5Sqm1a6Di1LaA4LBdw9i9ZdQPjBIY+taFqwXYKsnpqF
 jDILl1mD6R6tu7T5DEU0Y55ZowoAiEubW1AiKQumGjEHzZVS7FHoF30CNmMs4rbFaKsb
 hJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OriDBIGkROMsURVmetfKb6fkuOKnfVmdSbXOrcL+9Ws=;
 b=GoVmqxYXTf9sJeb7UP8mrWmLyZCpep7rxSGvlRVuOw/sg8DkH5Z5QflaDg0ZUopx+T
 0eF82c33+crHs9JkFNPQcBW2yI8gZX0XAE66dYcS4vX8A4kHrVgWzV82TKnCHOhUHfX6
 OV3xJtK4+HEy7yTH888r3kBRc7QTf7L5ezQ0LbQNGBM2E+vr9ba+S5C91UQVFyTezgQd
 eNyX4Djsrq7r68wl9xPGUIsT0oJ224BZyLR0RTd+UV81rhEZ0kkrAg7vLPUco+b7y/Hm
 17wJ13T4n4cIH86BIMIhNJiAx70+VUCGLgE4w8wCfvtLkygNLaFy/SbB+sXSE25DmpXz
 AVZA==
X-Gm-Message-State: AOAM53009sz1ojh0AVPZYF04cqIc3cazyOgosYafk3TZ7iNMVnChkO3a
 CeNXXsNdEi4IkzDLUtzJG9/IEw==
X-Google-Smtp-Source: ABdhPJykumqc5g5R5PfKQioXqckqTgheDiIfHt1cl3kQlK441rohumRksgUfa6cCJ2bt+HsVmp+Bvw==
X-Received: by 2002:a63:ca0c:: with SMTP id n12mr12540682pgi.209.1600124783342; 
 Mon, 14 Sep 2020 16:06:23 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k62sm4401671pge.36.2020.09.14.16.06.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 16:06:22 -0700 (PDT)
Subject: Re: [PATCH v2 01/10] capstone: Convert Makefile bits to meson bits
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
 <20200914230210.2185860-2-richard.henderson@linaro.org>
Message-ID: <eced490f-0250-3516-5d75-c6c3ff6e97be@linaro.org>
Date: Mon, 14 Sep 2020 16:06:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914230210.2185860-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, luoyonggang@gmail.com,
 alex.bennee@linaro.org, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 4:02 PM, Richard Henderson wrote:
> +option('capstone', type: 'combo', value: 'no',
> +       choices: ['no', 'yes', 'auto', 'system', 'internal'],
> +       description: 'Whether and how to find the capstone library')

Dangit, meant to change value: back to 'auto'.


r~


Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC376C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591D621556
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKIYrmur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591D621556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2js-0007sM-98
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka2iB-0006QM-Db
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:15:24 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka2i7-0004IL-VL
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:15:23 -0500
Received: by mail-pl1-x642.google.com with SMTP id j5so9103088plk.7
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 12:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/H3P24xTLvUSobqQcbkvu8fPIHywjAl5a+Jyiu45cJs=;
 b=UKIYrmurCbz7Vr2HUA00wOtVkCiZ4IYlOuPttc1dKD+3R5nqjtPfQowt4WkrSjxaJ7
 PqKEWEb5fo6s4li3wvJU5KisOfZJOzPE1orj3htfQ1NQvN33Jyippv/xX53vJV24SaKn
 s3DBcj9y2waM3TOXM2rYSYYRbe/RS7taQJpGHJgdRZUS+AY2i+nZWLr6Jor7E4LfJZrW
 DJXBviQbsft7Abs8IDz9gu4dxRpsn1LobMAZ+ES3JmRoqTJmzclIlEppU+5KBGJXPzWB
 8TsetU0Ahd42LdnWhDMfA8bXetcCCJbdAgMnBQZRxkruOlABU0+epzbZ7HinOIqBLlbt
 Io8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/H3P24xTLvUSobqQcbkvu8fPIHywjAl5a+Jyiu45cJs=;
 b=qhMEyLi7xAMbRbAX2ZOlHjB/4VTVx4UChX1VtvlSymBTwRQ/lKp946b+pBv4Zm5h3m
 sIQEhkjzw1itGjWNKQk3umPrAVQqwlvml9iaSEU/5TXyBU93CH+uo4TrD/0VE1V0Sjhj
 ipe4ye2INLC9S+cYM180LcwfS7xLY5BWM/p/pxsgVnHYnYZ/tJYncE/QZBTZcerRfMU4
 VSd7Wt8jwwovWoxch2gnG3BoZG0TX/poK+X7ZPJKRNYCyWIRJ5AItoua65zTdipp1L85
 W+Qkx/mYcsrxW23hrlZaDvozpg6m7wpIfXhZ9WphpYZsbbj6ZO+7Q7pST6PPhOllu5ZI
 eheQ==
X-Gm-Message-State: AOAM531G+oBtvhSSoqa22qIRoISEKCZxO29pMo2f0TF0eBwKsTsEFqLo
 bFFt7FCruv6HiX8vv53qGtEh4ROXB6ANzw==
X-Google-Smtp-Source: ABdhPJyqjB9HeE5WlHzVZe3JiS7xfsx1H/1Qi+JblHnqgeWtP/Zx20mN2PB+QvVyVj9UqSqssFX/RQ==
X-Received: by 2002:a17:902:c084:b029:d6:b04a:b091 with SMTP id
 j4-20020a170902c084b02900d6b04ab091mr17883194pld.14.1604434517277; 
 Tue, 03 Nov 2020 12:15:17 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id l7sm172310pjg.29.2020.11.03.12.15.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 12:15:16 -0800 (PST)
Subject: Re: [PATCH 14/14] target/arm: enable Secure EL2 in max CPU
To: remi.denis.courmont@huawei.com, qemu-arm@nongnu.org
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-14-remi.denis.courmont@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f70812bc-fe9b-fed9-d91d-bf359d35fcf5@linaro.org>
Date: Tue, 3 Nov 2020 12:15:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102105802.39332-14-remi.denis.courmont@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 2:58 AM, remi.denis.courmont@huawei.com wrote:
> From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  target/arm/cpu64.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



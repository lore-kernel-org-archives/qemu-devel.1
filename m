Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EC1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7234D2088E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kC497/6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7234D2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jay5x-0003Pq-IY
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 04:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jay2E-0001H8-N4
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:55:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:47103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jay2E-0004ux-0L
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:55:38 -0400
Received: by mail-wr1-x443.google.com with SMTP id w7so14879002wre.13
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 01:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=LOLhdqHnrhlX0x0yM5DlGf91l4Nee9fWxxcpIIJ1uGE=;
 b=kC497/6ubqXrOl5HQoONl/55XT/MtWhytwmUlMT2tXk6dF11b9OTxDrOPzOXLC7g0F
 bn1+mQPtDq7nQnz5uE+GYJzF36P/ljSVT/eBHhZFDEXs8SsJSwxSQRh/kFpuQPyHqnaG
 R/32Ep2KHoiLV4SrRfIcu+DwgI2zz4JSOhA+nK4kTwQqh7cbH/os1pcv727Kbz4C6Iz2
 zKNKxsekMNdkoPpwOS41xfYFtchhFX8zMqxk9jxncQGuYN5hJae7mxYsstiMP1Kg3Ybp
 Z6ZpVOVld0wbuSm+82sjMdSVuvG1dQtoI1UNvbcMDTfqsfjP01G6xG/k6cx+m5jiIpkY
 u0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=LOLhdqHnrhlX0x0yM5DlGf91l4Nee9fWxxcpIIJ1uGE=;
 b=J+AvAx4WjGRZyVOYO0bL9ROC9sUSiPWsJSs6yhU6PMjIoxh1JyEyGXo1Se2Qk2S1/v
 Bckt0R6eCWVndhb0uSj6y76TGsuA2KRoBTINV/YkGUsL+oEySmkwbMCHnqoBJn1NswtM
 FUnw7T03JHT+QxJ4FeryvFgI9LZ8n+OaT8cNlKs7s9/VpqWhdUua8EBOMmXyNFQTn1Pk
 caMuAJlf52PdNrBXpGfhhVct9ag3fuH0p1lvPbVaNfa4TwX6LZEKYN6wJbMo7y59N4Mx
 YGq8ntXmTFbkMy4XOxA7aJHs6nf1NSJTZuZYByMOJdXtyub0o4r3/aAwmOaTw8B7W+Mq
 wRDA==
X-Gm-Message-State: AOAM530CRPLRFZw24B7tuICPG8WcTdztN9Zm9bMlqh8OXPSM6KOivMTx
 J0eAXgHNDKCYxpDRBTzMKNA86A==
X-Google-Smtp-Source: ABdhPJz4pLNjPdaA92ZJJV8o9mU/Ju3mytWei7eNHkc8EtE++oVJkyu5HTgmtFfrgT40t+TiSIZhSQ==
X-Received: by 2002:a05:6000:10c3:: with SMTP id
 b3mr25134561wrx.53.1589878536460; 
 Tue, 19 May 2020 01:55:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 5sm3085155wmd.19.2020.05.19.01.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 01:55:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A11BD1FF7E;
 Tue, 19 May 2020 09:55:34 +0100 (BST)
References: <20200515190153.6017-1-richard.henderson@linaro.org>
 <20200515190153.6017-4-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 03/10] softfloat: Change tininess_before_rounding to bool
In-reply-to: <20200515190153.6017-4-richard.henderson@linaro.org>
Date: Tue, 19 May 2020 09:55:34 +0100
Message-ID: <874kscjoc9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Slightly tidies the usage within softfloat.c and the
> representation in float_status.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e


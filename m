Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5008CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC9020671
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M//U9dV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC9020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfxSF-00088e-C4
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 23:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxRX-0007cX-PC
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:18:23 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:40781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxRW-0006te-FT
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:18:23 -0400
Received: by mail-pf1-x429.google.com with SMTP id v2so4390054pfv.7
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 20:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OkFIi5Mxf3fvPsHj+oX7KiNnRIh3rdVzURh4uHgDtIY=;
 b=M//U9dV1UjwjmeNNOods+7qc5yBfWVVW6bBZXVhq0Kobt83OuicJO4gCwgjjJWgkJD
 e0SUe3iPCahcHuKTnOVsSO3kPJxYw9a2S1LvvQ5hAmgFKFf+kjOvQfwOfRp2JeWE3yeI
 KNF0FGwnIcat1L20aKdEwD9IIjpJMqUMOWufMRZAdA5hWA1GyBEFVh86ERcMGa0yC5km
 NSfp4jMGmP+7FKgXRmhcBNCWM89a6PHgsR7uxfkJ3B6jRPAhAlTYl0DoHQfqXHV9GaBd
 OkHxa2pUMW8mljYyFBLJ3bGNeg4+UXu5wh4AOwDklzYeAHJa7YN3AwKh0NshrygfWYAE
 PtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OkFIi5Mxf3fvPsHj+oX7KiNnRIh3rdVzURh4uHgDtIY=;
 b=Oemomky8aVDEtCoRGzaxGTUaosMwCW/4t4HfcVXgl7R49H1BIMc81iRCS8ldWk9z4L
 d+Sz7y5B0YMuHRTiXUj7vSjcPbyXbQpxKjxNHYCFfMbYPGNzdgpj/LvJYVBHI/sMSsWm
 laQ0e+VhfI4WHmvqAmgubr+uDb9SVRDluMrdSkpvNh6x1orus7vRgbjmmZQe7Z6zNfN9
 y6IaoFbhanWbE4PDiscodEPRegaxvACGgx1gXn27BzxupPmUllAnuahW1OgzK/U+bXnB
 Uo6wDbW/6hU+wjC2FU350v4fSGBfrLzz71JFCSPW672UkHvaLQBcP8zqK+NLALGqVdxL
 zKXQ==
X-Gm-Message-State: AOAM532V70seJO2OuVbeJhPRy0Xb5k1QzHMpKtAloOSStMKhz0MMG91G
 yykkpDLwUB8MT6/obQ19Mo6GCw==
X-Google-Smtp-Source: ABdhPJwNGG9GWJajoXpr3g6vvaivD/1cTPCj7p9XmmjiW6KU7Do9GR3B4HKwd3VTxsbJtG+W28/q8w==
X-Received: by 2002:a62:8c42:: with SMTP id m63mr23039485pfd.106.1591067901032; 
 Mon, 01 Jun 2020 20:18:21 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id e124sm709630pfh.140.2020.06.01.20.18.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 20:18:20 -0700 (PDT)
Subject: Re: [RFC v2 09/18] target/i386: sev: Unify SEVState and SevGuestState
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, frankja@linux.ibm.com, dgilbert@redhat.com,
 pair@us.ibm.com
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-10-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fc66c595-9a10-65f0-37c0-83ff1d5e42ed@linaro.org>
Date: Mon, 1 Jun 2020 20:18:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521034304.340040-10-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 8:42 PM, David Gibson wrote:
> SEVState is contained with SevGuestState.  We've now fixed redundancies
> and name conflicts, so there's no real point to the nested structure.  Just
> move all the fields of SEVState into SevGuestState.
> 
> This eliminates the SEVState structure, which as a bonus removes the
> confusion with the SevState enum.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/i386/sev.c | 79 ++++++++++++++++++++---------------------------
>  1 file changed, 34 insertions(+), 45 deletions(-)

Yay!

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



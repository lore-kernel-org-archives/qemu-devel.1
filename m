Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B19C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA6920671
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WpBSX7ii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA6920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfxJ9-0002EC-0F
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 23:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxIV-0001hM-Bh
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:09:03 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37668)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxIU-0003vS-5K
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:09:03 -0400
Received: by mail-pg1-x543.google.com with SMTP id d10so4426266pgn.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 20:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qZbs1BllaBBL3bnoChDxm8kx95yZyhFFyPL2Vif8b0A=;
 b=WpBSX7iigtBq+c+VsExmv+11JGFPrheA5EKc79brBG6tYeBX/lsoA0Dw1Kko7JF/CF
 pHgy3Q4cOt7HjjNzRiRbE6OO69TBVEExgij7c36X1vaGHQSuwzCxrFSvEY6FhgwisZSs
 WGUU+r9zKsQqU0XPWB+4mwupu418w4HH+hdI2UzOBML4Za6UMFG7L0/GdK/Bo3bQnrbI
 Z1hnl2ZXFbE5PSFGopAVI8DW0wl3po21aAPbb36kHIRyBZfhKhiD6LhS/FKOLiZfQV0K
 vzRC6uAomZ5+cJ9A8h+nM+McUa9vaAYLaTSvnrOQAyJHAWVJvKWgXU4RS8dy0KM/IpEg
 cX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qZbs1BllaBBL3bnoChDxm8kx95yZyhFFyPL2Vif8b0A=;
 b=e67p1qp0RpkoTI1Z6is4Uaq5rjmFJnDyRidmyKKuZWZ1tCXP+2DDsn1+IPNuAPID31
 mVky9o8VRufRwkkMP2jntYDahGlrxZJEKjJKBpV0r4cLHZw+pv0GmJXIS2OFB3t44UOR
 yAK4MaRlze23oUQ4IwqULCF3/tY7x76nbwVx2KU7/jFpZZgLQctnhijcXpqOyhl9i4WG
 Wwy6gf4xxWndJpVlNGtCgHNqn561k1CA95f4uCxViz2n2whLpDTWJWzVkbHFs+MTLTRI
 r0ZUQ8A4ejz6EWXxEYnW/FkKWFWmEAX/Dfyh6S7zuX30KfgQVamE3sk7I1NNi59QBPCY
 uCXQ==
X-Gm-Message-State: AOAM531YuJjwGvHhsWu/NQqxkN6ZQbrYTBiiZZzwFASplmKB01+mH4rZ
 5CXqoNc8+d+9Ku9HI25RbGuR/Q==
X-Google-Smtp-Source: ABdhPJxlkrrVC6n3zDSCXrEolx9lNwAGETXn7CgxWXKz9aWnRwIODQbdZ0GEyorNT0PUHtLswOHj2A==
X-Received: by 2002:aa7:9ae3:: with SMTP id y3mr8777804pfp.224.1591067340702; 
 Mon, 01 Jun 2020 20:09:00 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id m2sm724135pjf.34.2020.06.01.20.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 20:09:00 -0700 (PDT)
Subject: Re: [RFC v2 05/18] target/i386: sev: Partial cleanup to sev_state
 global
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, frankja@linux.ibm.com, dgilbert@redhat.com,
 pair@us.ibm.com
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-6-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5fb496aa-0b67-d287-c39f-cd5d2380986d@linaro.org>
Date: Mon, 1 Jun 2020 20:08:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521034304.340040-6-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
> The SEV code uses a pretty ugly global to access its internal state.  Now
> that SEVState is embedded in SevGuestState, we can avoid accessing it via
> the global in some cases.  In the remaining cases use a new global
> referencing the containing SevGuestState which will simplify some future
> transformations.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/i386/sev.c | 92 ++++++++++++++++++++++++-----------------------
>  1 file changed, 48 insertions(+), 44 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



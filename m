Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BE1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 01:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44E820734
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 01:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cdn1gJTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44E820734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfw06-0003sV-Su
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 21:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfvz6-0003De-Tf
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 21:44:56 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:37864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfvz5-0004D9-TT
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 21:44:56 -0400
Received: by mail-pl1-x62f.google.com with SMTP id y18so685857plr.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 18:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=R+wtA4TQuVAjoHFrtNuxPYnux9aq5YlheMtq49QWXJk=;
 b=Cdn1gJTGL+eXIasgRJVSvqJ5yFZoFpO2kXnl4VB6YbHhYkp3IUjxQ3IoP7FBG/kI86
 e3nfyNDkU3oiuTnarD26uFWmCIh6mF9s9nPytXygGtx47ovpH7sK+2zH3EPZbc4wmPgW
 ePOSo7GSG3rmnRvMzlU1PHvw86n0mX2gkmtkjFhfOH9WAYaQaZrleNKHy4GLZSTfwyFi
 YPNU/2KQ7pI8YpO5GvDoN18cVyTmvB7n2ICL2cp/+R7IlZZBsB6UadkUD9BIys7zS8MT
 GLUQv/62s5bZ/E7xWApYO4WO6ZiMLV/Y+Soh5bxliSTe8IdRKeB+XOpSUuenhk39u4hB
 wsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R+wtA4TQuVAjoHFrtNuxPYnux9aq5YlheMtq49QWXJk=;
 b=driUeRSvFDjorWWo0UxgjvjbQoVw1r1yWND57uXbtOBN3C83NduMBS3hn5l6ikvvC2
 FMvXJQrPbaKa+cnCyOleCYiJ42HRrSgbjgBnml830vSkOebx/OHgf9659tGKd8MV2ghk
 LELPep4mzlZTX8y4MGyAVRFtnu9r00WzxKOAxhJVIQdF8cbi86QCJXBCpW3J3d2uQGp+
 8KMZQdX5cV/uWY3epl6+rxjyB3b6Rvgi63XmEUAfSXcb/c3R0LwiBypKujoANWTkCN+S
 Zm0byTLx1X5IiUkPOaHUc0IfUwCoL6WcanuxibQCSN+qynjYJ//DEZgS5ip0/be6Crh4
 vXAA==
X-Gm-Message-State: AOAM5318yYEmOiyzVn3aPlBE1pz2H9im7tY9vjD8YeC604tlz2cIet9K
 iD5Vgwrf+zP1/gaJQgKR/RCjCw==
X-Google-Smtp-Source: ABdhPJyztznJyQgnMCh6JQJ0vNQfmraNrTA5vuQLGtKFVRHbXlnB2v8XoRNaGDGK/bycvkMFWglT9A==
X-Received: by 2002:a17:90b:400e:: with SMTP id
 ie14mr2480443pjb.44.1591062293638; 
 Mon, 01 Jun 2020 18:44:53 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b1sm634868pjc.33.2020.06.01.18.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 18:44:52 -0700 (PDT)
Subject: Re: [RFC v2 10/18] guest memory protection: Add guest memory
 protection interface
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, frankja@linux.ibm.com, dgilbert@redhat.com,
 pair@us.ibm.com
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-11-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <75221e39-837e-7cd0-6ed8-42610b539370@linaro.org>
Date: Mon, 1 Jun 2020 18:44:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521034304.340040-11-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
> @@ -0,0 +1,29 @@
> +#/*

Two extraneous # at the beginning of the new files.


r~


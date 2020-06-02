Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EB8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63184206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pBbKG4Ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63184206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfxmP-0004iR-Hc
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 23:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxll-0004Gx-O9
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:39:17 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:34948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxlk-0003TF-NT
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:39:17 -0400
Received: by mail-pg1-x52e.google.com with SMTP id o6so4460395pgh.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 20:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=25Z4PyvxNXVbTrzp+EyuP3SY+XgzmEQiG1XewmY0Vt0=;
 b=pBbKG4Ned4JGzOS+DVQGLSL5lT8WKb7rLDhvz96CmaBMlRH8kG9MwhSAltMvaTbzVv
 HRUvhXQIqj+AVwyFdX9vq4SezeXTe9RMKkboET2Z8WK44NtEH77TAm19VoMoSpVEgU1Y
 O0RKujZ0XLjJ24xI7+2lD1qpgJLARLqWwCC4SREMvITR9Veyfc0M3/itGIeTZB2kpI4M
 S1tnXfDZ90AqasEYOoFY4UOU+OmfnnUmoya1yVkJlmHt8HFOSGFGB/sfeHULcsWnguQj
 U6ADDxePnL5/aUp2CZzleT0Px+Q6rlb6VVBMbFqzGiW1rXoJ3g3LqQRGU7g+ZqyS1SZ5
 Va1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=25Z4PyvxNXVbTrzp+EyuP3SY+XgzmEQiG1XewmY0Vt0=;
 b=ZwA4djinYBE5v4XCl07Ja+GPgY18Hz1nRceIFStz114yCITMRGMTFyBBBLaJKp24j6
 ZrfGn1LK9M03efyDpv4j6wawK6JcfyB/vz6ZeZybyvABfwEZN/D1RZs6NQHezFbOzpLz
 5aJ+Hb+lwvd15RBRudHTu5RC24+U8eDYm8gxrPPWNO1ed8p+vh00sYkK1uJBsfr5OA0M
 XpOYWoobi9zLsxO4Gs8b3+CFpR0WUnihHl7tKxwqYR6mbtbJ0RNCSINHaRzqx469JGre
 +PzmBs8lvKmJjNaTQO3R3lwYsFCTez1D9rbwvlAILTEnmzJpYZt28AXK4vDu58ihl4Pd
 qmtQ==
X-Gm-Message-State: AOAM530hsggkkiEdwTwkucKzYqjpUY2/VBbUaXK0wcQHd9DjZBzvEQ9E
 8zfaiVl9SWCFP8zLF37V+DLzHQ==
X-Google-Smtp-Source: ABdhPJxRVnXSi5kwrj1LQ9UbzAVSlZeTuh/DCMjegFU5ZiSSCvExjTP2GfAuGamVgwL1M5vVHOj3/A==
X-Received: by 2002:a63:f959:: with SMTP id q25mr21567037pgk.137.1591069154965; 
 Mon, 01 Jun 2020 20:39:14 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x9sm731014pfi.13.2020.06.01.20.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 20:39:13 -0700 (PDT)
Subject: Re: [RFC v2 12/18] guest memory protection: Perform KVM init via
 interface
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, frankja@linux.ibm.com, dgilbert@redhat.com,
 pair@us.ibm.com
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-13-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e0b5be25-db1f-ab7d-681b-bd8afdecf4e2@linaro.org>
Date: Mon, 1 Jun 2020 20:39:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521034304.340040-13-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
> +        if (object_dynamic_cast(obj, TYPE_GUEST_MEMORY_PROTECTION)) {
> +            GuestMemoryProtection *gmpo = GUEST_MEMORY_PROTECTION(obj);

This duplicates the interface check.  You should use

  gmpo = (GuestMemoryProtection *)
    object_dynamic_cast(obj, TYPE_GUEST_MEMORY_PROTECTION);
  if (gmpo) {

AFICT.


r~


Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7270AC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:46:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34185206BE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LCKl2S96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34185206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDc1T-0004jF-3G
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 18:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDbjo-0005kE-Ku
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDbjm-0003MP-JX
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:28:04 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41279)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDbjm-0003IF-Bg
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:28:02 -0400
Received: by mail-pf1-x441.google.com with SMTP id z65so8803333pfz.8
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 15:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oK7xBCa7g5QgCCO0gLA8ro7mMuioiTQFpgi5b4B4gig=;
 b=LCKl2S96mflLKjPK1nmHt93NNMoV83Ta7cf1YrLMbU1Twqlgl4dQ4NV6xdCsSyl19+
 n7f48Bxou+zPei1No0sHAusCuYKnwJoF4gzBG0IMcb3D0zcLwFlIgGWvvm5ANQURM/qs
 IDsqaPwUTqX5kyRf+UJEemLq/EOh+URSdkdGTXseJWF2e7I86RCquDhR6CWLwwsgLTNJ
 XPH5uGdiAX1KRlBhr8AbmT11xhgjBS2eVjduK3xPrqqhnbbpsz5iAUoksBBWYAvh1+J7
 eKVTUO5BQeJgqPvR8B7FIjBXwLXqSg0KIJLGhzCc9kfHf2/aWbi8y5SLnzQX/no21UhH
 9f8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oK7xBCa7g5QgCCO0gLA8ro7mMuioiTQFpgi5b4B4gig=;
 b=ihNgStjFEc1kLZkfSI2qpB4E64RtgnQlhiZ4Dh1/BacqmGAsTM8wNGnhWoK/FWorGU
 Pj2pQIdc0PrCQlLxIiZBPF/0FFCJlhT41PNSrwjeowgB5kef9ctfwro6/C2nNrBFa00c
 opJjdpSP3r27LzDpG7SwzL6YpqTYxC5rTslv8iAMflX5h1k5TwSNshctkgODXez/Ley+
 rfhRl9kpEVKnsnJ24YhVqVunllJ8W3Eq+i+dJ1RwVwOsM0bQL+FwtYkeOkQWE0cXEASJ
 t70ie2RJ71yxM2KjgpOKwYXyORovl3Bs5MtLes+RcKCS5XwKGy5xFrQqeWSSi1VmzQ37
 FIrg==
X-Gm-Message-State: ANhLgQ0sa1PRF2zhD2y6hHblQb0Vf897O6xOROgaf7WdfxAskozs3Xct
 QXRIdg4J4IDZtYojRPSEv/1JNA==
X-Google-Smtp-Source: ADFU+vtWkSIdXHR9JhKqNYFmKqWq9ZIQfiyUT6Ox3sAqza4lG1GaGp7kfczC0oVWdaMgFPWWHYoejg==
X-Received: by 2002:a63:7508:: with SMTP id q8mr21476024pgc.300.1584311281219; 
 Sun, 15 Mar 2020 15:28:01 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 d22sm18170120pja.14.2020.03.15.15.28.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 15:28:00 -0700 (PDT)
Subject: Re: [PATCH 6/9] hw/core/qdev-properties: Export some integer-related
 functions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200313184607.11792-1-philmd@redhat.com>
 <20200313184607.11792-7-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <27638a3d-3441-8bb8-a6ee-92a19056ea24@linaro.org>
Date: Sun, 15 Mar 2020 15:27:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313184607.11792-7-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 11:46 AM, Philippe Mathieu-Daudé wrote:
> We are going to split this file and reuse these static functions.
> Declare them in the local "qdev-prop-internal.h" header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/core/qdev-prop-internal.h |  9 ++++++++
>  hw/core/qdev-properties.c    | 42 +++++++++++++++++++-----------------
>  2 files changed, 31 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


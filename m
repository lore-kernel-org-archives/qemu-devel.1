Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCF4C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 18:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68823217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 18:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwdC1fpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68823217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvnJF-0003Su-Pd
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 14:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44644)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvnHi-00023r-Pd
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 14:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvnHh-0004Cw-Mr
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 14:37:10 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvnHh-0004CL-GD
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 14:37:09 -0400
Received: by mail-pf1-x441.google.com with SMTP id p184so44571226pfp.7
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZwUGXhmWxNFcvkP+kWRtHSH+LXZ3dIUFppAlpP+dEec=;
 b=DwdC1fpC96Yg4sKyHmcG9W2BW3CaSDDybX7wcT8J9zsA799JHMI8lpbg4uJuRWxNA8
 OVLvdrpNAbVNJ488YJi+OsmcCcmkVWauKr4kTkDglP2F9WvldTEO40cUVg2Vu8WpSJtq
 6u4ynLwd8WU1SUb8ZvIFvcpb4mrzvpzuGCB761fzx7jNxBDJatSfJghll28UOxALdyrh
 j9w/JOgmfyVBx9vrhDbYoxR/O6WIPNfJ20nZoNQ99STbL7WFgpW6cz9BYfFjIM+svAKU
 sBYw2Uehe4FfSK7jWinfuF4ASv/GgDXNQ8/I8cgLy8RoG/mvxIjlmqRs5xX73xJUAYE3
 O+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZwUGXhmWxNFcvkP+kWRtHSH+LXZ3dIUFppAlpP+dEec=;
 b=i98CmF2V7MWigAchPjp+1pWjZUrXzPggmai+yVmiW7ERD5VJzEq6CeVWOmpF68I5uJ
 gRfBt6EzIKLOu0gYPpCHjUYdUfKWfZJc/mA6pNm/IqCpsmZWiM4/mwzextQma3xI262l
 btF7qE9FrrOwC1gn7XFEwFAFzK9I0OSy7RwcKfimPusqgSoN1zNyAbtF5p1KMF+SA7LA
 fzE8fq7nIDbUXKQ7se1/Rd1inu7i2I1iJeVsr5cgMvSFcwio2+T2GSGILPm8gLd9DvuG
 Ijm1/VHOPBQvZ+/JVhXb3hw+EcPojpw8ir4yBU1dqonGbeHYRNVgBWRAdzjulkpj5Su/
 wLbQ==
X-Gm-Message-State: APjAAAWHVEnKmjW9qSyEAteAMyJ98nBsBpWswUG09sfWNGxFNXWS5i0J
 VMq+T+/MWATYniSH5aSe0rl5IQ==
X-Google-Smtp-Source: APXvYqwpvntLVOS1gTrdgS482RvhtN63R9d9cKLXg85KUQSnQUSCfVPbCWSt5o2X/xu+BjrZaHpj0Q==
X-Received: by 2002:a62:2ad3:: with SMTP id
 q202mr17330549pfq.161.1565289428518; 
 Thu, 08 Aug 2019 11:37:08 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id m16sm97173069pfd.127.2019.08.08.11.37.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 11:37:07 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>
References: <20190802122540.26385-1-drjones@redhat.com>
 <20190802122540.26385-4-drjones@redhat.com>
 <d0983bd5-c1a5-adf6-324d-2b199ca0e23c@linaro.org>
 <ec44ddad-c33c-918b-e94b-a534a2519a9e@linaro.org>
 <20190806122144.bb3klk7aaaqdhgwi@kamzik.brq.redhat.com>
 <39a4d205-d291-8962-2693-6bbcce89c332@linaro.org>
 <20190808085012.23aokly34zo4wxbk@kamzik.brq.redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <bb477706-e09a-c992-38f0-d3f8725bb4c5@linaro.org>
Date: Thu, 8 Aug 2019 11:37:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808085012.23aokly34zo4wxbk@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3 03/15] target/arm/monitor: Introduce
 qmp_query_cpu_model_expansion
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/8/19 1:50 AM, Andrew Jones wrote:
> I'm not sure. Of course I'd need to experiment with it to be sure, but
> I'm reluctant to go through that exercise, because I believe that a
> deferred validation will result in less specific errors messages. For
> example, how would the validator know in which order the sve<N> properties
> were provided? Which is necessary to complain that one length is not
> allowed when another has already been disabled, or vice versa.

My point is that we would not *need* to know in which order the properties are
provided, and do not care.  Indeed, removing this ordering malarkey is a
feature not a bug.

The error message would simply state, e.g., that sve256 may not be disabled
while sve512 is enabled.  The error message does not need to reference the
order in which they appeared.

> Also with deferred validation I think I'd need more vq states, at least
> for when KVM is enabled. For example, if 384-bit vector lengths are not
> supported on the KVM host, but the user does sve384=on, and all we do
> is record that, then we've lost the KVM unsupported information and won't
> find out until we attempt to enable it later at kvm vcpu init time. We'd
> need a kvm-unsupported-user-enabled state to track that, which also means
> we're not blindly recording user input in cpu_arm_set_sve_vq() anymore,
> but are instead applying logic to decide which state we transition to.

Or perhaps, less vq states.  You do not need to compute kvm states early.  You
can wait to collect those until validation time and keep them in their own
local bitmap.

bool validate_sve_properties(...)
{
    // Populate uninitialized bits in sve_vq_map from sve_max_vq.
    // Populate uninitialized bits in sve_vq_map from on bits in sve_vq_map.
    // All remaining uninitialized bits are set to off.
    // Reset sve_max_vq to the maximum bit set in sve_vq_map, plus 1.
    // Diagnose off bits in sve_vq_map from on bits in sve_vq_map.

    if (kvm_enabled()) {
        DECLARE_BITMAP(test, ARM_MAX_VQ);
        kvm_arm_sve_get_vls(CPU(cpu), test);
        if (!bitmap_equal(test, s->sve_vq_map, s->sve_max_vq))  {
            bitmap_xor(test, test, s->sve_vq_map, s->sve_max_vq);
            // Diagnose the differences in TEST:
            // test[i] & s->sve_vq_map[i] -> i is unsupported by kvm
            // test[i] & !s->sve_vq_map[i] -> i is required by kvm
        }
    }
}

If you prefer not to experiment with this, then I will.


r~


Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C185C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 21:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168E720656
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 21:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMUPlLic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168E720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv6Tn-0001OS-Cn
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 17:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv6Sv-0000xO-P7
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 17:58:25 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv6Sr-0008I1-VR
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 17:58:25 -0400
Received: by mail-pg1-x541.google.com with SMTP id e8so6648012pgc.5
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 14:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ecJ2PD0sI5G7QUUH1Q9l3wOICmPtbiE1cArCriZj56o=;
 b=tMUPlLic1HBYADFoc9t+Ib69r4GcrZCE1pJVQMeR0yHnWWLC74vWuL2iEbz225UyRw
 JrLWC2B6urhQsMDMwwyGripOTW2RwBXWIIxnspEsoVpVOsuQNjWd+xATAMcBYmKqCdhx
 2AFaMYSUli+NN/3svl2lVS2f5gabAYO72HIiMqoIDC6LI571P2FzxlLHJOm0Q4cR00Ju
 dc08d8IA7Xnj4CrPNhy87PSNo9hvea5SGsgPUlcJC/WeRSwvnqeUqwrQJk8kRc7eM9TO
 WdQRrRzzpcGIoDeSA+6N2z3gouC7a5qJcVJcHQVGFVSjT8FgLMmtjyH29RhS6h0Yatxr
 5QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ecJ2PD0sI5G7QUUH1Q9l3wOICmPtbiE1cArCriZj56o=;
 b=COn5y6pgU4ss44pRXJcnZPmXpjsZAUkgwb79jBtBAywtgs4Qb1PmDYMLPMJX0MYso/
 pVXHSiEdBGUbAFln/Sf5LT5yiAOF6l71eeXZIb2MVlGAu/Qt+Zq3LPKiDdjn/sJbWKOZ
 U2IBGgh6sHSnhrIOK6IZsPyTTmHY/B7D1AwsDpLkaDr1ujiWU3FzsU6h+WUU+As2kHnz
 fOdfeFSVODAsTcgNQw/z3wwUL6DEqg51ylZwPahr8IjftjI45XvbyxqZ0/oAQgdYw6Is
 9WjgYE1+qEZ7Ja1v157KUh3wd0mFTeY+WSxTlPmefwheQ7JlDwRYNgwkewd3k92lICzP
 y7nw==
X-Gm-Message-State: AOAM5334XZsjbFWqbMU5E5eKl9GXIFAJ4UJRIe2cMSH/niz9VQjrE7kp
 af5bAS4P4Mp+KZ6L6CJtYGF1gw==
X-Google-Smtp-Source: ABdhPJxdYW5KfKntSYXjRMvv3rM5bSTdiWofRc9ZI/Bln6qDkshFXQssI+yCwiHeIaVnYLucc9JEJQ==
X-Received: by 2002:a62:794e:: with SMTP id u75mr1674918pfc.298.1594677500427; 
 Mon, 13 Jul 2020 14:58:20 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i125sm13872885pgd.21.2020.07.13.14.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 14:58:19 -0700 (PDT)
Subject: Re: [PATCH v2 06/11] cputlb: ensure we save the IOTLB data in case of
 reset
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200713200415.26214-1-alex.bennee@linaro.org>
 <20200713200415.26214-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a56f924b-7d2b-f962-4219-33a1a3964bcb@linaro.org>
Date: Mon, 13 Jul 2020 14:58:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713200415.26214-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, f4bug@amsat.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 1:04 PM, Alex Bennée wrote:
> Any write to a device might cause a re-arrangement of memory
> triggering a TLB flush and potential re-size of the TLB invalidating
> previous entries. This would cause users of qemu_plugin_get_hwaddr()
> to see the warning:
> 
>   invalid use of qemu_plugin_get_hwaddr
> 
> because of the failed tlb_lookup which should always succeed. To
> prevent this we save the IOTLB data in case it is later needed by a
> plugin doing a lookup.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


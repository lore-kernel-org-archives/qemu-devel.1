Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31952C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 01:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DED95207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 01:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fi+detnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED95207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlMuC-0002ny-39
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 21:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlMtN-00022i-N9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 21:29:29 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38602)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlMtM-0002Ec-1S
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 21:29:29 -0400
Received: by mail-pg1-x542.google.com with SMTP id l24so460241pgb.5
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 18:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=2eY4fvguLBXT7jfPbPFCGo+bTpu8wNIpzfFJrw+pOE8=;
 b=fi+detnTXJRPxQHyQClNPkgoyyaUm8bo3qmpHXqIVfmrgdhlG43H7PYljXbw0R1JNZ
 w369+1UCVec8YYFXulUikr3ft6TUHCYUk+xztlj08o6Qc9dN7+1ZwNj6vrSmtLLUCv3d
 ok7BRD9zYt2UaRRk5y1x25RLHJf74SOdEoWYpcq7362bx7dz/OJMsJapEJg+CkzSbz+u
 QhepOZnCOaYF0apjZkbohlKux6cSYC1n9mC2vtFUKqxzh4wZHWMtBCcXf8cqNrROtEd7
 eOulLzl4TXE1pt7LKMSc7SWXDnhDzvEC7MO9lbwQqeHW0xemN9XJ6aKiiovW23A7jEGw
 72Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2eY4fvguLBXT7jfPbPFCGo+bTpu8wNIpzfFJrw+pOE8=;
 b=Q0TLTJFn/QfqINCRcjvcbuSxLTCt76w6Uvo5crYpouWFcYXIiIxuHZHpLz259BDden
 8uvyJEJmkTJx6ka6iUh38tRTlCHJTiPjnI/2QhyCIoot/C5qQA2t74ytTEzOb+HYMEDm
 nt8KX4tC990ASWCCkR1ZoBB3wwt4m9Fj2ZpGL7RRrHKT25RvxRnRdtO0kKxIwzKQD1pY
 QYGxjaqzba3ahMAPr/F8VP6DfZrFop+GPP0GRDTbm2o1M+pEvFdTKNccusoQKlQqBt6i
 J/P0U3mkk0yg8KoQBxFnPTPZ2Zmq3SVS/bwhNjgkISB77rvwC18c62SN0jGaZBxIh4Qc
 Lz8Q==
X-Gm-Message-State: AOAM532ruQ5Kp2nnsJ9JWU60/4c7cqHQCY4RicI8B5lONev334oOhXoU
 KPeXFamGbfqLcwQGF9HUMEULS7j0hAg=
X-Google-Smtp-Source: ABdhPJyEXYwKzfb7P5hFHitAZLGapYg39c8R1+S13GtTIe83gfvU3eJO1nwxGOvye6e9N8cNCVkirQ==
X-Received: by 2002:a63:4cc:: with SMTP id 195mr4290504pge.294.1592357365802; 
 Tue, 16 Jun 2020 18:29:25 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y5sm15259087pgl.85.2020.06.16.18.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 18:29:25 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] configure: Clean up warning flag lists
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200610203942.887374-1-richard.henderson@linaro.org>
 <20200610203942.887374-4-richard.henderson@linaro.org>
 <61557057-f4be-9a74-1422-3dee74be7f03@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <40e3fce3-ce85-402d-bb0b-b4b00feabd5f@linaro.org>
Date: Tue, 16 Jun 2020 18:29:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <61557057-f4be-9a74-1422-3dee74be7f03@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 7:25 AM, Eric Blake wrote:
>> +add_to warn_flags -Wold-style-declaration
> 
> Hmm - should we add:
> warn_flags= nowarn_flags=
> prior to this line, to ensure that something inherited from the environment
> doesn't mess us up.
> 
>> +add_to warn_flags -Wold-style-definition
>> +add_to warn_flags -Wtype-limits
>> +add_to warn_flags -Wformat-security
>> +add_to warn_flags -Wformat-y2k
>> +add_to warn_flags -Winit-self
>> +add_to warn_flags -Wignored-qualifiers
>> +add_to warn_flags -Wempty-body
>> +add_to warn_flags -Wnested-externs
>> +add_to warn_flags -Wendif-labels
>> +add_to warn_flags -Wno-initializer-overrides
> 
> wrong list

Thanks, fixed both.


r~


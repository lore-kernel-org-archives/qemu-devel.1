Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E188C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 068A9218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXBsY8yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068A9218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPGv-0005yO-12
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXP5D-0006tR-6L
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:32:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXP57-0000On-Dd
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603805526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TK8hPM7Ysvvb8/8WqhaE5vPte48P0JgSHSUZle0XYDo=;
 b=EXBsY8yqgj1Qz7Rxuy6BUC5/P5RXU7IURPyYLbwsXEOqSvy7rl9abm+f2QXBFyO6h59ZRs
 Op75FSedQsRmaNpZp2jsUBO0qZG8TgSh1xvem8MyAP5cxpF0HCoSqGx81J4zWXYMuO65mT
 pxH7OabZ++6eVXmtZOtx4A5yShRJtL8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-UPG_lO7WNtmNdLiMkn7Bew-1; Tue, 27 Oct 2020 09:32:04 -0400
X-MC-Unique: UPG_lO7WNtmNdLiMkn7Bew-1
Received: by mail-wr1-f71.google.com with SMTP id t11so755272wrv.10
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TK8hPM7Ysvvb8/8WqhaE5vPte48P0JgSHSUZle0XYDo=;
 b=GfBi6OR7h+njwebxcf9RFLCtT/ptwsY0AC2rMDgqUY6DlFDe4NQCwaA1QyILjvs6qI
 oItgJPtRvB3nuJdwdFb/I46cVqUM9PSWzL0Zat7jV7EEGKc7O+z+fhikVywDYt54Dqbs
 h4fGv4ktDAno3BAgrM+wfYpTZHoA8DLBFF0qTXH2bL9CwYg/XnIjVsKDIMNS6g20uhjK
 J3rlYdUZD+h/EvmSPGhICcLGfhjGm8ttZsquQB2NktkykRI4kLlzAIoyBs8q2Dqpkutw
 OX9u+dBG76IsRu7aSHHZz8Jg0N07/czG/RI5fzZdtpygaMAse/gytmBZsk/R4VPG1u+9
 ZdLQ==
X-Gm-Message-State: AOAM533RDspl6UJfKnwB72JUeFYAqVJdV51dX7YAfgSU7JPj1pVjt8NV
 Pt+8LJt7Wf8zxa4EptHy1Va/jsklyu4gIC0xwaD/InGj3LMrur2s7a6a2tHkzSDQoEj/U2O1eBn
 etIceSEUSR9dyjWk=
X-Received: by 2002:a5d:4282:: with SMTP id k2mr2844756wrq.270.1603805523522; 
 Tue, 27 Oct 2020 06:32:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3OcMI/Dys9klddA8DDl9dIFLbyXDGTqCdrw0fKamw/UOdRW7ZvI62Y4lxSv9JuKWO5IBt7w==
X-Received: by 2002:a5d:4282:: with SMTP id k2mr2844742wrq.270.1603805523337; 
 Tue, 27 Oct 2020 06:32:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id a15sm2224058wrp.90.2020.10.27.06.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 06:32:02 -0700 (PDT)
Subject: Re: [PATCH 01/22] semihosting: fix order of initialization functions
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201021205716.2359430-1-pbonzini@redhat.com>
 <20201021205716.2359430-2-pbonzini@redhat.com> <87sg9zex2k.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <78f5ab2b-bd6d-631e-4d19-be499a3b08a6@redhat.com>
Date: Tue, 27 Oct 2020 14:32:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87sg9zex2k.fsf@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, berrange@redhat.com, jsnow@redhat.com,
 ehabkost@redhat.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/10/20 12:18, Alex Bennée wrote:
>>  
>> -    /* now chardevs have been created we may have semihosting to connect */
>> -    qemu_semihosting_connect_chardevs();
>> -
> Move both here:
> 
>     if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
>         exit(1);
> 
>     /* now chardevs have been created we may have semihosting to connect */
>     qemu_semihosting_connect_chardevs();
>     qemu_semihosting_console_init();
> 
> 

Sounds good, thanks!

Paolo



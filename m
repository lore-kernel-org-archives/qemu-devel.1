Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556DAC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79F2A247A4
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gB1ZpsYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F2A247A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmjk-0006t7-4m
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXmhl-0005nf-P0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXmhk-0001w0-4q
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603896335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/TvaCAukIhhXBpxsC8/36FcaQb+DcsxzU6a+suiGdw=;
 b=gB1ZpsYkOLoXxUWWIfIbcKlIzU8Nva1mXA3aXDkvf4qmfTRDjsg5XwRCjHaTqlAUIJurfj
 YN1apHbnCRPUK2mqTLQ3Fw15wP2MrEyD0Zl9VDsgU256Df4TY1qrQwEsVztYanIISbmFOe
 xFUI1QPJ1mLxZtwuYUgH70eDm0YQD/I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-fJXwr3arO12uRNWlGYfT9g-1; Wed, 28 Oct 2020 10:45:31 -0400
X-MC-Unique: fJXwr3arO12uRNWlGYfT9g-1
Received: by mail-wm1-f70.google.com with SMTP id s12so1703138wmj.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 07:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g/TvaCAukIhhXBpxsC8/36FcaQb+DcsxzU6a+suiGdw=;
 b=E0GWrB14dgqS241q5OQtYwpYqVJ9S25Z7eXHZgeREwLVDiRBiVMDfWu2Zj7hNIb2Mr
 PU0d/j8XOVNz6PNQP/0FasgRUYVIQrtu9w0s2fLM7iM7jMSjNGOqUOBLB0nzv2VhmPy4
 /7JffEDTZyUNSN+oMg74VvbW7u1o7Pn1aPRCwVVT8SV8rE+hIjPswknEgHw8oqJaRXZz
 65FBVmOwyRijFeNCEb7NdFFY7UTK0KMABOXaDK8I1dvmJj2BY/580wE7LDNa5Ax2JreS
 S1ZnOgS+knFakYp9C+bybFjM48wJir5s2RYqE8cfqNqQS+MYEzkjkb1eFBJW9kD+8Mpg
 kW4Q==
X-Gm-Message-State: AOAM532BSVdJSQTS3ScJCeRwUPp4ogpEmzQhHV1pomqutQrm1Rgpy0Bj
 YElcGcjZxSuRVrsToTbR2TEf6r8KlMWie9gXbOdNhnqga3ZpRiEQFJrRHorLNwHmT3go+s2vGTc
 KXiQnarBUf3kh4EI=
X-Received: by 2002:a5d:434f:: with SMTP id u15mr4226552wrr.8.1603896329731;
 Wed, 28 Oct 2020 07:45:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgYaKMs20z+DAtTifnnx1KTfQ9ukP2N17ZL90jlTLHubJDHB873oyZoh/FEd5t5qfxXGsnAQ==
X-Received: by 2002:a5d:434f:: with SMTP id u15mr4226523wrr.8.1603896329542;
 Wed, 28 Oct 2020 07:45:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id g83sm6595434wmf.15.2020.10.28.07.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 07:45:28 -0700 (PDT)
Subject: Re: [PATCH] WHPX: support for the kernel-irqchip on/off
To: Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <SN4PR2101MB0880B13258DA9251F8459F4DC0170@SN4PR2101MB0880.namprd21.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <167595b8-bf4a-b961-cfaa-593a3f8d1940@redhat.com>
Date: Wed, 28 Oct 2020 15:45:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB0880B13258DA9251F8459F4DC0170@SN4PR2101MB0880.namprd21.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/10/20 03:23, Sunil Muthuswamy wrote:
> This patch adds support the kernel-irqchip option for
> WHPX with on or off value. 'split' value is not supported
> for the option. The option only works for the latest version
> of Windows (ones that are coming out on Insiders). The
> change maintains backward compatibility on older version of
> Windows where this option is not supported.

Sorry, this has missed the 5.2 soft freeze.  Can you please resend it in
about a month?

Thanks,

Paolo



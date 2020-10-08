Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A98C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 052DA2184D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWEApSc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052DA2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQQaz-0005Xf-JE
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQQZu-0004s9-Gq
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQQZs-0008IW-N9
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602142983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jGaD8/OLFXROoNlp5eVFGbgA0uj7BxmrwWbwuWI3E+s=;
 b=HWEApSc7k0AVwkxo2g2IOPiejSxZDaJQ/frNqQvgpv4J8rtWyEi86a2uFuwpiEznX3rfwG
 EjOXDtBbmRrT/QboFeKaztequXFRdgQG57jjK5eztVK8jlIrWhU/DeZ62tkNzz0LTOHyV/
 XNGNELqz/eyUXgN8uSO4wOL3WTWuLiE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-6MJ3pJR7Nee_0UkI5RIBFg-1; Thu, 08 Oct 2020 03:43:02 -0400
X-MC-Unique: 6MJ3pJR7Nee_0UkI5RIBFg-1
Received: by mail-wr1-f72.google.com with SMTP id p6so3062735wrm.23
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 00:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jGaD8/OLFXROoNlp5eVFGbgA0uj7BxmrwWbwuWI3E+s=;
 b=MzcrOqirt5M4nD4whWBpHcwcsS+Z5YOa+9LcBOnKqME61ZBWVL2gZTJEqSCm11z7NY
 tBAGZJtkkyCgyU98GWGnlMbAIimXPph8eRD4EcV+zyAAiICZLIRxmfyWxFPUdfg8fPWs
 z2jHN+cc0wnYNA0NA+0QCL5SWW+rUd0Rkc7Vq09XgWmxRnDXP+1Rr3VGvD9XF+m6GYMl
 TrK7FOctk30RBJgPsS3oQrbEnaeYS548oqaQ9+uA17ODquSuelElfTXablPLMIkSJAGj
 MmACcbwTV/HNySp4EeZBQMHyzONTKkLggVcga/CV2Iw2p7J10sns7oiPSj4NinmIQLEh
 PtZw==
X-Gm-Message-State: AOAM532SlkjZnfYxfAqHdXyzsnTzjfBA47xDtnmtBTKoRs0dXKJqHzWp
 X4gnqLwySWX9/2r8qRxWsLVtIfFnPbPeZZEm75LHaPQsGZ1VJmhIZtECY/oqXfRj1/eNVxQu51p
 RjP0si1cGClx+9W8=
X-Received: by 2002:adf:f34a:: with SMTP id e10mr7618030wrp.91.1602142981132; 
 Thu, 08 Oct 2020 00:43:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8B8ksgWlbubeYCyO6ikTX3KR0EDUW6gUnGGJTKs1ZIqvR8n+TBezZ6Ug08BEQ5HZyMMGArQ==
X-Received: by 2002:adf:f34a:: with SMTP id e10mr7618009wrp.91.1602142980887; 
 Thu, 08 Oct 2020 00:43:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bb8c:429c:6de1:f4ec?
 ([2001:b07:6468:f312:bb8c:429c:6de1:f4ec])
 by smtp.gmail.com with ESMTPSA id v9sm6538649wrv.35.2020.10.08.00.43.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 00:43:00 -0700 (PDT)
Subject: Re: [PATCH v3 14/16] scripts/oss-fuzz: Add script to reorder a
 general-fuzzer trace
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-15-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fa3e116c-c8b3-daf8-0b4d-3df6c38f4a6e@redhat.com>
Date: Thu, 8 Oct 2020 09:42:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921022506.873303-15-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, philmd@redhat.com,
 Thomas Huth <thuth@redhat.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/09/20 04:25, Alexander Bulekov wrote:
> +
> +Note: this won't work for traces where the device tries to read from the same
> +DMA region twice in between MMIO/PIO commands. E.g:
> +    [R +0.028434] outl 0xc000 0xbeef
> +    [DMA][R +0.034639] write 0xbeef 0x2 0xAAAA
> +    [DMA][R +0.034639] write 0xbeef 0x2 0xBBBB

Can you detect this and print an error?

Paolo



Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06493C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBC620795
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYspTIAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBC620795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGIdG-0004qz-F1
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 05:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGIcB-0003vs-IP
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:11:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32150
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGIc8-0003hk-13
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599729091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2S+dASRYX7B6gIlF4p7C2wh2Lfe0xE+w23SHE4uKPDk=;
 b=JYspTIAeteO+FjsuFlL0zZ4Qt0CGoyUJEmqudPO15paI6gAUXSivbYPMNO2feuSYyiQ76t
 SoODbJXzkKrGcYkr6A7PhsrgymrLmpyPch7MrPf2LbHvndt8ND89G8Jf64WfWbAavMn63I
 K5n3qZXsdOZD0+N0KE3z+PEVFFx9E0E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-12bRT4LBM3-WiZcOzsyVAg-1; Thu, 10 Sep 2020 05:11:26 -0400
X-MC-Unique: 12bRT4LBM3-WiZcOzsyVAg-1
Received: by mail-ej1-f69.google.com with SMTP id w27so2450321ejb.12
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 02:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2S+dASRYX7B6gIlF4p7C2wh2Lfe0xE+w23SHE4uKPDk=;
 b=p/H1x/G72Hn9Ob+J4ET1RsTcxf9HZ6pR1iWMlLIgMr5f/hSK3eKee6jQdbf5tfnGQl
 DC3tMX08Nh4iabOOs4xirNa/0AY2RG5rI5z9KGnluc/Hw0gWLumc0DOD8ZKyO0E0k9iK
 rVIRswL+elykzjpCCc9cllhFReyI+Z4+o2fqGwyfchryzc7GpK9RRSnuuZ05wg4BoMGt
 R9SaIRNEIIwBmP6Lg2IpU4tIkId/vEARsaPC0vaVzxJaVoivH5fY5duh+J1bxKZEJe1I
 EKsA+Ci8PhrQhNGkdjyDYOq04YSY/S5uuTlHb5QPmZ8StxxpY8eh+bbSJys3wRPGtC/9
 twPg==
X-Gm-Message-State: AOAM533EL/XJd4VYGuatvhzq1s3ysq9uJ+CZ6CPUd394+R5hCxmXdzV0
 5e/LwkJAYnHwdWlqemmJgAsbvPjK82WteYP7gOilo9d44nUDq2giz0g7GpAGvbOqEpzq4K66VGU
 6d+/3iylyIuB6tN4=
X-Received: by 2002:a17:906:1542:: with SMTP id
 c2mr8069348ejd.533.1599729085467; 
 Thu, 10 Sep 2020 02:11:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDlmTUr6fJdtjDWNBypBMs7J2QrRY7INrpq4ulD5kRBc5YH6RHCcQDfHDuKW2yVlaRaNE9kA==
X-Received: by 2002:a17:906:1542:: with SMTP id
 c2mr8069317ejd.533.1599729085289; 
 Thu, 10 Sep 2020 02:11:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2744:1c91:fa55:fa01?
 ([2001:b07:6468:f312:2744:1c91:fa55:fa01])
 by smtp.gmail.com with ESMTPSA id br7sm6403283ejb.76.2020.09.10.02.11.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 02:11:24 -0700 (PDT)
Subject: Re: [PATCH 5/6] hw/pci-host/q35: Rename PCI 'black hole as '(memory)
 hole'
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, qemu-devel@nongnu.org
References: <20200910070131.435543-1-philmd@redhat.com>
 <20200910070131.435543-6-philmd@redhat.com>
 <7dbdef90-1ca6-bf27-7084-af0c716d01d9@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d04610d8-2ba3-4f36-2820-56044324a73d@redhat.com>
Date: Thu, 10 Sep 2020 11:11:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7dbdef90-1ca6-bf27-7084-af0c716d01d9@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:23:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Joel Stanley <joel@jms.id.au>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/20 09:15, Thomas Huth wrote:
> On 10/09/2020 09.01, Philippe Mathieu-Daudé wrote:
>> In order to use inclusive terminology, rename "blackhole"
>> as "(memory)hole".
> A black hole is a well-known astronomical term, which is simply named
> that way since it absorbes all light. I doubt that anybody could get
> upset by this term?
> 

Agreed.  This is a memory region that absorbs all writes and always
reads as zero, the astronomical reference is obvious.

Paolo



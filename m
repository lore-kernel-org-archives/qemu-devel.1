Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EEFC4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD7F20674
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SwTqw7mz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD7F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNEQ9-0003iy-Ju
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 08:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNEP4-00037O-2o
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNEP1-0003jc-2Z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:06:41 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601381195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u3f9gvMHKwa0NkJ8QgNZafyQKhYLamz/uoAPjoJ9hRE=;
 b=SwTqw7mz2Sxa8XIZD3uKH7wm12wpKd/Apbbyi9OPPeZ1KEU/cydAVyWxAPs2fcgHq/VmiU
 5RYabx7Y7y3YS513gsMW/TA5aotarWzmuvbVk1bVnJk/8LHCjImsYbnJ6OvGQmO99fkmZj
 ZUFL0cgH+ZizjhKlmW65X9q0zLf1YeQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530--KlnXaqJOTOOTXPbZD2bQQ-1; Tue, 29 Sep 2020 08:06:33 -0400
X-MC-Unique: -KlnXaqJOTOOTXPbZD2bQQ-1
Received: by mail-wr1-f71.google.com with SMTP id b7so1673973wrn.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 05:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=u3f9gvMHKwa0NkJ8QgNZafyQKhYLamz/uoAPjoJ9hRE=;
 b=nproLJAMJ5nssuiin2JYYaWWXLu3VvGXXmoVwweRKYvgIwkg6zKmWAYBYF0VlwToNO
 qcxw/aGgOlK0wg9Pk2fmNJ4cd61FYsZoPFNbcqTmCsGyKZx7hnLVt2xUhVC7xL9VKNxH
 RLm7kigNaBrM7GB6qqYUa0qsIBIIgj+ffsX82yqF/lXXbe1I6hQvrwh3Za4P60Kgdh1o
 NJAeuxVAq2AiPJBTioS++Q7R1wWI5IV1tQnZJowG8wST9B9tDs5gz7tX6X7fSnnNvbiF
 u2/si6DLfV84CAJT+yYJ2ZZ4Tbt4LVAEzcrgAmUjZXaEYt51v7XCIY1LUEsKi5gO9/7O
 ZDiA==
X-Gm-Message-State: AOAM531qXYGobSofSvUQxLOzBQdAAp31w2VB+nWBTzlLgPdnMxjFdd8Z
 XumC1f/hNrn3YnhVevU29MOEl7fmVvvSdgDy3X73aXyE6wAHp4PjFcy2MTKbeV4AhObIVgg41CU
 TZXkzSR3G90Jj91M=
X-Received: by 2002:a05:600c:2252:: with SMTP id
 a18mr4512719wmm.154.1601381191866; 
 Tue, 29 Sep 2020 05:06:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFvMNYmaEwZn078JjKb/FCEmQRJLfxqhQox0jPgYm6s0TqVC/LgmBQTLWgG8ycxsfJf27lbg==
X-Received: by 2002:a05:600c:2252:: with SMTP id
 a18mr4512700wmm.154.1601381191677; 
 Tue, 29 Sep 2020 05:06:31 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id x2sm5741674wrl.13.2020.09.29.05.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 05:06:31 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] target/i386: support KVM_FEATURE_ASYNC_PF_INT
In-Reply-To: <eff476d4-d991-8532-723a-d6c5199b8f74@redhat.com>
References: <20200908141206.357450-1-vkuznets@redhat.com>
 <f0c66049-57c0-4955-bac8-f7f090f7e12e@redhat.com>
 <eff476d4-d991-8532-723a-d6c5199b8f74@redhat.com>
Date: Tue, 29 Sep 2020 14:06:30 +0200
Message-ID: <87d024bxdl.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 12/09/20 08:02, Paolo Bonzini wrote:
>> @@ -4209,6 +4209,7 @@ static PropValue kvm_default_props[] = {
>>      { "kvmclock", "on" },
>>      { "kvm-nopiodelay", "on" },
>>      { "kvm-asyncpf", "on" },
>> +    { "kvm-asyncpf-int", "on" },
>>      { "kvm-steal-time", "on" },
>>      { "kvm-pv-eoi", "on" },
>
> This would warn on old kernels.  I removed it.
>

With Eduardo's comment updated (thanks) it's clear it should not be
there. Thanks!

-- 
Vitaly



Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C25C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134BD206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djb6jAP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134BD206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxz9-0007QU-06
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZxR5-0007lx-S4
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:37:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZxR3-0007PO-Va
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6nvCdA0ADTZNgkZ4YQafyTlrB7F+Il7qGwPiV4M5tIU=;
 b=djb6jAP7DJkQFMJJT89N3CdLtos13BC5873ZL48yqROAilxHYJRsSOmHnnHonzoswYga9S
 1U7FZO2VQiaoXLT91tyKXfi/f4AgHMzg6i5pHH6kS6eXvjivfI1DVsLSlOvfLXtdYMxKy2
 DTgyfC9RtBzz3RBT0MOaYg53B4OZFX0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-RIRecGbAOMOMn1NNmozVGw-1; Tue, 03 Nov 2020 09:37:16 -0500
X-MC-Unique: RIRecGbAOMOMn1NNmozVGw-1
Received: by mail-ej1-f71.google.com with SMTP id p18so5490919ejl.14
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6nvCdA0ADTZNgkZ4YQafyTlrB7F+Il7qGwPiV4M5tIU=;
 b=VI+HNY61eb9JaQc56g8WhPjJxgvIXauL6ucMtohDwHFBqUkqDfQqLyH6ogNNLT1jxY
 kgJ1TxdirV+O3hjWjzZIEhw5rxRwm6TRPU1KL4pKH9ITfklhM0MtaUj68MQGzsrWvMkD
 s56uSVR1N19MmhiKqVG/JUAPpKVue5E6zK6CW7GJqixnNaAj+/cEzrsqhHJwt9hmXmFk
 Awo8H5OebirHdHLFQjVhRZP0nZ79YhWn8MHUktbMHmFSEJpu4qfvLpZYzNJ3PIuEecHh
 VvR3PNIMCWJFHHntsP9CCXis1PGozYcZVZf0eYrdPpvYU8tNhF/IRw24sCSwQlld1mZc
 wOXg==
X-Gm-Message-State: AOAM530oGvI7OIPtwKuDvhk7rx9qv8R4fEpUcm2Y+TEYlAu0dvtvg0qU
 eX9EUpN7+Z+Qmtod+NclIBR68k9+kl2AWL5rmoSr9/HUTrmDgm+C7xj9Jsv4Y1XDuzn0wleKUpM
 HcGIWnYJQf5g3pDM=
X-Received: by 2002:a17:906:404f:: with SMTP id
 y15mr1903894ejj.60.1604414234913; 
 Tue, 03 Nov 2020 06:37:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLwb/VJ+mnJuVEtJJT0JDzK1vDahUqTSxVeYxNciTmmVRoBYoimoqfOCG1htgCQd0Rr6w9Zw==
X-Received: by 2002:a17:906:404f:: with SMTP id
 y15mr1903880ejj.60.1604414234742; 
 Tue, 03 Nov 2020 06:37:14 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id o16sm7698086ejm.73.2020.11.03.06.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 06:37:14 -0800 (PST)
To: Igor Mammedov <imammedo@redhat.com>
References: <20201027182144.3315885-1-pbonzini@redhat.com>
 <20201102165756.69540720@redhat.com>
 <6c08fbaa-57aa-b2da-c90a-6b53f628806a@redhat.com>
 <20201103135735.029c9b6d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 00/37] cleanup qemu_init and make sense of command
 line processing
Message-ID: <13f14d6c-e52a-390c-7940-9df2e220113e@redhat.com>
Date: Tue, 3 Nov 2020 15:37:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103135735.029c9b6d@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/11/20 13:57, Igor Mammedov wrote:
>> It's based on 20201026143028.3034018-1-pbonzini@redhat.com (which you
>> should be able to get through patchew).
> Not sure what you mean and how to do that.
> Is it possible to share v2 as a git tree somewhere?

I pushed it to for-6.0 on my gitlab repo.  There's a lot more stuff in
the branch, but these patches are at the top.

Paolo



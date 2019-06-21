Return-Path: <SRS0=QkNH=UV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41D6C43613
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 00:00:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9323220821
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 00:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9323220821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38472 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heTS0-0005nD-RL
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 20:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42880)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1heTRC-0005M6-2C
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 19:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1heTRB-000676-6i
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 19:59:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46322)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1heTRA-00065v-WE
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 19:59:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so8022117wrw.13
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 16:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ti8uChpvZxZ8gGxCDrOIOLG2OsOih9j9fBssRuuWX+o=;
 b=iHF9ljY8muJBKUcCVHDzwoh7samiUq8baruQadIE3ibgAZWV6zQny7nNG2mlIjUA2B
 vwty7x5uRH3JhcI/gsd5zYmhq67QIuisYVJCnXYxNlvBaSQCjXm9MKJilIZjLPbCw9y7
 hJXoLOz0QkogRmQi7DTUs/Oe6HlPMstwKxOePx3BliEsEKlInmNLoM7ByAsSRRslg+ut
 dXSFwGweSjOEpbRX/U1KFlE2tHiTyy/MfT8X7cgL1mXtjOYYOc4FknHmsCdsgvidlBL4
 X2RB1Juz9NAQvWXmF8nF8NGPOGJfZSJDSA5hyCX+HmhKpHm2JG4/gjNyKefrb+yg5Z9L
 rx4A==
X-Gm-Message-State: APjAAAWYO0hppgJfUSi68ZSEWcDYL7uXc/FXsYDAoaKsE5KvkJ7MoKeG
 nbrbmvyFqo7jTNbpC5hIRdItSQ==
X-Google-Smtp-Source: APXvYqzeynYHfYaILX5uPFVdtoW89PLwCO3SC0+eLaCGlhKJ6VUrH6WT+tezENgpl4IDlbsizSFtvg==
X-Received: by 2002:a5d:6742:: with SMTP id l2mr35628886wrw.323.1561161559636; 
 Fri, 21 Jun 2019 16:59:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:45fb:a0de:928e:79e8?
 ([2001:b07:6468:f312:45fb:a0de:928e:79e8])
 by smtp.gmail.com with ESMTPSA id w67sm4897793wma.24.2019.06.21.16.59.18
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 16:59:19 -0700 (PDT)
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20190621213712.16222-1-liran.alon@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <01713909-71dd-99e6-40bf-a2b93dfbd578@redhat.com>
Date: Sat, 22 Jun 2019 01:59:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190621213712.16222-1-liran.alon@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 0/2] target/i386: kvm: Fix treatment of AMD
 SVM in nested migration
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
Cc: dgilbert@redhat.com, maran.wilson@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/06/19 23:37, Liran Alon wrote:
> However, during discussion made after merge, it was realised that since QEMU commit
> 75d373ef9729 ("target-i386: Disable SVM by default in KVM mode"), an AMD vCPU that
> is virtualized by KVM doesn't expose SVM by default, even if you use "-cpu host".
> Therefore, it is unlikely that vCPU expose SVM CPUID flag when user is not running
> an SVM workload inside guest.

libvirt has "host-model" mode, which constructs a "-cpu
model,+feature,+feature" command line option that matches the host as
good as possible.  This lets libvirt check migratability while retaining
a lot of the benefits of "-cpu host", and is the default for OpenStack
for example.  I need to check if libvirt adds SVM to this configuration,
if it does the QEMU commit you mention is unfortunately not enough.

Paolo


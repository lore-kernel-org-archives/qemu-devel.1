Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2279C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874492089E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874492089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsSIZ-0004ei-Pt
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 09:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49629)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hsSHL-00044L-Ku
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hsSHK-0004zr-EA
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:34:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hsSHK-0004zN-8c
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:34:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so65918190wru.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 06:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZtMpzTLaI6fhf1m14S++OtPvJ5uF/5YpfH3OxBspJP4=;
 b=LR/KEwNcLPzo0lyF3Ag+BfUydKXIuRvoraefB9/2pN6AGntwP/TDxlEBOJB0pIPlHO
 UKWZMrEmbyT4CyTWP0xlIJvtZksT/pg4gt2XwA19A17am0f+vjzx+62XLzNv336fN1+t
 MVx5iQLeR7MZLpRlp13XsHaIj3aVI2K6GGMyh2rkjLDVMUlrybtjtNC19mNs6XxZegjX
 zF0631ALwNAyr1QKnMxcSL5mqVZlCu2jGfntRbKp5jWKwtCuJpFEV6dFhBdZaN6On3Ir
 LfgERn7IVyB5HapbblJfMfpf+FOHFrvnZ8AHwrGxvBTwg3j1i4t3Aq1BJM/oEeQW4Oei
 /78A==
X-Gm-Message-State: APjAAAWRkaSSniQrkfxhL6oxhUVPu+xf0PQ6wsdKAXm6tEy0DCwqVh4v
 hxAeYRLJ1ecahc3K2O+E1bPw9Q==
X-Google-Smtp-Source: APXvYqxIjRSOmEbCboXa7ErqfE9mNWrZ4/5JTSgym3jCeyAN21OUokS+mVCu41054lkSFRlMNXtCqw==
X-Received: by 2002:adf:f64a:: with SMTP id x10mr25373613wrp.287.1564493696948; 
 Tue, 30 Jul 2019 06:34:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04?
 ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
 by smtp.gmail.com with ESMTPSA id t24sm59697747wmj.14.2019.07.30.06.34.55
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jul 2019 06:34:56 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190729145229.4333-1-imammedo@redhat.com>
 <20190729145229.4333-2-imammedo@redhat.com> <20190729175315.GK2756@work-vm>
 <20190730152558.2e1aa23a@Igors-MacBook-Pro>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <41ee4043-0f91-9bfa-f3f6-f85358250bb9@redhat.com>
Date: Tue, 30 Jul 2019 15:34:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730152558.2e1aa23a@Igors-MacBook-Pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] memory: make MemoryRegion alias
 migratable
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/07/19 15:25, Igor Mammedov wrote:
> I'd guess you've meant RAMBlocks instead of memory regions, if that's it
> then yes, every alias pointing to RAM backed memory region will have
> RAMBlock that's points to aliased part of aliased memory region.

The question is just, does it break migration from old QEMU to new QEMU
on x86 (which has plenty of RAM-backed aliases)?  If not, explain that
in the commit message or in a code comment.

Paolo


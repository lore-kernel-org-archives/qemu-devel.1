Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FD2C4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C9412089F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9412089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCRaK-0008WO-Uq
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iCRWZ-0004wU-Eb
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iCRWX-0000AE-00
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:49:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iCRWW-000097-Q5
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:49:16 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EBC44C049E10
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 16:49:14 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id f63so5189419wma.7
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q4ZQVnl05lKtmjEVU/3ImMMDVEOetq6yYiV7Ugwothc=;
 b=gkRYhZgypj6fqO0SQpN5xUhID4xQoYUVz9y0zO9hE/pzJNC/o+zBequakQAdc/EHLs
 HhGOod6HGO0plMbcmKUq4ym0VUkChE+KXQ8MbYLv10lqT0OLAXY8hY280/u1swnSQGof
 QSBxVVkiCWCzijFgFKLd6OYi/g4YwoPfG8KkrgtgFYHLBU3o54z+CSGJoyRjM1+rujot
 yISGXff59P+F+A37+yeuiVagjb8N+Pm81hIBy5QFZUH4UaUSDlwVjMSBJhzvPAOh+Ewg
 idr9jEu+6uml/AM2+99tDrIbYIUGfas3J9XS3O4Fs2PRWJWcOHCvy6Krre9mFCXGwVmU
 8GqA==
X-Gm-Message-State: APjAAAUhNtdG6TgYzXCpCLo2kC/EW1+VtjNLx3Y80EXb26UtmkBNGYa0
 8f5hLbW+I2/i99740o9apseIFktFg+9jalqJmy5jAZYvBKhNUDtLFCS87u3Y2jAng9neTFj5Icu
 HyZoR1KLHUuDkfY4=
X-Received: by 2002:adf:d848:: with SMTP id k8mr295011wrl.254.1569257353582;
 Mon, 23 Sep 2019 09:49:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwU+llXPbJ2r13crlLPRf9+Je1DXBWVXfxbM3bjMOVyrYDr5IlI/nlxzr9wqm7bc89k1O9lAw==
X-Received: by 2002:adf:d848:: with SMTP id k8mr294995wrl.254.1569257353362;
 Mon, 23 Sep 2019 09:49:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id q10sm28477342wrd.39.2019.09.23.09.49.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 09:49:12 -0700 (PDT)
Subject: Re: [PATCH 0/2] kvm: clear dirty bitmaps from all overlapping memslots
To: Igor Mammedov <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>
References: <1568974882-7419-1-git-send-email-pbonzini@redhat.com>
 <20190920121951.GI12858@xz-x1> <20190920155851.7445cd2a@redhat.com>
 <20190923012946.GJ12858@xz-x1> <20190923181512.144e3b77@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ad751c10-69f5-8d20-5150-9750425a5f72@redhat.com>
Date: Mon, 23 Sep 2019 18:49:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923181512.144e3b77@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/09/19 18:15, Igor Mammedov wrote:
> Yep, commit message doesn't fit patch, how about following description:
> "
> Currently MemoryRegionSection has 1:1 mapping to KVMSlot.
> However next patch will allow splitting MemoryRegionSection into
> several KVMSlot-s, make sure that kvm_physical_log_slot_clear()
> is able to handle such 1:N mapping.
> "

Yes, that's great.

Paolo


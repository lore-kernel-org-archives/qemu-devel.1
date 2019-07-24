Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69DFC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 08:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B433217D9
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 08:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B433217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqD7r-0002rr-O4
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 04:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38304)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqD7h-0002TL-69
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqD7g-0005hM-A1
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:59:45 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:45460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqD7g-0005gi-0q
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:59:44 -0400
Received: by mail-wr1-f44.google.com with SMTP id f9so46010287wre.12
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 01:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ldyWFbKB7XtYD7eVStMHLPGEy55p0B+kxtJdtUyssi4=;
 b=SqE1+ZFG8gNoVXBjW9VTsiWWDZThvztSnnDQ32VoWvpChLFnEo7idXiKhj2ztnGP8A
 UAS9KExhCm/2c8Okx9A4TLubAOzVuAPO3D45kYRfVcjKU/TomYez6/X03C1Vx8oTXES0
 Ldwb2A1MGMPsnMTGuyYUI5xgZi46lvwrMeq37Joq3qpMOCbMiVRgyNaxBopJJ8wgmxhl
 V8b0LYKRCTlf8IPkiUIouUWOdarhjOFyBQzmyHJkLB+V2ZhvNT6H8bwN9mrInoAGzIrQ
 566Q7bctNEW90GsDrK74VQPbTEhPchne9B+WvvH4i2XXbS+xnA1jXmzRidx6rkEHGuhh
 pWvA==
X-Gm-Message-State: APjAAAWGIgmBcrTLmzwlRl+rDjK/T2GkYXqzxYHbvIH7+658U5gVtQop
 qeJhWqWUwECM+HVzhcMZtStWpA==
X-Google-Smtp-Source: APXvYqxqQa85HOG/f86sGhT1F4k+uBDxO8cG7CdG7r9kqCGMB/U3OkhFGQufv6wac67s5yQDx13Wuw==
X-Received: by 2002:adf:cd81:: with SMTP id q1mr83986434wrj.16.1563958782932; 
 Wed, 24 Jul 2019 01:59:42 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o6sm88327974wra.27.2019.07.24.01.59.41
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2019 01:59:42 -0700 (PDT)
To: Yang Zhong <yang.zhong@intel.com>
References: <7A85DF989CAE8F42902CF7B31A7D94A1487D6D13@shsmsx102.ccr.corp.intel.com>
 <93e3762a-d906-6d6b-9a5f-7497af188f94@redhat.com>
 <20190724065513.GA3369@yangzhon-Virtual>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c158d398-8049-7e9c-d3be-573ff5b032d3@redhat.com>
Date: Wed, 24 Jul 2019 10:57:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724065513.GA3369@yangzhon-Virtual>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.44
Subject: Re: [Qemu-devel] The WCE issue in guest when i enable WCE in Qemu
 side.
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/07/19 08:55, Yang Zhong wrote:
> 
> The SPDK code i am using is latest version, So, i feel we should
> enable WCE feature in SPDK side by default. thanks for your help!

Note that enabling the CONFIG_WCE feature has some consequences.
According to the spec:

- if the VIRTIO_BLK_F_CONFIG_WCE feature was negotiated and the
writeback field in configuration space was 0 all the time between the
submission of the write and its completion, the device MUST ensure that
stable writes are committed to persistent storage before reporting
completion of the write.  This means using FUA writes or something like that

- the device MUST offset VIRTIO_BLK_F_FLUSH if they offer
VIRTIO_BLK_F_CONFIG_WCE

- if VIRTIO_BLK_F_CONFIG_WCE is negotiated but VIRTIO_BLK_F_FLUSH is
not, the device MUST initialize writeback to 0

Paolo


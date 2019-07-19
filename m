Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1737C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8912920873
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8912920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoROb-000210-Rx
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 07:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42235)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hoROS-0001c9-5P
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hoROR-0003jP-4G
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:49:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33028)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hoROQ-0003in-Uj
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:49:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so32041855wru.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 04:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MDOi0A1HnIsayFtsGLfesWmFa9cOJ4N+w+FQwsbhA7o=;
 b=o34Gct+eecY4Tf2baO+q8pfhDvR86CbD9KxY6Z/ub0bQZY0M4IQ/C/i/YlZcLG9M9f
 FOI9UWlaJCC4rEbhUdOmzxh8cF0BztYq5HD3kcthOH96vXlWrXVGhr4ScR5wVtnNs/gW
 5Qk/MLS8iBU+yJBrc/wSmhPWsbQuHtPYdHQ60bexMd2uCMSeiaWbaIfFehp7qT2hEfXE
 JM6mCSc5UjNZ5KQhz38cg3xhu6rF+vR5xnH5EFu/T+FKWe/GSJ9O+372hN3xd07OpzoF
 r2g1qDDi1VpUpsLg7LNBQGXjuDbdSO8tS3vcT4rd7UBswi8EOuMjoliUhZbJ+pE7JWAB
 wZSA==
X-Gm-Message-State: APjAAAWASFMKwsqjiiwiYoSF3r+a41iZnlZrYvMW2kfN2tggAP8PqxWE
 Fgw9SSZVahQOG5DGsd946fP75/lS+4o=
X-Google-Smtp-Source: APXvYqzNRLvREuwYSSPQl1izKKLq8271NOqnAKyPlL0RjjaSYQJ7u2L1fKDwU8G2utUqHl16D2PlwA==
X-Received: by 2002:a5d:4cc5:: with SMTP id c5mr7586492wrt.278.1563536981681; 
 Fri, 19 Jul 2019 04:49:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8501:6b03:f18c:74f8?
 ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id d10sm24915521wrx.34.2019.07.19.04.49.40
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 04:49:41 -0700 (PDT)
To: Sergio Lopez <slp@redhat.com>
References: <20190701144705.102615-1-slp@redhat.com>
 <20190701144705.102615-5-slp@redhat.com>
 <20190702081733.ff6cboiddln5wmti@sirius.home.kraxel.org>
 <878stgygiu.fsf@redhat.com>
 <20190702101625.trsg5dnnf2a4woqs@sirius.home.kraxel.org>
 <875zokyahg.fsf@redhat.com> <8c3b4619-f779-fb0c-7a53-b67150036a07@redhat.com>
 <8736joxzv4.fsf@redhat.com> <87ef2ntnr1.fsf@redhat.com>
 <8cc45a56-1d12-838c-e746-e10df8804bc9@redhat.com> <875znypb8s.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9bb83ac5-2fc5-732d-772c-ad653c080d58@redhat.com>
Date: Fri, 19 Jul 2019 13:49:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <875znypb8s.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/i386: Introduce the microvm
 machine type
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
Cc: ehabkost@redhat.com, maran.wilson@oracle.com, mst@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/07/19 12:30, Sergio Lopez wrote:
> If people feel more comfortable keeping QEMU on x86_64 starting on Real
> Mode and having the firmware writing mptables, I'm fine with taking this
> approach.
>
> That said, to avoid confusing users, I think it'd be better to drop the
> legacy mode for SeaBIOS, and support just qboot. That would mean having
> to add a binary from the latter to "pc-bios" with some descriptive name
> ("qboot-microvm.bin"?) and making microvm look for that one by default.
> 
> Does this sound like a reasonable plan?

Yes, though I wouldn't call it qboot-microvm.bin but just bios-microvm.bin.

In the meanwhile, feel free to send a pull request to the qboot project.
 The mptables can be written for all platforms, even those that have
ACPI (there is always -no-acpi, too).

Paolo


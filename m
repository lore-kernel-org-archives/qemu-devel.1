Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E376C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 746FE21873
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746FE21873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprQE-0001uH-Np
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 05:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51020)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hprQ5-0001Vi-G5
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hprQ4-0000Zf-If
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:49:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hprQ4-0000Yv-CD
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:49:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so27452637wrr.9
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 02:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3tQ13mIXJbST8vS8DAD0niaSEcTyIgOkLn/GaVA7bDE=;
 b=Tn0R1zIbj14c8haytBJ4mmmgA4jnTMEXZ1digug/+grGqH1GzNbV6B2E50IbzYJheO
 XHQeVCOTqQ9wmJuD5tB1IP72F5L/dU5oVSq4tf2Ap7SfSUSpcNEPu82RGllvypShzeUe
 N0azxkXNDVMUoXBFn1xGePIzucpSeaPU4vaPB1ZdUjAGbTHCd52UPd8P8lMU6csd9PRc
 /UySlT8cxA1sZBRhAgejCMatKmZOYjlJZYh89tAqYD734tCsh+gxdKSrH1z96Sqi9oZD
 ybnsvd/7an7w27FEEX+4JHlq7J6cysNRsafg1/lIb40yPDT2FVe/Wqv3DzpdwneAaVbK
 3mhA==
X-Gm-Message-State: APjAAAWt0yrc/qHYMHhUSOw43r3sQNH3i/XmotXrd8q7rkprHRNWFrJP
 sncfGG4r6ny2/vPy6J58f85a4w==
X-Google-Smtp-Source: APXvYqxFYVxN2zrIdFoNQ90EbM74ZBnG9r4BO1lEViZ+IpxuUc8N3+xSTQhHGsT0JMOolWAG/PEC8w==
X-Received: by 2002:a5d:6182:: with SMTP id j2mr35126742wru.275.1563875354850; 
 Tue, 23 Jul 2019 02:49:14 -0700 (PDT)
Received: from [10.201.49.73] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id k124sm68843580wmk.47.2019.07.23.02.49.13
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jul 2019 02:49:14 -0700 (PDT)
To: Stefano Garzarella <sgarzare@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190723090718.14590-1-sgarzare@redhat.com>
 <20190723090718.14590-2-sgarzare@redhat.com>
 <CAFEAcA_KspUxk75hR4YV444tj8-bQKOJ_4eq+aPD-idZ12Lzwg@mail.gmail.com>
 <20190723094241.7znxmk3wa6gti6tr@steredhat>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a4ec2c49-7b21-26bf-42a0-61427539d5d2@redhat.com>
Date: Tue, 23 Jul 2019 11:49:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723094241.7znxmk3wa6gti6tr@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 1/2] elf-ops.h: Map into memory the ELF to
 load
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/07/19 11:42, Stefano Garzarella wrote:
> "If writable is TRUE, the mapped buffer may be modified, otherwise it is an
> error to modify the mapped buffer. Modifications to the buffer are not visible
> to other processes mapping the same file, and are not written back to the file."
> 
> I don't know what "error" means, but reading the second part I thought
> the changes in that case were only visible at the current process.

My reading would be that the second part applies to the writable==TRUE
case.  In fact, the glib source code agrees:

      file->contents = (gchar *) mmap (NULL,  file->length,
                           writable ? PROT_READ|PROT_WRITE : PROT_READ,
                           MAP_PRIVATE, fd, 0);

meaning that we could after all just use writable == true.

Paolo

> I'll test it to understand better the behavior. If we can't touch it, then we
> have to make a copy in these cases.
> 
>> (We can't get out of this by just passing writable=true, because
>> we definitely don't want to be writing back to the underlying file.)
> Yes, I agree.



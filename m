Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC942C76190
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B92DE2239F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92DE2239F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprc3-0005zl-Uj
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54886)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hprbs-0005bW-Rz
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hprbr-0001qp-OY
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:01:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hprbr-0001pt-Ha
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:01:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so37946138wmj.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YMJ0/ybdApu3hEpLUwuklp9tExryLy9O842tqjbih6M=;
 b=hJ3q2qXlKVnY/XfPahBbFr7Sv57UziSzZ0eXpg8JX3b0HmasPix3i3BiYq+lDICFNm
 XIDzh8JMQCrRZBwxP7+Zcl2rrLUcLpXm2Xig4aKwZMGwBuEtiB+Ig5CmSbPVKeITMH9i
 xDq5m3+AsXFuzFP0RoZVoohaT7XXvJv86G8ECbzvsIRzDgwPiAlLrn1b7Fn1Qa+3YY4k
 v4XVpsV1HXv+8M9zWsNN1V1uqD+KvufOkheAyQSpnaa2Uu7CZARSU6tLmC5JuqTNHyGh
 TEAL7vbXJUW7G+yUbrm+dR9YgGUiV19Lh5BPHFuVkMWC7Exs8za9rlgQ6QtzSQLEjR6N
 YLfA==
X-Gm-Message-State: APjAAAXEK2XC7bMtbKHmiTd+rpbqulrNtscWhqSo1AjADUn1HAYBMZKu
 F+4dYHkT1I5QfMO7SYHAIuxLlA==
X-Google-Smtp-Source: APXvYqy03CnR8LCTOK6K3frpJXZQ9rMu42V4GtC+9UaGC9FDYjr3YKskmhOAZWNII/XTafeqlXw8Tw==
X-Received: by 2002:a1c:7310:: with SMTP id d16mr66485516wmb.107.1563876086336; 
 Tue, 23 Jul 2019 03:01:26 -0700 (PDT)
Received: from [10.201.49.73] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id g12sm59182251wrv.9.2019.07.23.03.01.25
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jul 2019 03:01:25 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@gmail.com>, Sergio Lopez <slp@redhat.com>
References: <20190702121106.28374-1-slp@redhat.com>
 <20190703095825.GE11844@stefanha-x1.localdomain> <87d0i7tlkl.fsf@redhat.com>
 <20190719102915.GG18585@stefanha-x1.localdomain> <8736j2p22w.fsf@redhat.com>
 <CAJSP0QXTSwk4eJteC0wTB7LGoHY3=7t4G-eNfgREQ6k+GzV2_w@mail.gmail.com>
 <904248411098104fcf7db22382172057e50db76c.camel@intel.com>
 <87tvbdrvin.fsf@redhat.com>
 <CAJSP0QW1NrYwC6a61jj_vgJOJO7ofJOVUcz6Bf4z720OiN_0rw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c1464003-38f9-95ee-c42a-fb1d370df0ab@redhat.com>
Date: Tue, 23 Jul 2019 12:01:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJSP0QW1NrYwC6a61jj_vgJOJO7ofJOVUcz6Bf4z720OiN_0rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "Montes, Julio" <julio.montes@intel.com>,
 "maran.wilson@oracle.com" <maran.wilson@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/07/19 11:47, Stefan Hajnoczi wrote:
> fw_cfg could expose this information so guest kernels know when to
> stop enumerating the PCI bus.  This would make all PCI guests with new
> kernels boot ~50 ms faster, regardless of machine type.

The number of buses is determined by the firmware, not by QEMU, so
fw_cfg would not be the right interface.  In fact (as I have just
learnt) lastbus is an x86-specific option that overrides the last bus
returned by SeaBIOS's handle_1ab101.

So the next step could be to figure out what is the lastbus returned by
handle_1ab101 and possibly why it isn't zero.

Paolo

> The difference between microvm and tuned Q35 is 76 ms now.
> 
> microvm:
> qemu_init_end: 64.043264
> linux_start_kernel: 65.481782 (+1.438518)
> linux_start_user: 114.938353 (+49.456571)
> 
> Q35 with -cpu host and pci=lasbus=0:
> qemu_init_end: 73.711569
> linux_start_kernel: 113.414311 (+39.702742)
> linux_start_user: 190.949939 (+77.535628)
> 
> There is a ~39 ms difference before linux_start_kernel.  SeaBIOS is
> loading the PVH Option ROM.
> 
> Stefano: any recommendations for profiling or tuning SeaBIOS?



Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2D8C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D38206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D38206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59976 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdHLk-0006Fc-G1
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49672)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hdGnE-0005B5-0P
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hdGnA-0005kV-4G
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:17:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36586)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hdGn9-0005F5-Of
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:17:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id u8so3904337wmm.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 09:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5e9uLp89Gt+m5g88zVJ9D5G0JHLLMLu3Kl8Zr8OgjC8=;
 b=lcGoACooWqolyfbDuPBLtWRjvPSTpXfZwWLHg0sOrgsJRXk9y+PJUknFP0vZV9UJ6i
 rmxDtF2RP+ngLt/IMZNvBFqkYMmC23B3l9phUQGkPtjDtK1QrTF2jgRiDmy/GQazwl4l
 a/J6IKuiPouCEZS5xLfMTigbIqVwfY/DWiMqSVxJ9vy+6iNxSeTCfRBrWw1CF2+uAr55
 kKUfricfa6xzyfbERcZMbUCRJOdsrc0/af+pTPWSOYn5yLi02zNm29DI+rIQcMoB4cFw
 /296IpS5K3kyi/++1v6eRxHEzgKmCpn+Tec+632eR5aJUZTcAfNXCOvLrWoJIKozLmeq
 xw6A==
X-Gm-Message-State: APjAAAVFZq98rnEgIipr4nDq22UTH4MQrEJeG2Zc26ycPFSiEc+wI+Uc
 F2YDGfGCK9sZiZp9nC1c/aZ/IA==
X-Google-Smtp-Source: APXvYqw1J9CwL+z6Y1GnoG219YYSsmAGstLgCwPixXpJKUR7s+TMMAsy7qhDiA6bWSLkIly4qjc0Ww==
X-Received: by 2002:a7b:c057:: with SMTP id u23mr4411268wmc.29.1560874600084; 
 Tue, 18 Jun 2019 09:16:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:51c0:d03f:68e:1f6d?
 ([2001:b07:6468:f312:51c0:d03f:68e:1f6d])
 by smtp.gmail.com with ESMTPSA id v27sm30359654wrv.45.2019.06.18.09.16.38
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Jun 2019 09:16:39 -0700 (PDT)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Liran Alon <liran.alon@oracle.com>
References: <20190617175658.135869-1-liran.alon@oracle.com>
 <20190617175658.135869-8-liran.alon@oracle.com>
 <20190618090316.GC2850@work-vm>
 <32C4B530-A135-475B-B6AF-9288D372920D@oracle.com>
 <20190618154817.GI2850@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <476e9ff5-133a-4ee0-6eec-6c55c5e98dfc@redhat.com>
Date: Tue, 18 Jun 2019 18:16:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190618154817.GI2850@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [QEMU PATCH v3 7/9] KVM: i386: Add support for
 save and restore nested state
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, maran.wilson@oracle.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, rth@twiddle.net,
 jmattson@google.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/06/19 17:48, Dr. David Alan Gilbert wrote:
>> Currently, KVM folks (including myself), haven’t decided yet to expose vmcs12 struct layout to userspace but instead to still leave it opaque.
>> The formal size of this size is VMCS12_SIZE (defined in kernel as 0x1000). I was wondering if we wish to expose VMCS12_SIZE constant to userspace or not.
>> So currently I defined these __u8 arrays as 0x1000. But in case Paolo agrees to expose VMCS12_SIZE, we can use that instead.
> Well if it's not defined it's bound to change at some state!
> Also, do we need to clear it before we get it from the kernel - e.g.
> is the kernel guaranteed to give us 0x1000 ?

It is defined, it is the size of data.vmx[0].vmx12.  We can define it.

Paolo


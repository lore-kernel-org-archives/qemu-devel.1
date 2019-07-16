Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9750BC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 21:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F87420659
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 21:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F87420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnUhJ-0003Wo-Ta
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 17:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51099)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hnUh9-00038N-NM
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hnUh8-0006uA-Px
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:09:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46711)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hnUh8-0006sw-J5
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:09:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so22394261wru.13
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 14:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ph3IVC3avkK9m7SP4JVhBgpCnO3Je1f1imGTT1xbtj0=;
 b=GbTlPpRthUf0BxRu3DrGqR8yhJ6qmd0w0MO1woPg24GcOo99YsJ5ztPPdr+zlSo5wS
 rmsnV1lgMg6bdvRWgebnPF48HKI6n9AHoZdqJ+Y60O5hvRp/oUE8I2Ve+FUUGiysRHz2
 ctunr+U7U01znexUR2YoEJQsy9bn9SmmgSM+WbDj8TVS+3B5EQzMSE0GGnxc+hF+SCj7
 x7o0v/Ui4g0OwsuHxfzDxtvtLe0GeTE9vW2uRz8rDTeTPiYQb5Iic/cMfq7oZyB3yQXC
 f6eqajgAsKYdMSzHXeS/+30CcpCzDIpxy5Q/5EyJlLk507MPi31LbHmhJweBr+hKEhQs
 ru6g==
X-Gm-Message-State: APjAAAUgjvnLpXpqQ3eUPmVewnBqXhK6XMVGLArJnISMzoGnD0Qby0gs
 DfXw+nFkY3Scbq7UINCKto1Otw==
X-Google-Smtp-Source: APXvYqwrTEjR7Sq79t4rs8fZ/nUY/V/3gOKq1qgd333KXslym0csJvmn0X726MssZLnS6/mYmVUiwQ==
X-Received: by 2002:adf:e841:: with SMTP id d1mr38401760wrn.204.1563311344946; 
 Tue, 16 Jul 2019 14:09:04 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id j10sm36429573wrd.26.2019.07.16.14.09.04
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 14:09:04 -0700 (PDT)
To: Mark Kanda <mark.kanda@oracle.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <20190603230408.GA7938@amt.cnet>
 <1afdac17-3f86-5e5b-aebc-5311576ddefb@redhat.com>
 <0c40f676-a2f4-bb45-658e-9758fd02ce36@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <86e64a5c-bb2b-00c8-56c3-722c9b8f9db6@redhat.com>
Date: Tue, 16 Jul 2019 23:09:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0c40f676-a2f4-bb45-658e-9758fd02ce36@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [patch QEMU] kvm: i386: halt poll control MSR
 support
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
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/07/19 21:52, Mark Kanda wrote:
> 
> As such, I think we should only enable halt polling if it is supported
> on the host - see the attached patch.
> 
> ...thoughts?

No, it should not be enabled by default at all, at least not until we
can require kernel 5.2.  My mistake, sorry.  Can you post a patch?

Paolo


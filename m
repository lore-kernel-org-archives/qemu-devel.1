Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C81C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207132469F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnrRWGhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207132469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7hVq-000360-5R
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:25:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j7hV9-0002Zf-TQ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:24:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j7hV8-0006F7-Fo
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:24:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60357
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j7hV8-0006EY-C6
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582903469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B2vOxYcVfEODVgxwvGFfJUdgwzDh+Xv44vUEtvRMT5E=;
 b=KnrRWGhi3therH31Hi9rR/jl18LBmUk1bOiHEkzcOnkBzL9gNr8uvCi5tyMytdEJ0MYdzY
 IBJ8o9i0hz+vIgP8GRNOrOVSSpB4KZa2JY1MiZtRwlpEn0rLdYSCtk0+MFP62Ds5j3djdH
 RFRbqTZI7NToqN+D+IFx0HRVKwJsCpk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-x4XCb8M4OV-HgfUJCtnXow-1; Fri, 28 Feb 2020 10:24:25 -0500
X-MC-Unique: x4XCb8M4OV-HgfUJCtnXow-1
Received: by mail-wm1-f69.google.com with SMTP id o24so857289wmh.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 07:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B2vOxYcVfEODVgxwvGFfJUdgwzDh+Xv44vUEtvRMT5E=;
 b=lulDAwokbOTuJ8qpZOOWd+q7drBZRdttroG0MQXK9DFLesQJv5qufy/RpcfPRDDFD+
 MhBeyCYtFAa1lIKvjNm6TNcuW5G1oYopcILlIX766DKj6qsBs7mda0SSJbWjifD61bK4
 1d8fxFkSlVfd2g366NfN4SO8BLoKjzKczWwdR+ZTlEH4tfeR4WJpJPvHSlkq2DByIsCo
 HVvr7BGC9pLJh67vqcrJq4N+SJ2SJWa4QPdYCIMruwy5SBynPO4fLuWfrd3UxhKSf9Wd
 VugMwFKUDjEnsAyEg56IdkovVxAq0prp36DAGd7pCVHSlFf8bE8LWs8eyQD9RrS6ma95
 PPBw==
X-Gm-Message-State: APjAAAUn2lWiR1QM1gfwST3TqyvTchc5gN7PH2cyJFI0Zh108DMHpvKh
 jeQvkQerMNs7k4O3o+oDatToWY9bq9hETtztYONR7gaPLeSGvDcYsu5DJ1faorSIDjEHXCTkxpL
 +YcoHHgUeMDtPhhQ=
X-Received: by 2002:adf:eb51:: with SMTP id u17mr5607379wrn.29.1582903464549; 
 Fri, 28 Feb 2020 07:24:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqwpLQ2YyB4CAng+K0o3G/7OQRHAy7k87IQcGVs9Yy9zbHaPTI+giUneGHWZbL7Ea3pSfNte8g==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr5607357wrn.29.1582903464218; 
 Fri, 28 Feb 2020 07:24:24 -0800 (PST)
Received: from [192.168.178.40] ([151.20.130.54])
 by smtp.gmail.com with ESMTPSA id l3sm11329327wrq.62.2020.02.28.07.24.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 07:24:23 -0800 (PST)
Subject: Re: [PATCH 4/5] KVM: Kick resamplefd for split kernel irqchip
To: Peter Xu <peterx@redhat.com>
References: <20200226225510.217077-1-peterx@redhat.com>
 <0c8147b1-ee26-cd5d-1592-f07371feaeb8@redhat.com>
 <20200228145800.GR180973@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <deabda06-61b5-6d6c-aaa3-6b9553f2fbcb@redhat.com>
Date: Fri, 28 Feb 2020 16:24:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228145800.GR180973@xz-x1>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/02/20 15:58, Peter Xu wrote:
> Yes I was thinking it the same way, however...  I noticed that VFIO
> will even mask edge INTx after getting IRQ (vfio_intx_handler).

INTx is always level-triggered so that's okay.

> And if look into current KVM kernel implementation, it has done the
> same logic to ack edge triggerred irqs (kvm_ioapic_update_eoi_one),
> we should logically ack it here too even for edge-triggered?

Right, that's because it's using ack notifiers also for in-kernel PIT
and for RTC.  But yeah, it makes sense to have userspace IOAPIC
resamplefd match the functionality of the kernel ones.  Thanks!

Paolo



Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02D4C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28F92342E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28F92342E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0iXZ-0008Fw-Qk
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 04:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0iUv-0007PR-NB
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0iUu-0007Pc-11
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:31:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56886)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0iUs-0007Nd-O7
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:31:07 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 78001C059758
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 08:31:04 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id j10so2849249wrb.16
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 01:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XmOUOEsTVQM59nS2QtNEKx/xIV8wFJhn7Usco1+C30w=;
 b=tS1IzCj0OQcEkSkDK11usxsqArTicwZOYLkHMGfmWJbxfEczEl7eSeNveNM5dsSgxs
 v4+m4X7QeNbpVqgKx3BPsGEnm5upfWPk12d+qd0Y5Dn05BrguCHn0nx8czepuaKxX/9d
 balmqaqh27z5JQeyfAm8Nn+DG9yaCEGArUb9fw7y5CAE2A0FmU6V9tBTFy1vbgBUpB6c
 NoB7TwfPPx0Ng/B22aiDO9FLQGKfw27wLIF8x8nGY1cDBjZtaK9SrgTfKiYamZXJwAlq
 nHXcXEQLLHpBdVIMZM3UhE9PBgwfMLuB3RzR9vIjKR8TyUACch3LKBqbG5/44yBPaKs7
 KxYA==
X-Gm-Message-State: APjAAAWZpYnCAEPWXolhZnp6JorG/H/yI/62xTLVhJ0XrLUCEUW3F7C+
 9aySnmf1z/KDzCZH686ARN6am5xnXRjlenvN8ZoHzK/PmEkI2fhDOmRBIYaC1YlN+1kxHsP3YKJ
 2MaF5nGC20/3gn8Y=
X-Received: by 2002:adf:a1de:: with SMTP id v30mr6892039wrv.138.1566462663168; 
 Thu, 22 Aug 2019 01:31:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyRhEEWRxys/hKXAGe7ZOUbxgksE2CkqaJplXLb8sFyYqjDFsECoezvNgqQr+vyol4zVUMdHA==
X-Received: by 2002:adf:a1de:: with SMTP id v30mr6892002wrv.138.1566462662886; 
 Thu, 22 Aug 2019 01:31:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3?
 ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
 by smtp.gmail.com with ESMTPSA id t198sm6104981wmt.39.2019.08.22.01.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 01:31:02 -0700 (PDT)
To: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
References: <1560299717-177734-1-git-send-email-raphael.norwitz@nutanix.com>
 <20190614091841.GE10957@stefanha-x1.localdomain>
 <20190822040725.GA26234@raphael-norwitz.user.nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f58e4c47-dd80-9046-861e-309504394886@redhat.com>
Date: Thu, 22 Aug 2019 10:30:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822040725.GA26234@raphael-norwitz.user.nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] vhost-user-scsi: prevent using
 uninitialized vqs
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
Cc: fam@euphon.net, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/08/19 06:07, Raphael Norwitz wrote:
> On Fri, Jun 14, 2019 at 10:18:41AM +0100, Stefan Hajnoczi wrote:
>> On Tue, Jun 11, 2019 at 05:35:17PM -0700, Raphael Norwitz wrote:
>>> Of the 3 virtqueues, seabios only sets cmd, leaving ctrl
>>> and event without a physical address. This can cause
>>> vhost_verify_ring_part_mapping to return ENOMEM, causing
>>> the following logs:
>>>
>>> qemu-system-x86_64: Unable to map available ring for ring 0
>>> qemu-system-x86_64: Verify ring failure on region 0
>>>
>>> The qemu commit e6cc11d64fc998c11a4dfcde8fda3fc33a74d844
>>> has already resolved the issue for vhost scsi devices but
>>> the fix was never applied to vhost-user scsi devices.
>>>
>>> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
>>> ---
>>>  hw/scsi/vhost-user-scsi.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Ping on this. Any reason it has not been merged?

I had missed it.  I have now queued it (but I won't send another pull
request until approx. the middle of September).

Paolo



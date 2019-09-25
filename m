Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306A2C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054D3207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054D3207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDAW7-0006HG-RL
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 12:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iDARz-0003Hd-Bn
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iDARy-00020G-Ah
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:47:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22122)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iDARy-0001zv-2P
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:47:34 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 21000C01F2E8
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 16:47:33 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id q10so2615259wro.22
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mIWa69Hl6HkgnChbB9aa2LlXGzIAIx6XoqAaNHB0dE8=;
 b=dbLsV3ZhevmDNrQiYK+UjK7tGoXRuMwxq0iPJVCFeGD1H+gCnladgf9nO5QF7XKRy2
 CB+oN52VRTPOJWBn4PR+PDeGs8Qy1ro3P/qh9LTyKsAtdb2gulTXOydabV1t4FPEzgZu
 JJl1uEQx3fbdqn6QJwoTO1JCJ6dRQ6ltHUJgmetbf9t+UxRN5UG/KpeVnIV15XX79AVh
 kHoZBvnasu/ZEKajjdL+PNR70kNPH0UqHGCVSyILTHlFMuy68bno5RdK+xpDUyI9tEim
 qTmKuX62RhrkQCPHmZlE65gILzOWPF57JKryEIkBaQK1g7HuHXFT5kST34+wK2aw2iGg
 xcRA==
X-Gm-Message-State: APjAAAU9pFffJhw+mfsZadboIWqR9RkrzPuvkq+FZZ2VxqXKwQLusUCk
 4saYRuTOJQ7nQCiql2rgDrBv5WdyXVulXOdN1mCa9Zx/Rx26VhmZIbeaeePT32TNt+A0KVYANbh
 fGHuXFYyQqbf1z6Y=
X-Received: by 2002:adf:8168:: with SMTP id 95mr9956474wrm.332.1569430051777; 
 Wed, 25 Sep 2019 09:47:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw+hy/3Fn4E3zU0XSMMaipw4jbth+zGDznPTHFO70R0uxwHWxmPGLVuya+IakbbiaOKzwAOgg==
X-Received: by 2002:adf:8168:: with SMTP id 95mr9956458wrm.332.1569430051449; 
 Wed, 25 Sep 2019 09:47:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id g185sm7569472wme.10.2019.09.25.09.47.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 09:47:30 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Automatic RCU read unlock
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190913102538.24167-1-dgilbert@redhat.com>
 <20190925131324.GG21544@work-vm>
 <a94e7f44-165c-c1c8-f253-f849eaf0a8d0@redhat.com>
 <20190925152858.GE2876@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a3812aea-e2b9-4a7f-5d27-3906769fa48c@redhat.com>
Date: Wed, 25 Sep 2019 18:47:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925152858.GE2876@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: quintela@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/19 17:28, Dr. David Alan Gilbert wrote:
> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>> On 25/09/19 15:13, Dr. David Alan Gilbert wrote:
>>> * Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
>>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>>
>>>> This patch uses glib's g_auto mechanism to automatically free
>>>> rcu_read_lock's at the end of the block.  Given that humans
>>>> have a habit of forgetting an error path somewhere it's
>>>> best to leave it to the compiler.
>>>
>>> I've had to unqueue this - clang doesn't like the apparently unused
>>> auto variable; we need to find a way to make that happy.
>>
>> __attribute__((unused))?
> 
> I worry that if I do that, then it'll optimise it out.

It cannot, since the function passed to the cleanup attribute can have
side effects.

Paolo

> 
> Dave
> 
>> Paolo
>>
>>> Dave
>>>
>>>> v3
>>>>   Add block-head version of macro
>>>>   Rename
>>>>   Add docs
>>>>   Convert more cases using the block-head version
>>>>
>>>> Dr. David Alan Gilbert (5):
>>>>   rcu: Add automatically released rcu_read_lock variants
>>>>   migration: Fix missing rcu_read_unlock
>>>>   migration: Use automatic rcu_read unlock in ram.c
>>>>   migration: Use automatic rcu_read unlock in rdma.c
>>>>   rcu: Use automatic rc_read unlock in core memory/exec code
>>>>
>>>>  docs/devel/rcu.txt      |  16 +++
>>>>  exec.c                  | 120 +++++++---------
>>>>  include/exec/ram_addr.h | 138 +++++++++----------
>>>>  include/qemu/rcu.h      |  25 ++++
>>>>  memory.c                |  15 +-
>>>>  migration/ram.c         | 295 +++++++++++++++++++---------------------
>>>>  migration/rdma.c        |  57 ++------
>>>>  7 files changed, 310 insertions(+), 356 deletions(-)
>>>>
>>>> -- 
>>>> 2.21.0
>>>>
>>>>
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 



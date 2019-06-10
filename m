Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E638C28CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8F2207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8F2207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46888 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKy8-0000Wc-5D
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 10:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51884)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1haKiD-0001uJ-Il
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1haKiB-00033L-I4
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:51:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1haKi9-00030O-Pq
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:51:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so3687005wma.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 06:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WTUsB+4NaNNOz+8uDVCds+jQLaMxKJkibKsqnyiAkpI=;
 b=KCFuF/Nar0ZVgV+UO+2RDDYM8ZmZVycgEeoVdaD4bIAL/z1G702zU4ACedGWCyTyiA
 yTQfN3hwsA3XJzR4rSZQSHqw2PP1ajQAGqR2oDh2FIyov2d/60C/jXIB8eSPzj2H3gXZ
 7rKrr4UpB68YVE08gzzuG7oeFI/N5gHnXwqvwi58HKMlzcm2vV9pS5yjjD0qohNC0JdU
 D+jzQbMaFmIsxH8TB1Y1f9GNbDdOrW6NoS371GOVOnQyR1WN+jae0E5NBguGe11Zyu7r
 dynGSIonLO+YT+VnW7gIRSx0RvqSBp+CELieaxfKleO57o+4ti4tnjL8xT4Q2aJWwTMy
 DsRA==
X-Gm-Message-State: APjAAAUO2a7fa9cM2xrmcpd0hA6hjua6PbNbhXHCRMZGiQhImUMuT9t7
 1LDZuYkpxPl6GIMAuPVOJpe9eg==
X-Google-Smtp-Source: APXvYqwOjPSyNaX+TyZG4qdMbItf/28CmDsx85poMYQeAQVQHYtzFMW9Y7tJvnEjUqfz5SsEPm705Q==
X-Received: by 2002:a1c:411:: with SMTP id 17mr12359882wme.74.1560174701579;
 Mon, 10 Jun 2019 06:51:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:49d3:a711:c5a3:8ebf?
 ([2001:b07:6468:f312:49d3:a711:c5a3:8ebf])
 by smtp.gmail.com with ESMTPSA id j7sm14793499wru.54.2019.06.10.06.51.40
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 06:51:41 -0700 (PDT)
To: Zhengui li <lizhengui@huawei.com>, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com
References: <1560173684-6264-1-git-send-email-lizhengui@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1a218c83-7167-68c4-798f-2870f2f98475@redhat.com>
Date: Mon, 10 Jun 2019 15:51:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1560173684-6264-1-git-send-email-lizhengui@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] file-posix: unlock
 qemu_global_mutex before pread when attach disk
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
Cc: jiangyiwen@huawei.com, wangjie88@huawei.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, eric.fangyi@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/06/19 15:34, Zhengui li wrote:
> 
> when do qmp sush as drive_add,  qemu main thread locks the
> qemu_global_mutex  and do pread in raw_probe_alignmen. Pread is a
> synchronous operation. If backend storage network has a large delay
> or IO pressure is too large,  the pread operation will not return for
> a long time, which make vcpu thread can't acquire qemu_global_mutex
> for a long time and make the vcpu thread unable to be scheduled for a
> long time.  So virtual machine cpu soft lockup happened.
> 
> qemu main thread should not hold qemu_global_mutex for a long time
> when do qmp that involving IO synchronous operation sush pread ,
> ioctl, etc. So this patch unlock qemu_global_mutex before IO
> synchronous operation sush pread.

These preads are for 512-4096 bytes, can they really last much longer
than the "open" that precedes them?  If pread of 4K can trigger a soft
lockup, things are really screwed up---and it's hard to be sure that all
callers of raw_probe_alignment are okay with releasing the global mutex.

Paolo


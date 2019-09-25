Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0C6C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 03:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EAB32064A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 03:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EAB32064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCxyB-0001sq-IF
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 23:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iCxxU-0001T1-7L
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 23:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iCxxS-00014o-JH
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 23:27:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11021)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iCxxS-00014Q-Ax
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 23:27:14 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3A4E77FDCC
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 03:27:13 +0000 (UTC)
Received: by mail-pl1-f197.google.com with SMTP id p15so2490289plq.4
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 20:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zWpJ9kPj8TgfaMZLT9oNpV8QAnwBGi4IfaApWvqShoQ=;
 b=pwYXCRave/L4upwvY58M52a4/2R+8hzO+BhGfakNhbnduJryrRs6VwoSjXeHwJoKUV
 boNI22Zxv0Zp4PutLa8WKLFlD42QXq4sxhhlfTI9+JXTdDMINwdEIbjCxjjgR0c4pjlL
 k8d2xO5w25PkzYNGolQ45QdxzI6FfpSVu4vBhiMoCAg2IXxnqHQ+Z/RHM7vMtGjBLeAR
 rx771gJbH5iFla3IPDvGxOy3lyaqtn16m5oX9uRQvbwbnOHOY9fu4NwI9w6BVU92PWYg
 uERhUhXHZjLuoee3WxhiSDDlD+LsrYwfc4q3kE+15ydPjmPb9Q16S7MnQkPnzM7CG86e
 YPaw==
X-Gm-Message-State: APjAAAXDXzEcibSm6dY2IAQM1ob24LGtA5eWNPaDX5cMQOuZZf6Hjran
 WiXmJIw8NS9814n/YtHtJUmRamecBPrfNRJhUH5zmedEwLNalcFbgUWvpPRazt+Px5kkcceQQ1V
 +gE3WGnR+CmGx2po=
X-Received: by 2002:a62:1d82:: with SMTP id d124mr7255019pfd.135.1569382032784; 
 Tue, 24 Sep 2019 20:27:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx6Y8Y9mSAcck49VLIPBcIlxLFdz9NqNqtpxrzAeWFlV1KAUajsIu+lQLGMmbOdItUjcHmzdw==
X-Received: by 2002:a62:1d82:: with SMTP id d124mr7254993pfd.135.1569382032353; 
 Tue, 24 Sep 2019 20:27:12 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id cx22sm1178522pjb.19.2019.09.24.20.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 20:27:11 -0700 (PDT)
Date: Wed, 25 Sep 2019 11:27:00 +0800
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v7 4/4] s390: do not call
 memory_region_allocate_system_memory() multiple times
Message-ID: <20190925032700.GI28074@xz-x1>
References: <20190924144751.24149-1-imammedo@redhat.com>
 <20190924144751.24149-5-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924144751.24149-5-imammedo@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 24, 2019 at 10:47:51AM -0400, Igor Mammedov wrote:
> s390 was trying to solve limited KVM memslot size issue by abusing
> memory_region_allocate_system_memory(), which breaks API contract
> where the function might be called only once.
> 
> Beside an invalid use of API, the approach also introduced migration
> issue, since RAM chunks for each KVM_SLOT_MAX_BYTES are transferred in
> migration stream as separate RAMBlocks.
> 
> After discussion [1], it was agreed to break migration from older
> QEMU for guest with RAM >8Tb (as it was relatively new (since 2.12)
> and considered to be not actually used downstream).
> Migration should keep working for guests with less than 8TB and for
> more than 8TB with QEMU 4.2 and newer binary.
> In case user tries to migrate more than 8TB guest, between incompatible
> QEMU versions, migration should fail gracefully due to non-exiting
> RAMBlock ID or RAMBlock size mismatch.
> 
> Taking in account above and that now KVM code is able to split too
> big MemorySection into several memslots, partially revert commit
>  (bb223055b s390-ccw-virtio: allow for systems larger that 7.999TB)
> and use kvm_set_max_memslot_size() to set KVMSlot size to
> KVM_SLOT_MAX_BYTES.
> 
> 1) [PATCH RFC v2 4/4] s390: do not call  memory_region_allocate_system_memory() multiple times
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

IMHO it would be good to at least mention bb223055b9 in the commit
message even if not with a "Fixed:" tag.  May be amended during commit
if anyone prefers.

Also, this only applies the split limitation to s390.  Would that be a
good thing to some other archs as well?

Thanks,

-- 
Peter Xu


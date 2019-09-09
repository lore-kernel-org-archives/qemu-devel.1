Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6BCC00307
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 08:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30B282086D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 08:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B282086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Edo-0006BU-Pa
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 04:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1i7Eci-0005Y5-4u
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 04:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1i7Ecg-0001VH-P7
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 04:02:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1i7Ecg-0001Tw-Gt
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 04:02:06 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A7CF77325
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 08:02:04 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id s5so6956649wrv.23
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 01:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GVKBq9XDzn6xt+j1x34EptCO3sFMxRGbvPbJliDzTMw=;
 b=oJHFdo5+VwRLukvSmUqoSg4dvPXSH48jBWziVI4JrclktEhs2/ZHgd7Nfg9DNWx7Cw
 RoAmGdYApmHzjbZkXwz5qeu5i9rnquu7sDenm2vZmOhtKt6dTvQV7eLe3gcc7+y1xn9j
 gmL9rgaDECgo8KwwR7SDfSDBI4U7ZSGJ4Wc0XgZ4iSpqtOfB13quhAQYLNvjW0kSWJOQ
 5nbIfuFQZlWNqDn7kw+OgXWYnGEfglSKTQFcaOnQIIRYAv5IlLPcxZs218IG7idWdWa1
 CSOjIuEs55nVxQwtbqaYghaXuZ6CdYvjx1t6DtiDjEvPdvShRf1M4mxaLVfO/gpk+qUe
 JLbw==
X-Gm-Message-State: APjAAAWcQEnpEWVfRKEBDK6X1rvF0NjVcKkLAps8hvnv6iqdNdtIMk3n
 1Dt9VxrjZIxXe4TpWbX7QOON52XckMaY/iA2nncqXIKbP1dKvuWn+RfBVI46RLIwj9uzvWc3+kc
 ODMZdeHatafaRa5E=
X-Received: by 2002:a7b:c764:: with SMTP id x4mr16437547wmk.134.1568016123336; 
 Mon, 09 Sep 2019 01:02:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwiaF56z31uEmZEDx2JQQFkJRz5GQEQo3tIJ9pPgffEjC0jns3kn8OvF6uWIa/AIx8z+SjMiQ==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr16437529wmk.134.1568016123078; 
 Mon, 09 Sep 2019 01:02:03 -0700 (PDT)
Received: from steredhat (host170-61-dynamic.36-79-r.retail.telecomitalia.it.
 [79.36.61.170])
 by smtp.gmail.com with ESMTPSA id u22sm27117473wru.72.2019.09.09.01.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2019 01:02:02 -0700 (PDT)
Date: Mon, 9 Sep 2019 10:01:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Message-ID: <20190909080159.b3yj7tv26ce6ir3k@steredhat>
References: <20190907223841.20210-1-dmitry.fomichev@wdc.com>
 <20190907223841.20210-2-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907223841.20210-2-dmitry.fomichev@wdc.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 1/4] block: Add zoned device model
 property
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Sep 07, 2019 at 06:38:38PM -0400, Dmitry Fomichev wrote:
> This commit adds Zoned Device Model (as defined in T10 ZBC and
> T13 ZAC standards) as a block driver property, along with some
> useful access functions.
> 
> A new backend driver permission, BLK_PERM_SUPPORT_HM_ZONED, is also
> introduced. Only the drivers having this permission will be allowed
> to open host managed zoned block devices.
> 
> No code is added yet to initialize or check the value of this new
> property, therefore this commit doesn't change any functionality.
> 
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block.c                   | 37 +++++++++++++++++++++++++++----------
>  include/block/block.h     | 21 +++++++++++++++++++--
>  include/block/block_int.h |  3 +++
>  qapi/block-core.json      |  5 ++++-
>  4 files changed, 53 insertions(+), 13 deletions(-)
> 

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


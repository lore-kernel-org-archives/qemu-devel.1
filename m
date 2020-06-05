Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF9AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A09206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVh6ieEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A09206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh6mg-0005fz-Fv
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 03:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jh6m6-0004vQ-1A
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:28:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20750
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jh6m5-0002yi-99
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591342100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IIIxZWQXG0yrPH7d0TtpTldM2J7wjIF0QkyNtFWKSKA=;
 b=eVh6ieEeyfNyu7UDCFTLVqfGY3v1qGWJk+AL8UaVX2axmSCdC+zOEcn/fTxpAgDxwFOwt/
 E90maEImURYlNWbwMtmQQ9xRwZHfmVgs9wd1bnJvvow3PJksksbsKvQ22dmBAwIfJe9e3S
 JUW7zivjiITNIH2PkpRmjMWsPbveEbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-rRa08lEhNPaQ3YLXGXLmvA-1; Fri, 05 Jun 2020 03:28:18 -0400
X-MC-Unique: rRa08lEhNPaQ3YLXGXLmvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E00621005510
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2020 07:28:17 +0000 (UTC)
Received: from gondolin (ovpn-113-2.ams2.redhat.com [10.36.113.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36F1A62ABC;
 Fri,  5 Jun 2020 07:28:17 +0000 (UTC)
Date: Fri, 5 Jun 2020 09:28:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] linux-headers: update to Linux 5.8-rc1
Message-ID: <20200605092814.086db16b.cohuck@redhat.com>
In-Reply-To: <20200604224148.2536-1-pbonzini@redhat.com>
References: <20200604224148.2536-1-pbonzini@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  4 Jun 2020 18:41:48 -0400
Paolo Bonzini <pbonzini@redhat.com> wrote:

Isn't it still a bit early for -rc1? :) Probably wants a commit id...

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/standard-headers/asm-x86/kvm_para.h |  17 ++-
>  include/standard-headers/drm/drm_fourcc.h   | 140 ++++++++++++++++++--
>  include/standard-headers/linux/ethtool.h    |  16 ++-
>  linux-headers/asm-arm/unistd-common.h       |   1 +
>  linux-headers/asm-arm64/mman.h              |   8 ++
>  linux-headers/asm-generic/unistd.h          |   4 +-
>  linux-headers/asm-mips/unistd_n32.h         |   1 +
>  linux-headers/asm-mips/unistd_n64.h         |   1 +
>  linux-headers/asm-mips/unistd_o32.h         |   1 +
>  linux-headers/asm-powerpc/unistd_32.h       |   1 +
>  linux-headers/asm-powerpc/unistd_64.h       |   1 +
>  linux-headers/asm-s390/unistd_32.h          |   1 +
>  linux-headers/asm-s390/unistd_64.h          |   1 +
>  linux-headers/asm-x86/kvm.h                 |  20 ++-
>  linux-headers/asm-x86/unistd.h              |  11 +-
>  linux-headers/asm-x86/unistd_32.h           |   1 +
>  linux-headers/asm-x86/unistd_64.h           |   1 +
>  linux-headers/asm-x86/unistd_x32.h          |   1 +
>  linux-headers/linux/kvm.h                   |  18 ++-
>  linux-headers/linux/psp-sev.h               |   2 +
>  20 files changed, 224 insertions(+), 23 deletions(-)

There will be more (e.g. on the vfio side); anything in particular you
need this update for?



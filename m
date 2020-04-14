Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BF7C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E5720575
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3k394ks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E5720575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOG94-0007Fj-1Q
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 03:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jOG7u-0006LT-IB
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jOG7t-0006Rb-Gu
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:36:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46208
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jOG7t-0006RO-Cz
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586849816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mId3KI05xyz9I2/MOsprFW1GtQjdFIeWOQi4bN9Jbuo=;
 b=c3k394ksLnH6g6JArYHdWD2epdtqCqlG0b054XBWqGZMR+QSNi3/CcomwvJrT0+ADxHe81
 1cOMz844C3OMnq8fOv4QEnHOMidEl4QPvQ7r7HQDbyw2pJRTMgsZChCSV2q+mfeuLj/gus
 uIhX9dmANKtatOMZzCIMgugZaTJXLRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-EkTGuq8zMLuTHjvy0_Xv5w-1; Tue, 14 Apr 2020 03:36:55 -0400
X-MC-Unique: EkTGuq8zMLuTHjvy0_Xv5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A26B8017F6
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 07:36:54 +0000 (UTC)
Received: from localhost (unknown [10.40.208.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 608B360BE1;
 Tue, 14 Apr 2020 07:36:52 +0000 (UTC)
Date: Tue, 14 Apr 2020 09:36:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 0/8] Misc patches for QEMU 5.0-rc3
Message-ID: <20200414093650.62ff8502@redhat.com>
In-Reply-To: <20200411130330.1993-1-pbonzini@redhat.com>
References: <20200411130330.1993-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Sat, 11 Apr 2020 09:03:22 -0400
Paolo Bonzini <pbonzini@redhat.com> wrote:

> The following changes since commit 53ef8a92eb04ee19640f5aad3bff36cd4a36c250:
> 
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200406' into staging (2020-04-06 12:36:45 +0100)
> 
> are available in the Git repository at:
> 
>   git://github.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 8c12bd8e32faf8c483cd96c1557899120bc67eea:
> 
>   module: increase dirs array size by one (2020-04-11 08:49:26 -0400)
> 
> ----------------------------------------------------------------
> Bugfixes, and reworking of the atomics documentation.
> 
> ----------------------------------------------------------------
> Alexander Duyck (1):
>       memory: Do not allow direct write access to rom_device regions
> 
> Bauerchen (1):
>       oslib-posix: take lock before qemu_cond_broadcast
> 
> Bruce Rogers (1):
>       module: increase dirs array size by one
> 
> Igor Mammedov (1):
>       vl.c: error out if -mem-path is used together with -M memory-backend

It seems one more patch was forgotten
 "[PATCH for-5.0 0/2] fix qemu crash with memory-backend-* prealloc=yes"


> 
> Olaf Hering (1):
>       piix: fix xenfv regression, add compat machine xenfv-4.2
> 
> Paolo Bonzini (3):
>       atomics: convert to reStructuredText
>       atomics: update documentation
>       rcu: do not mention atomic_mb_read/set in documentation
> 
>  docs/devel/atomics.rst               | 507 +++++++++++++++++++++++++++++++++++
>  docs/devel/atomics.txt               | 403 ----------------------------
>  docs/devel/index.rst                 |   1 +
>  docs/devel/rcu.txt                   |   4 +-
>  hw/i386/pc_piix.c                    |  19 +-
>  include/exec/memory.h                |   4 +-
>  roms/SLOF                            |   2 +-
>  softmmu/vl.c                         |   5 +
>  tests/qtest/device-introspect-test.c |   2 +-
>  tests/qtest/qom-test.c               |  42 +--
>  tests/qtest/test-hmp.c               |   2 +-
>  util/module.c                        |   2 +-
>  util/oslib-posix.c                   |   3 +
>  13 files changed, 548 insertions(+), 448 deletions(-)
>  create mode 100644 docs/devel/atomics.rst
>  delete mode 100644 docs/devel/atomics.txt



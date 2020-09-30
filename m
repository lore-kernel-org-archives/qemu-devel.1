Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA9AC4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5EB2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dshBnqSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5EB2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNe37-00034E-HD
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kNe1i-0001Lp-MG
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:28:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kNe1g-0007OD-3E
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:28:18 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601479694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gNpAgJi6Rdc8qz6EM5672Qh/ppwi6/9Jx86viah0Zco=;
 b=dshBnqSevpS0WU5jliA5wSea7NCO2GS4SzVMs/zrlS8pT0qdkzq9/4dCLJ9i+j1Lp2qfaS
 JUSUWQsEbNSrWhUYWdSEljcmc5iUXk4/HmeK9aemQaMXj/PpHo5NIc4uuu9p8oIMjm346R
 OM1iK//75VAOV+sredGuRh/FCCzuRJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-9lKRz2-TOCC7YTpftQfayQ-1; Wed, 30 Sep 2020 11:28:11 -0400
X-MC-Unique: 9lKRz2-TOCC7YTpftQfayQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA72B2FD12;
 Wed, 30 Sep 2020 15:28:09 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 177915C1CF;
 Wed, 30 Sep 2020 15:28:07 +0000 (UTC)
Date: Wed, 30 Sep 2020 17:28:05 +0200
From: Andrew Jones <drjones@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 13/13] qemu/atomic.h: rename atomic_ to qatomic_
Message-ID: <20200930152805.tycn6lcm4qx74phi@kamzik.brq.redhat.com>
References: <20200923161031.69474-1-stefanha@redhat.com>
 <20200923161031.69474-14-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200923161031.69474-14-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 23, 2020 at 05:10:31PM +0100, Stefan Hajnoczi wrote:
> clang's C11 atomic_fetch_*() functions only take a C11 atomic type
> pointer argument. QEMU uses direct types (int, etc) and this causes a
> compiler error when a QEMU code calls these functions in a source file
> that also included <stdatomic.h> via a system header file:
> 
>   $ CC=clang CXX=clang++ ./configure ... && make
>   ../util/async.c:79:17: error: address argument to atomic operation must be a pointer to _Atomic type ('unsigned int *' invalid)
> 
> Avoid using atomic_*() names in QEMU's atomic.h since that namespace is
> used by <stdatomic.h>. Prefix QEMU's APIs with 'q' so that atomic.h
> and <stdatomic.h> can co-exist. I checked /usr/include on my machine and
> searched GitHub for existing "qatomic_" users but there seem to be none.
> 
> This patch was generated using:
> 
>   $ git grep -h -o '\<atomic\(64\)\?_[a-z0-9_]\+' include/qemu/atomic.h | \
>     sort -u >/tmp/changed_identifiers
>   $ for identifier in $(</tmp/changed_identifiers); do
>         sed -i "s%\<$identifier\>%q$identifier%g" \
>             $(git grep -I -l "\<$identifier\>")
>     done
> 
> I manually fixed line-wrap issues and misaligned rST tables.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20200923105646.47864-1-stefanha@redhat.com>
> ---
>  include/qemu/atomic.h                         | 248 +++++++++---------
>  docs/devel/lockcnt.txt                        |   8 +-
>  docs/devel/rcu.txt                            |  34 +--
>  accel/tcg/atomic_template.h                   |  20 +-
>  include/block/aio-wait.h                      |   4 +-
>  include/block/aio.h                           |   8 +-
>  include/exec/cpu_ldst.h                       |   2 +-
>  include/exec/exec-all.h                       |   6 +-
>  include/exec/log.h                            |   6 +-
>  include/exec/memory.h                         |   2 +-
>  include/exec/ram_addr.h                       |  26 +-
>  include/exec/ramlist.h                        |   2 +-
>  include/exec/tb-lookup.h                      |   4 +-
>  include/hw/core/cpu.h                         |   2 +-
>  include/qemu/atomic128.h                      |   6 +-
>  include/qemu/bitops.h                         |   2 +-
>  include/qemu/coroutine.h                      |   2 +-
>  include/qemu/log.h                            |   6 +-
>  include/qemu/queue.h                          |   7 +-
>  include/qemu/rcu.h                            |  10 +-
>  include/qemu/rcu_queue.h                      | 100 +++----
>  include/qemu/seqlock.h                        |   8 +-
>  include/qemu/stats64.h                        |  28 +-
>  include/qemu/thread.h                         |  24 +-
>  .../infiniband/hw/vmw_pvrdma/pvrdma_ring.h    |  14 +-

Hi Stefan,

pvrdma_ring.h is an update-linux-headers.sh file. When running the
script again we lose the atomic_ to qatomic_ renaming. I've hacked
the script by adding

 -e 's/\batomic_read/qatomic_read/g;s/\batomic_set/qatomic_set/g'

to the cp_portable() sed command, but only considering the two
qatomic_ functions currently used is obviously not a complete
solution.

Any ideas?

Thanks,
drew



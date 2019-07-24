Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505B5C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27D872070B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D872070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqIN7-0002UA-7X
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 10:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60191)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqIMg-0001NQ-JS
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqIMe-0007kk-7t
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:35:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqIMd-0007jd-Us
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:35:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so22190204wrr.4
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 07:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2KUjTigwt2mtR1V5Y+Szcxui5Up8chSwr1BDCz8FuHk=;
 b=q3hv+ohUKeBIl9d1/jkz5H+Fub1JlkGuxPiIV9MltWe99u4338x0Ud1x3BOAGzI+YT
 xkszZkz+hvjxCCLkY7q5xDBvjbROb/FKozW330dRRBQ65IkrGcF6MtgUV5r2FwThlW/k
 ECmR1fyg4zbuSGI0jZP4KKSSLfXPhg8VEEyTbAGrYxiu73zNNqY/ksbaqj60ONXLWVJm
 O47aay2p2bJCcm6gRRZDBDRGqKC5I58yYIMoU7/g0/VUHOPZlQ7dOyl0Q8XuPiQGXhXl
 bHw3sPFfvI9XlvhzODoPlMSkoTrzdPIBP+e5sKAnOwTffIrRFX8wBz4vRVuesTsCUiIG
 vwVQ==
X-Gm-Message-State: APjAAAWx05u3w7tFe/RyOATLRSQ7VNEMHcNaVsjjTkLBMFF8qcAjwPvq
 OED2oolzO9I2FpQGbnBVY50PpA==
X-Google-Smtp-Source: APXvYqwchfrhDLFK00RltxlTb3Bvc/3gNSqQr4vYtXyL6fP6oSArDFfPDTSugXQmFsbrEa3of/UskA==
X-Received: by 2002:adf:e8c2:: with SMTP id k2mr73240493wrn.198.1563978930493; 
 Wed, 24 Jul 2019 07:35:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:10f7:67c8:abb4:8512?
 ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
 by smtp.gmail.com with ESMTPSA id w7sm54515538wrn.11.2019.07.24.07.35.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2019 07:35:29 -0700 (PDT)
To: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <156395778867.510.17588721322993616668.stgit@pasha-Precision-3630-Tower>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <83f7a43a-3039-0ac2-e7c7-5e802811d431@redhat.com>
Date: Wed, 24 Jul 2019 16:35:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156395778867.510.17588721322993616668.stgit@pasha-Precision-3630-Tower>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH for-4.2 00/14] Some record/replay fixes
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 crosthwaite.peter@gmail.com, armbru@redhat.com, mreitz@redhat.com,
 alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com, dgilbert@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/07/19 10:43, Pavel Dovgalyuk wrote:
> The set of patches include the latest fixes for record/replay icount function:
>  - fix for icount for the case when translation blocks are chained
>  - block operation fixes for rr mode
>  - development documentation update
>  - some refactoring
> 
> These patches make record/replay functional on the latest 4.2 QEMU core.
> 
> ---
> 
> Pavel Dovgalyuk (13):
>       block: implement bdrv_snapshot_goto for blkreplay
>       replay: disable default snapshot for record/replay
>       replay: update docs for record/replay with block devices
>       replay: don't drain/flush bdrv queue while RR is working
>       replay: finish record/replay before closing the disks
>       replay: provide an accessor for rr filename
>       replay: add BH oneshot event for block layer
>       replay: document development rules
>       util/qemu-timer: refactor deadline calculation for external timers
>       replay: fix replay shutdown
>       replay: refine replay-time module
>       replay: rename step-related variables and functions
>       icount: clean up cpu_can_io before jumping to the next block
> 
> pbonzini@redhat.com (1):
>       replay: add missing fix for internal function
> 
> 
>  accel/tcg/tcg-runtime.c   |    2 ++
>  block/blkreplay.c         |    8 ++++++++
>  block/block-backend.c     |    8 +++++---
>  block/io.c                |   32 +++++++++++++++++++++++++++++--
>  block/iscsi.c             |    5 +++--
>  block/nfs.c               |    5 +++--
>  block/null.c              |    4 +++-
>  block/nvme.c              |    6 ++++--
>  block/rbd.c               |    5 +++--
>  block/vxhs.c              |    5 +++--
>  cpus.c                    |   11 ++++-------
>  docs/devel/replay.txt     |   46 +++++++++++++++++++++++++++++++++++++++++++++
>  docs/replay.txt           |   12 +++++++++---
>  include/qemu/timer.h      |    7 +++----
>  include/sysemu/replay.h   |    7 ++++++-
>  qtest.c                   |    2 +-
>  replay/replay-events.c    |   18 +++++++++++++++++-
>  replay/replay-internal.c  |   10 +++++-----
>  replay/replay-internal.h  |   11 ++++++-----
>  replay/replay-snapshot.c  |    6 +++---
>  replay/replay-time.c      |   36 ++++++++++++++++-------------------
>  replay/replay.c           |   39 +++++++++++++++++++++++---------------
>  stubs/Makefile.objs       |    1 +
>  stubs/replay-user.c       |    9 +++++++++
>  tests/ptimer-test-stubs.c |    4 ++--
>  tests/ptimer-test.c       |    4 ++--
>  util/qemu-timer.c         |   41 ++++++++++++++++++++++++++++++++--------
>  vl.c                      |   11 +++++++++--
>  28 files changed, 259 insertions(+), 96 deletions(-)
>  create mode 100644 docs/devel/replay.txt
>  create mode 100644 stubs/replay-user.c
> 

Please separate patches 1 and 9-14, I can merge those.

Paolo


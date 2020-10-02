Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B5AC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 335B82074B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CaO9SmRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335B82074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONIt-0001d9-Cu
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kON9n-0001Rk-Mr
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kON9l-0003iM-GM
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601653176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQ9LLqXPSgdpZ+Y9rpUKcKengKscn7IuT+g4aoCrgRM=;
 b=CaO9SmRhOfoMKMyhMT1pK1h/jfIsrxAbQDcXOFvc7mrhAvkJxI2KfUJl56i44/smSN7Bdf
 Auu600R+RLeCyWfiNWorSHH4MyMh+GGmlVXn+HHuNH+zDijf8UgWrkN5qox+OF24u6SgnD
 Xvgq1QE55j/eb1wzU4FJql2cSpCeKcE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-ll-DsocDP9GqbC-JHOj9aQ-1; Fri, 02 Oct 2020 11:39:34 -0400
X-MC-Unique: ll-DsocDP9GqbC-JHOj9aQ-1
Received: by mail-wr1-f72.google.com with SMTP id y3so684244wrl.21
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 08:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zQ9LLqXPSgdpZ+Y9rpUKcKengKscn7IuT+g4aoCrgRM=;
 b=dpBGyZVdNpBSZ1eSykCB/VXSdTPl1V3OkXa6CZwnNLBxcPdohE1U2Iqa2QS8YY2qNK
 zZjJWckx+2+Bo4JVWYEQ0ErOcscAAwH0FHtv9unuMnPrgcbMVJyeE+Gqe3qYS+8VcLEG
 Hgtz2OqBExrU224twikRZ+x1R4Y/vWC5UkrmfBcdIMc4IcodDtB1VtBHc8PX2n1g4z9f
 1x4NXWfrVuaeQ5B8PBwhkgZBYo4S3E5JML33h/IPJ0u+slIGhEywVMUewWZ2G75PBNTp
 d7Vso6nJ9iBps3v6yLuPWW0o5yld9PqYMU0/lnGtpQY6Ggrli+OcZjy6Yt32JVLkq/iF
 bxCg==
X-Gm-Message-State: AOAM530cxRYob31UalHVbtr+0l4LODB0GP5QPrh+wvdiQfrTJ38hoe6R
 nIXxb2qDCZX2DrKhz9IqLG47r6vyrCVbLpvdgX4VAoTdQcFl+5ElU3UaDtmWSz7An4aM7ZUg2ys
 0CJpecZ8tKdozWhY=
X-Received: by 2002:adf:f5c7:: with SMTP id k7mr3897158wrp.246.1601653172238; 
 Fri, 02 Oct 2020 08:39:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwm0JBVCwe8jPHYFBuqAj1HYp6fYwtusTCGm6AUiirwArStJqluHa7uIe5ZKfdA58i6VAfQAQ==
X-Received: by 2002:adf:f5c7:: with SMTP id k7mr3897122wrp.246.1601653171919; 
 Fri, 02 Oct 2020 08:39:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:47e0:e742:75ba:b84d?
 ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id n66sm2175611wmb.35.2020.10.02.08.39.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 08:39:29 -0700 (PDT)
Subject: Re: [PATCH v6 00/14] Reverse debugging
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <160137726426.31007.12061315974029139983.stgit@pasha-ThinkPad-X280>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74dc59b1-7a2b-4f6b-a022-3d796f86b9c7@redhat.com>
Date: Fri, 2 Oct 2020 17:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <160137726426.31007.12061315974029139983.stgit@pasha-ThinkPad-X280>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, ehabkost@redhat.com, philmd@redhat.com,
 mtosatti@redhat.com, stefanha@redhat.com, armbru@redhat.com, mreitz@redhat.com,
 wrampazz@redhat.com, crosa@redhat.com, alex.bennee@linaro.org,
 zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/09/20 13:01, Pavel Dovgalyuk wrote:
> GDB remote protocol supports reverse debugging of the targets.
> It includes 'reverse step' and 'reverse continue' operations.
> The first one finds the previous step of the execution,
> and the second one is intended to stop at the last breakpoint that
> would happen when the program is executed normally.
> 
> Reverse debugging is possible in the replay mode, when at least
> one snapshot was created at the record or replay phase.
> QEMU can use these snapshots for travelling back in time with GDB.
> 
> Running the execution in replay mode allows using GDB reverse debugging
> commands:
>  - reverse-stepi (or rsi): Steps one instruction to the past.
>    QEMU loads on of the prior snapshots and proceeds to the desired
>    instruction forward. When that step is reaches, execution stops.
>  - reverse-continue (or rc): Runs execution "backwards".
>    QEMU tries to find breakpoint or watchpoint by loaded prior snapshot
>    and replaying the execution. Then QEMU loads snapshots again and
>    replays to the latest breakpoint. When there are no breakpoints in
>    the examined section of the execution, QEMU finds one more snapshot
>    and tries again. After the first snapshot is processed, execution
>    stops at this snapshot.
> 
> The set of patches include the following modifications:
>  - gdbstub update for reverse debugging support
>  - functions that automatically perform reverse step and reverse
>    continue operations
>  - hmp/qmp commands for manipulating the replay process
>  - improvement of the snapshotting for saving the execution step
>    in the snapshot parameters
>  - avocado-based acceptance tests for reverse debugging
> 
> The patches are available in the repository:
> https://github.com/ispras/qemu/tree/rr-200901

Hi Pavel,

I'm still seeing failures in "make check-block":

https://gitlab.com/bonzini/qemu/-/jobs/769653852

Paolo

> v6 changes:
>  - removed passing err variable without checking it's value after
> v5 changes:
>  - disabled reverse debugging tests for gitlab-based testing
>    due to the unidentified timeout problem
> v4 changes:
>  - added VM snapshot creation on gdb connect (suggested by Alex Bennée)
>  - removed useless calls to error_free
>  - updated poll interrupt processing
>  - minor changes
> v3 changes:
>  - rebased to support the new build system
>  - bumped avocado framework version for using fixed remote gdb client
> v2 changes:
>  - rebased to the latest upstream version
>  - fixed replaying of the POLL interrupts after the latest debug changes
> 
> ---
> 
> Pavel Dovgaluk (11):
>       replay: provide an accessor for rr filename
>       qcow2: introduce icount field for snapshots
>       qapi: introduce replay.json for record/replay-related stuff
>       replay: introduce info hmp/qmp command
>       replay: introduce breakpoint at the specified step
>       replay: implement replay-seek command
>       replay: flush rr queue before loading the vmstate
>       gdbstub: add reverse step support in replay mode
>       gdbstub: add reverse continue support in replay mode
>       replay: describe reverse debugging in docs/replay.txt
>       tests/acceptance: add reverse debugging test
> 
> Pavel Dovgalyuk (3):
>       replay: don't record interrupt poll
>       migration: introduce icount field for snapshots
>       replay: create temporary snapshot at debugger connection
> 
> 
>  MAINTAINERS                           |    2 
>  accel/tcg/cpu-exec.c                  |   21 ++
>  accel/tcg/translator.c                |    1 
>  block/qapi.c                          |   18 +-
>  block/qcow2-snapshot.c                |    9 +
>  block/qcow2.h                         |    3 
>  blockdev.c                            |   10 +
>  docs/interop/qcow2.txt                |    5 
>  docs/replay.txt                       |   46 +++++
>  exec.c                                |    8 +
>  gdbstub.c                             |   64 ++++++
>  hmp-commands-info.hx                  |   11 +
>  hmp-commands.hx                       |   50 +++++
>  include/block/snapshot.h              |    1 
>  include/monitor/hmp.h                 |    4 
>  include/sysemu/replay.h               |   26 +++
>  migration/savevm.c                    |   17 +-
>  qapi/block-core.json                  |   11 +
>  qapi/meson.build                      |    1 
>  qapi/misc.json                        |   18 --
>  qapi/qapi-schema.json                 |    1 
>  qapi/replay.json                      |  121 ++++++++++++
>  replay/meson.build                    |    1 
>  replay/replay-debugging.c             |  332 +++++++++++++++++++++++++++++++++
>  replay/replay-events.c                |    4 
>  replay/replay-internal.h              |    6 -
>  replay/replay.c                       |   22 ++
>  softmmu/cpus.c                        |   19 ++
>  stubs/replay.c                        |   15 +
>  tests/acceptance/reverse_debugging.py |  208 +++++++++++++++++++++
>  tests/qemu-iotests/267.out            |   48 ++---
>  31 files changed, 1039 insertions(+), 64 deletions(-)
>  create mode 100644 qapi/replay.json
>  create mode 100644 replay/replay-debugging.c
>  create mode 100644 tests/acceptance/reverse_debugging.py
> 
> --
> Pavel Dovgalyuk
> 



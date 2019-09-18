Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A2BC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EDD3214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kjefUP0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDD3214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAXQb-0005Bo-FX
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 06:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAXPr-0004hZ-Bn
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAXPp-0005GV-Oy
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:42:31 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42415)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAXPp-0005G8-HB
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:42:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id n14so5466310wrw.9
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 03:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=004wkyAyw5kt9LMTEOWsclWWolBnx7Z9+qMK4Qt0XFo=;
 b=kjefUP0MnoW0z+YDPTpaCVoSS+wq6CQwoixG7dUCk332qp5VSs9fucypv+o1DWbfh8
 eak+g/6msrp4vumakgqamNrYVh385KDY9Yy32K4VSLoKyKdLVU3nJjOk0FShRsKPSchH
 a2b5j/D7ZQNJBlOfEZjXLh9HEM/9yrMSfsVAbxNH51lJtnaESxB4kFW/eR+7LtdnxWeZ
 7LUT7zT5pmhCajDWIxQ5I61YUzspqKmc608VVN5iYCBZSnXR7NdUYa3mfMdwwVq6h+vd
 GpNlkKVdgQGq1l/H6eyGr775VIi39v03CDketTEZka8nLGETkKPitn8rmHU1saDoWujS
 1AIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=004wkyAyw5kt9LMTEOWsclWWolBnx7Z9+qMK4Qt0XFo=;
 b=ruNXfTUO5gNRBlUckGsRX68REATR+aXpe0e5blkxHtact0+ZcYANoNcaEkH0G6QDBL
 uTXqsYp8ssQTkqvDsFqFiI/Y+rXVAtSb0Wx81A+47Mj4saU9K9kzAacLPSA9Ta1njYCa
 she/K66op8ZHB3Q0u/OEhmgfUS68HrWtD434/m3s4cP8GBOUUUvzZakWscZ2jzpavPgN
 rdr+POJPEH9PdZiKjHzTTVj4rhlCPKMwgyCg0uzTEkTjeP8DGb6VKO4IpE6vL+IM40Sm
 s7ixA6ZHq+9qQhsKRY4YHz9fe0tAyg+L689p4e2F4DCf6nh2ap7edPM7ZHQJpywjzPcw
 ntPA==
X-Gm-Message-State: APjAAAVpjaLDM3459oWWLYkQn1Fg1A6BlamZn7iBLghimlzznesvt1ge
 povLrCX3RCtsNduLKUgWEbHlEg==
X-Google-Smtp-Source: APXvYqyr8Bhggyfs75EjLckn/A9/bFVe/4+k17ncYDSCyiuQ7GwEpaKBGV68NTTqUaRD9rkeHoBkPg==
X-Received: by 2002:adf:f150:: with SMTP id y16mr2347159wro.71.1568803348019; 
 Wed, 18 Sep 2019 03:42:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b16sm8252104wrh.5.2019.09.18.03.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 03:42:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 787731FF87;
 Wed, 18 Sep 2019 11:42:26 +0100 (BST)
References: <156872146565.1757.3033215873677512474.stgit@pasha-Precision-3630-Tower>
 <87blvi21cz.fsf@linaro.org> <001101d56dfa$bef4e630$3cdeb290$@ru>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
In-reply-to: <001101d56dfa$bef4e630$3cdeb290$@ru>
Date: Wed, 18 Sep 2019 11:42:26 +0100
Message-ID: <8736gt28dp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [for-4.2 PATCH 0/6] Block-related record/replay
 fixes
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
 crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com,
 boost.lists@gmail.com, thomas.dullien@googlemail.com, pbonzini@redhat.com,
 mreitz@redhat.com, artem.k.pisarenko@gmail.com, dgilbert@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

>> -----Original Message-----
>> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
>> Sent: Tuesday, September 17, 2019 10:02 PM
>> To: Pavel Dovgalyuk
>> Cc: qemu-devel@nongnu.org; kwolf@redhat.com; peter.maydell@linaro.org;
>> crosthwaite.peter@gmail.com; boost.lists@gmail.com; artem.k.pisarenko@gm=
ail.com;
>> quintela@redhat.com; ciro.santilli@gmail.com; jasowang@redhat.com; mst@r=
edhat.com;
>> armbru@redhat.com; mreitz@redhat.com; maria.klimushenkova@ispras.ru; dov=
galuk@ispras.ru;
>> kraxel@redhat.com; pavel.dovgaluk@ispras.ru; thomas.dullien@googlemail.c=
om;
>> pbonzini@redhat.com; dgilbert@redhat.com; rth@twiddle.net
>> Subject: Re: [for-4.2 PATCH 0/6] Block-related record/replay fixes
>>
>>
>> Pavel Dovgalyuk <pavel.dovgaluk@gmail.com> writes:
>>
>> > The set of patches include the block-related updates
>> > of the record/replay icount feature:
>> >  - application of 'snapshot' option on the file layer instead of
>> >    the top one: command line and documentation fix
>> >  - implementation of bdrv_snapshot_goto for blkreplay driver
>> >  - start/stop fix in replay mode with attached block devices
>> >  - record/replay of bh oneshot events, used in the block layer
>>
>> Can we come up with a reasonable smoke test to verify record/replay is
>> functional? AIUI we don't need a full OS but we do need a block device
>> to store the replay data. Could we use one of the simple system tests
>> like "memory" and run that through a record and replay cycle?
>
> That's would be great.
> I'm not familiar with testing framework and couldn't find "memory"
> test that you refer to.

The memory test code is in tests/tcg/multiarch/system and gets combined
with the boot code for whichever target can build it. For example on
aarch64 it is run like:

  timeout 15  $BLD/aarch64-softmmu/qemu-system-aarch64 -monitor none -displ=
ay none -chardev file,path=3Dmemory.out,id=3Doutput  -M virt -cpu max -disp=
lay none -semihosting-config enable=3Don,target=3Dnative,chardev=3Doutput -=
kernel memory

The test binaries will be in $BLD/tests/tcg/aarch64-softmmu and are
built when you run "make check-tcg" and have either the appropriate
cross compilers installed on your system or docker enabled and setup
(see docs/devel/testing.rst).

> Replay test must at least the following:
> 1. record some execution
> 2. replay that execution
>
> And there could be several endings:
> 1. record stalled
> 2. record crashed
> 3. replay stalled
> 4. replay crashed
> 5. all executions finished successfully

If you can provide an appropriate set of invocations I can plumb them
into the Makefiles for you.

>
> Pavel Dovgalyuk
>
>>
>> >
>> > ---
>> >
>> > Pavel Dovgaluk (6):
>> >       block: implement bdrv_snapshot_goto for blkreplay
>> >       replay: disable default snapshot for record/replay
>> >       replay: update docs for record/replay with block devices
>> >       replay: don't drain/flush bdrv queue while RR is working
>> >       replay: finish record/replay before closing the disks
>> >       replay: add BH oneshot event for block layer
>> >
>> >
>> >  block/blkreplay.c        |    8 ++++++++
>> >  block/block-backend.c    |    9 ++++++---
>> >  block/io.c               |   32 ++++++++++++++++++++++++++++++--
>> >  block/iscsi.c            |    5 +++--
>> >  block/nfs.c              |    6 ++++--
>> >  block/null.c             |    4 +++-
>> >  block/nvme.c             |    6 ++++--
>> >  block/rbd.c              |    5 +++--
>> >  block/vxhs.c             |    5 +++--
>> >  cpus.c                   |    2 --
>> >  docs/replay.txt          |   12 +++++++++---
>> >  include/sysemu/replay.h  |    4 ++++
>> >  replay/replay-events.c   |   16 ++++++++++++++++
>> >  replay/replay-internal.h |    1 +
>> >  replay/replay.c          |    2 ++
>> >  stubs/Makefile.objs      |    1 +
>> >  stubs/replay-user.c      |    9 +++++++++
>> >  vl.c                     |   11 +++++++++--
>> >  18 files changed, 115 insertions(+), 23 deletions(-)
>> >  create mode 100644 stubs/replay-user.c
>>
>>
>> --
>> Alex Benn=C3=A9e


--
Alex Benn=C3=A9e


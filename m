Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEF3C33CAE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0EF2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LDKumHN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0EF2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir3Ga-00079x-26
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 12:12:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ir3F9-0005Gi-2A
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ir3F7-0003GE-HF
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:11:10 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44353)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ir3F7-0003Ex-8a
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:11:09 -0500
Received: by mail-wr1-x444.google.com with SMTP id q10so9400090wrm.11
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 09:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=LIieePK8Rp4gOfbOThvtrc9z57kZvlxPFu5ZiFQaxTE=;
 b=LDKumHN6PKpvpYDJtYmcGa3t8U/7GYwLvX2jD5nlTllZ6ESou53gouQS1E83wOpv2J
 7ENt/uXDrQ9LucaDzJQBgXDXfbAQNiG3SW7r6gb+NninqQ94AgRMoQASLZLnvq8/mD45
 nQffRBhdFEL7X7SSuMFRoLaRxI/xZgTDejNmEOd3clE3v6sbRsoIz6hPRW+x6JpGMtF/
 /GKHT8Uunx6/bJlal7XhO8CWfeyHMN2dwhVaMS5Txl6s68+AhYt9S6cSyjwkpaClNdUq
 0Erk5BaUInHEfImDqO4Dok6ntYAvXxtliWaHI+kP4vu+r5zthZwLGGtRQdj/9GFL9Ade
 /NQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=LIieePK8Rp4gOfbOThvtrc9z57kZvlxPFu5ZiFQaxTE=;
 b=jpzUmtZCHwegXumLVON26WKhK4oE+yxfUMv5Dn8d8cDPU0quz9GafS+CSj8TnzgpKs
 G/8ZCM82POnV7RJ4y1goUKsg+UIXvoBky7u/NJa/8VqL99s4vZov1FnwBLirurO8dHxT
 8GQjua6obATr1JUQOlAa4Vxlk7vwMEU0QGU6HkA1iTaGHhbLOIY3rlMvNpZ4IqQCwgiu
 Ty0tPV+V6Waq2a7tSD9FkVxfHMpAT3SEBTqMw3TcSkP70LDwEijDvlcvFSfkl78+ygc1
 xQpWjKlmPedbg6N4CopIjGRT6HdM5PDa3G7Scqkc7jDtx4ADSBodAPQZMOLa1+DN8VC9
 frFg==
X-Gm-Message-State: APjAAAWRJ3yXgKpBPzisTIpioEb/uQtAqs4Gb2WiIMTD0tDSaY6ZcuB3
 jHqhOSchV7n8N2RS0KwYDR8/Uw==
X-Google-Smtp-Source: APXvYqxZkLHwWI5se9nT4mWfKh8piwgInlCji20CXwSiOzAuPzOYohKGwwwoRh04y0PLzddnrclnfg==
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr19773503wru.40.1578935467350; 
 Mon, 13 Jan 2020 09:11:07 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x7sm15360468wrq.41.2020.01.13.09.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 09:11:06 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 564171FF87;
 Mon, 13 Jan 2020 17:11:05 +0000 (GMT)
References: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
 <157709442133.12933.4291167191595240519.stgit@pasha-Precision-3630-Tower>
 <20200109115918.GC9504@linux.fritz.box>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [for-5.0 PATCH 03/11] migration: introduce icount field for
 snapshots
In-reply-to: <20200109115918.GC9504@linux.fritz.box>
Date: Mon, 13 Jan 2020 17:11:05 +0000
Message-ID: <878smbnuxi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com,
 crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>, maria.klimushenkova@ispras.ru,
 mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com,
 thomas.dullien@googlemail.com, dovgaluk@ispras.ru, mreitz@redhat.com,
 artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Kevin Wolf <kwolf@redhat.com> writes:

> Am 23.12.2019 um 10:47 hat Pavel Dovgalyuk geschrieben:
>> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>>=20
>> Saving icount as a parameters of the snapshot allows navigation between
>> them in the execution replay scenario.
>> This information can be used for finding a specific snapshot for proceed=
ing
>> the recorded execution to the specific moment of the time.
>> E.g., 'reverse step' action (introduced in one of the following patches)
>> needs to load the nearest snapshot which is prior to the current moment
>> of time.
>>=20
>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>
> Acked-by: Kevin Wolf <kwolf@redhat.com>

Apologies my mailer ignored my replay-all:=20

This commit breaks when of the iotests for me:

 git bisect run /bin/sh -c "cd builds/all && make -j4 \
     && cd tests/qemu-iotests && ./check -qcow2 267"
=20

Gives:

  make[1]: Entering directory '/home/alex.bennee/lsrc/qemu.git/slirp'
  make[1]: Nothing to be done for 'all'.
  make[1]: Leaving directory '/home/alex.bennee/lsrc/qemu.git/slirp'
  QEMU          -- "/home/alex.bennee/lsrc/qemu.git/builds/all/tests/qemu-i=
otests/../../x86_64-softmmu/qemu-system-x86_64" -nodefaults -display none -=
accel qtest
  QEMU_IMG      -- "/home/alex.bennee/lsrc/qemu.git/builds/all/tests/qemu-i=
otests/../../qemu-img"
  QEMU_IO       -- "/home/alex.bennee/lsrc/qemu.git/builds/all/tests/qemu-i=
otests/../../qemu-io"  --cache writeback -f qcow2
  QEMU_NBD      -- "/home/alex.bennee/lsrc/qemu.git/builds/all/tests/qemu-i=
otests/../../qemu-nbd"
  IMGFMT        -- qcow2 (compat=3D1.1)
  IMGPROTO      -- file
  PLATFORM      -- Linux/x86_64 hackbox2 4.15.0-66-generic
  TEST_DIR      -- /home/alex.bennee/lsrc/qemu.git/builds/all/tests/qemu-io=
tests/scratch
  SOCK_DIR      -- /tmp/tmp.NV0n5HqCUs
  SOCKET_SCM_HELPER -- /home/alex.bennee/lsrc/qemu.git/builds/all/tests/qem=
u-iotests/socket_scm_helper

  267      fail       [12:17:36] [12:17:38]      (last: 1s)    output misma=
tch (see 267.out.bad)
  --- /home/alex.bennee/lsrc/qemu.git/tests/qemu-iotests/267.out  2019-10-3=
1 10:46:30.559805129 +0000
  +++ /home/alex.bennee/lsrc/qemu.git/builds/all/tests/qemu-iotests/267.out=
.bad   2020-01-13 12:17:38.096181947 +0000
  @@ -33,7 +33,7 @@
   (qemu) savevm snap0
   (qemu) info snapshots
   List of snapshots present on all disks:
  -ID        TAG                 VM SIZE                DATE       VM CLOCK
  +ID        TAG               VM SIZE                DATE     VM CLOCK    =
 ICOUNT
   --        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
   (qemu) loadvm snap0
   (qemu) quit
  @@ -44,7 +44,7 @@
   (qemu) savevm snap0
   (qemu) info snapshots
   List of snapshots present on all disks:
  -ID        TAG                 VM SIZE                DATE       VM CLOCK
  +ID        TAG               VM SIZE                DATE     VM CLOCK    =
 ICOUNT

But I've also seen:

  ERROR:/home/.../qemu.git/replay/replay-events.c:80:replay_flush_events:
     assertion failed: (replay_mutex_locked())

--=20
Alex Benn=C3=A9e


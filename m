Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B708C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 22:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3DA320833
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 22:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.fintelia.io header.i=@mg.fintelia.io header.b="oWJbAAVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DA320833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39131 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS7QR-0001QS-Vo
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 18:03:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49845)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<bounce+f6f2a2.b78a48-qemu-devel=nongnu.org@mg.fintelia.io>)
	id 1hS7PR-00016R-RR
	for qemu-devel@nongnu.org; Sat, 18 May 2019 18:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<bounce+f6f2a2.b78a48-qemu-devel=nongnu.org@mg.fintelia.io>)
	id 1hS7PQ-000334-N1
	for qemu-devel@nongnu.org; Sat, 18 May 2019 18:02:29 -0400
Received: from rs224.mailgun.us ([209.61.151.224]:47514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<bounce+f6f2a2.b78a48-qemu-devel=nongnu.org@mg.fintelia.io>)
	id 1hS7PQ-000323-D8
	for qemu-devel@nongnu.org; Sat, 18 May 2019 18:02:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.fintelia.io;
	q=dns/txt; 
	s=mailo; t=1558216948; h=Content-Type: Cc: To: Subject: Message-ID:
	Date: From: In-Reply-To: References: MIME-Version: Sender;
	bh=Pp1xobOlKYPYu4GqMuL7HZHsGc+tPWvefC6y7//3JSk=;
	b=oWJbAAVrDvqqo6/bGlpkhLxUroSIO9SDWbLETrrn93sSLB71iMPAgnmpXsQ8BfZz2rQ8z70U
	oNGUm6IrIe7vURoEihBg6+DDi9WBEDERBAFk4ODXKDmkVbiHP9KiPHJr/d5h8qjwSMaQ/9fZ
	RGU1AHq4r8PULoH5cZk1Nfs1/EU=
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyI4YWE2MyIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiYjc4YTQ4Il0=
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
	[209.85.208.170])
	by mxa.mailgun.org with ESMTP id 5ce07fc3.7f3cb94d3870-smtp-out-n03;
	Sat, 18 May 2019 21:57:23 -0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id h21so9173172ljk.13;
	Sat, 18 May 2019 14:57:22 -0700 (PDT)
X-Gm-Message-State: APjAAAUb9lJBCRBTdLqL/PkyeF4BX3QnRkN7LLoU0SxxOySh/59Ph0Ej
	1FnfOs1aNKEq9ylR5fjoOTIVTZm11zH+m9tqE20=
X-Google-Smtp-Source: APXvYqyesf0WgP0PT07q34zcA6cl75Sa5n1HpvcHEsjQEgHFwsHcdkSO6gYP0zXIvPv9B72Td0Z51CTei/tUb1tVsMs=
X-Received: by 2002:a2e:2bd7:: with SMTP id r84mr83167ljr.91.1558216641559;
	Sat, 18 May 2019 14:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190517222342.26394-1-jonathan@fintelia.io>
	<20190517222342.26394-3-jonathan@fintelia.io>
	<CAKmqyKMG6ffhQ5VYgLZ3XVfZ2-E_O9BH6UCanmLJ3awDDUfS_w@mail.gmail.com>
In-Reply-To: <CAKmqyKMG6ffhQ5VYgLZ3XVfZ2-E_O9BH6UCanmLJ3awDDUfS_w@mail.gmail.com>
From: Jonathan Behrens <jonathan@fintelia.io>
Date: Sat, 18 May 2019 17:56:55 -0400
X-Gmail-Original-Message-ID: <CANnJOVFE51rFdV0h0T6_dV6r37kBLcBQCo7Csg8NOUoYkOELpQ@mail.gmail.com>
Message-ID: <CANnJOVFE51rFdV0h0T6_dV6r37kBLcBQCo7Csg8NOUoYkOELpQ@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.61.151.224
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] target/riscv: Add support for
 -bios "firmware_filename" flag
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> I've never been fully convinced of this, why not just use the generic
loader?

If I understand you are proposing passing bbl (or other firmware) with the
-kernel flag, and then vmlinux (or another kernel) with the -initrd flag?
Wouldn't this result in losing the ability to pass a real init ramdisk to
Linux? It also seems to open the possibility for strange bugs/compatibility
issues later if firmware starts recognizing any "initrd" entries in the
device tree as kernel code to jump into.

I do wonder though how compatible the current design is with providing
default firmware for riscv in the future.

> This should be in a generic boot.c file and support added to all RISC-V
boards.

I can do this for v2.

Jonathan

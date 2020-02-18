Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EB6C34048
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365ED2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQ+foOCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365ED2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46Jo-0002r6-0c
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j46IZ-0001Mn-9p
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j46IW-0008VC-Sv
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:04:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22520
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j46IW-0008UT-J8
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582045475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2544dIPgl1aKA4Z7K5Z4971BiGCIl2iah54j9kjCL4E=;
 b=jQ+foOCpdzk/OuKQHEl11U0vf5OmKgQvDGsGEExgBS/Cq46aGeC9EhYQ3DQi+m944S7uvE
 WvXo6JMxrVbMXNjWbLsFst1yVMG76QpV03i1dBdUJpa0OVvcfpbjmkaDBR4PzGtAADAtrE
 WsqTYUlJPsn9YXdE4MdMCdPXvHo1pdc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-JtdlrZ7mPyGDNZnZ1MLvFg-1; Tue, 18 Feb 2020 12:04:30 -0500
Received: by mail-wm1-f72.google.com with SMTP id d4so304199wmd.7
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jf3dlEYrCzOw89Pny9+wuZ6snqo+K0B74r4yZz2W9gY=;
 b=sbvmumucBImlDIES0VpnOhGdhFYYFisoLEREICd3h8ocobSYzjgyZaGijL8BZWvAEF
 5ighwt40WjWvaoVo/06GpSQTYnC0hu5WrwJLUpOSpP64Bjq3Igy+BPvXf6O4Zg5mz5q1
 /gO+JfAYdPKlNAkZJwHxr5G8cz3m05A+NZewfDRY6wQhQFXVWC+/0iZJOHDqBdhS2R9r
 bIA9/7qQhO14wqPfwnfxIgntjQapcjKYPjW7Iu3AE82qltrG87w1/N1vBrhxs1tbbFYB
 sHp3/wsE2PSVuGofNwvP9+jN/Lkzoz1OYYUcvHaTo2ztsWLQXbCIW3WG6b7ybs77A4Zm
 3HDA==
X-Gm-Message-State: APjAAAWs/xGo50/8cBJ4xLi2SfOBbzuKXM3Bl7qPIMmeSwNHUpSM7yWE
 2Xim2ywZe4DLvzQb6oP2ElgFJ0tb9xIQIKFj3puUCTL1cAoMbPU6Zwd2PQjwMWNTtJWqhhYnCbj
 99eZJlER8Cqb6uGY=
X-Received: by 2002:adf:f80c:: with SMTP id s12mr30272985wrp.1.1582045469022; 
 Tue, 18 Feb 2020 09:04:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqyw9dUela3NtrkDeg0CyJlDb3coV6O3bBYGN64fh+CVkb+urV5Aj5z58vwpPB/Qnk2J8h/55A==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr30272937wrp.1.1582045468711; 
 Tue, 18 Feb 2020 09:04:28 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4?
 ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
 by smtp.gmail.com with ESMTPSA id a16sm7026333wrt.30.2020.02.18.09.04.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:04:28 -0800 (PST)
Subject: Re: [PATCH RESEND 00/13] trivial: Detect and remove superfluous
 semicolons in C code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200218094402.26625-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55411270-83ae-d6aa-362f-07018b44c0e1@redhat.com>
Date: Tue, 18 Feb 2020 18:04:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200218094402.26625-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: JtdlrZ7mPyGDNZnZ1MLvFg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Julia Suvorova <jusual@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/02/20 10:43, Philippe Mathieu-Daud=C3=A9 wrote:
> Luc noticed a superfluous trailing semicolon:
> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04593.html
>=20
> Prevent that by modifying checkpatch.pl and clean the codebase.
>=20
> Philippe Mathieu-Daud=C3=A9 (13):
>   scripts/checkpatch.pl: Detect superfluous semicolon in C code
>   audio/alsaaudio: Remove superfluous semicolons
>   block: Remove superfluous semicolons
>   block/io_uring: Remove superfluous semicolon
>   hw/arm/xlnx-versal: Remove superfluous semicolon
>   hw/m68k/next-cube: Remove superfluous semicolon
>   hw/scsi/esp: Remove superfluous semicolon
>   hw/vfio/display: Remove superfluous semicolon
>   migration/multifd: Remove superfluous semicolon
>   ui/input-barrier: Remove superfluous semicolon
>   target/i386/whpx: Remove superfluous semicolon
>   tests/qtest/libqos/qgraph: Remove superfluous semicolons
>   contrib/rdmacm-mux: Remove superfluous semicolon
>=20
>  audio/alsaaudio.c           | 4 ++--
>  block.c                     | 4 ++--
>  block/io_uring.c            | 2 +-
>  contrib/rdmacm-mux/main.c   | 2 +-
>  hw/arm/xlnx-versal-virt.c   | 2 +-
>  hw/m68k/next-cube.c         | 2 +-
>  hw/scsi/esp.c               | 2 +-
>  hw/vfio/display.c           | 2 +-
>  migration/multifd.c         | 2 +-
>  target/i386/whpx-all.c      | 2 +-
>  tests/qtest/libqos/qgraph.c | 4 ++--
>  ui/input-barrier.c          | 2 +-
>  scripts/checkpatch.pl       | 5 +++++
>  13 files changed, 20 insertions(+), 15 deletions(-)
>=20

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Laurent, can you queue this in qemu-trivial?



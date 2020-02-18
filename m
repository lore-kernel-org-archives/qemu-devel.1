Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66913C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF83206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fspnfxs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF83206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zMj-000612-Cp
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3zM0-0005FR-Jl
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3zLz-0003nZ-A5
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:39:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60782
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3zLz-0003n5-6y
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582018782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDpZh9t8LLET6RXRGhAckHvfEVt6l0LA4TOOOjdMTRY=;
 b=Fspnfxs31zPemJqZcLbCCEUiK4iMqizuQvoY9YcMUtNYs4YO21YCkQzjHvZFd95vbu44ND
 vCaTU8d721l1bFT81LNtfaOsHH2Ddqi/XgZAFsWp3LB1D5bILl4NT0vijdXlpiMALHYv40
 3GljM5fD8gvgyCjuKdC6WxvlGrxoeKo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-H0_eOoyzNdeWIF-YDD7h7w-1; Tue, 18 Feb 2020 04:39:41 -0500
Received: by mail-wm1-f71.google.com with SMTP id f207so872818wme.6
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:39:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1g/C6QYaKp+orHyEvN3jLzhLeWKUCNsgpCmrU0OhnIk=;
 b=Y5RJtqpu3Ibvv3SHsuI47kUouXkM7h1sbz7+kqVCL81wVifQILFtyQJ1LlIphE08dd
 kOwkDk8bhFoGEhzZ0i3QLDWaupiibGYGfqoQG2BLXklYW4GRs1qCFyf0LGEiA7hSFgLw
 hQBuE/Fe/FlXXQwPoBy90vlHoRsnAMXuKSl7w0QNnSGzLlRu2L4KHEIqSAGHMEpnRhdd
 fZNSRXJ+TYAzb2YHrI7nihMwuLUuqLXA9DxYBOCNYVahKqdU/GSpnzTxujL3Wxq/Mh3/
 utEJUuZmbUwF0x9aHQT5Pwqg7chrqJIZabwe2MftlALdAK9Al4kmEw6e35FQKYM61lz8
 wEYg==
X-Gm-Message-State: APjAAAVaZ9b08+o6ZuPY+og2MxrL4e7BmQLKLzxUyc8OnkbkclKJA6mz
 ljP0hdHk8JVoa8FEajp6nUpPejC65BwckNI+1aTojWXSdqWSIGoH0SnP5xCrppLhtlu8qW85BfG
 8+NZGPi2vFhteokg=
X-Received: by 2002:adf:e3cd:: with SMTP id k13mr1489920wrm.302.1582018779830; 
 Tue, 18 Feb 2020 01:39:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqzOTIhAo2sGoUQNcga8XH3kVCe0py6m2/WE6Df8EmJr/OFkr6cK80YvNJTw2wnEhWmy3WCIWw==
X-Received: by 2002:adf:e3cd:: with SMTP id k13mr1489862wrm.302.1582018779527; 
 Tue, 18 Feb 2020 01:39:39 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id k10sm5362253wrd.68.2020.02.18.01.39.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 01:39:39 -0800 (PST)
Subject: Re: [PATCH 00/13] trivial: Detect and remove superfluous semicolons
 in C code
To: qemu-devel@nongnu.org
References: <20200218093217.25156-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <11b9a381-b0c2-1817-bed5-d00f000b5af5@redhat.com>
Date: Tue, 18 Feb 2020 10:39:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218093217.25156-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: H0_eOoyzNdeWIF-YDD7h7w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Julia Suvorova <jusual@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 10:32 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Luc noticed a superfluous trailing semicolon:
> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04593.html
>=20
> Prevent that by modifying checkpatch.pl and clean the codebase.
>=20
> Philippe Mathieu-Daud=C3=A9 (13):
>    scripts/checkpatch.pl: Detect superfluous semicolon in C code
>    audio/alsaaudio: Remove superfluous semicolons
>    block: Remove superfluous semicolons
>    block/io_uring: Remove superfluous semicolon
>    hw/arm/xlnx-versal: Remove superfluous semicolon
>    hw/m68k/next-cube: Remove superfluous semicolon
>    hw/scsi/esp: Remove superfluous semicolon
>    hw/vfio/display: Remove superfluous semicolon
>    migration/multifd: Remove superfluous semicolon
>    ui/input-barrier: Remove superfluous semicolon
>    target/i386/whpx: Remove superfluous semicolon
>    tests/qtest/libqos/qgraph: Remove superfluous semicolons
>    contrib/rdmacm-mux: Remove superfluous semicolon

Series incomplete, git-send-email aborted:

Sent [PATCH 00/13] trivial: Detect and remove superfluous semicolons in=20
C code
Sent [PATCH 01/13] scripts/checkpatch.pl: Detect superfluous semicolon=20
in C code
5.5.2 Syntax error. v8sm5146891wrw.2 - gsmtp



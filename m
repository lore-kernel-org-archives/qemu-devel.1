Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4DDC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51CFC24125
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CFC24125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48Gk-0005TC-Do
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j48FJ-0003yQ-UD
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:09:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j48FI-0000KP-O6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:09:25 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:40731)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j48FI-0000IP-EP; Tue, 18 Feb 2020 14:09:24 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N0G5n-1jQ2Vn41Wp-00xGFd; Tue, 18 Feb 2020 20:09:01 +0100
Subject: Re: [PATCH RESEND 00/13] trivial: Detect and remove superfluous
 semicolons in C code
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200218094402.26625-1-philmd@redhat.com>
 <55411270-83ae-d6aa-362f-07018b44c0e1@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <99f23c4c-5dd1-bc83-f881-a45e11fc2b37@vivier.eu>
Date: Tue, 18 Feb 2020 20:08:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <55411270-83ae-d6aa-362f-07018b44c0e1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hG58ZJcFDBSamg2vHnxkdja47JKwwYVIDT8w7JxDEtE2MS+80Gw
 nLOziodEM72gdK8MVQWm2x+MHshhRX3bPhy1rIxw7WfSJVMIIOlw2iXMhaG+Yk5HW0ixq4U
 3omQy/+cLlCTt0QCZWIRkeWovMf5D5Q2IKsGbfZRqONKYeJ3a/YydtIgooJKGXpVgE2CR7G
 3fs7bXzf+wxIy9p+/oDYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RIk19QkihUQ=:o7hQmilc1dsrStY9EUYqFf
 i0ECaRBIWSSqf8zpJZ56jdr4U2lCuVkUcYahwT9219qdILNOhVwvThA8KVQwaRJ4WIkqv4Ihj
 S5o+S6vRwYd19NiWMrw7kk/3i0wQ8CYS9JgGVXxenm0QAQQZ/HihU8/lLLvTy/SJWDejxqrxG
 RyrHjqxQGUAhcATVBqI9CrdV8XjmC8w8HRGKb+bZ+qGPJcSCBJkgHy/18AdayDgr5ngQPe5EN
 3qCB0KIhhsuLK2UyrXJVZOgr603zhMjO/POMTdK3YfUS9MbDSCyNEOG0hWrvYqkNOAq9KwMFD
 L/FgA0+5K6q03uLrotCqBKpLIJThH+ntgu6blFW1dVxf5qLyPbieACYk4nMOQy1NALvI2Rc/7
 8XZkXDOzR3cHuvUar/dtGWvzNODuajck4vKrdjJspHJ01/cG2HmvWGS97Q36rpkJZe2gbr2Vz
 ndY1Hl5o/cKlCTzUETnkVkVBghlnY0yDOLW0OxB0nkaV0ZNCQXUm+rAdmXKavWY86VOoUiQj6
 b1ctfnCIJNnaJ87n6La9oQOSODUZy1Xpxnk4ZMfV3sBg3xPgeEIqEsWAtk3X4AE6ffMkhKtnN
 P7NN90W9PhZgR6jREMiw810+Tt0UJcS0wfi9D1ESsc4+HdNoHRvJXcGi8XqrJywkJ8wJXXmRh
 fev3BtOhrpXO3vogYcAGXhU9KSfT94ko1ltD057vqNfHlGT+ldH5M5tv0JCus6Mg7vqCWN81E
 DnDsNaCQomG5/Ag0I+pdz4wK12FDcwvXjS6o0htzBfbZYXc6JcRr+uGBh3gKA2wRW261DEZ5S
 bxH7ca8/dirOd+R4fOv/1L5aScBHFHF5fFwyjTdVyynNAaLIq8+8ZQ2RJjIp+AgRdUDAybX
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
 Thomas Huth <huth@tuxfamily.org>, Max Reitz <mreitz@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 18/02/2020 à 18:04, Paolo Bonzini a écrit :
> On 18/02/20 10:43, Philippe Mathieu-Daudé wrote:
>> Luc noticed a superfluous trailing semicolon:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04593.html
>>
>> Prevent that by modifying checkpatch.pl and clean the codebase.
>>
>> Philippe Mathieu-Daudé (13):
>>   scripts/checkpatch.pl: Detect superfluous semicolon in C code
>>   audio/alsaaudio: Remove superfluous semicolons
>>   block: Remove superfluous semicolons
>>   block/io_uring: Remove superfluous semicolon
>>   hw/arm/xlnx-versal: Remove superfluous semicolon
>>   hw/m68k/next-cube: Remove superfluous semicolon
>>   hw/scsi/esp: Remove superfluous semicolon
>>   hw/vfio/display: Remove superfluous semicolon
>>   migration/multifd: Remove superfluous semicolon
>>   ui/input-barrier: Remove superfluous semicolon
>>   target/i386/whpx: Remove superfluous semicolon
>>   tests/qtest/libqos/qgraph: Remove superfluous semicolons
>>   contrib/rdmacm-mux: Remove superfluous semicolon
>>
>>  audio/alsaaudio.c           | 4 ++--
>>  block.c                     | 4 ++--
>>  block/io_uring.c            | 2 +-
>>  contrib/rdmacm-mux/main.c   | 2 +-
>>  hw/arm/xlnx-versal-virt.c   | 2 +-
>>  hw/m68k/next-cube.c         | 2 +-
>>  hw/scsi/esp.c               | 2 +-
>>  hw/vfio/display.c           | 2 +-
>>  migration/multifd.c         | 2 +-
>>  target/i386/whpx-all.c      | 2 +-
>>  tests/qtest/libqos/qgraph.c | 4 ++--
>>  ui/input-barrier.c          | 2 +-
>>  scripts/checkpatch.pl       | 5 +++++
>>  13 files changed, 20 insertions(+), 15 deletions(-)
>>
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Laurent, can you queue this in qemu-trivial?
> 

Queued, except patches 3, 4 (taken by Kevin) and 9 (by Juan)

Thanks,
Laurent


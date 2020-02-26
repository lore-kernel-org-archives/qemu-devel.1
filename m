Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4BFC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:45:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035FD24685
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035FD24685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6v7w-0004J1-4f
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:45:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j6v1k-0003nT-MR
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j6v1f-00024f-Hq
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:38:54 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:60527)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j6v1d-0001yu-PO; Wed, 26 Feb 2020 06:38:50 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A0314747DFA;
 Wed, 26 Feb 2020 12:38:46 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6FE86747DF7; Wed, 26 Feb 2020 12:38:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6E9A7747DF5;
 Wed, 26 Feb 2020 12:38:46 +0100 (CET)
Date: Wed, 26 Feb 2020 12:38:46 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Howard Spoelstra <hsp.cat7@gmail.com>
Subject: Re: Issue with vl.c: move -m parsing after memory backends has been
 processed. Commit a1b18df9a4848fc8a906e40c275063bfe9ca2047
In-Reply-To: <CABLmASF7CoOufGDz-1d-Py3t1PN3CrWdN64XAzgAx4=rbSxGEA@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2002261237310.39786@zero.eik.bme.hu>
References: <CABLmASF7CoOufGDz-1d-Py3t1PN3CrWdN64XAzgAx4=rbSxGEA@mail.gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On Wed, 26 Feb 2020, Howard Spoelstra wrote:
> Hi all,
>
> Commit a1b18df9a4848fc8a906e40c275063bfe9ca2047 on the ppc-for-50 branch
> makes qemu-system-ppc running Mac OS 9 extremely slow. I bisected to the
> result below.
>
> Command line used:
> ./qemu-system-ppc -L pc-bios -M mac99,via=pmu -m 512 -boot c \
> -hda 9.2.img \
> -serial stdio -sdl
>
> Best,
> Howard
>
> a1b18df9a4848fc8a906e40c275063bfe9ca2047 is the first bad commit
> commit a1b18df9a4848fc8a906e40c275063bfe9ca2047
> Author: Igor Mammedov <imammedo@redhat.com>

Isn't this the same as what's discussed in

https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg07229.html

Regards,
BALATON Zoltan

> Date:   Wed Feb 19 11:08:40 2020 -0500
>
>    vl.c: move -m parsing after memory backends has been processed
>
>    It will be possible for main RAM to come from memory-backend
>    and we should check that size specified in -m matches the size
>    of the backend and [MachineState::]ram_size also matches
>    backend's size.
>
>    However -m parsing (set_memory_options()) happens before backends
>    are intialized (object_create_delayed()) which complicates it.
>    Consolidate set_memory_options() and assigning parsed results to
>    current_machine after backends are initialized, so it would be
>    possible access the initialized backend instance to compare
>    sizes.
>
>    This patch only consolidates scattered places touching ram_size
>    within vl.c. And follow up patch will integrate backend handling
>    to set_memory_options().
>
>    Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>    Message-Id: <20200219160953.13771-7-imammedo@redhat.com>
>
> vl.c | 27 ++++++++++++++-------------
> 1 file changed, 14 insertions(+), 13 deletions(-)
>


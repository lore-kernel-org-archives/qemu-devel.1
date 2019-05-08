Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C95C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5AF20644
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5AF20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37749 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hON8J-0005oP-OI
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 10:01:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hON6q-0005Cp-6T
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hON6p-0000gT-2T
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:59:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hON6j-0000cY-8S; Wed, 08 May 2019 09:59:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5BBD830832E1;
	Wed,  8 May 2019 13:59:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DDA31001E6F;
	Wed,  8 May 2019 13:59:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 840911132B35; Wed,  8 May 2019 15:59:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <1555560291-3415-1-git-send-email-hongbo.zhang@linaro.org>
	<1555560291-3415-3-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-poCxPqPtfhx4mUJ5pcOjn1Hz-WNxEt29f=JgpFMi4Kg@mail.gmail.com>
Date: Wed, 08 May 2019 15:59:32 +0200
In-Reply-To: <CAFEAcA-poCxPqPtfhx4mUJ5pcOjn1Hz-WNxEt29f=JgpFMi4Kg@mail.gmail.com>
	(Peter Maydell's message of "Tue, 30 Apr 2019 15:16:59 +0100")
Message-ID: <87mujxavy3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 08 May 2019 13:59:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 2/2] hw/arm: Add arm SBSA reference
 machine, devices part
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
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>,
	Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 18 Apr 2019 at 05:05, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>>
>> Following the previous patch, this patch adds peripheral devices to the
>> newly introduced SBSA-ref machine.
>>
>> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
>> ---
>>  hw/arm/sbsa-ref.c | 451 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 451 insertions(+)
>
> Some fairly minor comments on this one.
>
>> +static void create_flash(const SBSAMachineState *vms,
>> +                         MemoryRegion *sysmem,
>> +                         MemoryRegion *secure_sysmem)
>> +{
>> +    /*
>> +     * Create one secure and nonsecure flash devices to fill SBSA_FLASH
>> +     * space in the memmap, file passed via -bios goes in the first one.
>> +     */
>> +    hwaddr flashsize = vms->memmap[SBSA_FLASH].size / 2;
>> +    hwaddr flashbase = vms->memmap[SBSA_FLASH].base;
>> +
>> +    create_one_flash("sbsa-ref.flash0", flashbase, flashsize,
>> +                     bios_name, secure_sysmem);
>> +    create_one_flash("sbsa-ref.flash1", flashbase + flashsize, flashsize,
>> +                     NULL, sysmem);
>> +}
>
> I think Markus might have an opinion on the best way to create
> flash devices on a new board model. Is "just create two flash
> devices the way the virt board does" the right thing?

Short answer: create flash devices the way the ARM virt board does now,
after commit e0561e60f17, merged into master today.  Possibly less
backward compatibility stuff you don't need.  As is, your patch creates
them the way the ARM virt board did before commit e0561e60f17.  Please
consider updating.

Longer answer:

The old way to configure block backends is -drive.

The newer -blockdev is more flexible.  Libvirt is in the process of
transitioning from -drive to -blockdev entirely.  Other users with
similar needs for flexibility may do the same.  We hope to deprecate
-drive eventually.

The traditional way to configure onboard flash is -drive if=pflash.
Works, but we need a way to configure with -blockdev for full
flexibility, and to support libvirt ditching -drive entirely.

I recently improved the i386 PC machine types (commit ebc29e1beab) and
the ARM virt machine types (commit e0561e60f17) to support flash
configuration with -blockdev.

I recommend new boards support flash configuration with -blockdev from
the start.

Questions?


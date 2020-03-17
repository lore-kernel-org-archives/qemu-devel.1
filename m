Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C42C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9235A20724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9235A20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEHDQ-00019U-Nf
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jEH2y-0003LU-FI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jEH2x-0003qQ-2W
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:34:36 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:36498)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jEH2t-0003RW-6X; Tue, 17 Mar 2020 14:34:31 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 05D88747DF5;
 Tue, 17 Mar 2020 19:34:29 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D6B6E747D5D; Tue, 17 Mar 2020 19:34:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D504D746383;
 Tue, 17 Mar 2020 19:34:28 +0100 (CET)
Date: Tue, 17 Mar 2020 19:34:28 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 0/8] Misc hw/ide legacy clean up
In-Reply-To: <bcb72a4d-ace7-f4b2-650b-fd2e7cfece71@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2003171931520.35246@zero.eik.bme.hu>
References: <cover.1584457537.git.balaton@eik.bme.hu>
 <bcb72a4d-ace7-f4b2-650b-fd2e7cfece71@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 hpoussin@reactos.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020, John Snow wrote:
> On 3/17/20 11:05 AM, BALATON Zoltan wrote:
>> Avoid problems from reassigning variable in piix4_create and fix
>> compilation problem with mips_r4k
>>
>> BALATON Zoltan (8):
>>   hw/ide: Get rid of piix3_init functions
>>   hw/isa/piix4.c: Introduce variable to store devfn
>>   hw/ide: Get rid of piix4_init function
>>   hw/ide: Remove now unneded #include "hw/pci/pci.h" from hw/ide.h
>>   hw/ide/pci.c: Coding style update to fix checkpatch errors
>>   hw/ide: Do ide_drive_get() within pci_ide_create_devs()
>>   hw/ide: Move MAX_IDE_DEVS define to hw/ide/internal.h
>>   hw/ide: Remove unneeded inclusion of hw/ide.h
>>
>>  hw/alpha/dp264.c              | 13 +++----------
>>  hw/hppa/hppa_sys.h            |  1 -
>>  hw/hppa/machine.c             |  1 -
>>  hw/i386/pc_piix.c             | 18 +++++++++---------
>>  hw/ide/ahci_internal.h        |  1 +
>>  hw/ide/pci.c                  | 11 +++++++----
>>  hw/ide/piix.c                 | 31 +------------------------------
>>  hw/isa/piix4.c                | 23 ++++++++++-------------
>>  hw/mips/mips_fulong2e.c       |  5 +----
>>  hw/mips/mips_malta.c          |  2 +-
>>  hw/mips/mips_r4k.c            |  1 +
>>  hw/ppc/mac_newworld.c         |  1 -
>>  hw/ppc/mac_oldworld.c         |  1 -
>>  hw/ppc/prep.c                 |  1 -
>>  hw/sparc64/sun4u.c            |  6 +-----
>>  include/hw/ide.h              |  6 ------
>>  include/hw/ide/internal.h     |  2 ++
>>  include/hw/ide/pci.h          |  3 ++-
>>  include/hw/misc/macio/macio.h |  1 +
>>  include/hw/southbridge/piix.h |  3 +--
>>  20 files changed, 41 insertions(+), 90 deletions(-)
>>
>
> Passed local testing. Pushed to gitlab and pending further tests.
>
> Track here: https://gitlab.com/jsnow/qemu/pipelines/127143307

These tests don't seem to compile mips64el-softmmu target so probably miss 
some of these which are only used on those boards. (E.g. I could not find 
hw/ide/via.c mentioned in any of the logs.)

Regards,
BALATON Zoltan


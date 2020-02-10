Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06C9C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:33:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE17B20661
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="SdM5TRJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE17B20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j18Fa-0007Bl-Uk
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 07:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1j18E4-0005Zr-VG
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1j18E3-0007sw-R2
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:31:44 -0500
Received: from hoth.uni-paderborn.de ([2001:638:502:c003::19]:53406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1j18Dt-0007h6-Ii; Mon, 10 Feb 2020 07:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mDNHl+zfi34uwd4J0+J8Yr//LVt0FLx1RzRka/73Xsw=; b=SdM5TRJqmuWjQvzFlRJIziMKu+
 s86HE5drAR07EVWpLlJJjM082f3xpC9Us9hT42CSMKW0I7VH7vLvn4WRXuuEeOHaJxS0ERqce+Vwb
 lNB/XAxR1ddJPwIcsjrfR5JH+w/aBPrLuTwDofwAwrFpdpnjYqsA47/l6uujy6txlmMo=;
Subject: Re: Tricore default machine
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, qemu-devel@nongnu.org
References: <20200207161948.15972-1-philmd@redhat.com>
 <20200207161948.15972-2-philmd@redhat.com>
 <9590e020-226d-bc85-e496-95b4f0116f69@redhat.com>
 <e4157357-7697-a2d5-8662-f5bd12d74619@redhat.com>
 <f7b72c47-4202-d220-7b29-bd5ad6283700@redhat.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <c775db8c-63ec-e88a-f643-63f31de26f2b@mail.uni-paderborn.de>
Date: Mon, 10 Feb 2020 13:31:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <f7b72c47-4202-d220-7b29-bd5ad6283700@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.2.10.122417, AntiVirus-Engine: 5.70.0,
 AntiVirus-Data: 2020.2.8.5700001
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:638:502:c003::19
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
Cc: Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Jia Liu <proljc@gmail.com>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2/10/20 11:26 AM, Thomas Huth wrote:
> On 10/02/2020 11.08, Philippe Mathieu-Daudé wrote:
>> On 2/10/20 10:35 AM, Thomas Huth wrote:
>>> On 07/02/2020 17.19, Philippe Mathieu-Daudé wrote:
>>>> The MachineClass is already zeroed on creation.
>>>>
>>>> Note: The code setting is_default=0 in hw/i386/pc_piix.c is
>>>>         different (related to compat options). When adding a
>>>>         new versioned machine, we want it to be the new default,
>>>>         so we have to mark the previous one as not default.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> ---
>>>> v3: new patch
>>>> ---
>>>>    hw/lm32/lm32_boards.c               | 1 -
>>>>    hw/lm32/milkymist.c                 | 1 -
>>>>    hw/m68k/q800.c                      | 1 -
>>>>    hw/microblaze/petalogix_ml605_mmu.c | 1 -
>>>>    hw/tricore/tricore_testboard.c      | 1 -
>>>>    5 files changed, 5 deletions(-)
>>> [...]
>>>> diff --git a/hw/tricore/tricore_testboard.c
>>>> b/hw/tricore/tricore_testboard.c
>>>> index 20c9ccb3ce..8ec2b5bddd 100644
>>>> --- a/hw/tricore/tricore_testboard.c
>>>> +++ b/hw/tricore/tricore_testboard.c
>>>> @@ -105,7 +105,6 @@ static void ttb_machine_init(MachineClass *mc)
>>>>    {
>>>>        mc->desc = "a minimal TriCore board";
>>>>        mc->init = tricoreboard_init;
>>>> -    mc->is_default = 0;
>>>>        mc->default_cpu_type = TRICORE_CPU_TYPE_NAME("tc1796");
>>>>    }
>>> I wonder whether we should simply make that machine the default for
>>> qemu-system-tricore? There is only one machine here, and not having a
>>> default machine always causes some headaches in the tests...
>>> (see e.g. tests/qemu-iotests/check for example)
>> Or make it generic? If a architecture has a single machine, use it by
>> default?
> Sounds like a good idea, too ... we've got a couple of targets that have
> only one machine.


As far as I remember, I did not make it the default machine, since Peter 
Maydell advised against it. His argument was that defaults are really 
hard to get rid off since external tools (like libvirt) might rely on 
the defaults and we don't want to break those. Anyways, no objections 
from my side.

Cheers,

Bastian




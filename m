Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DCAC43141
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 22:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE9F820684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 22:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9F820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icGxF-0007SK-Hg
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 17:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1icGs5-0005x0-Ha
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1icGs1-0007C5-GK
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:42:17 -0500
Received: from mail.ilande.co.uk ([46.43.2.167]:60968
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1icGru-0005eO-91
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:42:06 -0500
Received: from host86-173-229-99.range86-173.btcentralplus.com
 ([86.173.229.99] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1icGnI-0007rx-S4; Tue, 03 Dec 2019 22:37:21 +0000
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
References: <20191203072922.14981-1-thuth@redhat.com>
 <2b5d3c2d-6982-03f6-26cc-7400440b990f@redhat.com>
 <8ca69db3-7dfa-0c4d-bc50-61a80eb574c1@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <205c2f57-2022-316d-be90-85e63bbdcb61@ilande.co.uk>
Date: Tue, 3 Dec 2019 22:36:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8ca69db3-7dfa-0c4d-bc50-61a80eb574c1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.173.229.99
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/ppc/prep: Remove the deprecated "prep" machine and the
 OpenHackware BIOS
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.43.2.167
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
Cc: Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/12/2019 08:25, Thomas Huth wrote:

> On 03/12/2019 08.45, Philippe Mathieu-Daudé wrote:
>> On 12/3/19 8:29 AM, Thomas Huth wrote:
>>> It's been deprecated since QEMU v3.1. The 40p machine should be
>>> used nowadays instead.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   .gitmodules                |   3 -
>>>   MAINTAINERS                |   1 -
>>>   Makefile                   |   2 +-
>>>   docs/interop/firmware.json |   3 +-
>>>   hw/ppc/ppc.c               |  18 --
>>>   hw/ppc/prep.c              | 384 +------------------------------------
>>>   include/hw/ppc/ppc.h       |   1 -
>>>   pc-bios/README             |   3 -
>>>   pc-bios/ppc_rom.bin        | Bin 1048576 -> 0 bytes
>>>   qemu-deprecated.texi       |   6 -
>>>   qemu-doc.texi              |  15 +-
>>>   roms/openhackware          |   1 -
>>>   tests/boot-order-test.c    |  25 ---
>>>   tests/cdrom-test.c         |   2 +-
>>>   tests/endianness-test.c    |   2 +-
>>>   15 files changed, 10 insertions(+), 456 deletions(-)
>>>   delete mode 100644 pc-bios/ppc_rom.bin
>>>   delete mode 160000 roms/openhackware
>> [...]
>>> diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
>>> index a725bce729..4a6218a516 100644
>>> --- a/tests/boot-order-test.c
>>> +++ b/tests/boot-order-test.c
>>> @@ -108,30 +108,6 @@ static void test_pc_boot_order(void)
>>>       test_boot_orders(NULL, read_boot_order_pc, test_cases_pc);
>>>   }
>>>   -static uint8_t read_m48t59(QTestState *qts, uint64_t addr, uint16_t
>>> reg)
>>> -{
>>> -    qtest_writeb(qts, addr, reg & 0xff);
>>> -    qtest_writeb(qts, addr + 1, reg >> 8);
>>> -    return qtest_readb(qts, addr + 3);
>>> -}
>>> -
>>> -static uint64_t read_boot_order_prep(QTestState *qts)
>>> -{
>>> -    return read_m48t59(qts, 0x80000000 + 0x74, 0x34);
>>
>> I'd rather keep this generic mmio-mapped ISA test.
>> Maybe run it with the 40p machine?
> 
> I don't think that this is possible in an easy way here. On the prep
> machine, the ISA bus is on a hard-coded MMIO address. On the 40p
> machine, the ISA bus is behind a PCI-to-ISA bridge, thus the PCI part
> needs to be set up first.

FWIW for sun4u we already cheat a bit here: the ebus device is the first PCI device
behind the PCI bridge which uses IO space, and so we know that this ultimately gets
mapped to the start of the IO memory space. We also configure the PCI bridge in QEMU
so that it allows IO accesses by default which means we also get the early console
before PCI bus enumeration.

>> Maybe we can rename this as read_boot_order_mm, and the previous
>> read_boot_order_pc as read_boot_order_io.
> 
> I don't think it makes much sense. This was completely specific to the
> "prep" machine, even the "40p" machine seems to prefer fw_cfg nowadays.
> So let's simply remove this old stuff.

From memory there were some issues with fw_cfg because the prep (OHW) and 40p
(OpenBIOS) machines had different NVRAM layouts. Once the prep machine has been
removed it should be easy to fix though.


ATB,

Mark.


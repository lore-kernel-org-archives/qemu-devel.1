Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63D3C3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 21:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D9C20842
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 21:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D9C20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9bCs-00013p-Kw
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 16:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1j9bC8-0000SK-R0
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1j9bC6-0001Ce-Pd
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:04:44 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:60146
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1j9bC6-0001Az-Iz; Wed, 04 Mar 2020 16:04:42 -0500
Received: from host86-162-6-80.range86-162.btcentralplus.com ([86.162.6.80]
 helo=[192.168.1.65]) by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1j9bC5-0003Yf-AH; Wed, 04 Mar 2020 21:04:47 +0000
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <cover.1583017348.git.balaton@eik.bme.hu>
 <32bb2eab213344151ca342bab5db2cf8c2758fb7.1583017348.git.balaton@eik.bme.hu>
 <f7f6bca9-ce20-cc3d-5366-1e947d729c21@ilande.co.uk>
 <bdbef976-a853-7178-8163-579e4bf9e2e0@ilande.co.uk>
 <alpine.BSF.2.22.395.2003011731130.95594@zero.eik.bme.hu>
 <57ff6676-5054-d3f6-f4fc-6ff02b09019f@ilande.co.uk>
 <alpine.BSF.2.22.395.2003011902490.28669@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2003011951370.28669@zero.eik.bme.hu>
 <38cb0f83-79fc-7021-38fc-c1e28c3c0fa0@ilande.co.uk>
 <alpine.BSF.2.22.395.2003012202330.79908@zero.eik.bme.hu>
 <9ce6d135-4169-96ae-c457-1131b4510c49@ilande.co.uk>
 <alpine.BSF.2.22.395.2003022145430.47473@zero.eik.bme.hu>
 <2a39ccab-e4d4-8172-9a1d-0bc089e0104c@ilande.co.uk>
 <alpine.BSF.2.22.395.2003032356230.41934@zero.eik.bme.hu>
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
Message-ID: <a579c016-fd6c-ad4f-c091-2286265c9a57@ilande.co.uk>
Date: Wed, 4 Mar 2020 21:04:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003032356230.41934@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.162.6.80
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/2] via-ide: Also emulate non 100% native mode
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:41c9:1:41f::167
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
Cc: qemu-block@nongnu.org, philmd@redhat.com, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/03/2020 00:22, BALATON Zoltan wrote:

>>>> So on that basis the best explanation as to what is happening is the
>>>> comment in the link you provided here:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/powerpc/platforms/chrp/pci.c?h=v4.14.172#n353
>>>>
>>>>
>>>>
>>>> /* Pegasos2 firmware version 20040810 configures the built-in IDE controller
>>>> * in legacy mode, but sets the PCI registers to PCI native mode.
>>>> * The chip can only operate in legacy mode, so force the PCI class into legacy
>>>> * mode as well. The same fixup must be done to the class-code property in
>>>> * the IDE node /pci@80000000/ide@C,1
>>>> */
>>>
>>> I'm not sure that it makes much sense that the firmware configures the chip one way
>>> then puts info about a different way in the device tree. There could be bugs but this
>>> is not likely. Especially because I see in traces that the firmware does try to
>>> configure the device in native mode. These are the first few accesses of the firmware
>>> to via-ide:
>>
>> But that is exactly what is happening! The comment above clearly indicates the
>> firmware incorrectly sets the IDE controller in native mode which is in exact
>> agreement with the trace you provide below. And in fact if you look at
> 
> I may be reading the comment wrong but to me that says that "firmware configures IDE
> in _legacy_ mode" whereas the trace shows it actually configures it in _native_ mode
> which is complying to the CHRP doc above. But since it cannot comply to the "native
> devices using OpenPIC" part it probably tries to apply the "ISA devices embedded in
> PCI" part and locks IRQ to 14 and 15. Or it just wants to avoid sharing IRQs as much
> as possible and the designers decided they will use IRQ14 and 15 for IDE.

Interesting. My interpretation of the comment was that the hardware can only operate
in legacy mode, even though the firmware configures the PCI registers to enable
native mode (which is why the class-code and IRQ routing are wrong).

>> https://www.powerdeveloper.org/platforms/pegasos/devicetree you can see the nvramrc
>> hack that was released in order to fix the device tree to boot Linux which alters the
>> class-code and sets interrupts to 14 (which I believe is invalid, but seemingly good
>> enough here).
> 
> Isn't this the same fixup that newer Linux kernels already include? Maybe this was
> needed before Linux properly supported Pegasos2 but later kernels will do this
> anyway. This does not give us any new info we did not have before I think maybe just
> easier to see all fixups in one place.
> 
>>> pci_cfg_write via-ide 12:1 @0x9 <- 0xf
>>> pci_cfg_write via-ide 12:1 @0x40 <- 0xb
>>> pci_cfg_write via-ide 12:1 @0x41 <- 0xf2
>>> pci_cfg_write via-ide 12:1 @0x43 <- 0x35
>>> pci_cfg_write via-ide 12:1 @0x44 <- 0x18
>>> pci_cfg_write via-ide 12:1 @0x45 <- 0x1c
>>> pci_cfg_write via-ide 12:1 @0x46 <- 0xc0
>>> pci_cfg_write via-ide 12:1 @0x50 <- 0x17171717
>>> pci_cfg_write via-ide 12:1 @0x54 <- 0x14
>>> pci_cfg_read via-ide 12:1 @0x0 -> 0x5711106
>>> pci_cfg_read via-ide 12:1 @0x0 -> 0x5711106
>>> pci_cfg_read via-ide 12:1 @0x8 -> 0x1018f06
>>> pci_cfg_read via-ide 12:1 @0xc -> 0x0
>>> pci_cfg_read via-ide 12:1 @0x2c -> 0x11001af4
>>> pci_cfg_read via-ide 12:1 @0x3c -> 0x10e
>>> pci_cfg_read via-ide 12:1 @0x4 -> 0x2800080
>>> pci_cfg_read via-ide 12:1 @0x3c -> 0x10e
>>> pci_cfg_write via-ide 12:1 @0x3c <- 0x109
>>>
>>> The very first write is to turn on native mode, so I think it's not about what the
>>> firmware does but something about how hardware is wired on Pegasos II or the VT8231
>>> chip itself that only allows legacy interrupts instead of 100% native mode for IDE.
>>>
>>>> Given that the DT is wrong, then we should assume that all OSs would have to
>>>> compensate for this in the same way as Linux, and therefore this should be handled
>>>> automatically.
>>>>
>>>> AFAICT this then only leaves the question: why does the firmware set
>>>> PCI_INTERRUPT_LINE to 9, which is presumably why you are seeing problems running
>>>> MorphOS under QEMU.
>>>
>>> Linux does try to handle both true native mode and half-native mode. It only uses
>>> half-native mode if finds IRQ14 on Pegasos, otherwise skips Pegasos specific fixup
>>> and uses true native mode setup. I don't know what MorphOS does but I think it justs
>>> knows that Pegasos2 has this quirk and does not look at the device tree at all.

I think this is the other way around? From the code above:

	if (viaide->irq != 14)
		return;

Doesn't this suggest that chrp_pci_fixup_vt8231_ata() exits without applying the fix
if it finds PCI_INTERRUPT_LINE set to 9 from the firmware above?

Do you have a copy of the full DT and the firmware revision number that was used to
generate your Linux boot output on real hardware?

>> Again to summarise: this is a known bug in Pegasos2 firmware and the VIA is a
>> standard chip, so let's try and figure out exactly what is happening using a real
>> firmware and emulate that behaviour in QEMU. This should then make all guests happy,
>> regardless of architecture, without requiring the introduction of feature bits or
>> risk of introducing other incompatibilities.
> 
> I think I've already done that with this patch (within the limits possible in QEMU).
> The Pegasos2 seems to always use IRQ14 and 15 even when IDE is set to native mode
> (which the firmware does immediately, I'm using a real firmware to test) and all
> guests are happy with this. This behaviour is confirmed by excpectations of AmigaOS
> and MorphOS drivers and also Linux comments (although those comments may get the
> reason wrong, they confirm the behaviour). I'm not sure how real hardware implements
> this behaviour and also not sure if it's a bug in the firmware or rather a peculiar
> design choice for Pegasos2. But that probably does not matter for the fact that it's
> how it works which is all we need to emulate it.
> 
> Also consider that QEMU via-ide is only emulating native mode of the chip because we
> can't switch between the two modes so it's either legacy only or native only because
> all other implemented controllers are either ISA or native PCI so QEMU does not have
> way to deregister ISA IDE and PCI code does not have way to use io BARs despite not
> being enabled via PCI config which could be needed to use them when device is in
> legacy mode. Previously via-ide was emulating legacy only and that worked with Linux
> but not with anything else. I'm not planning to rewrite large parts of the IDE and
> PCI code to allow switching back and forth which is not even needed. Unless you know
> a better way to implement this I think the proposed patch is achieving this with
> minimal changes. I don't see a need to more exactly emulate some kind of hardware bug
> or peculiar design choices of a board than what's needed to make clients happy and boot.
> 
> Is this series good enough now to be merged or are any changes needed? I'd like to
> not miss the deadline for the freeze and get this delayed for months for not good
> reason because I'm not sure when will I have time to work on it again.

I think there's still time to get something done before freeze, however I'm not
convinced that we understand the actual problem correctly (and also the use of
feature bits feels somewhat odd to me).

One more thing I don't understand: I had a glance over the logs you posted over at
https://osdn.net/projects/qmiga/ticket/38949 and you mention that everything works up
to the point where BMDMA is enabled.

From memory working with cmd646 both the BMDMA and non-BMDMA interrupts end up
calling into the same *_set_irq() function in the emulated controller. So what is the
difference between the initial state where IRQs function enough to start to load an
OS, and at the point where BMDMA is enabled by the OS driver and things stop working?
How does the IRQ routing compare?


ATB,

Mark.


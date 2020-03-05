Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0C2C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 18:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4784E2072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 18:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4784E2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9vRY-0003Tv-Ex
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 13:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1j9vQf-0002Bl-8G
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 13:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1j9vQa-0001cs-UP
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 13:41:05 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:34102
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1j9vQa-0001bo-O4; Thu, 05 Mar 2020 13:41:00 -0500
Received: from host86-162-6-80.range86-162.btcentralplus.com ([86.162.6.80]
 helo=[192.168.1.65]) by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1j9vQp-0007OR-5Y; Thu, 05 Mar 2020 18:41:15 +0000
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
 <a579c016-fd6c-ad4f-c091-2286265c9a57@ilande.co.uk>
 <alpine.BSF.2.22.395.2003042227190.70853@zero.eik.bme.hu>
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
Message-ID: <b3bce0d3-3ab3-7fb3-ed3c-60f1f19159d6@ilande.co.uk>
Date: Thu, 5 Mar 2020 18:40:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003042227190.70853@zero.eik.bme.hu>
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

On 04/03/2020 22:33, BALATON Zoltan wrote:

>>>>>> AFAICT this then only leaves the question: why does the firmware set
>>>>>> PCI_INTERRUPT_LINE to 9, which is presumably why you are seeing problems running
>>>>>> MorphOS under QEMU.
>>>>>
>>>>> Linux does try to handle both true native mode and half-native mode. It only uses
>>>>> half-native mode if finds IRQ14 on Pegasos, otherwise skips Pegasos specific fixup
>>>>> and uses true native mode setup. I don't know what MorphOS does but I think it
>>>>> justs
>>>>> knows that Pegasos2 has this quirk and does not look at the device tree at all.

I just a quick look at the PCI specification and found this interesting paragraph in
the section about "Interrupt Line":


"The Interrupt Line register is an eight-bit register used to communicate interrupt
line routing information. The register is read/write and must be implemented by any
device (or device function) that uses an interrupt pin. POST software will write the
routing information into this register as it initializes and configures the system."

"The value in this register tells which input of the system interrupt controller(s)
the device's interrupt pin is connected to. The device itself does not use this
value, rather it is used by device drivers and operating systems. Device drivers and
operating systems can use this information to determine priority and vector
information. Values in this register are architecture-specific [43]."

[43] For x86 based PCs, the values in this register correspond to IRQ numbers (0-15)
of the standard dual 8259 configuration. The value 255 is defined as meaning
"unknown" or "no connection" to the interrupt controller. Values between 15 and 254
are reserved.


The key part here is "The device itself does not use this value, rather it is used by
device drivers and operating systems" since this immediately tells us that the
existing code in hw/ide/via.c which uses the interrupt line value for IRQ routing is
incorrect and should be removed.

If we do that the next question is how does the VIA know whether the use the PCI
interrupt or the legacy interrupt? Another look at the datasheet showed that there is
another possibility: PCI configuration space register 0x3d (Interrupt pin) is
documented as having value 0 == Legacy IRQ routing which should be the initial value
on reset, but QEMU incorrectly sets it to 1 which indicates PCI IRQ routing.

In your previous email you included a trace of the PCI configuration accesses to the
via-ide device. Can you try this again with the following diff and post the same
output once again?

diff --git a/hw/ide/via.c b/hw/ide/via.c
index 096de8dba0..db9f4af861 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -139,7 +139,7 @@ static void via_ide_reset(DeviceState *dev)
     pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
     pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
     pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 20-23h */
-    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
+    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000000e);

     /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
     pci_set_long(pci_conf + 0x40, 0x0a090600);


ATB,

Mark.


Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0897CC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A6B206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A6B206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEDRH-00016k-2l
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jEDPI-00080S-6I
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jEDPG-0002nV-Mp
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:41:24 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:33220
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jEDPG-0002bR-GV; Tue, 17 Mar 2020 10:41:22 -0400
Received: from host86-184-243-54.range86-184.btcentralplus.com
 ([86.184.243.54] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jEDPW-00023S-3V; Tue, 17 Mar 2020 14:41:42 +0000
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <cover.1584437957.git.balaton@eik.bme.hu>
 <3240656814c804513de08bdbbf318f2f590df241.1584437958.git.balaton@eik.bme.hu>
 <c43e2f9b-3002-32f0-08fa-7164a98f3b9f@redhat.com>
 <f70ea487-c8e8-d76d-fbe5-9213284a8574@redhat.com>
 <2038186d-3f18-d430-2305-5697097397e9@redhat.com>
 <549ffd77-a020-51c8-96e7-c4afc28ff633@redhat.com>
 <alpine.BSF.2.22.395.2003171505380.40468@zero.eik.bme.hu>
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
Message-ID: <18f24b73-b02c-f4c4-595d-ddf13b2f0813@ilande.co.uk>
Date: Tue, 17 Mar 2020 14:41:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003171505380.40468@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.184.243.54
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 2/7] hw/ide: Get rid of piix4_init function
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/03/2020 14:07, BALATON Zoltan wrote:

> On Tue, 17 Mar 2020, Philippe Mathieu-Daudé wrote:
>> On 3/17/20 2:50 PM, John Snow wrote:
>>> On 3/17/20 6:49 AM, Philippe Mathieu-Daudé wrote:
>>>> On 3/17/20 11:41 AM, Philippe Mathieu-Daudé wrote:
>>>>> On 3/17/20 10:39 AM, BALATON Zoltan wrote:
>>>>>> This removes pci_piix4_ide_init() function similar to clean up done to
>>>>>> other ide devices.
>>>>>>
>>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>>> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>>>>
>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>
>>>> Please disregard this tag (I withdraw it), I mis-read the pci variable
>>>> was not assigned.
>>>>
>>>
>>> Is there an issue you've noticed, or you are just no longer certain
>>> enough to give an RB?
>>
>> I asked Zoltan there why he was reassigning 'pci' and he replied here:
>> https://www.mail-archive.com/qemu-block@nongnu.org/msg63324.html
>>
>> I don't know enough the PCI API (and don't have time this week to dig into it) to
>> check how pci->devfn is used (is it populated by a pci_create() call?).
>>
>>    pci = pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
>>                                          true, TYPE_PIIX4_PCI_DEVICE);
>>    ...
>> +   pci = pci_create_simple(pci_bus, pci->devfn + 1, "piix4-ide");
>>    ...
>>    pci_create_simple(pci_bus, pci->devfn + 2, "piix4-usb-uhci");
>>
>> What annoys me is here -------^^^^^^ I don't know if reassigning the pci variable
>> can have an impact, so as I am not confident I prefer to withdraw my review tag.
> 
> OK, I did not know that's what you were asking about and did not notice this could be
> a problem. To avoid any doubt I'll send a new version to avoid this shortly.

Hmmm actually yes I think isn't quite right. Here you have PCI_DEVFN(10, 0) for the
PIIX4_PCI_DEVICE, and PCI_DEVFN(10, 0) + 1 for "piix4-ide". But since you've
reassigned pci then "piix4-usb-uhci" now ends up as (PCI_DEVFN(10, 0) + 1) + 2 =
PCI_DEVFN(10, 0) + 3 rather than PCI_DEVFN(10, 0) + 2 as it was before.


ATB,

Mark.


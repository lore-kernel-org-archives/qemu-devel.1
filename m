Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769D8C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:35:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4913621D6C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4913621D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Mde-0003zV-DV
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 12:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7Mcx-0003RQ-5u
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7Mcw-0001O5-6Y
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:34:55 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35003)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i7Mct-0001MM-Qk; Mon, 09 Sep 2019 12:34:52 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MQuPJ-1hjtgK1PKZ-00O1bO; Mon, 09 Sep 2019 18:34:27 +0200
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190909155813.27760-1-laurent@vivier.eu>
 <20190909155813.27760-9-laurent@vivier.eu>
 <CAFEAcA9NiHrGekrEte7__aGKSz-JBObdbWdMxmxduYozngDUNQ@mail.gmail.com>
 <20190909161804.GE2726@work-vm>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9de713dd-a19f-c5d9-428d-f60b05cd70b7@vivier.eu>
Date: Mon, 9 Sep 2019 18:34:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909161804.GE2726@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jODLc3TPeG4BPRV+7Mx/PS7/leOrRQ8/YbEu6UIuae9K0EoCc3g
 0Nme7N5/7HeyBpll96n8Ne2h53z5ShY/rA5Hl10+OSHp+SLpCd55ghFxqig8lmnUpP8B9W4
 sKpv7ekaIUFDVnWL7AaVBrB9m2R30VIzKvcLLxQC0vJ24Xl+DuUXMmv9G6iJa72sh9Taf8P
 aelZuraPKGiLR35qTasNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hlgGOTAcP+A=:fyzHe7vOtGsfDOmW1Kc0ZQ
 JlXdwKzkRtJnbkbvaOq80q8SITOHZvL31PeilL4SOKFvBLzuEWfBMAaHECWjJSvQk8XE88OR2
 S4MZPa99PVOqMppL16HIWzwHNYcpVZbfwL2cPgtb4PvF81PhBJdHMIibbCXNJhjghrSZfwjwc
 W309vb0mZGXsJ8sor+SFXboir2KnN7dAPwo9eumLbtCKM7l+SUGP5VfgHmkeSjInN0csnUCeX
 /E/Ia4FBLsGaCknp+04ZloN0PVJ0tORHgzppyDSosmBZdBX5sCHiG9GPU2JmScwqAiOoWp/xT
 XIAjflEGt8EswJjmT/FWRJZIYEetluvk1VRIGEVNOEMX3Z7w6QavWPR+gzx/wwfWLYlo9RMsz
 It/2S4PzGPhC0nGEfdzwGLYmbzureJqxeidVfZMbgnTvd021HDF0WEQBqH3OnAvyIspBBnWsg
 4FocUy7FDeuMdNQbMesHAZoOqHyqI7vtD5eeuk3DWytDXsSt5FC+IraxF5YZ2yUqwZ4QbOKOQ
 MYAji2QNBtwuVOqvANSGNjzqHgFoclDI/Prq8VR/PYjPZuq18ggAw/Mte0ZGGOlWE48+rSXKc
 pGb94q8oFqxvE1ur8FPvW+dt/F//UnUAiF35/yuNxc1vIAWpXTXYLAg6jkk0O8ebst/HcASMJ
 d3alIv7VvtLiBzi5dMDNJnjxSi71n0IvGv70H0FGvwj96VFyt4GPXKT/jyofsCxzJmXXvC6cf
 vxNKrUbuzS0+WhW82VuTvc7+zxW7xguaX5+eB6ftx1tU2RNwexUirPInBkmxIUNcKF19PmJi/
 M7/kAv9WGz+jb2ZJ9Uwn3v1Z07+vv+j9GGTjSxziYdD11pV9GQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [PATCH v9 8/9] hw/m68k: add a dummy SWIM floppy
 controller
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 09/09/2019 à 18:18, Dr. David Alan Gilbert a écrit :
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> On Mon, 9 Sep 2019 at 17:05, Laurent Vivier <laurent@vivier.eu> wrote:
>>>
>>> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>> Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
>>
>>> +static void sysbus_swim_class_init(ObjectClass *oc, void *data)
>>> +{
>>> +    DeviceClass *dc = DEVICE_CLASS(oc);
>>> +
>>> +    dc->realize = sysbus_swim_realize;
>>> +}
>>
>> Missing reset and VMState for migration. These should be
>> baseline requirements for adding new device models to the
>> tree, because in an ideal world every device would support
>> both -- we should be gradually fixing the existing devices
>> which are missing these, and not letting new devices in,
>> so the situation gets gradually better, not worse.
> 
> I'm happy to see things marked unmigratable instead for obscure
> devices; I don't see the need to worry about migration for stuff
> that's not going to be migrated.
> 

I think in this case it's better to mark it unmigratable because the
structure will change in the future to really manage floppy and it
avoids to introduces a new version of the migration data stream.

Thanks,
Laurent



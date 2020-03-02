Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21513C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1BF320842
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BF320842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8qZk-0003Ev-3c
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 14:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1j8qZ3-0002VN-4l
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1j8qZ1-0001Gn-W9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:17:17 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:55246
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1j8qZ1-0001F2-P4; Mon, 02 Mar 2020 14:17:15 -0500
Received: from host86-162-6-80.range86-162.btcentralplus.com ([86.162.6.80]
 helo=[192.168.1.65]) by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1j8qZD-0003RU-IO; Mon, 02 Mar 2020 19:17:33 +0000
To: Peter Maydell <peter.maydell@linaro.org>,
 Pan Nengyuan <pannengyuan@huawei.com>
References: <20200227025055.14341-1-pannengyuan@huawei.com>
 <20200227025055.14341-6-pannengyuan@huawei.com>
 <CAFEAcA8yvrYrBONtW46iswbEvMF-WC-j7fHOOfcoEC_RV66BkQ@mail.gmail.com>
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
Message-ID: <c2b9eab3-f589-ecb6-0115-f8e673d52998@ilande.co.uk>
Date: Mon, 2 Mar 2020 19:17:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8yvrYrBONtW46iswbEvMF-WC-j7fHOOfcoEC_RV66BkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.162.6.80
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 5/6] hw/misc/mos6522: move timer_new from init() into
 realize() to avoid memleaks
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/03/2020 13:21, Peter Maydell wrote:

> On Thu, 27 Feb 2020 at 02:35, Pan Nengyuan <pannengyuan@huawei.com> wrote:
>>
>> There are some memleaks when we call 'device_list_properties'. This patch move timer_new from init into realize to fix it.
>> Meanwhile, add calls to mos6522_realize() in mac_via_realize to make this move to be valid.
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> ---
>> v2->v1:
>> - no changes in this patch.
>> v3->v2:
>> - remove null check in reset, and add calls to mos6522_realize() in mac_via_realize to make this move to be valid.
> 
> Hi; this is really fixing two bugs in one patch:
> 
>> ---
>>  hw/misc/mac_via.c | 5 +++++
>>  hw/misc/mos6522.c | 6 ++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
>> index b7d0012794..1d72d4ef35 100644
>> --- a/hw/misc/mac_via.c
>> +++ b/hw/misc/mac_via.c
>> @@ -879,6 +879,11 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
>>      sysbus_init_child_obj(OBJECT(dev), "via2", &m->mos6522_via2,
>>                            sizeof(m->mos6522_via2), TYPE_MOS6522_Q800_VIA2);
>>
>> +    object_property_set_bool(OBJECT(&m->mos6522_via1), true, "realized",
>> +                             &error_abort);
>> +    object_property_set_bool(OBJECT(&m->mos6522_via2), true, "realized",
>> +                             &error_abort);
>> +
>>      /* Pass through mos6522 output IRQs */
>>      ms = MOS6522(&m->mos6522_via1);
>>      object_property_add_alias(OBJECT(dev), "irq[0]", OBJECT(ms),
> 
> This is fixing a bug in mac_via where it failed to actually
> realize devices it was using. That's a dependency for the bug
> you're trying to fix, but it's a separate one and should be
> in its own patch.

Sigh. Thanks for this - I actually discovered this a little while back and have some
local patches to do the same, but due to lack of time I never managed to tidy them up
for submission.

> You also want to pass the error back up to the caller, rather
> than using error_abort. To do that, at the top of the function:
> 
>     Error *err = NULL;
> 
> and then here you can do:
>     object_property_set_bool(OBJECT(&m->mos6522_via1), true, "realized", &err);
>     if (err) {
>         error_propagate(errp, err);
>         return;
>     }
> 
> The existing code which inits the mos6522 objects and
> calls object_property_add_alias on them which is in
> the mac_via realize function should be moved to the init
> function. (init should init child objects and set up
> properties; realize should realize them.)

And I believe at some point I had a patch lying around to do this too...

> This is all fixing the incorrect creation of the mos6522
> devices in mac_via (which has been wrong since the mac_via
> was first added in commit 6dca62a0000f9), so that can all
> be one patch I think.
> 
>> +static void mos6522_realize(DeviceState *dev, Error **errp)
>> +{
>> +    MOS6522State *s = MOS6522(dev);
>>
>>      s->timers[0].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_timer1, s);
>>      s->timers[1].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_timer2, s);
>> @@ -502,6 +507,7 @@ static void mos6522_class_init(ObjectClass *oc, void *data)
>>
>>      dc->reset = mos6522_reset;
>>      dc->vmsd = &vmstate_mos6522;
>> +    dc->realize = mos6522_realize;
>>      device_class_set_props(dc, mos6522_properties);
>>      mdc->parent_reset = dc->reset;
>>      mdc->set_sr_int = mos6522_set_sr_int;
> 
> The changes to hw/misc/mos_6522.c are good, but should be in
> their own patch.


ATB,

Mark.


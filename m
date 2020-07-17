Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D53C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0708207F5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5J2kG+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0708207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwMFS-0006aM-83
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 05:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwMEb-00061F-Ch; Fri, 17 Jul 2020 05:00:49 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:44432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwMEZ-0007bS-NN; Fri, 17 Jul 2020 05:00:49 -0400
Received: by mail-ej1-x641.google.com with SMTP id ga4so9943464ejb.11;
 Fri, 17 Jul 2020 02:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FudUr0PI604QQFt4oulURUEjJo6IlyE7rZop0Hus4/k=;
 b=b5J2kG+Y8jRQrFXuvSS0LzuBzvBSuOEie5P31BY2V61Y9Nnf4jb0Ih0KAmebl6iGF8
 cvUUCbZeV3qNNSW/ilVA4ak8RjOoeobSZ3Mozk4KG+kWtHFazA0ZVpzEox51fKOneV5q
 tp1ZnALwLKcYX/FpXcw4XgKylpgHgKgReo2lsQIo/7PYcwARjpBuKGUMLGFd2eGUkyio
 AF1/3dQ/ilXbiC7U0epk4RwnuKa+emrGHZFIf+iXbAfTMSR1ey43Upmx0+zOV8ZVgedX
 /9hU00oURWyotIayVPDeZFZuaL8KsXb+5bFTuinsiYZlvktcV2NwiXaS/N7Zr1SttIIh
 taCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=FudUr0PI604QQFt4oulURUEjJo6IlyE7rZop0Hus4/k=;
 b=moYrNOGcpBwUJmvx8GKsFa7UxLdKblHj3QIqMdn8MCqH+KD/g/1Ua0sbUmivv4NFeb
 DFlIvJtuHB2h6FzhNOay6xeNE7JbleQ0ugJRuhZGh4eqbsa+uT73vzZPh886SglSErFV
 KfDVZyN0RovbQLgsA0OJh6KlqMyNBTiWkhZA4bwi0Vc/M/T6MOEVmeNauA0AmC2jYhjV
 9geWlJBEEaWzSlMrOJA3E4KCbhQzqmGXiIZcE4k4K49a7dnqWMR734fKeZGKRrxU8TVq
 x1RvxTE3bcI8opGb1pfDbQAm2UldebZnnFLu6YYUWpWxOxGsNSv4rVE+41e5TLG2JtQc
 06EQ==
X-Gm-Message-State: AOAM533YxTgboaDQJ23tzUS/FDFffIoyYpPeAyphfYeDn7KL4hgx8aTO
 /3nh/2RKXK+CbvZ56HxlKNg=
X-Google-Smtp-Source: ABdhPJwU3IbVTQ9t15rek0Hwg+GL61o+EJw6IT8XmZUH/dpiAMmROtNJlLUR44Gud34NvxPrPORVJw==
X-Received: by 2002:a17:906:e294:: with SMTP id
 gg20mr7353875ejb.521.1594976444864; 
 Fri, 17 Jul 2020 02:00:44 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id bs18sm7740439edb.38.2020.07.17.02.00.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 02:00:44 -0700 (PDT)
Subject: Re: [PATCH v5 10/11] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Thomas Huth <thuth@redhat.com>, Havard Skinnemoen
 <hskinnemoen@google.com>, Markus Armbruster <armbru@redhat.com>
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-11-hskinnemoen@google.com>
 <109d52ed-65bf-0fcc-98f1-47b7a6671d0b@kaod.org>
 <CAFQmdRZcygskP3iwss01-Jz67yjAP_JENXjWM2Bp8U=DRzxR0Q@mail.gmail.com>
 <875zaq78xq.fsf@dusky.pond.sub.org>
 <19733456-a672-595d-e721-e0ef26d7f665@amsat.org>
 <87v9iq2hkv.fsf@dusky.pond.sub.org>
 <e87663cf-7cb2-ca6c-a751-e5c1cebc5440@amsat.org>
 <87pn8xywz2.fsf@dusky.pond.sub.org>
 <b3bc658f-a865-8e6b-c904-01c7724e89cc@amsat.org>
 <CAFQmdRa9FiP6yX=XDrJy5KpjifQyVkQiY6DXtSoJSvfoq7Vm6w@mail.gmail.com>
 <CAFQmdRac6tsZafN3PsnLhPA_Ny032ZAjOFuXkmYvJ-ubjcpPPw@mail.gmail.com>
 <5345d70f-3041-ed13-12e9-9a8e3d803805@amsat.org>
 <416d5243-dc8e-37c6-197f-96dec1c9f5cc@redhat.com>
 <d66bf4fe-7349-a90f-c4fb-a80de7597819@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <bc258d6f-059d-618d-6ccd-94c04082bb25@amsat.org>
Date: Fri, 17 Jul 2020 11:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d66bf4fe-7349-a90f-c4fb-a80de7597819@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 10:27 AM, Philippe Mathieu-Daudé wrote:
> On 7/17/20 10:03 AM, Thomas Huth wrote:
>> On 17/07/2020 09.48, Philippe Mathieu-Daudé wrote:
>>> +Thomas
>>
>>> On 7/16/20 10:56 PM, Havard Skinnemoen wrote:
>>>> On Wed, Jul 15, 2020 at 1:54 PM Havard Skinnemoen
>>>> <hskinnemoen@google.com> wrote:
>>>>>
>>>>> On Wed, Jul 15, 2020 at 3:57 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>>>
>>>>>> On 7/15/20 11:00 AM, Markus Armbruster wrote:
>>>>>>> Now my point.  Why first make up user configuration, then use that to
>>>>>>> create a BlockBackend, when you could just go ahead and create the
>>>>>>> BlockBackend?
>>>>>>
>>>>>> CLI issue mostly.
>>>>>>
>>>>>> We can solve it similarly to the recent "sdcard: Do not allow invalid SD
>>>>>> card sizes" patch:
>>>>>>
>>>>>>  if (!dinfo) {
>>>>>>      error_setg(errp, "Missing SPI flash drive");
>>>>>>      error_append_hint(errp, "You can use a dummy drive using:\n");
>>>>>>      error_append_hint(errp, "-drive if=mtd,driver=null-co,"
>>>>>>                              "read-ones=on,size=64M\n);
>>>>>>      return;
>>>>>>  }
>>>>>>
>>>>>> having npcm7xx_connect_flash() taking an Error* argument,
>>>>>> and MachineClass::init() call it with &error_fatal.
>>>>>
>>>>> Erroring out if the user specifies a configuration that can't possibly
>>>>> boot sounds good to me. Better than trying to come up with defaults
>>>>> that are still not going to result in a bootable system.
>>>>>
>>>>> For testing recovery paths, I think it makes sense to explicitly
>>>>> specify a null device as you suggest.
>>>>
>>>> Hmm, one problem. qom-test fails with
>>>>
>>>> qemu-system-aarch64: Missing SPI flash drive
>>>> You can add a dummy drive using:
>>>> -drive if=mtd,driver=null-co,read-zeroes=on,size=32M
>>>> Broken pipe
>>>> /usr/local/google/home/hskinnemoen/qemu/for-upstream/tests/qtest/libqtest.c:166:
>>>> kill_qemu() tried to terminate QEMU process but encountered exit
>>>> status 1 (expected 0)
>>>> ERROR qom-test - too few tests run (expected 68, got 7)
>>>>
>>>> So it looks like we might need a different solution to this, unless we
>>>> want to make generic tests more machine-aware...
>>
>> I didn't follow the other mails in this thread, but what we usually do
>> in such a case: Add a "if (qtest_enabled())" check to the device or the
>> machine to ignore the error if it is running in qtest mode.
> 
> Hmm I'm not sure it works in this case. We could do:
> 
>   if (!dinfo) {
>      if (qtest) {
>         /* create null drive for qtest */
>         opts = ...;
>         dinfo = drive_new(opts, IF_MTD, &error_abort);
>      } else {
>         /* teach user to use proper CLI */
>         error_setg(errp, "Missing SPI flash drive");
>         error_append_hint(errp, "You can use a dummy drive using:\n");
>         error_append_hint(errp, "-drive if=mtd,driver=null-co,"
>                                 "read-ones=on,size=64M\n);
>      }
>   }
> 
> But I'm not sure Markus will enjoy it :)
> 
> Markus, any better idea about how to handle that with automatic qtests?

FWIW IDE device has a concept of "Anonymous BlockBackend for an empty
drive":

static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
{
    IDEBus *bus = DO_UPCAST(IDEBus, qbus, dev->qdev.parent_bus);
    IDEState *s = bus->ifs + dev->unit;
    int ret;

    if (!dev->conf.blk) {
        if (kind != IDE_CD) {
            error_setg(errp, "No drive specified");
            return;
        } else {
            /* Anonymous BlockBackend for an empty drive */
            dev->conf.blk = blk_new(qemu_get_aio_context(), 0,
BLK_PERM_ALL);
            ret = blk_attach_dev(dev->conf.blk, &dev->qdev);
            assert(ret == 0);
        }
    }


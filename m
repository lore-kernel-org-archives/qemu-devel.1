Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A23C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 20:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB6E2070E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 20:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3wpv6pB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB6E2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwXMZ-0003lZ-JU
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 16:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwXLq-000368-Lp; Fri, 17 Jul 2020 16:53:02 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwXLp-0003VO-3J; Fri, 17 Jul 2020 16:53:02 -0400
Received: by mail-wr1-x441.google.com with SMTP id z2so12435386wrp.2;
 Fri, 17 Jul 2020 13:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XJvntyfmAbaKTlO3hOQKrFFuMseiVmdVKUlu2nkwpBk=;
 b=e3wpv6pB48DZu9GT+nL7E30xu+8/DcOrRyJh9ll3sL+X985cKrlxj+It/hjtTBRAkm
 ORa/MrZN6biHQQlqKnmOcosM5DkZPUQTbJ1NSTMd+1ZaOZWM2HiyN8XBrDedWGiqdqMT
 0IUfMt+dhtwC+4Lap7A2Pc+RVRf8OTvZEqWpZ/DXCpKBgWdazF3EZmKWN0VIZ17g9nVt
 Xspcdi3Lh/40V/mZWLQrcpexP1DseeWYkb7ZzQKJOHajQ60RwG93JBupOLjnFXflGion
 ggF4RQ2/MJN6EINuYf0pSkWG7Tt9YsOkAEf8cxtX9NDlg/abkrltcR59ZrpoPcoDJq4j
 crFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XJvntyfmAbaKTlO3hOQKrFFuMseiVmdVKUlu2nkwpBk=;
 b=NyK8kDAALCcM4y6DWo3dItBC8CMI0FJDRwbRZZzTwNTi9twiqj0JRjFVeEOQmklQnl
 J8lRWE8A19RxY0CZBtLVeazyQFI+vIJprRAYHBamfV4hkMK5r6ECg+1HFjOK4sp4F/NY
 djBrjfv2JmwjRszRB0LujbZa9q8srxNNSd+f4kHytc8FFMu3TPGXMUED8QwC4Fx7p7rD
 35XgsjQG6yjpjYI/7pv4F0FVYyu9LpFutyNycIxEKEBGpXCQ2bTp1c1hcPSBPiJ8xl0G
 1Cj+3kvlyd+xjezffs6VzSMRXd9e5WUSt/dcXTXJbL1cO4E951IPBBXRUXw8F1/kuNzV
 OEeQ==
X-Gm-Message-State: AOAM533Gj4yhlumsETVpNEQx4AKlPs8UxOEJgXv3OyeRSxOPlwkFUGwK
 Wx/VhmQU6CNt2ct5IqpMToA=
X-Google-Smtp-Source: ABdhPJyFXPD14imLA/wvuKvH4Vv+HHPbpPSoskS7ZNVBVbbHSxioOzhbNQlRBvBL0mJiDkanIsHEXA==
X-Received: by 2002:a5d:420e:: with SMTP id n14mr12668344wrq.164.1595019178508; 
 Fri, 17 Jul 2020 13:52:58 -0700 (PDT)
Received: from [192.168.1.43] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id q3sm14863912wmq.22.2020.07.17.13.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 13:52:57 -0700 (PDT)
Subject: Re: [PATCH v5 10/11] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
To: Havard Skinnemoen <hskinnemoen@google.com>
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
 <bc258d6f-059d-618d-6ccd-94c04082bb25@amsat.org>
 <CAFQmdRbdSYOGw1o2ur_dYdSAZZfvQMfz4PX1Hmu+XvX7b9B-QQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1424050b-148c-e05c-5978-e5f910226306@amsat.org>
Date: Fri, 17 Jul 2020 22:52:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFQmdRbdSYOGw1o2ur_dYdSAZZfvQMfz4PX1Hmu+XvX7b9B-QQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
 Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 9:18 PM, Havard Skinnemoen wrote:
> On Fri, Jul 17, 2020 at 2:00 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 7/17/20 10:27 AM, Philippe Mathieu-Daudé wrote:
>>> On 7/17/20 10:03 AM, Thomas Huth wrote:
>>>> On 17/07/2020 09.48, Philippe Mathieu-Daudé wrote:
>>>>> +Thomas
>>>>
>>>>> On 7/16/20 10:56 PM, Havard Skinnemoen wrote:
>>>>>> On Wed, Jul 15, 2020 at 1:54 PM Havard Skinnemoen
>>>>>> <hskinnemoen@google.com> wrote:
>>>>>>>
>>>>>>> On Wed, Jul 15, 2020 at 3:57 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>>>>>
>>>>>>>> On 7/15/20 11:00 AM, Markus Armbruster wrote:
>>>>>>>>> Now my point.  Why first make up user configuration, then use that to
>>>>>>>>> create a BlockBackend, when you could just go ahead and create the
>>>>>>>>> BlockBackend?
>>>>>>>>
>>>>>>>> CLI issue mostly.
>>>>>>>>
>>>>>>>> We can solve it similarly to the recent "sdcard: Do not allow invalid SD
>>>>>>>> card sizes" patch:
>>>>>>>>
>>>>>>>>  if (!dinfo) {
>>>>>>>>      error_setg(errp, "Missing SPI flash drive");
>>>>>>>>      error_append_hint(errp, "You can use a dummy drive using:\n");
>>>>>>>>      error_append_hint(errp, "-drive if=mtd,driver=null-co,"
>>>>>>>>                              "read-ones=on,size=64M\n);
>>>>>>>>      return;
>>>>>>>>  }
>>>>>>>>
>>>>>>>> having npcm7xx_connect_flash() taking an Error* argument,
>>>>>>>> and MachineClass::init() call it with &error_fatal.
>>>>>>>
>>>>>>> Erroring out if the user specifies a configuration that can't possibly
>>>>>>> boot sounds good to me. Better than trying to come up with defaults
>>>>>>> that are still not going to result in a bootable system.
>>>>>>>
>>>>>>> For testing recovery paths, I think it makes sense to explicitly
>>>>>>> specify a null device as you suggest.
>>>>>>
>>>>>> Hmm, one problem. qom-test fails with
>>>>>>
>>>>>> qemu-system-aarch64: Missing SPI flash drive
>>>>>> You can add a dummy drive using:
>>>>>> -drive if=mtd,driver=null-co,read-zeroes=on,size=32M
>>>>>> Broken pipe
>>>>>> /usr/local/google/home/hskinnemoen/qemu/for-upstream/tests/qtest/libqtest.c:166:
>>>>>> kill_qemu() tried to terminate QEMU process but encountered exit
>>>>>> status 1 (expected 0)
>>>>>> ERROR qom-test - too few tests run (expected 68, got 7)
>>>>>>
>>>>>> So it looks like we might need a different solution to this, unless we
>>>>>> want to make generic tests more machine-aware...
>>>>
>>>> I didn't follow the other mails in this thread, but what we usually do
>>>> in such a case: Add a "if (qtest_enabled())" check to the device or the
>>>> machine to ignore the error if it is running in qtest mode.
>>>
>>> Hmm I'm not sure it works in this case. We could do:
>>>
>>>   if (!dinfo) {
>>>      if (qtest) {
>>>         /* create null drive for qtest */
>>>         opts = ...;
>>>         dinfo = drive_new(opts, IF_MTD, &error_abort);
>>>      } else {
>>>         /* teach user to use proper CLI */
>>>         error_setg(errp, "Missing SPI flash drive");
>>>         error_append_hint(errp, "You can use a dummy drive using:\n");
>>>         error_append_hint(errp, "-drive if=mtd,driver=null-co,"
>>>                                 "read-ones=on,size=64M\n);
>>>      }
>>>   }
>>>
>>> But I'm not sure Markus will enjoy it :)
>>>
>>> Markus, any better idea about how to handle that with automatic qtests?
>>
>> FWIW IDE device has a concept of "Anonymous BlockBackend for an empty
>> drive":
>>
>> static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
>> {
>>     IDEBus *bus = DO_UPCAST(IDEBus, qbus, dev->qdev.parent_bus);
>>     IDEState *s = bus->ifs + dev->unit;
>>     int ret;
>>
>>     if (!dev->conf.blk) {
>>         if (kind != IDE_CD) {
>>             error_setg(errp, "No drive specified");
>>             return;
>>         } else {
>>             /* Anonymous BlockBackend for an empty drive */
>>             dev->conf.blk = blk_new(qemu_get_aio_context(), 0,
>> BLK_PERM_ALL);
>>             ret = blk_attach_dev(dev->conf.blk, &dev->qdev);
>>             assert(ret == 0);
>>         }
>>     }
> 
> Could someone please remind me what problem we're trying to solve here?

Sorry, out of the scope of your series, which is fine with the current
code base :)

> Currently, if the user (or test) doesn't provide a drive, we pass NULL
> as the block backend to m25p80. This means we'll take the code path in
> m25p_realize() that does
> 
>         trace_m25p80_binding_no_bdrv(s);
>         s->storage = blk_blockalign(NULL, s->size);
>         memset(s->storage, 0xFF, s->size);
> 
> which will look like a freshly chip-erased flash chip.
> 
> Are we looking for a more elegant way to replace those three lines of
> code (+ a couple of conditionals in the writeback paths)?

Yes, I am. Anyway, unrelated to your work, sorry if it confused you.

> 
> But we don't even have a dummy device that looks like an erased flash chip...

No, this is still the design stage, but your series has a quality that
let us foreseen a bit where we are heading...

> 
> Havard
> 


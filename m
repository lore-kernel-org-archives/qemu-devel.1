Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35158C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 20:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F312C20684
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 20:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F312C20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwWsO-0003cp-9m
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 16:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jwWrh-00033O-GI
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 16:21:53 -0400
Received: from 20.mo3.mail-out.ovh.net ([178.33.47.94]:50918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jwWrc-0006KY-Qx
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 16:21:52 -0400
Received: from player770.ha.ovh.net (unknown [10.108.57.49])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 9976D25AAEF
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 22:21:45 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player770.ha.ovh.net (Postfix) with ESMTPSA id 529BC148A3C00;
 Fri, 17 Jul 2020 20:21:33 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002a291c71b-559e-45ed-9adc-3b95eb84cfa1,EDCDB8C856EF0F0B0CA5B21EBB7B009702C7510A)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v5 10/11] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
To: Havard Skinnemoen <hskinnemoen@google.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
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
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <edd8e05f-deaa-7981-92e1-686643086138@kaod.org>
Date: Fri, 17 Jul 2020 22:21:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFQmdRbdSYOGw1o2ur_dYdSAZZfvQMfz4PX1Hmu+XvX7b9B-QQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 601512028433320858
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrfeejgdehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejtddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.33.47.94; envelope-from=clg@kaod.org;
 helo=20.mo3.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 16:21:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> 
> Currently, if the user (or test) doesn't provide a drive, we pass NULL
> as the block backend to m25p80. This means we'll take the code path in
> m25p_realize() that does
> 
>         trace_m25p80_binding_no_bdrv(s);
>         s->storage = blk_blockalign(NULL, s->size);
>         memset(s->storage, 0xFF, s->size);
> 
> which will look like a freshly chip-erased flash chip.

which is perfect. 

C. 



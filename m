Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB85AC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 13:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6807120751
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 13:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6807120751
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD6iZ-0001tJ-IR
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 09:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jD6hi-0000xw-6A
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 09:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jD6hg-0005rG-7A
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 09:19:50 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:54558
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jD6hg-0005nE-0N
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 09:19:48 -0400
Received: from host86-185-91-43.range86-185.btcentralplus.com ([86.185.91.43]
 helo=[192.168.1.65]) by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jD6hx-0007Nd-TD; Sat, 14 Mar 2020 13:20:10 +0000
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
 <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
 <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
 <0c3ae5aa-36c3-a809-4a42-159348f44780@huawei.com>
 <CAFEAcA8_RkECOT=YJ3ML0wxBrKiqVw=CssORU=jyryfcNueB0w@mail.gmail.com>
 <871rq08tn9.fsf@dusky.pond.sub.org>
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
Message-ID: <eca27715-554d-2c2e-5e58-ffd01abb654c@ilande.co.uk>
Date: Sat, 14 Mar 2020 13:19:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <871rq08tn9.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.185.91.43
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, Laurent Vivier <laurent@vivier.eu>,
 QEMU Developers <qemu-devel@nongnu.org>, Euler Robot <euler.robot@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/03/2020 09:07, Markus Armbruster wrote:

> Widespread QOM usage anti-pattern ahead; cc: QOM maintainers.
> 
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Mon, 9 Mar 2020 at 10:02, Pan Nengyuan <pannengyuan@huawei.com> wrote:
>>> On 3/9/2020 5:21 PM, Peter Maydell wrote:
>>>> Could you explain more? My thought is that we should be using
>>>> sysbus_init_child_obj() and we should be doing it in the init method.
>>>> Why does that break the tests ? It's the same thing various other
>>>> devices do.
>>>
>>> device-introspect-test do the follow check for each device type:
>>>
>>>     qtree_start = qtest_hmp(qts, "info qtree");
>>>     ...
>>>     qtest_qmp(qts, "{'execute': 'device-list-properties','arguments': {'typename': %s}}", type);
>>>     ...
>>>     qtree_end = qtest_hmp(qts, "info qtree");
>>>     g_assert_cmpstr(qtree_start, ==, qtree_end);
>>>
>>> If we do qdev_set_parent_bus in init, it will check fail when type = 'mac_via'.
>>> mac_via_init() is called by q800_init(). But it will not be called in qtest(-machine none) in the step qtree_start.
>>> And after we call 'device-list-properties', mac_via_init() was called and set dev parent bus. We can find these
>>> devices in the qtree_end. So it break the test on the assert.
>>
>> Markus, do you know what's happening here? Why is
>> trying to use sysbus_init_child_obj() breaking the
>> device-introspect-test for this particular device,
>> but fine for the other places where we use it?
>> (Maybe we're accidentally leaking a reference to
>> something so the sub-device stays on the sysbus
>> when it should have removed itself when the
>> device was deinited ?)
> 
> Two questions: (1) why does it break here, and (2) why doesn't it break
> elsewhere.
> 
> First question: why does it break here?
> 
> It breaks here because asking for help with "device_add mac_via,help"
> has a side effect visible in "info qtree".
> 
>>> Here is the output:
>>>
>>> # Testing device 'mac_via'
> [Uninteresting stuff snipped...]
> 
> "info qtree" before asking for help:
> 
>>> qtree_start: bus: main-system-bus
>>>   type System
> 
> "info qtree" after asking for help:
> 
>>> qtree_end: bus: main-system-bus
>>>   type System
>>>   dev: mos6522-q800-via2, id ""
>>>     gpio-in "via2-irq" 8
>>>     gpio-out "sysbus-irq" 1
>>>     frequency = 0 (0x0)
>>>     mmio ffffffffffffffff/0000000000000010
>>>   dev: mos6522-q800-via1, id ""
>>>     gpio-in "via1-irq" 8
>>>     gpio-out "sysbus-irq" 1
>>>     frequency = 0 (0x0)
>>>     mmio ffffffffffffffff/0000000000000010
> 
> How come?
> 
> "device_add mac_via,help" shows properties of device "mac_via".  It does
> so even though "mac_via" is not available with device_add.  Useful
> because "info qtree" shows properties for such devices.
> 
> These properties are defined dynamically, either for the instance
> (traditional) or the class.  The former typically happens in QOM
> TypeInfo method .instance_init(), the latter in .class_init().
> 
> "Typically", because properties can be added elsewhere, too.  In
> particular, QOM properties not meant for device_add are often created in
> DeviceClass method .realize().  More on that below.
> 
> To make properties created in .instance_init() visible in help, we need
> to create and destroy an instance.  This must be free of observable side
> effects.
> 
> This has been such a fertile source of crashes that I added
> device-introspect-test:
> 
> commit 2d1abb850fd15fd6eb75a92290be5f93b2772ec5
> Author: Markus Armbruster <armbru@redhat.com>
> Date:   Thu Oct 1 10:59:56 2015 +0200
> 
>     device-introspect-test: New, covering device introspection
>     
>     The test doesn't check that the output makes any sense, only that QEMU
>     survives.  Useful since we've had an astounding number of crash bugs
>     around there.
>     
>     In fact, we have a bunch of them right now: a few devices crash or
>     hang, and some leave dangling pointers behind.  The test skips testing
>     the broken parts.  The next commits will fix them up, and drop the
>     skipping.
>     
>     Signed-off-by: Markus Armbruster <armbru@redhat.com>
>     Reviewed-by: Eric Blake <eblake@redhat.com>
>     Message-Id: <1443689999-12182-8-git-send-email-armbru@redhat.com>
> 
> Now let's examine device "mac_via".  It defines properties both in its
> .class_init() and its .instance_init().
> 
>     static void mac_via_class_init(ObjectClass *oc, void *data)
>     {
>         DeviceClass *dc = DEVICE_CLASS(oc);
> 
>         dc->realize = mac_via_realize;
>         dc->reset = mac_via_reset;
>         dc->vmsd = &vmstate_mac_via;
> --->    device_class_set_props(dc, mac_via_properties);
>     }
> 
> where
> 
>     static Property mac_via_properties[] = {
>         DEFINE_PROP_DRIVE("drive", MacVIAState, blk),
>         DEFINE_PROP_END_OF_LIST(),
>     };
> 
> And
> 
>     static void mac_via_init(Object *obj)
>     {
>         SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>         MacVIAState *m = MAC_VIA(obj);
>         MOS6522State *ms;
> 
>         /* MMIO */
>         memory_region_init(&m->mmio, obj, "mac-via", 2 * VIA_SIZE);
>         sysbus_init_mmio(sbd, &m->mmio);
> 
>         memory_region_init_io(&m->via1mem, obj, &mos6522_q800_via1_ops,
>                               &m->mos6522_via1, "via1", VIA_SIZE);
>         memory_region_add_subregion(&m->mmio, 0x0, &m->via1mem);
> 
>         memory_region_init_io(&m->via2mem, obj, &mos6522_q800_via2_ops,
>                               &m->mos6522_via2, "via2", VIA_SIZE);
>         memory_region_add_subregion(&m->mmio, VIA_SIZE, &m->via2mem);
> 
>         /* ADB */
>         qbus_create_inplace((BusState *)&m->adb_bus, sizeof(m->adb_bus),
>                             TYPE_ADB_BUS, DEVICE(obj), "adb.0");
> 
>         /* Init VIAs 1 and 2 */
>         sysbus_init_child_obj(OBJECT(m), "via1", &m->mos6522_via1,
>                               sizeof(m->mos6522_via1), TYPE_MOS6522_Q800_VIA1);
>         sysbus_init_child_obj(OBJECT(m), "via2", &m->mos6522_via2,
>                               sizeof(m->mos6522_via2), TYPE_MOS6522_Q800_VIA2);
> 
>         /* Pass through mos6522 output IRQs */
>         ms = MOS6522(&m->mos6522_via1);
>         object_property_add_alias(OBJECT(m), "irq[0]", OBJECT(ms),
>                                   SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
>         ms = MOS6522(&m->mos6522_via2);
>         object_property_add_alias(OBJECT(m), "irq[1]", OBJECT(ms),
>                                   SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
>     }
> 
> Resulting help:
> 
>   adb.0=<child<apple-desktop-bus>>
>   drive=<str>            - Node name or ID of a block device to use as a backend
>   irq[0]=<link<irq>>
>   irq[1]=<link<irq>>
>   mac-via[0]=<child<qemu:memory-region>>
>   via1=<child<mos6522-q800-via1>>
>   via1[0]=<child<qemu:memory-region>>
>   via2=<child<mos6522-q800-via2>>
>   via2[0]=<child<qemu:memory-region>>
> 
> Observe that mac_via_init() has obvious side effects.  In particular, it
> creates two devices that are then visible in "info qtree", and that's
> caught by device-introspect-test.
> 
> I believe these things need to be done in .realize().

Thanks for the detailed explanation, Markus. I had to re-read this several times to
think about the different scenerios that could occur here.

From what you are saying above, my understanding is that the only thing that
.instance_init() should do is add properties, so I can see that this works fine for
value properties and MemoryRegions. How would this would for reference properties
such as gpios and links? Presumably these should be defined in .instance_init() but
not connected until .realize()?

If this is the case then how should object_property_add_alias() work since that not
only defines the property but also links to another object? qdev has a separate
concept of defining connectors vs. connecting them which feels like it would fit this
pattern.

> Second question: why doesn't it break elsewhere?
> 
> We have >200 calls of sysbus_init_child_obj() in some 40 files.  I'm
> arbitrarily picking hw/arm/allwinner-a10.c for a closer look.
> 
> It calls it from device allwinner-a10's .instance_init() method
> aw_a10_init().  Side effect, clearly wrong.
> 
> But why doesn't it break device-introspect-test?  allwinner-a10 is a
> direct sub-type of TYPE_DEVICE.  Neither "info qtree" nor "info
> qom-tree" know how to show these.
> 
> Perhaps the side effect is visible if I peek into QOM with just the
> right qom-list command.  Tell me, and I'll try to tighten
> device-introspect-test accordingly.
> 
> 
> Root cause of this issue: nobody knows how to use QOM correctly (first
> order approximation).  In particular, people are perenially confused on
> how to split work between .instance_init() and .realize().  We really,
> really, really need to provide some guidance there!  Right now, all we
> provide are hundreds of examples, many of them bad.

I certainly understand now why sysbus_init_child_obj() is wrong. Is there any way to
detect this around object_new()/realize()? Perhaps take a snapshot of properties
after object_new(), the same again after realize() and then write a warning to stderr
if there are any differences? It would make issues like this more visible than they
would be in device-introspect-test.


ATB,

Mark.


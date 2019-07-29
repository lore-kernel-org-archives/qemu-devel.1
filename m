Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD498C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9739E206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9739E206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs8PY-0007zA-Ly
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 12:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58094)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hs8P5-0007Sh-Ot
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hs8P3-0007vf-Hl
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:21:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38047)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hs8P3-0007tq-Bj
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:21:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so32650510wmj.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 09:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RGSC43Kx6WYawfJRE0rx5Je7+HPNJtxziqJXA5EEigY=;
 b=pMSfAai4OupA75saSK9LijOsnnx+PRBmBMSjBLLnlqcwYjtBzU/XumSQ05jMfwlMlD
 T9/sCkvcPL3QjWWLI8sJYIfKVa6WgjoGhI8oO0l1NOf4S0GlCakkxios9Hbg3snJ4MfQ
 2exBI5X+Aay8uSeAVjqz/kYDPbDEwLJ9H4v9+IlwEFVEYqyiykJWk7fpQ0qmaa5CT7q+
 zqac/hWFsa0G+ZBStEWgAOQpby1lo0s4csjKJU4rNWThN/jMOoyoz2UMifmbAw6X8KAQ
 9DvYaDxwHnGTsCH91uqjOvI3ijbpQ8nTyo8SAgdvAnquWu6koEOCwH9jj/+WaaSm+HbC
 3fLg==
X-Gm-Message-State: APjAAAXYGVMhDozgSnRF6UCHS3Qz1mpXm8yRr7pMHD8WwCHnKaeQfqgp
 Lf2UcgQ7195/WidkF9RMAQTDcw==
X-Google-Smtp-Source: APXvYqwM38JFtBMpw/JSkLgNGzbMHbpZv2qrMhNtQnKevMRccnwe+awZ9FeO32u575wDsvkUqB2EHw==
X-Received: by 2002:a1c:ab06:: with SMTP id u6mr98552796wme.125.1564417295711; 
 Mon, 29 Jul 2019 09:21:35 -0700 (PDT)
Received: from [192.168.1.38] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id s15sm44335032wrw.21.2019.07.29.09.21.34
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 09:21:35 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190715121338.20600-1-philmd@redhat.com>
 <20190715121338.20600-3-philmd@redhat.com>
 <87o91u2mk7.fsf@dusky.pond.sub.org> <20190716140443.GE2770@work-vm>
 <87h87m109o.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <eee0b6db-82d6-3735-f12f-ff139df6cc4a@redhat.com>
Date: Mon, 29 Jul 2019 18:21:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87h87m109o.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v5 2/5] hw/block/pflash_cfi01: Use the
 correct READ_ARRAY value
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
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus.

On 7/16/19 5:12 PM, Markus Armbruster wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
>> * Markus Armbruster (armbru@redhat.com) wrote:
>>> Philippe asked me to have a look at this one, so here goes.

Thanks a lot for your careful analysis.

I got scared the uh-oh you raised would get this series or rework of it
still refused for the release, so I went for a quick-and-dirty bugfix.
Since this bugfix got merged (as commit 3a283507c0347), I can now think
again about how to properly fix this (if it is fixable...).

>>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>>
>>>> In the document [*] the "Read Array Flowchart", the READ_ARRAY
>>>> command has a value of 0xff.
>>>>
>>>> Use the correct value in the pflash model.
>>>>
>>>> There is no change of behavior in the guest, because:
>>>> - when the guest were sending 0xFF, the reset_flash label
>>>>   was setting the command value as 0x00
>>>> - 0x00 was used internally for READ_ARRAY
>>>
>>> *Groan*
>>>
>>> Is this cleanup, or does it fix an observable bug?

Well it depends where you stand.

I have a few patches on top of this adding trace events (4.2 material)
and while debugging it was not making sense with the CFI specs.

1/ The guest writes 0xFF to go in READ_ARRAY mode, the model report a
warning and take the switch default case which calls pflash_reset(),
which happens to set the flash in READ_ARRAY.

2/ Then a later series adds the CFI specs timings (like the CFI02
model), because it would useful to test the UEFI Capsule Update feature
with real-time behavior. For the 'Virt' pflash, the timing is disabled.
Now running a non-Virt pflash, it becomes very slow because each time
the guest goes into READ_ARRAY mode, the reset delay (which is the
longest) occurs.

Talking with Laszlo, I figured for 1/ instead of fixing the model, I can
display 0x00 as 0xFF and ignore the pflash_reset() when the caller is
not system_reset(). Dirty again.

For 2/ it is not that easy, it will depends if there is more interest
from the UEFI community (Intel parallel NOR flashes are used on x86 and
aarch64 UEFI platforms).

If we justify 1/ and 2/ are not important, then it is simply a cleanup.

>>>> To keep migration with older versions behaving correctly, we
>>>> decide to always migrate the READ_ARRAY as 0x00.
>>>>
>>>> If the CFI open standard decide to assign a new command of value
>>>> 0x00, this model is flawed because it uses this value internally.
>>>> If a guest eventually requires this new CFI feature, a different
>>>> model will be required (or this same model but breaking backward
>>>> migration). So it is safe to keep migrating READ_ARRAY as 0x00.
>>>
>>> We could perhaps keep migration working for "benign" device states, with
>>> judicious use of subsections.  We'll cross that bridge when we get to
>>> it.
>>>
>>>> [*] "Common Flash Interface (CFI) and Command Sets"
>>>>     (Intel Application Note 646)
>>>>     Appendix B "Basic Command Set"
>>>>
>>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>>> Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> ---
>>>> v3: Handle migrating the 'cmd' field.
>>>> v4: Handle migrating to older QEMU (Dave)
>>>> v5: Add a paragraph about why this model is flawed due to
>>>>     historically using READ_ARRAY as 0x00 (Dave, Peter).
>>>>
>>>> Since Laszlo stated he did not test migration [*], I'm keeping his
>>>> test tag, because the change with v2 has no impact in the tests
>>>> he ran.
>>>>
>>>> Likewise I'm keeping John and Alistair tags, but I'd like an extra
>>>> review for the migration change, thanks!
>>>>
>>>> [*] https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00679.html
>>>> ---
>>>>  hw/block/pflash_cfi01.c | 57 ++++++++++++++++++++++++++++++++++-------
>>>>  1 file changed, 48 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>>>> index 9e34fd4e82..85bb2132c0 100644
>>>> --- a/hw/block/pflash_cfi01.c
>>>> +++ b/hw/block/pflash_cfi01.c
>>>> @@ -96,6 +96,37 @@ struct PFlashCFI01 {
>>>>      bool old_multiple_chip_handling;
>>>>  };
>>>>  
>>>> +static int pflash_pre_save(void *opaque)
>>>> +{
>>>> +    PFlashCFI01 *s = opaque;
>>>> +
>>>> +    /*
>>>> +     * Previous to QEMU v4.1 an incorrect value of 0x00 was used for the
>>>> +     * READ_ARRAY command. To preserve migrating to these older version,
>>>> +     * always migrate the READ_ARRAY command as 0x00.
>>>> +     */
>>>> +    if (s->cmd == 0xff) {
>>>> +        s->cmd = 0x00;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int pflash_post_save(void *opaque)
>>>> +{
>>>> +    PFlashCFI01 *s = opaque;
>>>> +
>>>> +    /*
>>>> +     * If migration failed, the guest will continue to run.
>>>> +     * Restore the correct READ_ARRAY value.
>>>> +     */
>>>> +    if (s->cmd == 0x00) {
>>>> +        s->cmd = 0xff;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>
>>> Uh, this gives me a queasy feeling.  Perhaps David can assuage it.
>>
>> See the previous 4 versions of discussion....
> 
> Jumped in at v5; sorry about that.
> 
>>> I figure the intent is to migrate PFlashCFI01 member @cmd value 0xFF as
>>> 0x00, for migration compatibility to and from older versions.
>>>
>>> You do this by monkey-patching it to 0x00 before migration, and to 0xFF
>>> afterwards.  On the incoming side, you replace 0x00 by 0xFF, in
>>> pflash_post_load() below.
>>>
>>> Questions:
>>>
>>> * Can anything but the code that sends @cmd see the temporary 0x00 value
>>>   between pflash_pre_save() and pflash_post_save()
>>
>> It is the same pflash data structure; but all CPUs are stopped and we're
>> just walking the list of devices serialising them; so no nothing should
>> be seeing that value.
> 
> Sounds good.
> 
>> (There is another way to do this, which is to produce a temporary
>> structure at this point, populate the temporary structure and migrate
>> that)
> 
> Not necessary.
> 
> The uh-ohs below still need assuaging, not necessarily yours.
> 
>> Dave
>>
>>> * Consider the matrix source \in { old, new } x dest \in { old, new } x
>>>   @cmd on source in { 0x00, 0xFF }.  What does migration put into @cmd
>>>   on dest?  Eight cases:
>>>
>>>   source @cmd  ->  wire  ->  dest @cmd
>>>     old  0x00  ->  0x00  ->  old  0x00  (1)
>>>                              new  0xFF  (2)
>>>     old  0xFF  ->  0xFF  ->  old  0xFF  (3)
>>>                              new  0xFF  (4)
>>>     new  0x00  ->  0x00  ->  old  0x00  (5)
>>>                              new  0xFF  (6)
>>>     new  0xFF  ->  0x00  ->  old  0x00  (7)
>>>                              new  0xFF  (8)
>>>
>>>   Old -> old (cases 1 and 3) is unaffected by this patch.
>>>
>>>   New -> new leaves 0xFF unchanged (8).  It changes 0x00 to 0xFF (6).
>>>   Uh-oh.  Can this happen?  Rephrasing the question: can @cmd ever be
>>>   0x00 with this patch applied?

0x00 is not in the spec (but as suggested Peter Maydell, the spec can
eventually assign the value in the future [*]). So no guests use it.
This value is only set:
- when the (old) model is initialized, without any access to the guest
- if the guest wrote an incorrect value, hitting the switch default case.
The guest can not read this value (value internal to the state machine).

So answer: Yes :(

[*] However the spec has a way to announce supported features to the guest.

>>>
>>>   Old -> new leaves 0xFF unchanged (4).  It changes 0x00 to 0xFF (2),
>>>   which I think is intentional.
>>>
>>>   New -> old leaves 0x00 unchanged (5).  It changes 0xFF to 0x00 (7),
>>>   which I think is intentional.
>>>
>>>   Old -> new -> old leaves 0x00 unchanged.  Good.  It changes 0xFF to
>>>   0x00.  Uh-oh.  Can @cmd ever be 0xFF before this patch?

I understand the full question as "Can @cmd ever be 0xFF [in Old] before
this patch?".

Answer: No, neither the guest nor the state machine can set @cmd to 0xFF
in Old.

>>>
>>>   New -> old -> new leaves 0xFF unchanged.  Good.  It changes 0x00 to
>>>   0xFF.  Same uh-oh as for new -> new.

"Same uh-oh", do you mean "Can @cmd ever be 0x00 [in New] before this
patch?"?

Same answer: No, neither the guest nor the state machine can set @cmd to
0x00 in New.

>>>
>>>> +
>>>>  static int pflash_post_load(void *opaque, int version_id);
>>>>  
>>>>  static const VMStateDescription vmstate_pflash = {
>>>> @@ -103,6 +134,8 @@ static const VMStateDescription vmstate_pflash = {
>>>>      .version_id = 1,
>>>>      .minimum_version_id = 1,
>>>>      .post_load = pflash_post_load,
>>>> +    .pre_save = pflash_pre_save,
>>>> +    .post_save = pflash_post_save,
>>>>      .fields = (VMStateField[]) {
>>>>          VMSTATE_UINT8(wcycle, PFlashCFI01),
>>>>          VMSTATE_UINT8(cmd, PFlashCFI01),
>>>> @@ -277,10 +310,9 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr offset,
>>>>          /* This should never happen : reset state & treat it as a read */
>>>>          DPRINTF("%s: unknown command state: %x\n", __func__, pfl->cmd);
>>>>          pfl->wcycle = 0;
>>>> -        pfl->cmd = 0;
>>>> +        pfl->cmd = 0xff;
>>>>          /* fall through to read code */
>>>> -    case 0x00:
>>>> -        /* Flash area read */
>>>> +    case 0xff: /* Read Array */
>>>>          ret = pflash_data_read(pfl, offset, width, be);
>>>>          break;
>>>
>>> On 0xFF, we no longer zap pfl->wcycle and pfl->cmd.

We have 2 ways to set @cmd=0xFF.

- Write 0xFF, write an invalid command,
  finish a multicycle operation (wcycle returns to 0):

  pflash_write() goto reset_flash, then calls
  memory_region_rom_device_set_romd(). set wcycle=0, cmd=READ_ARRAY.

  Next read() will be in ROMD mode, we won't reach pflash_read().

  - if next access is write, we'll enter the same pflash_write().

- The /* This should never happen */ comment in pflash_read().

  It might happens migrating? So we migrated crap, the guest wants to
  read, the crap defaults to READ_ARRAY in I/O mode. Wrong in many ways,
  not sure what the guest expects there, probably not ARRAY data.
  Anyway, we stay in this READ_ARRAY I/O mode until the guest eventually
  does a write access. Wrong.

The case "The state machine set 0xff, let the device in I/O mode" so we
expect to answer to a read() with READ_ARRAY is wrong too, the device
should already be in ROMD mode.

>>>
>>> On 0x00, we do.

Because we have no idea how we got there... Neither what we should do.

>>>
>>> We zap pfl->cmd to 0xFF instead of 0x00.  Same below after label
>>> error_flash and reset_flash.  Related: initialization to 0xFF instead of
>>> 0x00 in pflash_cfi01_realize().  I *guess* these changes together ensure
>>> pfl->cmd can't become 0x00.  Correct?
>>>
>>>>      case 0x10: /* Single byte program */
>>>> @@ -448,8 +480,6 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>>>>      case 0:
>>>>          /* read mode */
>>>>          switch (cmd) {
>>>> -        case 0x00: /* ??? */
>>>> -            goto reset_flash;
>>>
>>> On 0x00, we now use default: goto error_flash.  Can this happen?

This could happen if the the guest is writing crap, so we correctly
report this as an error.

>>>
>>>>          case 0x10: /* Single Byte Program */
>>>>          case 0x40: /* Single Byte Program */
>>>>              DPRINTF("%s: Single Byte Program\n", __func__);
>>>> @@ -526,7 +556,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>>>>              if (cmd == 0xd0) { /* confirm */
>>>>                  pfl->wcycle = 0;
>>>>                  pfl->status |= 0x80;
>>>> -            } else if (cmd == 0xff) { /* read array mode */
>>>> +            } else if (cmd == 0xff) { /* Read Array */
>>>>                  goto reset_flash;
>>>>              } else
>>>>                  goto error_flash;
>>>> @@ -553,7 +583,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>>>>              } else if (cmd == 0x01) {
>>>>                  pfl->wcycle = 0;
>>>>                  pfl->status |= 0x80;
>>>> -            } else if (cmd == 0xff) {
>>>> +            } else if (cmd == 0xff) { /* read array mode */
>>>
>>> Your new comment is phrased the way you corrected in the previous hunk.
>>> Intentional?

No :/ Too many rebases.

>>>
>>>>                  goto reset_flash;
>>>>              } else {
>>>>                  DPRINTF("%s: Unknown (un)locking command\n", __func__);
>>>> @@ -645,7 +675,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>>>     error_flash:
>>>        qemu_log_mask(LOG_UNIMP, "%s: Unimplemented flash cmd sequence "
>>>                      "(offset " TARGET_FMT_plx ", wcycle 0x%x cmd 0x%x value 0x%x)"
>>>                      "\n", __func__, offset, pfl->wcycle, pfl->cmd, value);
>>>
>>>     reset_flash:
>>>>      trace_pflash_reset();
>>>>      memory_region_rom_device_set_romd(&pfl->mem, true);
>>>>      pfl->wcycle = 0;
>>>> -    pfl->cmd = 0;
>>>> +    pfl->cmd = 0xff;
>>>>  }
>>>>  
>>>>  
>>>> @@ -761,7 +791,7 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>>>>      }
>>>>  
>>>>      pfl->wcycle = 0;
>>>> -    pfl->cmd = 0;
>>>> +    pfl->cmd = 0xff;
>>>>      pfl->status = 0;
>>>>      /* Hardcoded CFI table */
>>>>      /* Standard "QRY" string */
>>>> @@ -1001,5 +1031,14 @@ static int pflash_post_load(void *opaque, int version_id)
>>>>          pfl->vmstate = qemu_add_vm_change_state_handler(postload_update_cb,
>>>>                                                          pfl);
>>>>      }
>>>> +
>>>> +    /*
>>>> +     * Previous to QEMU v4.1 an incorrect value of 0x00 was used for the
>>>> +     * READ_ARRAY command.
>>>> +     */
>>>> +    if (pfl->cmd == 0x00) {
>>>> +        pfl->cmd = 0xff;
>>>> +    }
>>>> +
>>>>      return 0;
>>>>  }
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


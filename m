Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FA7C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 12:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6D720693
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 12:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6D720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsndi-0002w0-VW
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 08:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60076)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hsndG-0002Rs-1H
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 08:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hsndD-0006JS-JD
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 08:23:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35192)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hsnd8-0006GN-Lk; Wed, 31 Jul 2019 08:22:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A2BFE8553A;
 Wed, 31 Jul 2019 12:22:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4151A5D6D0;
 Wed, 31 Jul 2019 12:22:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD9C61138619; Wed, 31 Jul 2019 14:22:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190715121338.20600-1-philmd@redhat.com>
 <20190715121338.20600-3-philmd@redhat.com>
 <87o91u2mk7.fsf@dusky.pond.sub.org> <20190716140443.GE2770@work-vm>
 <87h87m109o.fsf@dusky.pond.sub.org>
 <eee0b6db-82d6-3735-f12f-ff139df6cc4a@redhat.com>
Date: Wed, 31 Jul 2019 14:22:46 +0200
In-Reply-To: <eee0b6db-82d6-3735-f12f-ff139df6cc4a@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 29 Jul 2019 18:21:33
 +0200")
Message-ID: <87d0hq5r6x.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 31 Jul 2019 12:22:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
 qemu-block@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Markus.
>
> On 7/16/19 5:12 PM, Markus Armbruster wrote:
>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>>=20
>>> * Markus Armbruster (armbru@redhat.com) wrote:
>>>> Philippe asked me to have a look at this one, so here goes.
>
> Thanks a lot for your careful analysis.
>
> I got scared the uh-oh you raised would get this series or rework of it
> still refused for the release, so I went for a quick-and-dirty bugfix.

This close to the release, minimal bug fix now and cleanup later makes
lots of sense.

> Since this bugfix got merged (as commit 3a283507c0347), I can now think
> again about how to properly fix this (if it is fixable...).
>
>>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>>>
>>>>> In the document [*] the "Read Array Flowchart", the READ_ARRAY
>>>>> command has a value of 0xff.
>>>>>
>>>>> Use the correct value in the pflash model.
>>>>>
>>>>> There is no change of behavior in the guest, because:
>>>>> - when the guest were sending 0xFF, the reset_flash label
>>>>>   was setting the command value as 0x00
>>>>> - 0x00 was used internally for READ_ARRAY
>>>>
>>>> *Groan*
>>>>
>>>> Is this cleanup, or does it fix an observable bug?
>
> Well it depends where you stand.
>
> I have a few patches on top of this adding trace events (4.2 material)
> and while debugging it was not making sense with the CFI specs.
>
> 1/ The guest writes 0xFF to go in READ_ARRAY mode, the model report a
> warning and take the switch default case which calls pflash_reset(),
> which happens to set the flash in READ_ARRAY.

This one, in pflash_write()?

    switch (pfl->wcycle) {
    case 0:
        ...
--->    case 0xff: /* Read array mode */
            DPRINTF("%s: Read array mode\n", __func__);
            goto reset_flash;
        ...
    }
    return;
    ...
 reset_flash:
    trace_pflash_reset();
    memory_region_rom_device_set_romd(&pfl->mem, true);
    pfl->wcycle =3D 0;
    pfl->cmd =3D 0;

I can't see a warning here.

Let's ignore the tracepoint.

Is the memory_region_rom_device_set_romd() appropriate for READ_ARRAY?

pfl->wcycle =3D 0 is a no-op.

pfl->cmd =3D 0 is part of the "use 0 instead 0f 0xFF to represent
READ_ARRAY state" madness.

By the way, use of tracing and DPRINTF() in the same .c is an
anti-pattern.  Care to convert the remaining DPRINTF() into tracepoints?
Feel free to delete useless ones, if any.

> 2/ Then a later series adds the CFI specs timings (like the CFI02
> model), because it would useful to test the UEFI Capsule Update feature
> with real-time behavior. For the 'Virt' pflash, the timing is disabled.
> Now running a non-Virt pflash, it becomes very slow because each time
> the guest goes into READ_ARRAY mode, the reset delay (which is the
> longest) occurs.

Feels like a latent bug.  Adding timing turns it into a real one.

> Talking with Laszlo, I figured for 1/ instead of fixing the model, I can
> display 0x00 as 0xFF and ignore the pflash_reset() when the caller is
> not system_reset(). Dirty again.
>
> For 2/ it is not that easy, it will depends if there is more interest
> from the UEFI community (Intel parallel NOR flashes are used on x86 and
> aarch64 UEFI platforms).
>
> If we justify 1/ and 2/ are not important, then it is simply a cleanup.

If it's a bug fix, have the commit message explain the bug.

If it's just cleanup, heave the commit message say so.

>>>>> To keep migration with older versions behaving correctly, we
>>>>> decide to always migrate the READ_ARRAY as 0x00.
>>>>>
>>>>> If the CFI open standard decide to assign a new command of value
>>>>> 0x00, this model is flawed because it uses this value internally.
>>>>> If a guest eventually requires this new CFI feature, a different
>>>>> model will be required (or this same model but breaking backward
>>>>> migration). So it is safe to keep migrating READ_ARRAY as 0x00.
>>>>
>>>> We could perhaps keep migration working for "benign" device states, wi=
th
>>>> judicious use of subsections.  We'll cross that bridge when we get to
>>>> it.
>>>>
>>>>> [*] "Common Flash Interface (CFI) and Command Sets"
>>>>>     (Intel Application Note 646)
>>>>>     Appendix B "Basic Command Set"
>>>>>
>>>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>>>> Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>> ---
>>>>> v3: Handle migrating the 'cmd' field.
>>>>> v4: Handle migrating to older QEMU (Dave)
>>>>> v5: Add a paragraph about why this model is flawed due to
>>>>>     historically using READ_ARRAY as 0x00 (Dave, Peter).
>>>>>
>>>>> Since Laszlo stated he did not test migration [*], I'm keeping his
>>>>> test tag, because the change with v2 has no impact in the tests
>>>>> he ran.
>>>>>
>>>>> Likewise I'm keeping John and Alistair tags, but I'd like an extra
>>>>> review for the migration change, thanks!
>>>>>
>>>>> [*] https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00679.ht=
ml
>>>>> ---
>>>>>  hw/block/pflash_cfi01.c | 57 ++++++++++++++++++++++++++++++++++-----=
--
>>>>>  1 file changed, 48 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>>>>> index 9e34fd4e82..85bb2132c0 100644
>>>>> --- a/hw/block/pflash_cfi01.c
>>>>> +++ b/hw/block/pflash_cfi01.c
>>>>> @@ -96,6 +96,37 @@ struct PFlashCFI01 {
>>>>>      bool old_multiple_chip_handling;
>>>>>  };
>>>>>=20=20
>>>>> +static int pflash_pre_save(void *opaque)
>>>>> +{
>>>>> +    PFlashCFI01 *s =3D opaque;
>>>>> +
>>>>> +    /*
>>>>> +     * Previous to QEMU v4.1 an incorrect value of 0x00 was used for=
 the
>>>>> +     * READ_ARRAY command. To preserve migrating to these older vers=
ion,
>>>>> +     * always migrate the READ_ARRAY command as 0x00.
>>>>> +     */
>>>>> +    if (s->cmd =3D=3D 0xff) {
>>>>> +        s->cmd =3D 0x00;
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int pflash_post_save(void *opaque)
>>>>> +{
>>>>> +    PFlashCFI01 *s =3D opaque;
>>>>> +
>>>>> +    /*
>>>>> +     * If migration failed, the guest will continue to run.
>>>>> +     * Restore the correct READ_ARRAY value.
>>>>> +     */
>>>>> +    if (s->cmd =3D=3D 0x00) {
>>>>> +        s->cmd =3D 0xff;
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>
>>>> Uh, this gives me a queasy feeling.  Perhaps David can assuage it.
>>>
>>> See the previous 4 versions of discussion....
>>=20
>> Jumped in at v5; sorry about that.
>>=20
>>>> I figure the intent is to migrate PFlashCFI01 member @cmd value 0xFF as
>>>> 0x00, for migration compatibility to and from older versions.
>>>>
>>>> You do this by monkey-patching it to 0x00 before migration, and to 0xFF
>>>> afterwards.  On the incoming side, you replace 0x00 by 0xFF, in
>>>> pflash_post_load() below.
>>>>
>>>> Questions:
>>>>
>>>> * Can anything but the code that sends @cmd see the temporary 0x00 val=
ue
>>>>   between pflash_pre_save() and pflash_post_save()
>>>
>>> It is the same pflash data structure; but all CPUs are stopped and we're
>>> just walking the list of devices serialising them; so no nothing should
>>> be seeing that value.
>>=20
>> Sounds good.
>>=20
>>> (There is another way to do this, which is to produce a temporary
>>> structure at this point, populate the temporary structure and migrate
>>> that)
>>=20
>> Not necessary.
>>=20
>> The uh-ohs below still need assuaging, not necessarily yours.
>>=20
>>> Dave
>>>
>>>> * Consider the matrix source \in { old, new } x dest \in { old, new } x
>>>>   @cmd on source in { 0x00, 0xFF }.  What does migration put into @cmd
>>>>   on dest?  Eight cases:
>>>>
>>>>   source @cmd  ->  wire  ->  dest @cmd
>>>>     old  0x00  ->  0x00  ->  old  0x00  (1)
>>>>                              new  0xFF  (2)
>>>>     old  0xFF  ->  0xFF  ->  old  0xFF  (3)
>>>>                              new  0xFF  (4)
>>>>     new  0x00  ->  0x00  ->  old  0x00  (5)
>>>>                              new  0xFF  (6)
>>>>     new  0xFF  ->  0x00  ->  old  0x00  (7)
>>>>                              new  0xFF  (8)
>>>>
>>>>   Old -> old (cases 1 and 3) is unaffected by this patch.
>>>>
>>>>   New -> new leaves 0xFF unchanged (8).  It changes 0x00 to 0xFF (6).
>>>>   Uh-oh.  Can this happen?  Rephrasing the question: can @cmd ever be
>>>>   0x00 with this patch applied?
>
> 0x00 is not in the spec (but as suggested Peter Maydell, the spec can
> eventually assign the value in the future [*]). So no guests use it.
> This value is only set:
> - when the (old) model is initialized, without any access to the guest
> - if the guest wrote an incorrect value, hitting the switch default case.
> The guest can not read this value (value internal to the state machine).
>
> So answer: Yes :(

Could zero @cmd be avoided?

> [*] However the spec has a way to announce supported features to the gues=
t.
>
>>>>
>>>>   Old -> new leaves 0xFF unchanged (4).  It changes 0x00 to 0xFF (2),
>>>>   which I think is intentional.
>>>>
>>>>   New -> old leaves 0x00 unchanged (5).  It changes 0xFF to 0x00 (7),
>>>>   which I think is intentional.
>>>>
>>>>   Old -> new -> old leaves 0x00 unchanged.  Good.  It changes 0xFF to
>>>>   0x00.  Uh-oh.  Can @cmd ever be 0xFF before this patch?
>
> I understand the full question as "Can @cmd ever be 0xFF [in Old] before
> this patch?".
>
> Answer: No, neither the guest nor the state machine can set @cmd to 0xFF
> in Old.

Good.

>>>>
>>>>   New -> old -> new leaves 0xFF unchanged.  Good.  It changes 0x00 to
>>>>   0xFF.  Same uh-oh as for new -> new.
>
> "Same uh-oh", do you mean "Can @cmd ever be 0x00 [in New] before this
> patch?"?

Uh, isn't "[in New] before this patch" is a contradiction?

Old =3D QEMU before this patch
New =3D QEMU with this patch applied

New -> old -> new =3D migrate from QEMU with the patch to QEMU without the
patch, then migrate again to QEMU with the patch.

If @cmd can be 0x00 initially, then the first migration is (5), and @cmd
remains 0x00.  The second migration is (2), and @cmd becomes 0xFF.  The
two migrations together change device state, which could be bad.

> Same answer: No, neither the guest nor the state machine can set @cmd to
> 0x00 in New.

I'm afraid you gave a different answer to the same question above:
"Yes :(".

>>>>
>>>>> +
>>>>>  static int pflash_post_load(void *opaque, int version_id);
>>>>>=20=20
>>>>>  static const VMStateDescription vmstate_pflash =3D {
>>>>> @@ -103,6 +134,8 @@ static const VMStateDescription vmstate_pflash =
=3D {
>>>>>      .version_id =3D 1,
>>>>>      .minimum_version_id =3D 1,
>>>>>      .post_load =3D pflash_post_load,
>>>>> +    .pre_save =3D pflash_pre_save,
>>>>> +    .post_save =3D pflash_post_save,
>>>>>      .fields =3D (VMStateField[]) {
>>>>>          VMSTATE_UINT8(wcycle, PFlashCFI01),
>>>>>          VMSTATE_UINT8(cmd, PFlashCFI01),
>>>>> @@ -277,10 +310,9 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hw=
addr offset,
>>>>>          /* This should never happen : reset state & treat it as a re=
ad */
>>>>>          DPRINTF("%s: unknown command state: %x\n", __func__, pfl->cm=
d);
>>>>>          pfl->wcycle =3D 0;
>>>>> -        pfl->cmd =3D 0;
>>>>> +        pfl->cmd =3D 0xff;
>>>>>          /* fall through to read code */
>>>>> -    case 0x00:
>>>>> -        /* Flash area read */
>>>>> +    case 0xff: /* Read Array */
>>>>>          ret =3D pflash_data_read(pfl, offset, width, be);
>>>>>          break;
>>>>
>>>> On 0xFF, we no longer zap pfl->wcycle and pfl->cmd.
>
> We have 2 ways to set @cmd=3D0xFF.
>
> - Write 0xFF, write an invalid command,
>   finish a multicycle operation (wcycle returns to 0):
>
>   pflash_write() goto reset_flash, then calls
>   memory_region_rom_device_set_romd(). set wcycle=3D0, cmd=3DREAD_ARRAY.
>
>   Next read() will be in ROMD mode, we won't reach pflash_read().
>
>   - if next access is write, we'll enter the same pflash_write().
>
> - The /* This should never happen */ comment in pflash_read().
>
>   It might happens migrating? So we migrated crap, the guest wants to
>   read, the crap defaults to READ_ARRAY in I/O mode. Wrong in many ways,
>   not sure what the guest expects there, probably not ARRAY data.
>   Anyway, we stay in this READ_ARRAY I/O mode until the guest eventually
>   does a write access. Wrong.
>
> The case "The state machine set 0xff, let the device in I/O mode" so we
> expect to answer to a read() with READ_ARRAY is wrong too, the device
> should already be in ROMD mode.
>
>>>>
>>>> On 0x00, we do.
>
> Because we have no idea how we got there... Neither what we should do.

The part I actually understand here is "this device model is wrong in so
many ways".

Is this device model fixable with reasonable effort?

Would starting over be easier?

>>>>
>>>> We zap pfl->cmd to 0xFF instead of 0x00.  Same below after label
>>>> error_flash and reset_flash.  Related: initialization to 0xFF instead =
of
>>>> 0x00 in pflash_cfi01_realize().  I *guess* these changes together ensu=
re
>>>> pfl->cmd can't become 0x00.  Correct?
>>>>
>>>>>      case 0x10: /* Single byte program */
>>>>> @@ -448,8 +480,6 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr=
 offset,
>>>>>      case 0:
>>>>>          /* read mode */
>>>>>          switch (cmd) {
>>>>> -        case 0x00: /* ??? */
>>>>> -            goto reset_flash;
>>>>
>>>> On 0x00, we now use default: goto error_flash.  Can this happen?
>
> This could happen if the the guest is writing crap, so we correctly
> report this as an error.

A bug fix of sorts.

>>>>
>>>>>          case 0x10: /* Single Byte Program */
>>>>>          case 0x40: /* Single Byte Program */
>>>>>              DPRINTF("%s: Single Byte Program\n", __func__);
>>>>> @@ -526,7 +556,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr=
 offset,
>>>>>              if (cmd =3D=3D 0xd0) { /* confirm */
>>>>>                  pfl->wcycle =3D 0;
>>>>>                  pfl->status |=3D 0x80;
>>>>> -            } else if (cmd =3D=3D 0xff) { /* read array mode */
>>>>> +            } else if (cmd =3D=3D 0xff) { /* Read Array */
>>>>>                  goto reset_flash;
>>>>>              } else
>>>>>                  goto error_flash;
>>>>> @@ -553,7 +583,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr=
 offset,
>>>>>              } else if (cmd =3D=3D 0x01) {
>>>>>                  pfl->wcycle =3D 0;
>>>>>                  pfl->status |=3D 0x80;
>>>>> -            } else if (cmd =3D=3D 0xff) {
>>>>> +            } else if (cmd =3D=3D 0xff) { /* read array mode */
>>>>
>>>> Your new comment is phrased the way you corrected in the previous hunk.
>>>> Intentional?
>
> No :/ Too many rebases.

Easy enough to clean up :)

>>>>
>>>>>                  goto reset_flash;
>>>>>              } else {
>>>>>                  DPRINTF("%s: Unknown (un)locking command\n", __func_=
_);
>>>>> @@ -645,7 +675,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr=
 offset,
>>>>     error_flash:
>>>>        qemu_log_mask(LOG_UNIMP, "%s: Unimplemented flash cmd sequence "
>>>>                      "(offset " TARGET_FMT_plx ", wcycle 0x%x cmd 0x%x=
 value 0x%x)"
>>>>                      "\n", __func__, offset, pfl->wcycle, pfl->cmd, va=
lue);
>>>>
>>>>     reset_flash:
>>>>>      trace_pflash_reset();
>>>>>      memory_region_rom_device_set_romd(&pfl->mem, true);
>>>>>      pfl->wcycle =3D 0;
>>>>> -    pfl->cmd =3D 0;
>>>>> +    pfl->cmd =3D 0xff;
>>>>>  }
>>>>>=20=20
>>>>>=20=20
>>>>> @@ -761,7 +791,7 @@ static void pflash_cfi01_realize(DeviceState *dev=
, Error **errp)
>>>>>      }
>>>>>=20=20
>>>>>      pfl->wcycle =3D 0;
>>>>> -    pfl->cmd =3D 0;
>>>>> +    pfl->cmd =3D 0xff;
>>>>>      pfl->status =3D 0;
>>>>>      /* Hardcoded CFI table */
>>>>>      /* Standard "QRY" string */
>>>>> @@ -1001,5 +1031,14 @@ static int pflash_post_load(void *opaque, int =
version_id)
>>>>>          pfl->vmstate =3D qemu_add_vm_change_state_handler(postload_u=
pdate_cb,
>>>>>                                                          pfl);
>>>>>      }
>>>>> +
>>>>> +    /*
>>>>> +     * Previous to QEMU v4.1 an incorrect value of 0x00 was used for=
 the
>>>>> +     * READ_ARRAY command.
>>>>> +     */
>>>>> +    if (pfl->cmd =3D=3D 0x00) {
>>>>> +        pfl->cmd =3D 0xff;
>>>>> +    }
>>>>> +
>>>>>      return 0;
>>>>>  }
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


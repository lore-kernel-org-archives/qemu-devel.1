Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E695C73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 19:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431C820656
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 19:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431C820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkvXT-0005je-KB
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 15:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37399)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hkuzH-0004nI-2C
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hkuzE-0004Qp-VL
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:37:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34151)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hkuzE-0004NU-LH
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:37:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so5329031wrm.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 11:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JcJKweXXqgi20M2ilubBx6fUDc/PsVi5uOVa0zCZPZw=;
 b=sKT3kRX3pcqZyNiGzbMlgsOlwLtEWrsjiCyNiJ+R0ufbkGqbTGvJ4AORGBkTIz5kQc
 FYT1eMrbcIyBuSGWVy3rLjmZLcpuBugShrKFFx9KTKdluMqzcrM/JkqdAYafJd2JMvpk
 rJ9BitT9qDMTldYhf7dVwrF4LJeMzzAcAnh7+z7hjIpPY0Ond71x3Lj2EFqIxgjzcARx
 E6VdBlRCTbu4+yPd2hrtMDzYzRVf6FqpbrW77pizoJSOzNzjdpIyu2UE1p+MuHZ2cxUD
 DCjupSPLTy+kXYEzmZRVj9f45eknXP2gx2gYgc3pHE2FtigiIai9hfKuuhmxkxVrlYB6
 TSXQ==
X-Gm-Message-State: APjAAAWljqwqepZDauhjpGJAVC4CU82Lv6Hi9ahdNcLMAsLpyIk0U0VV
 bqqsaX7hFbyyCkBuf7OpoNV9zA==
X-Google-Smtp-Source: APXvYqxY2CtTUSW0GxYBWiAVvp1hx1tZx/oWErE3YYj7Kb2Bd4zi8oAwnPou5PGx8I0fI1ZcNkktUg==
X-Received: by 2002:adf:afe7:: with SMTP id y39mr25307580wrd.350.1562697420999; 
 Tue, 09 Jul 2019 11:37:00 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id g12sm5229442wrv.9.2019.07.09.11.36.59
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 11:37:00 -0700 (PDT)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190705154639.16591-1-philmd@redhat.com>
 <20190705154639.16591-3-philmd@redhat.com> <20190709103022.GA2766@work-vm>
 <dd8dd585-9774-78d4-17ee-89b30c81a0c4@redhat.com>
 <20190709171002.GJ2725@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b800cb15-1e99-7701-bb5d-5c57cb45e6e5@redhat.com>
Date: Tue, 9 Jul 2019 20:36:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190709171002.GJ2725@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v3 2/9] hw/block/pflash_cfi01: Use the
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/19 7:10 PM, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-Daudé (philmd@redhat.com) wrote:
>> Hi David,
>>
>> On 7/9/19 12:30 PM, Dr. David Alan Gilbert wrote:
>>> * Philippe Mathieu-Daudé (philmd@redhat.com) wrote:
>>>> In the "Read Array Flowchart" the command has a value of 0xFF.
>>>>
>>>> In the document [*] the "Read Array Flowchart", the READ_ARRAY
>>>> command has a value of 0xff.
>>>>
>>>> Use the correct value in the pflash model.
>>>>
>>>> There is no change of behavior in the guest, because:
>>>> - when the guest were sending 0xFF, the reset_flash label
>>>>   was setting the command value as 0x00
>>>> - 0x00 was used internally for READ_ARRAY
>>>>
>>>> To keep migration behaving correctly, we have to increase
>>>> the VMState version. When migrating from an older version,
>>>> we use the correct command value.
>>>
>>> The problem is that incrementing the version will break backwards
>>> compatibility; so you won't be able to migrate this back to an older
>>> QEMU version; so for example a q35/uefi with this won't be able
>>> to migrate backwards to a 4.0.0 or older qemu.
>>>
>>> So instead of bumping the version_id you probably need to wire
>>> the behaviour to a machine type and then on your new type
>>> wire a subsection containing a flag; the reception of that subsection
>>> tells you to use the new/correct semantics.
>>
>> I'm starting to understand VMState subsections, but it might be overkill
>> for this change...
>>
>>   Subsections
>>   -----------
>>
>>   The most common structure change is adding new data, e.g. when adding
>>   a newer form of device, or adding that state that you previously
>>   forgot to migrate.  This is best solved using a subsection.
>>
>> This is not the case here, the field is already present and migrated.
>>
>> It seems I can use a simple pre_save hook, always migrating the
>> READ_ARRAY using the incorrect value:
>>
>> -- >8 --
>> --- a/hw/block/pflash_cfi01.c
>> +++ b/hw/block/pflash_cfi01.c
>> @@ -97,12 +97,29 @@ struct PFlashCFI01 {
>>      bool incorrect_read_array_command;
>>  };
>>
>> +static int pflash_pre_save(void *opaque)
>> +{
>> +    PFlashCFI01 *s = opaque;
>> +
>> +    /*
>> +     * Previous to QEMU v4.1 an incorrect value of 0x00 was used for the
>> +     * READ_ARRAY command. To preserve migrating to these older version,
>> +     * always migrate the READ_ARRAY command as 0x00.
>> +     */
>> +    if (s->cmd == 0xff) {
>> +        s->cmd = 0x00;
>> +    }
>> +
>> +    return 0;
>> +}
> 
> Be careful what happens if migration fails and you continue on the
> source - is that OK - or are you going to have to flip that back somehow
> (in a post_save).

Hmm OK...

> 
> Another way to do the same is to have a dummy field; tmp_cmd, and the
> tmp_cmd is the thing that's actually migrated and filled by pre_save
> (or use VMSTATE_WITH_TMP )
> 
> 
>>  static int pflash_post_load(void *opaque, int version_id);
>>
>>  static const VMStateDescription vmstate_pflash = {
>>      .name = "pflash_cfi01",
>>      .version_id = 1,
>>      .minimum_version_id = 1,
>> +    .pre_save = pflash_pre_save,
>>      .post_load = pflash_post_load,
>>      .fields = (VMStateField[]) {
>>          VMSTATE_UINT8(wcycle, PFlashCFI01),
>> @@ -1001,5 +1018,14 @@ static int pflash_post_load(void *opaque, int
>> version_id)
>>          pfl->vmstate = qemu_add_vm_change_state_handler(postload_update_cb,
>>                                                          pfl);
>>      }
>> +
>> +    /*
>> +     * Previous to QEMU v4.1 an incorrect value of 0x00 was used for the
>> +     * READ_ARRAY command.
>> +     */
>> +    if (pfl->cmd == 0x00) {
>> +        pfl->cmd = 0xff;
>> +    }
>> +
>>      return 0;
>>  }
>> ---
>>
>> Being simpler and less intrusive (no new property in hw/core/machine.c),
>> is this acceptable?
> 
> From the migration point of view yes; I don't know enough about pflash
> to say if it makes sense;  for example could there ever be a 00 command
> really used and then you'd have to distinguish that somehow?

Well, I think this change is simpler than it looks.

Currently the code is (what will run on older guest):

static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr offset,
                            int width, int be)
{
    switch (pfl->cmd) {
    default:
        /* This should never happen : reset state & treat it as a read*/
        DPRINTF("%s: unknown command state: %x\n", __func__, pfl->cmd);
        pfl->wcycle = 0;
        pfl->cmd = 0;
        /* fall through to read code */
    case 0x00:
        /* Flash area read */
        ret = pflash_data_read(pfl, offset, width, be);
        break;

and:

static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
                         uint32_t value, int width, int be)
{
    switch (pfl->wcycle) {
    case 0:
        /* read mode */
        switch (cmd) {
        case 0x00: /* ??? */
            goto reset_flash;
        case 0xff: /* Read array mode */
            DPRINTF("%s: Read array mode\n", __func__);
            goto reset_flash;
        default:
            goto error_flash;
        }

So current (incorrect) 0x00 will be then 0xff, and will be backprocessed
correctly.

What I want is to get ride of this 0x00 processing that is confusing,
the spec and the guests use 0xff for READ_ARRAY.

So if I increase version I can not back-migrate, but luckily it seems I
can simply update 0x00 -> 0xff without even increasing the version :)

(I'm reluctant to skip this patch because I'd rather avoid Laszlo to
re-run his tests).

Regards,

Phil.


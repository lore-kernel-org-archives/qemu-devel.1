Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E582CC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B18EE246AF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6qsO158"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18EE246AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7cip-0007Wn-SS
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7ci7-00073n-LR
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7ci5-0007hb-FV
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:17:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34898
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7ci5-0007hH-BU
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582885052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ILJ5N906GyezyGMRFIoIkND6Nt1CCaX/lHeN23SKxtY=;
 b=L6qsO158hbesIfkaqiYQGc+bpgDlD8aAU5K9QCT5xzy1SF5z3f1Jh6hCfBLv7kDQJWjWJ3
 wIkw6NQkL2Wd657qhZDeIDLozv6T5yrvTB449xAtJR6I99KkD66v4eQG1TVYPe2p7p1AZ9
 b6/bxgwE7q22x3wUqQzZd8RAC76W8KU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-vnhu87FHOPKCQtBYDtQxLQ-1; Fri, 28 Feb 2020 05:17:26 -0500
X-MC-Unique: vnhu87FHOPKCQtBYDtQxLQ-1
Received: by mail-wm1-f70.google.com with SMTP id y18so1478584wmi.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 02:17:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MrkKMjm3WeD61mF3RLh073Kli4H/HLnvWN9NH+AJBDc=;
 b=O+IkR2vJoQQtfCwCYRCfcDzRK9Qz03Q8BXqEmq8cmNJirXXuGh+WrdJc17WejrZzIW
 b14sHcwisxPxeSxUFRUCeepspvUKpBq7Eb5ECXK7JYceOA3HjH3Cq/rJeG685jzyLcht
 2GvSJlApO45q9dvtk2g/LS7A5ZJd+WuCkdXPwSfANwcv5mDTJpzzbGCOGa9vinsZ6o7s
 TaAsPopvIHsdxegIgLtIPZbfW8NkGnq3hJhzFh4U2feSq9fFC2vOtDJwJqq2HPcbnQBi
 FDb/y9gR8vVedJ051Y7fsuR0sjWR99UuqA4gI7/VEdNwphVcu+AuBdvQ1i+6ZCrdDJID
 K4Tg==
X-Gm-Message-State: APjAAAU96N4C8ADOixQvrGfHlroBm4x9jgKpG8kNWqgg1Pxiku8DK00Q
 jA3FGOlVOuGT90A2x6yjQotMqD+3ezxuOU4LiEWQ1obQ+zarrR8qnByoa90ZWtjEC6Sa9I6yjO1
 dCtFYxR5p6Em8K1M=
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr4045705wml.173.1582885045155; 
 Fri, 28 Feb 2020 02:17:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzAgOloih5ABkXlH1lBerM+WY8oAIe5X08vWFCAR0Es3uYHm9b9N7oqw2XhiFisGj9l7ivRhQ==
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr4045677wml.173.1582885044813; 
 Fri, 28 Feb 2020 02:17:24 -0800 (PST)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id z2sm5747642wrq.95.2020.02.28.02.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 02:17:24 -0800 (PST)
Subject: Re: [PATCH v2] qapi/machine: Place the 'Notes' tag after the 'Since'
 tag
To: Markus Armbruster <armbru@redhat.com>
References: <20200227134019.6218-1-philmd@redhat.com>
 <87tv3cozfw.fsf@dusky.pond.sub.org>
 <c27cdab5-23a9-78f4-994a-49aaf96eb487@redhat.com>
 <49248832-6ce3-a545-0ee3-8bd3ce664725@redhat.com>
 <87tv3bmc8c.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d124e9bc-1db6-52a4-843f-7f3fe73fbe5d@redhat.com>
Date: Fri, 28 Feb 2020 11:17:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87tv3bmc8c.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/28/20 7:56 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>> On 2/27/20 3:55 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 2/27/20 3:52 PM, Markus Armbruster wrote:
>>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>>>
>>>>> This fixes when adding a 'Since' tag:
>>>>>
>>>>>  =C2=A0=C2=A0 In file included from qapi/qapi-schema.json:105:
>>>>>  =C2=A0=C2=A0 qapi/machine.json:25:1: '@arch:' can't follow 'Notes' s=
ection
>>>>
>>>> I'm confused.=C2=A0 This error is detected in scripts/qapi/parser.py, =
and it
>>>> is fatal.=C2=A0 Is the build broken for you?=C2=A0 It isn't for me.=C2=
=A0 Moreover,
>>>> where is @arch?=C2=A0 I can't see it anywhere close to the two spots t=
he
>>>> patch patches.
>>>
>>> I get the error after trying to fix what Eric commented here:
>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg682344.html
>>
>> Using:
>> ---
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 6c11e3cf3a..40a36d6276 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -20,13 +20,15 @@
>>   #        prefix to produce the corresponding QEMU executable name. Thi=
s
>>   #        is true even for "qemu-system-x86_64".
>>   #
>> +# @rx: since 5.0
>> +#
>>   # Since: 3.0
>>   ##
>>   { 'enum' : 'SysEmuTarget',
>>     'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32'=
,
>>                'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>>                'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>> -             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>> +             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>>                'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>>                'x86_64', 'xtensa', 'xtensaeb' ] }
>> ---
>>
>> or
>>
>> ---
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 6c11e3cf3a..4b59e87b6f 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -21,12 +21,14 @@
>>   #        is true even for "qemu-system-x86_64".
>>   #
>>   # Since: 3.0
>> +#
>> +# @rx: since 5.0
>>   ##
>>   { 'enum' : 'SysEmuTarget',
>>     'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32'=
,
>>                'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>>                'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>> -             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>> +             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>>                'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>>                'x86_64', 'xtensa', 'xtensaeb' ] }
>> ---
>>
>> I get:
>>
>>    GEN     qapi-gen
>>    GEN     rx-softmmu/config-devices.mak
>> In file included from qapi/qapi-schema.json:105:
>> qapi/machine.json:23:1: '@rx:' can't follow 'Notes' section
>> make: *** [Makefile:645: qapi-gen-timestamp] Error 1
>>
>> This works however:
>>
>> ---
>>   ##
>>   # @SysEmuTarget:
>>   #
>>   # The comprehensive enumeration of QEMU system emulation ("softmmu")
>>   # targets. Run "./configure --help" in the project root directory, and
>>   # look for the *-softmmu targets near the "--target-list" option. The
>>   # individual target constants are not documented here, for the time
>>   # being.
>>   #
>> +# @rx: since 5.0
>> +#
>>   # Notes: The resulting QMP strings can be appended to the "qemu-system=
-"
>>   #        prefix to produce the corresponding QEMU executable name. Thi=
s
>>   #        is true even for "qemu-system-x86_64".
>>   #
>>   # Since: 3.0
>>   ##
>>   { 'enum' : 'SysEmuTarget',
>>     'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32'=
,
>>                'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>>                'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>> -             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>> +             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>>                'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>>                'x86_64', 'xtensa', 'xtensaeb' ] }
>> ---
>=20
> This one adds it to the correct spot.

OK I'll use that then.

>=20
> qapi-code-gen.txt:
>=20
>      Definition documentation starts with a line naming the definition,
>      followed by an optional overview, a description of each argument (fo=
r
>      commands and events), member (for structs and unions), branch (for
>      alternates), or value (for enums), and finally optional tagged
>      sections.

I was confused because I understood "@rx: since 5.0" as a tagged=20
section, not as an "Optional overview".

>=20
> Let's apply this to SysEmuTarget's doc comment:
>=20
>      ##
>      # @SysEmuTarget:
>=20
> Line naming the definition
>=20
>      #
>      # The comprehensive enumeration of QEMU system emulation ("softmmu")
>      # targets. Run "./configure --help" in the project root directory, a=
nd
>      # look for the *-softmmu targets near the "--target-list" option. Th=
e
>      # individual target constants are not documented here, for the time
>      # being.
>=20
> Optional overview.
>=20
> Missing here: a description of each value.  We should enforce such
> descriptions.  We don't, mostly because we have a number of exceptions
> where documentation would be bothersome, such as enum QKeyCode.
>=20
>      #
>      # Notes: The resulting QMP strings can be appended to the "qemu-syst=
em-"
>      #        prefix to produce the corresponding QEMU executable name. T=
his
>      #        is true even for "qemu-system-x86_64".
>=20
> A tagged section.
>=20
>      #
>      # Since: 3.0
>=20
> Another tagged section.
>=20
>      ##
>=20
> Note that qapi-code-gen.txt prescribes no order for the tagged
> sections.  They actually occur in pretty much any order:
>=20
>      $ awk '/^##/ { if (on) { if (length(t) > 1) print t; t=3D"" } on=3D!=
on } on && /^# (Returns|Since|Notes?|Examples?|TODO):/ { t=3Dt substr($2, 1=
, 1) }' qapi/*json | sort | uniq -c
>            1 ENS
>            2 ES
>            1 NES
>            1 NETS
>            1 NNSE
>            1 NRS
>            2 NRSE
>           14 NS
>           11 NSE
>            1 RE
>            6 RES
>            4 RNS
>            6 RNSE
>           23 RS
>           78 RSE
>            1 RSEEEE
>            3 RSEN
>           12 RSNE
>           55 SE
>            4 SN
>            2 SNE
>            2 SRNE
>            1 TRSE
>            1 TS
>            1 TSRE
>=20
> If you think tightening their order would improve the documentation, we
> should talk.

No thanks :)



Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCEEC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 06:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1430204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 06:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1430204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrytZ-0006Jg-2N
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 02:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50164)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hrysr-0005hk-Jh
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 02:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hrysq-000293-An
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 02:11:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37542)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hrysq-00025c-3R
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 02:11:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0F9E63083394;
 Mon, 29 Jul 2019 06:11:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DAF65D6A9;
 Mon, 29 Jul 2019 06:11:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 858CB1138619; Mon, 29 Jul 2019 08:11:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
References: <cover.1563224628.git.DirtY.iCE.hu@gmail.com>
 <8245dab2e59b99b55f3f7773fd39dc920ae48951.1563224628.git.DirtY.iCE.hu@gmail.com>
 <878ssyqyyu.fsf@dusky.pond.sub.org>
 <b8009305-9e17-97e5-a57d-f78dd111f55b@gmail.com>
 <87lfwqywsa.fsf@dusky.pond.sub.org>
 <59720be5-241e-be50-2b0f-be611cff7dbc@gmail.com>
 <58139154-2d7c-2eb0-f1a7-c5f57868f657@gmail.com>
Date: Mon, 29 Jul 2019 08:11:35 +0200
In-Reply-To: <58139154-2d7c-2eb0-f1a7-c5f57868f657@gmail.com>
 (=?utf-8?B?IlpvbHTDoW4JS8WRdsOhZ8OzIidz?= message of "Sun, 28 Jul 2019
 17:08:29 +0200")
Message-ID: <87sgqptlns.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 29 Jul 2019 06:11:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 03/14] audio: add audiodev property to
 vnc and wav_capture
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
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3" <dirty.ice.hu@gmail.com> writes:

> On 2019-07-28 15:42, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 wrote:
>> On 2019-07-22 16:21, Markus Armbruster wrote:
>>> "Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3" <dirty.ice.hu@gmail.com> writes:
>>>
>>>> On 2019-07-16 08:23, Markus Armbruster wrote:
[...]
>>>>>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>>>>>> index bfa5681dd2..fa7f009268 100644
>>>>>> --- a/hmp-commands.hx
>>>>>> +++ b/hmp-commands.hx
>>>>>> @@ -819,16 +819,19 @@ ETEXI
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "wavcapture",
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .args_type=C2=A0 =3D "pa=
th:F,freq:i?,bits:i?,nchannels:i?",
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .params=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D "path [frequency [bits [channels]]]",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .args_type=C2=A0 =3D
>>>>>> "path:F,freq:i?,bits:i?,nchannels:i?,audiodev:s?",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .params=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D "path [frequency [bits [channels
>>>>>> [audiodev]]]]",
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .help=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "capture audio to a wave file (def=
ault
>>>>>> frequency=3D44100 bits=3D16 channels=3D2)",
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cmd=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D hmp_wavcapture,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>>>>> =C2=A0=C2=A0 STEXI
>>>>>> -@item wavcapture @var{filename} [@var{frequency} [@var{bits}
>>>>>> [@var{channels}]]]
>>>>>> +@item wavcapture @var{filename} [@var{frequency} [@var{bits}
>>>>>> [@var{channels} [@var{audiodev}]]]]
>>>>>> =C2=A0=C2=A0 @findex wavcapture
>>>>>> -Capture audio into @var{filename}. Using sample rate @var{frequency}
>>>>>> -bits per sample @var{bits} and number of channels @var{channels}.
>>>>>> +Capture audio into @var{filename} from @var{audiodev}, using
>>>>>> sample rate
>>>>>> +@var{frequency} bits per sample @var{bits} and number of channels
>>>>>> +@var{channels}. When not using an -audiodev argument on command lin=
e,
>>>>>> +@var{audiodev} must be omitted, otherwise is must specify a valid
>>>>>> +audiodev.
>>>>>
>>>>> I can see the code for "must specify a valid audiodev" in
>>>>> hmp_wavcapture().=C2=A0 Where is "must be omitted" checked?
>>>>
>>>> It's not checked right now, but if the user specifies audiodev, it
>>>> must be a valid audiodev id.=C2=A0 So if the user can guess the id (wh=
ich
>>>> is not too hard ATM, it's simply the driver's name), it will work even
>>>> in this case.
>>>>
>>>>> Preexisting: the list "sample rate @var{frequency} bits per sample
>>>>> @var{bits} and number of channels @var{channels}" lacks a comma after
>>>>> @var{frequency}, please fix that.=C2=A0 I'd put one after @var{bits}
>>>>> as well,
>>>>> but that's a matter of taste[*]
>>>>>
>>>>> The sentence is of the form "if not COND then A else B".=C2=A0 The
>>>>> less-negated form "if COND then B else A" is commonly easier to read.
>>>>>
>>>>> Documentation says "from @var{audiodev}".=C2=A0 But when "not using an
>>>>> -audiodev argument on command line, +@var{audiodev} must be omitted".
>>>>> Where does it sample from then?=C2=A0 I figure from some default audio
>>>>> device.=C2=A0 Where is that default audio device explained?=C2=A0 I s=
kimmed the
>>>>> -audiodev documentation in qemu-options.hx, but couldn't see it there.
>>>>
>>>> Currently there are two ways to specify audio options, the legacy ones
>>>> using the QEMU_AUDIO_* environment variables, and the new one using
>>>> -audiodev arguments.=C2=A0 The two formats cannot be mixed, and eventu=
ally
>>>> we should remove the legacy ones (IIRC my previous patch series
>>>> already deprecated them), then we can get rid of this madness.=C2=A0 M=
aybe
>>>> something like "When using the legacy environment variable based audio
>>>> config, @var{audiodev} must be omitted." would be better?
>>>
>>> What about effectively de-documenting the deprecated method?=C2=A0 I.e.=
 write
>>> as if it was already gone.=C2=A0 This should result in more readable
>>> documentation.
>>
>> Makes sense.=C2=A0 User will less likely use deprecated methods that way
>> and it simplifies the documentation.
>>
>>> Double-checking: will audiodev become mandatory once the deprecated
>>> method is gone?
>>
>> Yes.
>
> Actually, now that I took a second look at the params, it might be
> problematic.  Currently audiodev is the last parameter, so if it
> becomes mandatory, that will effectively mean other parameters will
> become mandatory too.  And if I were to change the order and move
> audiodev first, that would break backward compatibility during the
> deprecation period.

HMP is not a stable interface.  We can break compatibility there when we
have a reason.

In this case, we can either break it right away (insert audiodev before
the other optional parameters), or later (insert it last, move it when
it becomes mandatory).  Matter of taste.  I'd break it right away.


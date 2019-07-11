Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EEAC74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE54320872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE54320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlaDN-0002My-Vh
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 10:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36806)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hlaCu-0001y7-JU
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hlaCt-0004dy-D2
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:38:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48380)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hlaCt-0004bt-4H
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:37:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B3735308213B;
 Thu, 11 Jul 2019 14:37:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15CE860928;
 Thu, 11 Jul 2019 14:37:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8C2501138648; Thu, 11 Jul 2019 16:37:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
 <597ee579c3d14ff6f0892ee9e1905cdb0e0990ad.1562695780.git.DirtY.iCE.hu@gmail.com>
 <87ef2yy1n4.fsf@dusky.pond.sub.org>
 <c0ada78b-6d77-936d-f059-3458ca74a156@gmail.com>
Date: Thu, 11 Jul 2019 16:37:53 +0200
In-Reply-To: <c0ada78b-6d77-936d-f059-3458ca74a156@gmail.com>
 (=?utf-8?B?IlpvbHTDoW4JS8WRdsOhZ8OzIidz?= message of "Wed, 10 Jul 2019
 21:37:31 +0200")
Message-ID: <87bly0iqm6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 11 Jul 2019 14:37:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 02/11] audio: basic support for multi
 backend audio
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3" <dirty.ice.hu@gmail.com> writes:

> On 2019-07-10 06:06, Markus Armbruster wrote:
>> "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com> writes:
>>=20
>>> Audio functions no longer access glob_audio_state, instead they get an
>>> AudioState as a parameter.  This is required in order to support
>>> multiple backends.
>>>
>>> glob_audio_state is also gone, and replaced with a tailq so we can store
>>> more than one states.
>>>
>>> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
>>> ---
>> [...]
>>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>>> index bfa5681dd2..23196da3fe 100644
>>> --- a/hmp-commands.hx
>>> +++ b/hmp-commands.hx
>>> @@ -819,16 +819,17 @@ ETEXI
>>>=20=20
>>>      {
>>>          .name       =3D "wavcapture",
>>> -        .args_type  =3D "path:F,freq:i?,bits:i?,nchannels:i?",
>>> -        .params     =3D "path [frequency [bits [channels]]]",
>>> +        .args_type  =3D "path:F,freq:i?,bits:i?,nchannels:i?,audiodev:=
s?",
>>> +        .params     =3D "path [frequency [bits [channels [audiodev]]]]=
",
>>>          .help       =3D "capture audio to a wave file (default frequen=
cy=3D44100 bits=3D16 channels=3D2)",
>>>          .cmd        =3D hmp_wavcapture,
>>>      },
>>>  STEXI
>>> -@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{cha=
nnels}]]]
>>> +@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{cha=
nnels} [@var{audiodev}]]]]
>>>  @findex wavcapture
>>> -Capture audio into @var{filename}. Using sample rate @var{frequency}
>>> -bits per sample @var{bits} and number of channels @var{channels}.
>>> +Capture audio into @var{filename} from @var{audiodev}. Using sample ra=
te
>>> +@var{frequency} bits per sample @var{bits} and number of channels
>>> +@var{channels}.
>>>=20=20
>>>  Defaults:
>>>  @itemize @minus
>>    @item Sample rate =3D 44100 Hz - CD quality
>>    @item Bits =3D 16
>>    @item Number of channels =3D 2 - Stereo
>>    @end itemize
>>    ETEXI
>>=20
>> Defaults for the other optional arguments are listed here.  Why not for
>> @audiodev?
>
> There's no default listed because there's no default when you use the
> -audiodev options, since there's no good default.  When you don't use
> -audiodev, it'll use the implicitly created audiodev which doesn't have
> a name, so it can't be specified.

Double-checking to avoid misunderstandings: there is a default
*behavior*, but no default *value*, i.e. there is no VALUE that makes
audiodev=3DVALUE give you the same behavior as no audiodev.  Correct?

>                                    But I agree that this situation
> should be documented somehow.

Yes, please.

>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>> index 9621e934c0..0111055aa4 100644
>>> --- a/qemu-options.hx
>>> +++ b/qemu-options.hx
>>> @@ -1978,6 +1978,11 @@ can help the device and guest to keep up and not=
 lose events in case
>>>  events are arriving in bulk.  Possible causes for the latter are flaky
>>>  network connections, or scripts for automated testing.
>>>=20=20
>>> +@item audiodev=3D@var{audiodev}
>>> +
>>> +Use the specified @var{audiodev} when the VNC client requests audio
>>> +transmission.
>>> +
>>=20
>> What's the default?
>
> It's the same story as wav_capture.
>
> Regards,
> Zoltan


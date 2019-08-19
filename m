Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3218C3A59D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 11:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7741420851
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 11:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7741420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzfk1-0004nX-H8
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 07:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hzfjP-0004NP-Gg
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hzfjO-0005Ig-2T
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:21:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hzfjN-0005IO-Rm
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:21:46 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D33EA2A09C1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 11:21:44 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id b135so210153wmg.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 04:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bVLkRqQ+N8bR16Wuj67RcbmRjq8W3/TIMhEZCcXrnYo=;
 b=DeDpxRIFQPJRoZo2teJ+p/iC3R6qec5v7KxMO3dgYnR4Ji7R64lWbJCa6XLY+A14Ox
 GEhHN2apYryuW3loERldFi5ClW0T3jEqb83Te33DqPyJBamHyCctdcuXWGdw4F9pc9Xy
 t39epE1VIvONDeJCfAIKYh/xHvdZIpzS+zNdOjNiDtYymEe2bCFEKGiBpcZWY1pNV41z
 DtMTXxq1Itq29PQgqT39I5O3/mFwiG2GNjhlbfEHMTsJAoJh/N2e/TwqiiE0NzJHZGpx
 xAV+7I88BAmYQKp8s0GKB8M8aYmu8NxkiO2wM4I2lTLRc378f0pRErkGa2qFv9bFKOKF
 CveA==
X-Gm-Message-State: APjAAAUpyyrZJi/9Rtb6PcmhUO+jNffzpHVJK0QGMFh3C7RukJM/QF2h
 7FvaHKa45I5HOaAq4WTB+X/OIh2PQnKKGj1NZTeQWitk1xMS/JML/usYJRbU+imfP+PdnXT2/G5
 s8eKFPriVv43D0c8=
X-Received: by 2002:adf:dd88:: with SMTP id x8mr28335509wrl.331.1566213703164; 
 Mon, 19 Aug 2019 04:21:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz222p1eVRW+lbBrRC4Krg6CzExJhFgKKBa3r7EwUTaxDUJ1+tvT3NBcyBMlcSAqVXga44E6g==
X-Received: by 2002:adf:dd88:: with SMTP id x8mr28335479wrl.331.1566213702945; 
 Mon, 19 Aug 2019 04:21:42 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id g15sm16446271wrp.29.2019.08.19.04.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2019 04:21:42 -0700 (PDT)
To: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>,
 qemu-devel@nongnu.org
References: <cover.1566168923.git.DirtY.iCE.hu@gmail.com>
 <ed35e9e72aa77c9376e9c8a8f3a5443703fe6fbe.1566168923.git.DirtY.iCE.hu@gmail.com>
 <4db4fa19-65f5-0bc8-3354-a1779bbdb0f3@redhat.com>
 <5b788626-f2bd-68a2-5825-2ad5b96ff221@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6a17304f-d9c2-0b98-e641-598e141107d1@redhat.com>
Date: Mon, 19 Aug 2019 13:21:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5b788626-f2bd-68a2-5825-2ad5b96ff221@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 14/14] audio: fix memory leak reported
 by ASAN
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/19 4:05 AM, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 wrote:
> Hi,
>=20
> On 2019-08-19 01:25, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Zolt=C3=A1n,
>>
>> On 8/19/19 1:06 AM, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n wrote:
>>> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail=
.com>
>>> ---
>>>  audio/audio.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/audio/audio.c b/audio/audio.c
>>> index 924dddf2e7..9b28abca14 100644
>>> --- a/audio/audio.c
>>> +++ b/audio/audio.c
>>> @@ -1343,6 +1343,12 @@ static void free_audio_state(AudioState *s)
>>>          qapi_free_Audiodev(s->dev);
>>>          s->dev =3D NULL;
>>>      }
>>> +
>>> +    if (s->ts) {
>>> +        timer_free(s->ts);
>>> +        s->ts =3D NULL;
>>> +    }
>>
>> Why not directly fix audio_cleanup() previous to your series?
>=20
> I didn't really think about it.  When I found the memory leak and
> figured out it wasn't made by one of my patches, I just patched it on
> top of my worktree.

I see. QEMU does 'stable' releases from time to time. These releases
contain security/bug fixes, and no new features. Sometimes important
memory leaks are fixed in stable release.
If this patch is at the beginning of your series, it might be selected
for stable release. If it is after you introduced your feature it won't.

If you have to respin your series, consider reordering this fix for
stable inclusion.

Meanwhile,
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>>
>>> +
>>>      g_free(s);
>>>  }
>>> =20
>>>
>=20
> Regards,
> Zoltan
>=20


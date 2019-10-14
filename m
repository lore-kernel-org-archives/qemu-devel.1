Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF56DECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 09:15:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C307420873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 09:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C307420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJwRf-0004wC-J1
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 05:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iJwQm-00045M-O6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iJwQl-0000i7-Ay
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:14:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57588)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iJwQl-0000hO-2n
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:14:19 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F2CDE81DEB
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:14:17 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id c6so1917630wrp.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 02:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dswhmYJnd4az4t6sEaGKX75B5mv4yhM8JZRUNZUygTY=;
 b=ql1zVhouXnGjIFcmSbbz3nPqnc+SjuA0dC44uOps1GsF16Umf5MEnURreDdOsBpdZp
 nUNyWIGtm1lyg5YpB9r/6eRZXMP8lqUBH/jff/uHGpjyb+cnEEDY5GWbxciYXc1lCtaA
 zTYFHwYuAQQrWaWuje6xddcgDaLi2YM40KKCiRWEeJ5r/CshwlGvU+4iTNsL//tuy+Gl
 0618FdwlKSBm8rRJKLwBgta2M2rQUuLkakEbm2sfhsjdcSPZ9hRaO6Cub5D1HavUesLP
 xn7BP9crrY1VHlP2iaI0ujnbRT+VKqdMJ0LF1OfSABl10saupTojrj72WkUm3z4GmSSU
 jbPQ==
X-Gm-Message-State: APjAAAVx240wzhFlU6/F3EYzRhZACrS4pSlWlab0N+0ddi9XM4e+05sM
 pkecC5sMnetEjwKppYp4NSbIxvjZmniqwuSp5oyvlRNd4Ehd6io9JDR0KCMsqvbNnrCPPKcPoP0
 LVEGPENlBa1sope0=
X-Received: by 2002:a1c:5409:: with SMTP id i9mr14427225wmb.120.1571044456512; 
 Mon, 14 Oct 2019 02:14:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx0ui6WZ6Tz52JE/AM3Ic3F9gN4Czl4D+1ouX15AmX3D6hSy8yfRD4ZA/BSGF5clUPYZzP9sg==
X-Received: by 2002:a1c:5409:: with SMTP id i9mr14427203wmb.120.1571044456251; 
 Mon, 14 Oct 2019 02:14:16 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id t8sm16290296wrx.76.2019.10.14.02.14.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2019 02:14:15 -0700 (PDT)
Subject: Re: [RFC v5 121/126] hw/sd/ssi-sd.c: introduce ERRP_AUTO_PROPAGATE
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Eric Blake <eblake@redhat.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-122-vsementsov@virtuozzo.com>
 <fe720ff6-0949-fced-8d33-2e8dcb5d568a@redhat.com>
 <8af36e08-26ce-4a49-00f8-a50affe0132f@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a8610c4e-2f33-a348-e44e-688e6ca3c4e1@redhat.com>
Date: Mon, 14 Oct 2019 11:14:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <8af36e08-26ce-4a49-00f8-a50affe0132f@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 11:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.10.2019 9:33, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 10/11/19 6:05 PM, Vladimir Sementsov-Ogievskiy wrote:
>>> If we want to add some info to errp (by error_prepend() or
>>> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
>>> Otherwise, this info will not be added when errp =3D=3D &fatal_err
>>> (the program will exit prior to the error_append_hint() or
>>> error_prepend() call).=C2=A0 Fix such cases.
>>>
>>> If we want to check error after errp-function call, we need to
>>> introduce local_err and than propagate it to errp. Instead, use
>>> ERRP_AUTO_PROPAGATE macro, benefits are:
>>> 1. No need of explicit error_propagate call
>>> 2. No need of explicit local_err variable: use errp directly
>>> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>>>  =C2=A0=C2=A0=C2=A0 &error_fatel, this means that we don't break erro=
r_abort
>>>  =C2=A0=C2=A0=C2=A0 (we'll abort on error_set, not on error_propagate=
)
>>>
>>> This commit (together with its neighbors) was generated by
>>>
>>> for f in $(git grep -l errp \*.[ch]); do \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 spatch --sp-file scripts/coccinelle/auto-pr=
opagated-errp.cocci \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 --macro-file scripts/cocci-macro-file.h --i=
n-place --no-show-diff $f; \
>>> done;
>>>
>>> then fix a bit of compilation problems: coccinelle for some reason
>>> leaves several
>>> f() {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 ...
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 ...
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 out:
>>> }
>>> patterns, with "out:" at function end.
>>>
>>> then
>>> ./python/commit-per-subsystem.py MAINTAINERS "$(< auto-msg)"
>>>
>>> (auto-msg was a file with this commit message)
>>>
>>> Still, for backporting it may be more comfortable to use only the fir=
st
>>> command and then do one huge commit.
>>>
>>> Reported-by: Kevin Wolf <kwolf@redhat.com>
>>> Reported-by: Greg Kurz <groug@kaod.org>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>  =C2=A0 hw/sd/ssi-sd.c | 14 ++++++++------
>>>  =C2=A0 1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
>>> index 91db069212..f42204d649 100644
>>> --- a/hw/sd/ssi-sd.c
>>> +++ b/hw/sd/ssi-sd.c
>>> @@ -241,10 +241,10 @@ static const VMStateDescription vmstate_ssi_sd =
=3D {
>>>  =C2=A0 static void ssi_sd_realize(SSISlave *d, Error **errp)
>>>  =C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0 ERRP_AUTO_PROPAGATE();
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ssi_sd_state *s =3D FROM_SSI_SLAVE(ss=
i_sd_state, d);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *carddev;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DriveInfo *dinfo;
>>> -=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qbus_create_inplace(&s->sdbus, sizeof=
(s->sdbus), TYPE_SD_BUS,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 DEVICE(d), "sd-bus");
>>> @@ -254,12 +254,14 @@ static void ssi_sd_realize(SSISlave *d, Error *=
*errp)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dinfo =3D drive_get_next(IF_SD);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 carddev =3D qdev_create(BUS(&s->sdbus=
), TYPE_SD_CARD);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dinfo) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_set_drive(cardd=
ev, "drive", blk_by_legacy_dinfo(dinfo), &err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_set_drive(cardd=
ev, "drive", blk_by_legacy_dinfo(dinfo),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 errp);
>>
>> This fits 72 chars, can you keep it in the same line?
>=20
> Honestly, I'd prefer not fixing code style in these 100 auto-generated =
commits...
> But if only you request this, it's not a problem.

Ah, Coccinelle added the newline. Hmm maybe there is a spatch argument=20
to set the maximum line length?

$ spatch --longhelp
[...]
   --linux-spacing               spacing of + code follows the=20
conventions of Linux
   --smpl-spacing                spacing of + code follows the semantic=20
patch
   --indent                      default indent, in spaces (no tabs)
   --max-width                   column limit for generated code

Have you tried --max-width? Maybe we need a combination with --smpl-spaci=
ng.

>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 object_property_set_bool(OBJECT(carddev), true, "=
spi", &err);
>>> -=C2=A0=C2=A0=C2=A0 object_property_set_bool(OBJECT(carddev), true, "=
realized", &err);
>>> -=C2=A0=C2=A0=C2=A0 if (err) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "failed =
to init SD card: %s", error_get_pretty(err));
>>> +=C2=A0=C2=A0=C2=A0 object_property_set_bool(OBJECT(carddev), true, "=
spi", errp);
>>> +=C2=A0=C2=A0=C2=A0 object_property_set_bool(OBJECT(carddev), true, "=
realized", errp);
>>> +=C2=A0=C2=A0=C2=A0 if (*errp) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "failed =
to init SD card: %s",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_get_pretty(*errp));
>>
>> Ditto...
>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0 }
>>>
>>
>> If possible please squash with "47/126 SD (Secure Card)"
>=20
> Hmm this is in separate, as it's unmaintained accordingly to MAINTAINER=
S. I'll rebase
> the next version on your MAINTAINERS-fixes and it should work.
>=20
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Thanks!
>=20


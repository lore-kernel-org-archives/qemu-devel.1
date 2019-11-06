Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FD9C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 19:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B933D20869
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 19:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5prZsiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B933D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSQrb-0001SP-TX
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 14:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iSQqP-0000Yp-Qa
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iSQqM-0005Fk-No
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:19:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35756
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iSQqM-0005FM-IV
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573067989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OXaroyROq13ng8ErYVmm+IAIe8TmM58oUiay5KwykvU=;
 b=M5prZsiHPnZVN9tX7mSD0iRFdFrcQQItlvGlYsBpHiXKFDjhPXbyVKLzwv13I2bL3sRXvT
 Q5YmG7i5I33fjks0PoBEmrzNLaqgIWhCctkUa8XR53oxjnpUqcuAcTaXWTC+dPhAsmXurr
 4pu3AxWHYe8Y/nVCsmezpRGnlPv05dw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-ushVc03sNkOm_RAyA73RgA-1; Wed, 06 Nov 2019 14:19:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D7401800D6B;
 Wed,  6 Nov 2019 19:19:43 +0000 (UTC)
Received: from [10.3.117.38] (ovpn-117-38.phx2.redhat.com [10.3.117.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3AF160BF4;
 Wed,  6 Nov 2019 19:19:42 +0000 (UTC)
Subject: Re: [PATCH v8 1/3] docs: improve qcow2 spec about extending image
 header
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191018094758.7124-1-vsementsov@virtuozzo.com>
 <20191018094758.7124-2-vsementsov@virtuozzo.com>
 <71ad0b78-65da-9a39-4c12-f78449cdca9c@redhat.com>
 <ba5ae50c-9406-5095-89ae-6a10893e452e@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8cfcca15-4018-2876-6d75-a4d5125beedc@redhat.com>
Date: Wed, 6 Nov 2019 13:19:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ba5ae50c-9406-5095-89ae-6a10893e452e@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ushVc03sNkOm_RAyA73RgA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 9:36 AM, Vladimir Sementsov-Ogievskiy wrote:

>> Maybe:
>>
>> if software doesn't know how to interpret the field, it may be safely ig=
nored unless a corresponding incompatible feature flag bit is set; however,=
 the field should be preserved unchanged when rewriting the image header.
>>
>>> +
>>> +For all additional fields zero value equals to absence of field (absen=
ce is
>>> +when field.offset + field.size > @header_length). This implies
>>> +that if software want's to set fields up to some field not aligned to =
multiply
>>> +of 8 it must align header up by zeroes. And on the other hand, if soft=
ware
>>> +need some optional field which is absent it should assume that it's va=
lue is
>>> +zero.
>>
>> Maybe:
>>
>> Each optional field that does not have a corresponding incompatible feat=
ure bit must support the value 0 that gives the same default behavior as wh=
en the optional field is omitted.
>=20
> Hmmm. That doesn't work, as "corresponding" is something not actually def=
ined. Consider our zstd extension.
>=20
> It has corresponding incompatible bit, therefore, this sentence doesn't a=
pply to it. But still, if incompatible bit is unset we can have this field.=
 And it's zero value must correspond
> to the absence of the field.
>=20
> So, additional field may use incomaptible bit only for subset of its valu=
es.
>=20
> But, I see, that you want to allow 0 value to not match field-absence if =
incompatible bit is set?

Not necessarily.  Rather, if the value of an unknown field can be safely=20
ignored, then it should default to 0.  If it cannot be safely ignored,=20
then that field will not be set to a non-zero value without also setting=20
an incompatible feature flag, so that software that does not know how to=20
interpret the field will fail to load the image because it also fails to=20
recognize the associated new incompatible feature bit.

But I'd really like Kevin's opinion on how much wording is worth adding.

>=20
> So, may be
>=20
> Additional fields has the following compatible behavior by default:

s/has/have/

>=20
> 1. If software doesn't know how to interpret the field, it may be safely =
ignored, other than preserving the field unchanged when rewriting the image=
 header.
> 2. Zeroed additional field gives the same behavior as when this field is =
omitted.

Both good.

>=20
> This default behavior may be altered with help of incompatible feature bi=
ts. So, if, for example, additional field has corresponding incompatible fe=
ature bit, and it is set, we are sure that software which opens the image k=
nows how to interpret the field, so,
> 1. The field definitely will not be ignored when corresponding incompatib=
le bit is set.
> 2. The field may define any meaning it wants for zero value for the case =
when corresponding incompatible bit is set.

Rather wordy but seems accurate.  Perhaps compress it to:

3. Any additional field whose value must not be ignored for correct=20
handling of the file will be accompanied by a corresponding incompatible=20
feature bit.

and maybe even reorder it to list the points as:

Additional fields have the following compatibility rules:
1. Any additional field whose value must not be ignored for correct=20
handling of the file will be accompanied by a corresponding incompatible=20
feature bit.
2. If there are no unrecognized incompatible feature bits set, an=20
additional field may be safely ignored other than preserving its value=20
when rewriting the image header.
3. An explicit value of 0 will have the same behavior as when the field=20
is not present.


>>> +It's allowed for the header end to cut some field in the middle (in th=
is case
>>> +the field is considered as absent), but in this case the part of the f=
ield
>>> +which is covered by @header_length must be zeroed.
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 < ... No additional fields =
in the header currently ... >
>>
>> Do we even still need this if we require 8-byte alignment?=C2=A0 We'd ne=
ver be able to cut a single field in the middle
>=20
> hmm, for example:
> 105: compression byte
> 106-113: some other 8-bytes field, unalinged
> 113-119: padding to multiply of 8
>=20
> - bad example, for sure. But to prevent it, we should also define some fi=
eld alignment requirements..
>=20
>=20
>> , but I suppose you are worried about cutting a 2-field 16-byte addition=
 tied to a single feature in the middle.
>=20
> and this too.
>=20
>>  =C2=A0 But that's not going to happen in practice.
>=20
> why not?
>=20
> 4 bytes: feature 1
>=20
> 4 bytes: feature 2
> 8 bytes: feature 2
>=20
> so, last 12 bytes may be considered as one field.. And software which don=
't know about feature2, will pad header to the middle of feature2
>=20
>> The only time the header will be longer than 104 bytes is if at least on=
e documented optional feature has been implemented/backported, and that fea=
ture will be implemented in its entirety.=C2=A0 If you backport a later fea=
ture but not the earlier, you're still going to set header_length to the bo=
undary of the feature that you ARE backporting.
>=20
> That's true, of course.
>=20
>>  =C2=A0 Thus, I argue that blindly setting header_length to 120 prior to=
 the standard ever defining optional field(s) at 112-120 is premature, and =
that if we ever add a feature requiring bytes 112-128 for a new feature, yo=
u will never see a valid qcow2 file with a header length of 120.
>=20
> consider my example above.

As long as we never add new fields that are not 8-byte aligned=20
(including any explicit padding), then we will never have the case of=20
dividing fields in the middle by keeping the header length a multiple of 8.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



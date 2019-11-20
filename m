Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AA7C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B409E2230E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWLD9VPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B409E2230E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXQsT-0001R6-TM
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iXQrm-0000yx-NL
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:22:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iXQrl-0000Fa-A1
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:21:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47200
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iXQrl-0000FO-56
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574259716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5luUpTg0UAQzehg3fBXLY58EYWPcWVDvALjsMciE1GU=;
 b=JWLD9VPY754/dughTP/1f11/UPIIs4KN5XRbPimJwRwce2bYUTc7Gn3+UUJKTVOhXsHwOx
 LQ+b6zs40sNawLFt0JezeHIJEpQBAMlXgK/zInZD8+S1jqgWCSNB3Du+uPs/zCfcvTQ0ms
 vezlWYo41iUcUMRpQNdg9UImWO6mBbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-LAyYOOCfO8GIMU9vDSJazg-1; Wed, 20 Nov 2019 09:21:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63473800A02;
 Wed, 20 Nov 2019 14:21:51 +0000 (UTC)
Received: from [10.36.118.126] (unknown [10.36.118.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5EA91024704;
 Wed, 20 Nov 2019 14:21:48 +0000 (UTC)
Subject: Re: [PATCH v1 0/2] s390x/cpumodel: Introduce "best" model variants
To: Eduardo Habkost <ehabkost@redhat.com>
References: <3aa1d025-20a3-e813-2fe6-35518efedf2f@redhat.com>
 <20191118184906.GB3812@habkost.net>
 <CAFEAcA_iTX2TKh20DB9ZMtDLuPm=OvoyP==KRhfVh99BqDnrzA@mail.gmail.com>
 <20191118220417.GF3812@habkost.net>
 <CAFEAcA8XoyeAfHuKe0AEvecCzo748Yk1VD1+VD=C3ACZdfzwsw@mail.gmail.com>
 <ca517ad9-46bb-c0ac-2227-a64ab8fe5e15@redhat.com>
 <CAFEAcA-egL5kbo81eBT+FVBz7vSaWqUVzFUF3MNOttnzY6vZMQ@mail.gmail.com>
 <1fd9876d-5ad9-15e9-a2dc-6e5e747f9ca8@redhat.com>
 <20191119194238.GJ3812@habkost.net>
 <cad42cd6-2f0c-b3c6-7c96-d3a34b265a00@redhat.com>
 <20191120140407.GN3812@habkost.net>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <fc2e8ae8-eb47-7196-460e-ad09a2562603@redhat.com>
Date: Wed, 20 Nov 2019 15:21:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120140407.GN3812@habkost.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: LAyYOOCfO8GIMU9vDSJazg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Michael Mueller <mimu@linux.ibm.com>,
 Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20.11.19 15:04, Eduardo Habkost wrote:
> On Wed, Nov 20, 2019 at 11:28:29AM +0100, David Hildenbrand wrote:
>> On 19.11.19 20:42, Eduardo Habkost wrote:
>>> On Tue, Nov 19, 2019 at 12:00:14PM +0100, David Hildenbrand wrote:
>>>> On 19.11.19 11:36, Peter Maydell wrote:
>>>>> On Tue, 19 Nov 2019 at 09:59, David Hildenbrand <david@redhat.com> wr=
ote:
>>>>>>
>>>>>> On 19.11.19 10:22, Peter Maydell wrote:
>>>>>>> I don't hugely care about query-cpu-model-expansion. I
>>>>>>> just don't want it to have bad effects on the semantics
>>>>>>> of user-facing stuff like x- properties.
>>>>>>
>>>>>> IMHO, max should really include all features (yes, also the bad
>>>>>> x-features on arm :) ) and we should have a way to give users the
>>>>>> opportunity to specify "just give me the best model independent of t=
he
>>>>>> accelerator" - something like a "best" model, but I don't care about=
 the
>>>>>> name.
>>>
>>> I'm in agreement with Peter, here: if "max" is user-visible, it's
>>> better to make it provide more usable defaults.
>>
>> Agreed, unless we warn the user about the model.
>>
>>>>>
>>>>> How would "max includes all features" work if we have two
>>>>> x- features (or even two normal features!) which are incompatible
>>>>> with each other? How does it work for features which are
>>>>
>>>> I assume the "max" model should at least be consistent, see below.
>>>>
>>>>> valid for some other CPU type but not for 'max'? The design
>>>>> seems to assume a rather simplified system where every
>>>>> feature is independent and can always be applied to every
>>>>> CPU, which I don't think is guaranteed to be the case.
>>>>
>>>> I do agree that the use case of "max" for detecting which features can=
 be
>>>> enabled for any CPU model is quite simplified and would also not work =
like
>>>> this on s390x. It really means "give me the maximum/latest/greatest yo=
u
>>>> can". Some examples on s390x:
>>>>
>>>> On s390x, we don't allow to enable new features for older CPU generati=
on.
>>>> "vx" was introduced with a z13. If "max" is a z13, it can include "vx"=
, if
>>>> available. However, if you select a z12 (zEC12), you cannot enable "vx=
":
>>>>
>>>> "Feature '%s' is not available for CPU model '%s', it was introduced w=
ith
>>>> later models."
>>>>
>>>> Also, we have dependency checks
>>>> (target/s390x/cpu_models.c:check_consistency()), that at least warn on
>>>> inconsistencies between features (feature X requires feature Y).
>>>>
>>>> We would need more fine-grained "max" models. E.g., z13-max vs. z13-be=
st vs.
>>>> z13-base.
>>>>
>>>> - z13-max: Maximum features that can be enabled on the current
>>>>              accel/host for a z13.
>>>> - z13-best: Best features that can be enabled on the current
>>>>              accel/host for a z13.
>>>> - z13-base: base feature set, independent of current
>>>>              accel/host for a z13. (we do have this already on s390x)
>>>
>>> We don't need to create new CPU types for that, do we?  These
>>> different modes could be configured by a CPU option (e.g.
>>> "z13,features=3Dmax"[1], "z13,features=3Dbest").
>>
>> I somewhat don't like such options mixed into ordinary feature configura=
tion
>> if we can avoid it. It allows for things like
>>
>> z13,features=3Dmax,features=3Dbest
>>
>> The z13 model is migration-safe. So would be "z13,vx=3Doff".
>> "z13,features=3Dbest" would no longer be migration safe.
>>
>> IOW, reusing an existing model along with that feels wrong, read below.
>> Especially, I dislike that one config option (features=3Dbest) disables =
and
>> enables features at the same time. Read below.
>>
>>>
>>> If we do add new CPU options to tune feature defaults, libvirt
>>> can start using these options on query-cpu-model-expansion, and
>>> everybody will be happy.  No need to change defaults in the "max"
>>> CPU model in a way that makes it less usable just to make
>>> query-cpu-model-expansion work.
>>>
>>> [1] Probably we need to call it something else instead of
>>>       "features=3Dmax", just to avoid confusion with the "max" CPU
>>>       model.  Maybe "experimental-features=3Don",
>>>       "recommended-features=3Don"?
>> We already do have feature groups on s390x. So these could behave like
>> "host/accelerator dependent" feature groups. I would prefer that over th=
e
>> suggestion above.
>>
>> The only downside is that z13,recommended-features=3Don could actually
>> "disable" features that are already in z13 (e.g., "vx" is part of z13, b=
ut
>> if it's not available in the host we would have to disable it). I don't =
like
>> these semantic. Maybe introducing new types of models that don't have an=
y
>> features as default could come into play.
>>
>> E.g.,
>>
>> z13-best =3D> z13-raw,recommended-features=3Don
>> z13-max =3D> z13-raw,recommended-features=3Don,experimental-features=3Do=
n
>>
>> Maybe we can find a better name for "recommended-features" and
>> "experimental-features" to highlight that these are only "features avail=
able
>> via the accelerator in the current host"
>>
>> We could also expose:
>>
>> z13-full =3D> z13-raw,all-features=3Don
>>
>> Which would include all features theoretically valid for a model (but ev=
en
>> if not available).
>=20
> I don't have a strong opinion on the specifics.  If you believe
> that's the best solution, I trust your judgement.
>=20
> My only point was that we don't always need to add new CPU types
> for every conceivable use case, and some (but not all) problems
> can be solved by simple new properties.

Makes sense.

>=20
> (To be honest, I'm now having trouble mapping these ideas to real
> world problems or use cases.  What are the specific problems
> we're trying to solve right now?)

I mostly only care about z13-best or "z13-raw,recommended-features=3Don"=20
for now. What's described in patch #2. Allow upper layers (or user on=20
the command line) get a CPU model that has the best features supported=20
by the accelerator on the current host. Esp., include new features to=20
mitigate security issues.


--=20

Thanks,

David / dhildenb



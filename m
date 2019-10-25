Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00431CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D5221872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1Jpf9md"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D5221872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO3Hl-00053m-O4
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 13:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iO3Fv-0001K0-7X
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 13:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iO3Ft-0004yt-FN
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 13:20:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56140
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iO3Ft-0004vY-1z
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 13:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572024003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3v+GSmMQPPkXsBm1xBxl1LmRHcfjOeWRWp+ur6ft3MY=;
 b=c1Jpf9mdeL4sJbLDcgwCW3DOcjwkpS3S3ZylLsog29PRjKh7f2qSyxwMtVW5BV6y0JbAzb
 HIqTnGMt9v4bvO1qVlFzMdVUOkUQg13eOa0p2Y9YFj4BhKmkaoZVkiatE3lDR+HpOSDJa6
 tHyDydZvzBltwwFErLcPHVDkUZ5n5KY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-mPiM2zDVPHmEGMfjNwL0yw-1; Fri, 25 Oct 2019 13:19:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5CDD800D41;
 Fri, 25 Oct 2019 17:19:58 +0000 (UTC)
Received: from [10.36.116.74] (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 804E45D70E;
 Fri, 25 Oct 2019 17:19:56 +0000 (UTC)
Subject: Re: [PATCH 0/7] i386: Add `machine` parameter to query-cpu-definitions
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191025022553.25298-1-ehabkost@redhat.com>
 <dbf9e4c1-0acf-9469-84f9-f80c41e2cae0@redhat.com>
 <6e7d171e-18c4-6835-f89c-e9e66c093d62@de.ibm.com>
 <4cd530f9-54f3-80e7-1b66-c91f71160062@redhat.com>
 <20191025140310.GB3581@redhat.com>
 <7a29438c-572d-5a26-a14f-717a177af4d1@redhat.com>
 <20191025150040.GC3581@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <92cda748-8cb0-e95d-8fe1-4f9632762f64@redhat.com>
Date: Fri, 25 Oct 2019 19:19:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025150040.GC3581@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: mPiM2zDVPHmEGMfjNwL0yw-1
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>> I once was told that if a user actually specified an explicit CPU model =
in
>> the libvirt XML ("haswell-whatever"), you should not go ahead and make a=
ny
>> later changes to that model (guest ABI should not change when you
>> update/restart the guest ...). So this only applies when creating new
>> guests? Or will you change existing model definitions implicitly?
>=20
> Libvirt will only ever expand a bare CPU model at time it first parses
> the XML. So if a mgmt app defines a new persistent guest in libvirt, the
> CPU is expanded them and remains unchanged thereafter, in order to preser=
ve
> ABI compat.

Okay, perfect.

>=20
> If using transient guests its different as libvirt doesn't store the conf=
ig
> in disk when the guest isn't running. So mgmt apps using transient guests
> are responsible  for picking a explicit versioned model themselves if the=
y
> need stable ABI.

That makes sense.

>=20
>>>> Then you can specify "-cpu z13-vX" or "-cpu z13 -cpuv X" (no idea how
>>>> versioned CPU model were implemented) on any QEMU machine. Which is th=
e same
>>>> as telling your customer "please use z13,featX=3Don" in case you have =
a good
>>>> reason to not use the host model (along with baselining) but use an ex=
plicit
>>>> model.
>>>>
>>>> If you can change the default model of QEMU machines, you can automate=
 this
>>>> process. I am pretty sure this is a corner case, though (e.g., IBRS).
>>>> Usually you have a new QEMU machine and can simply enable the new feat=
ure
>>>> from that point on.
>>>
>>> There are now 4 Haswell variants, only some of which are runnable
>>> on any given host, depending on what microcode the user has installed
>>> or what particular Haswell silicon SKU the user purchased. Given the
>>> frequency of new CPU flaws arrived since the first Meltdown/Spectre,
>>> this isn't a corner case, at least for the x86 world & Intel in
>>> particular. Other arches/vendors haven't been quite so badly affected
>>> in this way.
>>
>> On s390x you can assume that such firmware/microcode updates will be on =
any
>> machine after some time. That is a big difference to x86-64 AFAIK.
>=20
> I don't know s390x much, but can we really assume that users promptly
> install firmware updates, any better than users do for x86 or other
> arch. IME corporate beaurcracy can drag out time to update arbitrarily
> long.

That's what you get when you pay premium prices for premium support :D

The real issue when it comes to CPU models on s390x is the variance of=20
features of a specific model across environments (especially different=20
hypervisors).

>>> If we tied each new Haswell variant to a machine type, then users would
>>> be blocked from consuming a new machine type depending on runnability o=
f
>>> the CPU model. This is not at all desirable, as mgmt apps now have comp=
lex
>>> rules on what machine type they can use.
>>
>> So you actually want different CPU variants, which you have already, jus=
t in
>> a different form. (e.g., "haswell" will be mapped to "haswell-whatever",
>> just differently via versions)
>=20
> Yes, you can think of "Haswell", "Haswell-noTSX", "Haswell-noTSX-IBRS"
> as all being versions of the same thing. There was never any explicit
> association or naming though. So what's changing is that we're defining
> a sane naming scheme for the variants of each model so we don't end
> up with   "Haswell-noTSX-IBRS-SSBD-MDS-WHATEVER-NEXT-INTEL-FLAW-IS",
> and we declaring that a bare "Haswell" will expand to some "best"
> version depending on machine type (but also selectable by mgmt app
> above).

I mean, all you really want is a way to specify "give me the best=20
haswell you can do with this accelerator", which *could* map to "-cpu=20
haswell,tsx=3Doff,ibrs=3Don,ssbf=3Don" ... but also something else on the H=
W.

I really don't see why we need versioned CPU models for that, all you=20
want to do is apply delta updates to the initial model if possible on=20
the current accelerator. Just like HW does. See below for a simpler=20
approach.

>=20
>>> Both these called for making CPU versioning independant of machine
>>> type versioning.
>>>
>>> Essentially the goal with CPU versioning is that the user can request
>>> a bare "Haswell" and libvirt (or the mgmt app) will automatically
>>> expand this to the best Haswell version that the host is able to
>>> support with its CPUs / microcode / BIOS config combination.
>>
>>
>> So if I do a "-cpu haswell -M whatever-machine", as far as I understood
>> reading this,  I get the "default CPU model alias for that QEMU machine"=
 and
>> *not* the "best Haswell version that the host is able to support".
>>
>> Or does the default actually also depend on the current host?
>=20
> At the QEMU level "haswell" will expand to a particular CPU version
> per machine type. So yes, at the QEMU level machine types might have
> a dependancy on the host.
>=20
> Above QEMU though, libvirt/mgmt apps can be more dynamic in how they
> expand a bare "haswell" to take account of what the host supports.

Let me propose something *much* simpler which would work just fine on=20
s390x, and I assume on x86-64 as well.

On s390x we e.g. have the two models:
- "z14-base"
  -> minimum feature set we expect to have in every environment
  -> QEMU version/machine independent, will never change
- "z14"
  -> "default model", can change between QEMU machines
  -> migration-safe

Now, internally we have in addition something that matches:
- "z14-max"
  -> all possible CPU features valid for this model
  -> Includes e.g., nested virt features not in the "z14" model
  -> Can and will change between QEMU versions

Of course we also have:
- "max"
  -> "all features supported by the accelerator in the current host"

What we really want is:
- "z14-best"
  -> "best features for this model supported by the accelerator in the
      current host"

The trick is that *usually* :
=09"z14-best" =3D baseline("z14-max", "max")

Minor exceptions can be easily added (e.g., always disable a certain=20
feature). So, what I would be proposing for s390x (and also x86-64, but=20
I know that they have more legacy handling) is simply implementing and=20
exposing all -best models.


Why is this good in general?

1. No semantic changes of existing models. What was migration safe
    remains migration safe.
2. No CPU versions, less complexity.
3. No changes in the tool stack. Implement it in QEMU and it will be
    supported on every layer. Simply specify/expand "z14-best" and you
    get something that will run and make use of the best (on s390x
    usually all) features available that are valid for this model.

Why is this good for s390x?

1. As discussed, versioning all the different flavors we have is
    not feasible, nor practicable.

2. Features that are typically not around (especially, nested virt
    features) will be enabled similar to the host model when around.


I think I can hack a prototype of that in a couple of hours.

--=20

Thanks,

David / dhildenb



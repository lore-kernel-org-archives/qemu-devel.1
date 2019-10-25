Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9752BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F6320684
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0gLhhPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F6320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0QY-0006F9-Af
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iO0IV-00031s-1V
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iO0IS-0002l9-FA
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:10:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41240
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iO0IS-0002js-BT
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572012630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lHfFv+bHO4dxT3tpPi6gtPios1cSIlNl+dxlycDH5nc=;
 b=N0gLhhPy9iY2bK6KJ4LahZu3k+3ooLeqr7uxacG2E74rI3joOg2fH3I9pFi+kI+MEB8ma0
 gFyd8VjOapH49pMNTJ+77D5UQpcauNbs60VrjmQ2qDdakEfKVQDRkgzKeaknQZYRDi9plX
 4GhVPOr09eTpSj1552Z9RSrAaHgXA1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-W7ZfdaoOOFSSAg9OiMBCWg-1; Fri, 25 Oct 2019 10:10:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C2C4107AD31;
 Fri, 25 Oct 2019 14:10:25 +0000 (UTC)
Received: from [10.36.116.227] (ovpn-116-227.ams2.redhat.com [10.36.116.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7E6C5EE1D;
 Fri, 25 Oct 2019 14:10:11 +0000 (UTC)
Subject: Re: [PATCH 0/7] i386: Add `machine` parameter to query-cpu-definitions
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20191025022553.25298-1-ehabkost@redhat.com>
 <dbf9e4c1-0acf-9469-84f9-f80c41e2cae0@redhat.com>
 <20191025133846.GD6744@habkost.net>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <25e33d78-3d25-7ca9-6922-920846d0d98b@redhat.com>
Date: Fri, 25 Oct 2019 16:10:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025133846.GD6744@habkost.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: W7ZfdaoOOFSSAg9OiMBCWg-1
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, libvir-list@redhat.com,
 Cornelia Huck <cohuck@redhat.com>,
 Michal Skrivanek <michal.skrivanek@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.10.19 15:38, Eduardo Habkost wrote:
> CCing danpb, libvir-list, mskrivanek.
>=20
> On Fri, Oct 25, 2019 at 09:17:46AM +0200, David Hildenbrand wrote:
>> On 25.10.19 04:25, Eduardo Habkost wrote:
>>> We had introduced versioned CPU models in QEMU 4.1, including a
>>> method for querying for CPU model versions using
>>
>> Interesting, I was not aware of that.
>>
>> On s390x, we somewhat have versioned CPU models, but we decided against
>> giving them explicit names (e.g., z13-v1 or z13-4.1.0), because it didn'=
t
>> really seem to be necessary. (and we often implement/add features for ol=
der
>> CPU models, there is a lot of fluctuation) Actually, you would have had =
to
>> add "z13-z/VM-x.x.x" or "z13-LPAR-x.x.x" or "z13-KVM-x.x.x" to model the
>> features you actually see in all the different virtual environments ("wh=
at a
>> CPU looks like"). Not to talk about QEMU versions in addition to that. S=
o we
>> decided to always model what you would see under LPAR and are able to
>> specify for a KVM guest. So you can use "z13" in an up-to-date LPAR
>> environment, but not in a z/VM environment (you would have to disable
>> features).
>>
>> Each (!base) CPU model has a specific feature set per machine. Libvirt u=
ses
>> query-cpu-model-expansion() to convert this model+machine to a
>> machine-independent representation. That representation is sufficient fo=
r
>> all use cases we were aware of (esp. "virsh domcapabilities", the host C=
PU
>> model, migration).
>>
>> While s390x has versioned CPU models, we have no explicit way of specify=
ing
>> them for older machines, besides going over query-cpu-model-expansion an=
d
>> using expanded "base model + features".
>>
>> I can see that this might make sense on x86-64, where you only have mayb=
e 3
>> versions of a CPU (e.g., the one Intel messed up first - Haswell, the on=
e
>> Intel messed up next - Haswell-noTSX, and the one that Intel eventually =
did
>> right - Haswell-noTSX-IBRS) and you might want to specify "Haswell" vs.
>> "Haswell-IBRS" vs. "Haswell-noTSX-IBRS". But actually, you will always w=
ant
>> to go for "Haswell-noTSX-IBRS", because you can expect to run in updated
>> environments if I am not wrong, everything else are corner cases.
>>
>> Of course, versioned CPU model are neat to avoid "base model + list of
>> features", but at least for expanding the host model on s390x, it is not
>> really helpful. When migrating, the model expansion does the trick.
>>
>> I haven't looked into details of "how to specify or model versions". May=
be
>> IBM wants to look into creating versions for all the old models we had. =
But
>> again, not sure if that is of any help for s390x. CCing IBM.
>=20
> I'm not sure yet if there are the x86-specific goals and
> constraints that would make it difficult to follow the same
> approach followed by s390x.  I have the impression we do,
> but I need to think more carefully about it.
>=20
> Let's discuss that during KVM Forum?

I won't be attending KVM Forum this year, but Christian should be around.

>=20
> The two main goals of versioned CPU models in x86 are:
> 1) Decoupling CPU model updates from machine-types (users should be
>     able to update a CPU model definition without changing machine
>     type).
> 2) Letting management software automate CPU model updates.
>     Normally this is necessary when bare metal microcode or
>     software updates add/remove features from CPUs.  Sometimes the
>     Virtual CPU model update needs to be performed before the host
>     updates are applied (if features are being removed)

We have 2) on s390x after a QEMU machine update. You need a QEMU update=20
usually either way to support the new CPU feature. But I can see how=20
decoupling the CPU model definition from the machine makes this easier.=20
It does introduce complexity. It applies only when running older QEMU=20
machines, or if we have to update a CPU model before we get a new QEMU=20
machine.

But we do have versioned CPU models already, so the discussion is=20
already over :)

>=20
> The main constraint that makes it difficult to address the above
> without a new API is:
> A) Every CPU model in x86 except "host" is already expected to
>     be migration-safe (I don't know how this compares to s390x).

I would describe that not a bug but a feature :) It does come with the=20
price that only using the newest QEMU machine results in the newest CPU=20
model, that part I understand.

--=20

Thanks,

David / dhildenb



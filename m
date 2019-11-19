Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971B9C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9CA2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4iOCqh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9CA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX0In-0001dA-Fs
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 05:00:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iX0Hy-0001BL-VQ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:59:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iX0Hw-0001RZ-Sm
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:59:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26806
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iX0Hw-0001R2-Nn
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574157552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dP3vWiKP9TSPoer7coDxttsww5yKhJDxscwnpTkXDcQ=;
 b=B4iOCqh99S6hLpqxW6Y1Ztd06vxZzbFNVupY8u9v8O8WL8fSyGwYfpNKWzNB9k4mMQOzNz
 BpOURaQEYGcjwT5IHg97+1XfdyvwKQnRG8NG5uaLpiOdMMqXAv1ml+3XjSSWXubabt2cQs
 0xx5l6GGsuRpqAsYreFry5wC/Lv0M/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-Bi_ZxeQ6P6KYk7WNxyLsow-1; Tue, 19 Nov 2019 04:59:09 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89A7F85B6FE;
 Tue, 19 Nov 2019 09:59:07 +0000 (UTC)
Received: from [10.36.117.126] (ovpn-117-126.ams2.redhat.com [10.36.117.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E27810375D5;
 Tue, 19 Nov 2019 09:59:00 +0000 (UTC)
Subject: Re: [PATCH v1 0/2] s390x/cpumodel: Introduce "best" model variants
To: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <CAFEAcA-mD3-Zg2JunGpMqbcaT1qboCenhqEFytZD0FmFcL2i9Q@mail.gmail.com>
 <5dd613c0-6d9e-b943-b64d-7ba1791cbefe@redhat.com>
 <CAFEAcA-4r53vM-K24WYr1OFSOufhZ7hDHeZBhnywyaJ0gpMO1g@mail.gmail.com>
 <20191108191057.GZ3812@habkost.net>
 <CAFEAcA_No5oAFtULbAOrPDeQE18HHgc0agXbs4m2AGZ+gK_ReQ@mail.gmail.com>
 <66c64c6d-b7c0-2cb1-2b29-4fdd9b369714@redhat.com>
 <CAFEAcA-Q7H9sZjN-PcMMDHQU41yN1RdXhNY5KqMh7E6xh0yjgA@mail.gmail.com>
 <3aa1d025-20a3-e813-2fe6-35518efedf2f@redhat.com>
 <20191118184906.GB3812@habkost.net>
 <CAFEAcA_iTX2TKh20DB9ZMtDLuPm=OvoyP==KRhfVh99BqDnrzA@mail.gmail.com>
 <20191118220417.GF3812@habkost.net>
 <CAFEAcA8XoyeAfHuKe0AEvecCzo748Yk1VD1+VD=C3ACZdfzwsw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ca517ad9-46bb-c0ac-2227-a64ab8fe5e15@redhat.com>
Date: Tue, 19 Nov 2019 10:58:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8XoyeAfHuKe0AEvecCzo748Yk1VD1+VD=C3ACZdfzwsw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Bi_ZxeQ6P6KYk7WNxyLsow-1
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
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

On 19.11.19 10:22, Peter Maydell wrote:
> On Mon, 18 Nov 2019 at 22:04, Eduardo Habkost <ehabkost@redhat.com> wrote=
:
>>
>> On Mon, Nov 18, 2019 at 09:19:55PM +0000, Peter Maydell wrote:
>>> Why should it matter whether a feature is enabled
>>> or disabled by default in the CPU type? It ought to be probeable
>>> by QMP either way (ie there is a difference between
>>> "this CPU has this feature switch and it is on by default",
>>> "this CPU has this feature switch and it is off by default"
>>> and "this CPU does not have this feature switch at all",
>>> and presumably libvirt needs to distinguish them).
>>
>> Its use case is neither "this CPU has this feature switch" or for
>> "it is on|off by default".  We use it to probe for "this feature
>> can be enabled in this host hardware+kernel+QEMU combination".
>=20
> OK. Well, the answer to that depends on the name of the CPU,
> in general. So you can't use a fake CPU name to try to answer
> the question.
>=20
>> In other words, in x86 and s390x "max" is just a reserved name
>> for the query-cpu-model-expansion command arguments in s390x and
>> x86.  The fact that it is visible to users can be considered a
>> bug, and we can fix that.
>=20
> I think 'max' is useful to users, and we've provided it to users,
> so removing it again would be a compatibility break. I'm not
> entirely sure where we go from here...

I agree, right now on s390x "-cpu max" behaves almost like "-cpu=20
qemu"/"-cpu host", but you don't have to care about the accelerator.=20
Removing it might we evil. Removing it is not really an option.

>=20
>> If you still don't like how query-cpu-model-expansion works, we
>> can also discuss that.  But I'm not sure it would be a good use
>> of our (and libvirt developers') time.
>=20
> I don't hugely care about query-cpu-model-expansion. I
> just don't want it to have bad effects on the semantics
> of user-facing stuff like x- properties.

IMHO, max should really include all features (yes, also the bad=20
x-features on arm :) ) and we should have a way to give users the=20
opportunity to specify "just give me the best model independent of the=20
accelerator" - something like a "best" model, but I don't care about the=20
name.

E.g., we could introduce a new model for that purpose and start warning=20
if "-cpu max" is used (and recommend them to use the other model) to run=20
a VM and not simply to query model properties via the qmp interfaces.=20
The users are aware of the model restrictions and can switch.

--=20

Thanks,

David / dhildenb



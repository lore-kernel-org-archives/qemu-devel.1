Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B24BC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0453321D6C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emwCxC1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0453321D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT3gT-0006lM-1P
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 07:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iT3eY-0005KL-3v
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:46:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iT3eV-0003EF-UP
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:46:13 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59539
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iT3eV-0003Dt-QF
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573217170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SUo1SvmRW1T9BAStRLEJxmsliYF+9UWqSz6o0sDmKsg=;
 b=emwCxC1dc8yZmKE04eJUjd6mZBE5jw/DrPMGVDSh/KGgMPh0FgQxzsICed9bYqQk8kQBwP
 X05TEEhbimtkyfX67AxnpJg+ETfhGtLzXCoGe7XTq6+TUH/WXsvz6Cjdgn/dqG/HqqNHKW
 uUbyEOQsSmMqoCGf/ZznFSacrSfZ3nI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-y3ixSvJYPX6lHnb20KvhaA-1; Fri, 08 Nov 2019 07:46:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A14D58017DD;
 Fri,  8 Nov 2019 12:46:07 +0000 (UTC)
Received: from [10.36.117.63] (ovpn-117-63.ams2.redhat.com [10.36.117.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02AC060BE1;
 Fri,  8 Nov 2019 12:46:01 +0000 (UTC)
Subject: Re: [PATCH v1 0/2] s390x/cpumodel: Introduce "best" model variants
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191108110714.7475-1-david@redhat.com>
 <CAFEAcA-mD3-Zg2JunGpMqbcaT1qboCenhqEFytZD0FmFcL2i9Q@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5dd613c0-6d9e-b943-b64d-7ba1791cbefe@redhat.com>
Date: Fri, 8 Nov 2019 13:46:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-mD3-Zg2JunGpMqbcaT1qboCenhqEFytZD0FmFcL2i9Q@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: y3ixSvJYPX6lHnb20KvhaA-1
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Michael Mueller <mimu@linux.ibm.com>,
 Jiri Denemark <jdenemar@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08.11.19 12:10, Peter Maydell wrote:
> On Fri, 8 Nov 2019 at 11:08, David Hildenbrand <david@redhat.com> wrote:
>>
>> There was recently a discussion regarding CPU model versions. That conce=
pt
>> does not fit s390x where we have a lot of feature variability. I
>> proposed an alternative approach in [1], which might work for x86 as wel=
l
>> (but I am not sure if x86 still can or wants to switch to that), and
>> requires no real changes in upper layers.
>>
>> [1] and patch #2 contains more information on the motivation for this.
>>
>> E.g., specifying/expanding "z14-best" will result in the "best feature
>> set possible on this accelerator, hw and, firmware". While a "z13" does
>> not work under TCG and some z/VM versions, "z13-best" will work.
>=20
> I think other architectures call this concept "max", not "best".
> If we can manage some cross-architecture consistency that would
> be helpful, but is s390x using 'max' already for something else?

We have the "max" model just like other architectures

s390 max             Enables all features supported by the accelerator=20
in the current host

It is basically the "host" model under KVM, and the "qemu" model under=20
TCG (with minor differences for the latter).


This series introduces e.g.,

s390 z900-best       IBM zSeries 900 GA1 with best features supported by=20
the accelerator in the current host

s390 z14-best        IBM z14 GA1 with best features supported by the=20
accelerator in the current host

s390 z14ZR1-best     IBM z14 Model ZR1 GA1 with best features supported=20
by the accelerator in the current host

s390 gen15a-best     IBM z15 GA1 with best features supported by the=20
accelerator in the current host

s390 gen15b-best     IBM 8562 GA1 with best features supported by the=20
accelerator in the current host


There is a small but important difference between "max"/"host" and=20
"best". Max really means "all features", including deprecated ones.=20
"best", however, can disable experimental or deprecated features. Or any=20
other features we don't want to be enabled when somebody selects a model=20
manually.

On s390x, the feature "csske" is deprecated. New HW still has it, but we=20
want new guests to run without this facility. Dropping it from "max"=20
would affect existing setups. We already changed the default model=20
(e.g., -cpu z13) to disable it with never QEMU machines.

E.g., nested virtualization features on some architectures could be a=20
feature set you want to disable, although contained in the "max" model.=20
(e.g., no migration support yet).


I am not completely against calling these "max" models instead of "best"=20
models, but I think this makes it clearer that there is indeed a difference=
.

Maybe, we even want a "-cpu best" that would not map to "-cpu=20
host"/"-cpu max", but to a cleaned up "-cpu host"/"-cpu max" (e.g.,=20
disable deprecated features). Long term, we might even want to change=20
the default when no "-cpu" is specified to "-cpu best" - which should=20
now be possible with the latest QEMU changes to query the default model=20
for a specific QEMU machine.

--=20

Thanks,

David / dhildenb



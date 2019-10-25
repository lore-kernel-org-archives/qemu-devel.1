Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29721CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDCBE206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKRDlLFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDCBE206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuZF-0000i7-2o
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 04:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iNuYT-0007qq-7w
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iNuYR-0002Dh-9U
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:02:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23179
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iNuYR-0002DB-3L
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571990558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+SDVIfgo+/VQaO14ExbVrEsidOzMPOLpkOCvl/+2ejQ=;
 b=cKRDlLFtfaUstBxUoNG5RuWxZwuvGU4Ux/d5o+RcCvP/PRkxJxrrkjH07UF9YZciLZ/69A
 qr7pcVzXFVy/TsukNjovwFxC9NGYRKpXTQxK46ojZAETXd2L+G1zXc1OY3dymEsQctEPQQ
 +pViHV3oBWU7Gdo75Hrs1cAD0+uNyQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-q1qmSX4LM6aOXticw-XDBQ-1; Fri, 25 Oct 2019 04:02:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9DB85E6;
 Fri, 25 Oct 2019 08:02:32 +0000 (UTC)
Received: from [10.36.116.205] (ovpn-116-205.ams2.redhat.com [10.36.116.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93C881001B2D;
 Fri, 25 Oct 2019 08:02:30 +0000 (UTC)
Subject: Re: [PATCH 0/7] i386: Add `machine` parameter to query-cpu-definitions
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20191025022553.25298-1-ehabkost@redhat.com>
 <dbf9e4c1-0acf-9469-84f9-f80c41e2cae0@redhat.com>
 <6e7d171e-18c4-6835-f89c-e9e66c093d62@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4cd530f9-54f3-80e7-1b66-c91f71160062@redhat.com>
Date: Fri, 25 Oct 2019 10:02:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <6e7d171e-18c4-6835-f89c-e9e66c093d62@de.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: q1qmSX4LM6aOXticw-XDBQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.10.19 09:55, Christian Borntraeger wrote:
>=20
>=20
> On 25.10.19 09:17, David Hildenbrand wrote:
>> On 25.10.19 04:25, Eduardo Habkost wrote:
>>> We had introduced versioned CPU models in QEMU 4.1, including a
>>> method for querying for CPU model versions using
>>
>> Interesting, I was not aware of that.
>>
>> On s390x, we somewhat have versioned CPU models, but we decided against =
giving them explicit names (e.g., z13-v1 or z13-4.1.0), because it didn't r=
eally seem to be necessary. (and we often implement/add features for older =
CPU models, there is a lot of fluctuation) Actually, you would have had to =
add "z13-z/VM-x.x.x" or "z13-LPAR-x.x.x" or "z13-KVM-x.x.x" to model the fe=
atures you actually see in all the different virtual environments ("what a =
CPU looks like"). Not to talk about QEMU versions in addition to that. So w=
e decided to always model what you would see under LPAR and are able to spe=
cify for a KVM guest. So you can use "z13" in an up-to-date LPAR environmen=
t, but not in a z/VM environment (you would have to disable features).
>>
>> Each (!base) CPU model has a specific feature set per machine. Libvirt u=
ses query-cpu-model-expansion() to convert this model+machine to a machine-=
independent representation. That representation is sufficient for all use c=
ases we were aware of (esp. "virsh domcapabilities", the host CPU model, mi=
gration).
>>
>> While s390x has versioned CPU models, we have no explicit way of specify=
ing them for older machines, besides going over query-cpu-model-expansion a=
nd using expanded "base model + features".
>>
>> I can see that this might make sense on x86-64, where you only have mayb=
e 3 versions of a CPU (e.g., the one Intel messed up first - Haswell, the o=
ne Intel messed up next - Haswell-noTSX, and the one that Intel eventually =
did right - Haswell-noTSX-IBRS) and you might want to specify "Haswell" vs.=
 "Haswell-IBRS" vs. "Haswell-noTSX-IBRS". But actually, you will always wan=
t to go for "Haswell-noTSX-IBRS", because you can expect to run in updated =
environments if I am not wrong, everything else are corner cases.
>>
>> Of course, versioned CPU model are neat to avoid "base model + list of f=
eatures", but at least for expanding the host model on s390x, it is not rea=
lly helpful. When migrating, the model expansion does the trick.
>>
>> I haven't looked into details of "how to specify or model versions". May=
be IBM wants to look into creating versions for all the old models we had. =
But again, not sure if that is of any help for s390x. CCing IBM.
>=20
> I agree that this does not look very helpful.
> Especially as several things depend on the kernel version a QEMU version =
is
> not sufficient to be guarantee construction success.
> So we would need something like z14-qemu4.0-kernel-5.2-suse-flavour-onLPA=
R
>=20
> Instead we do check if we can construct an equivalent model on the migrat=
ion target.
> And that model is precise. We do even have versions.
> Right now with QEMU on s390  our models are versioned in a way that we fe=
nce of
> facilities for old machine versions.
>=20
> For example
> -machine s390-virtio-ccw-3.1 -cpu z14 will not have the multiple epoch fa=
cility
> and
> -machine s390-virtio-ccw-4.0 -cpu z14 will have the multiple epoch facili=
ty.
> As migration does always require the tuple of machine and cpu this is sav=
e. I fail
> to see what the benefit of an explicit z14-3.1 would be.
>=20

AFAIKS the only real benefit of versioned CPU models is that you can add=20
new CPU model versions without new QEMU version.

Then you can specify "-cpu z13-vX" or "-cpu z13 -cpuv X" (no idea how=20
versioned CPU model were implemented) on any QEMU machine. Which is the=20
same as telling your customer "please use z13,featX=3Don" in case you have=
=20
a good reason to not use the host model (along with baselining) but use=20
an explicit model.

If you can change the default model of QEMU machines, you can automate=20
this process. I am pretty sure this is a corner case, though (e.g.,=20
IBRS). Usually you have a new QEMU machine and can simply enable the new=20
feature from that point on.

--=20

Thanks,

David / dhildenb



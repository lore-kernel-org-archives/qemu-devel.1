Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A7EC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 12:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF4120811
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 12:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF4120811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53123 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIuXg-0005a9-Jg
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 08:28:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hIuTn-0002IJ-Mg
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hIuH6-0002va-NO
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:11:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hIuH6-0002vJ-Dt; Tue, 23 Apr 2019 08:11:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDC293086229;
	Tue, 23 Apr 2019 12:11:46 +0000 (UTC)
Received: from [10.36.117.135] (ovpn-117-135.ams2.redhat.com [10.36.117.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 911AA5D71D;
	Tue, 23 Apr 2019 12:11:42 +0000 (UTC)
To: Christian Borntraeger <borntraeger@de.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	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
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <d3cdd199-0457-7255-9540-2bbe5555e079@redhat.com>
Date: Tue, 23 Apr 2019 14:11:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418113110.160664-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 23 Apr 2019 12:11:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 00/10] s390x: new guest features
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
	Collin Walling <walling@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
	Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423121141.SfNdNJo8Fay5THHmYK9XM-Uxw_-EPTWVzT1oUnEva-o@z>

On 18.04.19 13:31, Christian Borntraeger wrote:
> Adding generation 15.
>=20
> Some interesting aspects:
> - conditional SSKE and bpb are deprecated. This patch set addresses tha=
t
>   for csske.
> - no name yet for gen15, I suggest to use the assigned numbers and
>   provide an alias later on. (I have split out this into a separate
>   patch)
>=20
> Christian Borntraeger (10):
>   linux header sync
>   s390x/cpumodel: remove CSSKE from base model
>   s390x/cpumodel: Miscellaneous-Instruction-Extensions Facility 3
>   s390x/cpumodel: msa9 facility
>   s390x/cpumodel: vector enhancements
>   s390x/cpumodel: enhanced sort facility
>   s390x/cpumodel: deflate
>   s390x/cpumodel: add gen15 defintions
>   s390x/cpumodel: wire up 8561 and 8562 as gen15 machines
>   s390x/cpumodel: do not claim csske for expanded models in qmp
>=20
>  hw/s390x/s390-virtio-ccw.c      |  6 +++
>  linux-headers/asm-s390/kvm.h    |  5 +-
>  target/s390x/cpu_features.c     | 54 +++++++++++++++++++
>  target/s390x/cpu_features.h     |  3 ++
>  target/s390x/cpu_features_def.h | 49 +++++++++++++++++
>  target/s390x/cpu_models.c       | 35 ++++++++++++
>  target/s390x/cpu_models.h       |  1 +
>  target/s390x/gen-features.c     | 94 ++++++++++++++++++++++++++++++++-
>  target/s390x/kvm.c              | 18 +++++++
>  9 files changed, 263 insertions(+), 2 deletions(-)
>=20

I guess to handle deprecation of CSSKE:

1. Remove it from the base + default model of the gen15, keep it in the
max model. This is completely done in target/s390x/gen-features.c.
Existing base models are not modified.

2. Add CSSKE to "ignored_base_feat", so fallback of gen15 to e.g. z14
will work. We can backport this to distros/stable.


CPU model expansion:

cpu_info_from_model() should already properly be based on the base
features. "gen15" vs. "gen15,csske=3Don" should be automatically generate=
d
when expanding.

CPU model baseline:

s390_find_cpu_def() should make sure that CSSKE is basically ignored
when determining maximum model, however it will properly be indicated if
both models had the feature.

CPU model comparison:

Should work as expected. Availability of CSSKE will be considered when
calculating the result.

gen14,csske=3Don and gen15,csske=3Doff will result in
CPU_MODEL_COMPARE_RESULT_INCOMPATIBLE.

gen14,csske=3Doff and gen15,csske=3Doff should result in
CPU_MODEL_COMPARE_RESULT_SUBSET

gen14,csske=3Don and gen15,csske=3Don should result in
CPU_MODEL_COMPARE_RESULT_SUBSET

Forward migration:

Now, the only issue is when csske is actually turned of in future
machines. We would e.g. have

gen15,csske=3Don and gen16,csske=3Doff

While baselining will work correctly (gen15,csske=3Doff), forward
migration is broken (comparison will properly indicate
CPU_MODEL_COMPARE_RESULT_INCOMPATIBLE), which is expected when ripping
out features. Same applies to BPB.


Your patch "[PATCH 10/10] s390x/cpumodel: do not claim csske for
expanded models in qmp" tried to address this, however I am not really
happy with this approach. We should not play such tricks when expanding
the host model. "-cpu host" and "-cpu $expanded_host" would be
different, that is really confusing, especially think about baselining
or comparing against "host", where your patch does not apply..


Whenever users would specify "-cpu gen15", everything would be fine in
regards to forward migration. Maybe clients really have to be taught
about upcoming forward migration issues. "Don't use the host model, make
sure bpa and csske are disabled".

--=20

Thanks,

David / dhildenb


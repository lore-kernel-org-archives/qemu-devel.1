Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B08AC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:00:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5C220730
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlZi7bIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5C220730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY6ft-0006xc-1Y
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 06:00:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iY6ev-0006X5-O5
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iY6eu-0006ph-OM
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:59:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56840
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iY6eu-0006pQ-Jp
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574420368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HRVJ1u9Ugqbv7MELPjT+OcYukYlKswZFyk7h5ajFRFU=;
 b=XlZi7bIU9gqHpzRskUZG6u6Wab3+GNl8HkTnHvEmJzudqmwY6BgECBnPbqGCzR6yRaO9fS
 jbO2f38pCyLk1GWaouDk+Q5U45gijd0FCUueT1BuWaiemMxYw1VquvSgTBFOgl+6f6jz9x
 5p3Rsk66gEZkZXRBW4PxhX/7tXxgR/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252--4F2Wh57PCemk8mzb61Caw-1; Fri, 22 Nov 2019 05:59:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C67D9800054;
 Fri, 22 Nov 2019 10:59:22 +0000 (UTC)
Received: from [10.36.118.121] (unknown [10.36.118.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 24D6E60C23;
 Fri, 22 Nov 2019 10:59:20 +0000 (UTC)
Subject: Re: [PATCH 4/4] s390x: Beautify machine reset
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191122075218.23935-1-frankja@linux.ibm.com>
 <20191122075218.23935-5-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d026944f-1a0a-0dbe-6514-d8e4fd293e35@redhat.com>
Date: Fri, 22 Nov 2019 11:59:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122075218.23935-5-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: -4F2Wh57PCemk8mzb61Caw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.11.19 08:52, Janosch Frank wrote:
> * Add comments that tell you which diag308 subcode caused the reset
> * Sort by diag308 reset subcode
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index c1d1440272..88f7758721 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -330,15 +330,7 @@ static void s390_machine_reset(MachineState *machine=
)
>       s390_cmma_reset();
>  =20
>       switch (reset_type) {
> -    case S390_RESET_EXTERNAL:
> -    case S390_RESET_REIPL:
> -        qemu_devices_reset();
> -        s390_crypto_reset();
> -
> -        /* configure and start the ipl CPU only */
> -        run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
> -        break;
> -    case S390_RESET_MODIFIED_CLEAR:
> +    case S390_RESET_MODIFIED_CLEAR: /* Subcode 0 */

IMHO "Subcode X" isn't of much help here. We're out of diag handling.

I'd suggest to just document the subcodes along with the definitions, if=20
really needed, and drop this patch, at least I don't quite see the value=20
of moving code around here... or is the code shuffling of any value on=20
your prot virt patches?

--=20

Thanks,

David / dhildenb



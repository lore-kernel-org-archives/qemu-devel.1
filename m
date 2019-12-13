Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610E5C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 07:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DCE222527
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 07:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+3bUnua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DCE222527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iff77-0006TM-Bo
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 02:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iff6Q-0005vK-L2
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iff6N-0001K5-OR
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:11:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23962
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iff6N-0001Im-5w
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576221062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Z9481crTfuDxmQqSMOjo03EDWmMJej6UDt1Ym4TNGM=;
 b=B+3bUnuaaimNMxBWNX9DmtDJqbhW4M6Tj+iOOYG/61EVj05/3s0dHHLOPvQZkU46ZCrAEe
 WI+0X6hHpEJGmb9ox7dSt0mxJTD2Yl7IJGcfoymKIvXmdPDIv6uYRIdfXx5kWsHm5aWRYe
 jGZkuwzi5izSdLhkDFxypJPOwRckvFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-vFNZT84jOtOlevkhw20ZoA-1; Fri, 13 Dec 2019 02:10:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38444100550E;
 Fri, 13 Dec 2019 07:10:56 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-204-115.brq.redhat.com
 [10.40.204.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5CC160474;
 Fri, 13 Dec 2019 07:10:44 +0000 (UTC)
Date: Fri, 13 Dec 2019 08:10:40 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [RFC PATCH v2 1/5] hw: add compat machines for 5.0
Message-ID: <20191213071040.mc52d5mnezedyc54@kamzik.brq.redhat.com>
References: <20191212173320.11610-1-drjones@redhat.com>
 <20191212173320.11610-2-drjones@redhat.com>
 <20191212192419.GB498046@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20191212192419.GB498046@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: vFNZT84jOtOlevkhw20ZoA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: peter.maydell@linaro.org, bijan.mottahedeh@oracle.com,
 David Hildenbrand <david@redhat.com>, maz@kernel.org,
 Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 guoheyi@huawei.com, "open list:sPAPR" <qemu-ppc@nongnu.org>,
 msys.mizuma@gmail.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:24:19PM -0300, Eduardo Habkost wrote:
> On Thu, Dec 12, 2019 at 06:33:16PM +0100, Andrew Jones wrote:
> > Add 5.0 machine types for arm/i440fx/q35/s390x/spapr.
> >=20
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> >=20
> > ---
> >=20
> > Hi Eduardo,
> >=20
> > If we need to do something special for i440fx and q35, as
> > 9aec2e52ce9d ("hw: add compat machines for 4.2") implies, then
> > I'll need guidance as to what.
>=20
> Keeping default_cpu_version=3D=3D1 in pc-*-5.0 (like you did) is
> correct.
>=20
> However, you might want to use Cornelia's patch (which is
> probably already queued in the s390 tree) instead:
> https://patchew.org/QEMU/20191112104811.30323-1-cohuck@redhat.com
>

Drat. I did search the mailing list for a posting from someone else first,
but I made the mistake of searching subjects for 'machine type' rather
than 'compat machines'. Certainly we should use Cornelia's. Mine is
just noise.

Thank you reviewers, and sorry for the duplicated effort.

drew



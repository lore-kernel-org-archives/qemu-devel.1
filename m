Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CA4C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 19:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C6C21556
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 19:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LuHjU8Y5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C6C21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifU5Q-0002FP-Dz
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 14:25:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1ifU4g-0001dC-Pz
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 14:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1ifU4e-0006iR-7J
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 14:24:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41784
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ifU4d-0006dm-PL
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 14:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576178670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZaMMktr1w2w1L85b8GArQ5TfvVL+4OikUsN0TdF5oAs=;
 b=LuHjU8Y5awuDv8JgMVQZ/IooMITjbGENlYgRxy29cAKMJnxcUon5E2s3wZhkqiwxO0934D
 NfsPdmqd0KXA5hB5sEJ9IOKyG8tnnZvpHujeXvFgmjjh4/kf0Bak2t4kKbEB+gGLc+Ekk/
 ibwt7nxRy4c46/t1ekJHgrWiClVub9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-s7sOpm61NjuN6GKZbrLnhw-1; Thu, 12 Dec 2019 14:24:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EACB61005502;
 Thu, 12 Dec 2019 19:24:25 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E6E260BB9;
 Thu, 12 Dec 2019 19:24:20 +0000 (UTC)
Date: Thu, 12 Dec 2019 16:24:19 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [RFC PATCH v2 1/5] hw: add compat machines for 5.0
Message-ID: <20191212192419.GB498046@habkost.net>
References: <20191212173320.11610-1-drjones@redhat.com>
 <20191212173320.11610-2-drjones@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212173320.11610-2-drjones@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: s7sOpm61NjuN6GKZbrLnhw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: peter.maydell@linaro.org, Cornelia Huck <cohuck@redhat.com>,
 bijan.mottahedeh@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>,
 maz@kernel.org, David Hildenbrand <david@redhat.com>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>, qemu-arm@nongnu.org,
 "open list:sPAPR" <qemu-ppc@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>, guoheyi@huawei.com,
 Paolo Bonzini <pbonzini@redhat.com>, msys.mizuma@gmail.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 06:33:16PM +0100, Andrew Jones wrote:
> Add 5.0 machine types for arm/i440fx/q35/s390x/spapr.
>=20
> Signed-off-by: Andrew Jones <drjones@redhat.com>
>=20
> ---
>=20
> Hi Eduardo,
>=20
> If we need to do something special for i440fx and q35, as
> 9aec2e52ce9d ("hw: add compat machines for 4.2") implies, then
> I'll need guidance as to what.

Keeping default_cpu_version=3D=3D1 in pc-*-5.0 (like you did) is
correct.

However, you might want to use Cornelia's patch (which is
probably already queued in the s390 tree) instead:
https://patchew.org/QEMU/20191112104811.30323-1-cohuck@redhat.com

--=20
Eduardo



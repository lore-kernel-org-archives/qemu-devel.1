Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C59FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D38205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWRrJGdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D38205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMaGK-00029s-Iu
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iMaEn-0000f2-9l
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iMaEm-0005Ur-6v
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:08:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59720
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iMaEm-0005Uf-3s
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571674131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pA6C95Q7vTUlGpWAlvd64SzqEsuC6lOd6g0Z6+l1qI8=;
 b=SWRrJGdDVOGkpGhCtjZJ9D4pquxzYC1zICEvK/sUP5Rz1wlFut6l1Y+cZRdTFmsleOGq68
 ktsgg+2C0l4KeJFEqsYvKwKJL/bmodVBKeWWEduYf8S7+OHBxOM46vFmtiUbVbBwFSeRFZ
 pQwhk5FWILKBndbvxGOFwKYdvMY0X50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-syywmzCSMt6sH5e3dl4d6Q-1; Mon, 21 Oct 2019 12:08:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C64B1800D79;
 Mon, 21 Oct 2019 16:08:46 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3568B194B6;
 Mon, 21 Oct 2019 16:08:40 +0000 (UTC)
Date: Mon, 21 Oct 2019 18:08:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] s390x/kvm: Set default cpu model for all machine
 classes
Message-ID: <20191021180839.5868156a.cohuck@redhat.com>
In-Reply-To: <20191021100515.6978-1-david@redhat.com>
References: <20191021100515.6978-1-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: syywmzCSMt6sH5e3dl4d6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Oct 2019 12:05:15 +0200
David Hildenbrand <david@redhat.com> wrote:

> We have to set the default model of all machine classes, not just for
> the active one. Otherwise, "query-machines" will indicate the wrong
> CPU model ("qemu-s390x-cpu" instead of "host-s390x-cpu") as
> "default-cpu-type".
>=20
> Doing a
>     {"execute":"query-machines"}
> under KVM now results in
>     {"return": [
>         {
>             "hotpluggable-cpus": true,
>             "name": "s390-ccw-virtio-4.0",
>             "numa-mem-supported": false,
>             "default-cpu-type": "host-s390x-cpu",
>             "cpu-max": 248,
>             "deprecated": false},
>         {
>             "hotpluggable-cpus": true,
>             "name": "s390-ccw-virtio-2.7",
>             "numa-mem-supported": false,
>             "default-cpu-type": "host-s390x-cpu",
>             "cpu-max": 248,
>             "deprecated": false
>         } ...
>=20
> Libvirt probes all machines via "-machine none,accel=3Dkvm:tcg" and will
> currently see the wrong CPU model under KVM.
>=20
> Reported-by: Jiri Denemark <jdenemar@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Fixes: b6805e127c6b ("s390x: use generic cpu_model parsing")
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>=20
> v1 -> v2:
> - Added a sentence how libvirt probes the machines/default cpu models
> - klass -> oc
>=20
> ---
>  target/s390x/kvm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Thanks, applied.



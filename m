Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28912C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF2E21741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfLzkdqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF2E21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izktv-0003jQ-2t
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1izktF-0003EI-HT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1izktD-0002Y7-OZ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:24:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35584
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1izktD-0002QE-BA
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581009870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=duWytEMModfj1Vx3+fNQaLt/AFI3werUy64om3T3yVg=;
 b=JfLzkdqHYZqxExGYrz1WICZNTK2cccqyBHTRA8lPknx++s+O9iKVDZlW+/XblXCN6jjrRj
 BZupVCWbWpBA+lH9aGwYx/Wdv1K2yFxXXnqgc0GsgNAWk/KqOQJhJfgjF2BiDyVRi08P19
 KOgC/okfHnHMrE6a+r/dXsTFixUBa9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-0q9G7cMsOF2hyrucHhGw_Q-1; Thu, 06 Feb 2020 12:24:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5316CDBA5;
 Thu,  6 Feb 2020 17:24:27 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0587C60BF7;
 Thu,  6 Feb 2020 17:24:19 +0000 (UTC)
Date: Thu, 6 Feb 2020 18:24:17 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] tests/acceptance/virtio_check_params: Disable test
Message-ID: <20200206182417.01de2834.cohuck@redhat.com>
In-Reply-To: <20200206171715.25041-1-philmd@redhat.com>
References: <20200206171715.25041-1-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 0q9G7cMsOF2hyrucHhGw_Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  6 Feb 2020 18:17:15 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> This test fails on various CI:
>=20
> - Using QEMU 4.0:
>=20
>   tests/acceptance/x86_cpu_model_versions.py:X86CPUModelAliases.test_none=
_alias:  ERROR: 'alias-of' (0.45 s)
>=20
> - On OSX
>=20
>    Unexpected error in object_property_find() at qom/object.c:1201:
>    qemu-system-x86_64: -device virtio-blk-pci,id=3Dscsi0,drive=3Ddrive0: =
can't apply global virtio-blk-device.scsi=3Dtrue: Property '.scsi' not foun=
d

Hm, but there was a fix for that, wasn't there?

>=20
> - When removing unavailable machine:
>=20
>   VirtioMaxSegSettingsCheck.test_machine_types: ERROR: list.remove(x): x =
not in list (0.12 s)
>=20
> - Using Xen:
>=20
>   xencall: error: Could not obtain handle on privileged command interface=
: No such file or directory
>   xen be core: xen be core: can't open xen interface
>=20
> - On PPC:
>=20
>   TestFail: machine type pseries-2.8: No Transactional Memory support in =
TCG, try appending -machine cap-htm=3Doff
>=20
> - On S390X:
>=20
>   ERROR: qemu-system-s390x: -device virtio-scsi-pci,id=3Dscsi0: 'virtio-s=
csi-pci' is not a valid device model name

Depends on how your QEMU is configured... does virtio-pci default to
off on s390x? I use it all the time to test pci :)

>=20
> Disable it for now.
>=20
> Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Series fixing the errors:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg675074.html
> ---
>  tests/acceptance/virtio_check_params.py | 2 ++
>  1 file changed, 2 insertions(+)
>=20

It seems reasonable though to disable it until the problems are fixed.

Acked-by: Cornelia Huck <cohuck@redhat.com>



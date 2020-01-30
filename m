Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DE2C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C917D20CC7
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SI94vNt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C917D20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix9A0-0001Rf-1a
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 07:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ix95D-0003l1-Pw
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:38:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ix95C-0000tQ-Ol
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:38:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37555
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ix95C-0000sK-Km
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580387886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CJXARBSwjxFrJadX5Pz42s+C5a9dXrL8e2+s1bSXG/0=;
 b=SI94vNt29kP8P9+sN4ZJbuwKHtpH7ndX2yGLpyPUQ2iVqd0846N7pHwi9IKwQsZ8Hr/Bb/
 iKSfUQuAWk+OizDBBZfSXPPvV20vPhzX0Pm3dnAhcNg8mNZ6dA8e59lIHgABXAgK2rhdxN
 zHb7U6zyFmGgZqszkFDjocD+6FWnfUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-c_HUm-V4P0-OCxJ0kYSE9Q-1; Thu, 30 Jan 2020 07:38:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF40B18FF661;
 Thu, 30 Jan 2020 12:38:00 +0000 (UTC)
Received: from gondolin (ovpn-117-199.ams2.redhat.com [10.36.117.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C20265C1B2;
 Thu, 30 Jan 2020 12:37:54 +0000 (UTC)
Date: Thu, 30 Jan 2020 13:37:51 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 19/29] tests/acceptance/virtio_check_params: Only
 test Xen as superuser
Message-ID: <20200130133751.4e954bb1.cohuck@redhat.com>
In-Reply-To: <20200129212345.20547-20-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-20-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: c_HUm-V4P0-OCxJ0kYSE9Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jan 2020 22:23:35 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> When running the test unprivileged, we get:
>=20
>   $ avocado --show=3Dapp,machine run tests/acceptance/virtio_check_params=
.py
>   JOB ID     : b631d5d692e49b791b211d33b80730315d561d45
>   JOB LOG    : job-results/job-2020-01-22T17.56-b631d5d/job.log
>    (1/1) tests/acceptance/virtio_check_params.py:VirtioMaxSegSettingsChec=
k.test_machine_types:
>   machine: {'name': 'pc-i440fx-2.12', 'seg_max_adjust': 'false', 'device'=
: 'virtio-scsi-pci'}
>   machine: {'name': 'pc-i440fx-2.0', 'seg_max_adjust': 'false', 'device':=
 'virtio-scsi-pci'}
>   machine: {'name': 'xenpv', 'seg_max_adjust': 'false', 'device': 'virtio=
-scsi-pci'}
>   FAIL: machine type xenpv: <class 'qemu.qmp.QMPConnectError'> (0.40 s)
>=20
> Looking at the job.log file we find:
>=20
>   xencall: error: Could not obtain handle on privileged command interface=
: No such file or directory
>   xen be core: xen be core: can't open xen interface
>=20
> Do not run this test on Xen machines if not superuser.
>=20
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/virtio_check_params.py | 2 ++
>  1 file changed, 2 insertions(+)

I still think changing the title to "Test Xen only as superuser" would
be an improvement.



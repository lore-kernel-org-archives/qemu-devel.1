Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C3FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0042224125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRvmD3jQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0042224125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuahx-0008JT-5z
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 06:31:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iuafZ-0005cb-4u
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iuafY-0006Xd-0v
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:29:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25652
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iuafX-0006XW-Tq
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579778943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/1YV3+RoCAt4xVVVjcQqTcd3vYv28dBfy+uc5bOw54=;
 b=dRvmD3jQL6RtodZp6YyaY3z2ET5Dehnb78ucvUVtxaQ/iKlPJXuylem69av7uwsvCtY5yH
 2+crMftSlC0C/AMfd+yELwXNX/uUZkqlcmeBM+GeU3QQhe1apsxsACJ/cXYkYoRDs9rAib
 d4IAyFpDxBVuWM5VuCBMpEXcvjWxliQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-uZbjrhAOPEyA-zU1Sgm9QQ-1; Thu, 23 Jan 2020 06:29:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80127DB62;
 Thu, 23 Jan 2020 11:29:00 +0000 (UTC)
Received: from gondolin (ovpn-116-120.ams2.redhat.com [10.36.116.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA5347C42C;
 Thu, 23 Jan 2020 11:28:51 +0000 (UTC)
Date: Thu, 23 Jan 2020 12:28:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 4/6] tests/acceptance/virtio_seg_max_adjust: Only test
 Xen as superuser
Message-ID: <20200123122848.6a74c2ce.cohuck@redhat.com>
In-Reply-To: <20200122223247.30419-5-philmd@redhat.com>
References: <20200122223247.30419-1-philmd@redhat.com>
 <20200122223247.30419-5-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: uZbjrhAOPEyA-zU1Sgm9QQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Jan 2020 23:32:45 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

$SUBJECT: s/Only test Xen as superuser/Test Xen only as superuser/ ?

> When running the test unprivileged, we get:
>=20
>   $ avocado --show=3Dapp,machine run tests/acceptance/virtio_seg_max_adju=
st.py
>   JOB ID     : b631d5d692e49b791b211d33b80730315d561d45
>   JOB LOG    : job-results/job-2020-01-22T17.56-b631d5d/job.log
>    (1/1) tests/acceptance/virtio_seg_max_adjust.py:VirtioMaxSegSettingsCh=
eck.test_machine_types:
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
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/virtio_seg_max_adjust.py | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptance=
/virtio_seg_max_adjust.py
> index f679b0eec7..ad736bcda3 100755
> --- a/tests/acceptance/virtio_seg_max_adjust.py
> +++ b/tests/acceptance/virtio_seg_max_adjust.py
> @@ -118,6 +118,8 @@ class VirtioMaxSegSettingsCheck(Test):
> =20
>      def test_machine_types(self):
>          EXCLUDED_MACHINES =3D ['none', 'isapc', 'microvm']
> +        if os.geteuid() !=3D 0:
> +            EXCLUDED_MACHINES +=3D ['xenfv', 'xenpv']
>          # collect all machine types except the ones in EXCLUDED_MACHINES
>          with QEMUMachine(self.qemu_bin) as vm:
>              vm.launch()

Acked-by: Cornelia Huck <cohuck@redhat.com>



Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7686C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 10:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D5D20842
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 10:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCyfrcvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D5D20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1TAg-0004uK-TP
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 05:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j1T9v-00041y-PH
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j1T9u-0002D0-Rl
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:52:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59210
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j1T9u-0002Cj-O4
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581418370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HYx6OVR723Zi4nipjoFJ22+MDt+DL3IeYBIHYelzPpo=;
 b=aCyfrcvodCVPnCAx9+pcmMLRPsdxKD9de1Un5f56UChyELVMhXhg+fuTLd5XAsWWEd9g3Q
 XSZjyTTqHBBWHZEpjzU4MiHyGYXiebpInW4gzfP0c+T9ItVAldbto50WGrSxtBWJ51SZeV
 vPpgpsYH2u3KLvHZ48dtIEEsZ5u/pVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-QtxOb3vKPVKHpxweGSzaug-1; Tue, 11 Feb 2020 05:52:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A77CA18B5FAC;
 Tue, 11 Feb 2020 10:52:47 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 204E35C109;
 Tue, 11 Feb 2020 10:52:41 +0000 (UTC)
Date: Tue, 11 Feb 2020 11:52:39 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] tests/acceptance/virtio_check_params: Only disable the
 test on CI
Message-ID: <20200211115239.6027b3c7.cohuck@redhat.com>
In-Reply-To: <20200211104938.12068-1-philmd@redhat.com>
References: <20200211104938.12068-1-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: QtxOb3vKPVKHpxweGSzaug-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Feb 2020 11:49:38 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Commit 2d6a6e238a incorrectly totally disabled this test.
> The original intention was to only disable on continuous integration.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/virtio_check_params.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/v=
irtio_check_params.py
> index 87e6c839d1..015582cf9c 100644
> --- a/tests/acceptance/virtio_check_params.py
> +++ b/tests/acceptance/virtio_check_params.py
> @@ -25,7 +25,7 @@ import logging
>  sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pyt=
hon'))
>  from qemu.machine import QEMUMachine
>  from avocado_qemu import Test
> -from avocado import skip
> +from avocado import skipIf
> =20
>  #list of machine types and virtqueue properties to test
>  VIRTIO_SCSI_PROPS =3D {'seg_max_adjust': 'seg_max_adjust'}
> @@ -117,7 +117,7 @@ class VirtioMaxSegSettingsCheck(Test):
>              return True
>          return False
> =20
> -    @skip("break multi-arch CI")
> +    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Break multi-arch CI')
>      def test_machine_types(self):
>          # collect all machine types except 'none', 'isapc', 'microvm'
>          with QEMUMachine(self.qemu_bin) as vm:

Acked-by: Cornelia Huck <cohuck@redhat.com>



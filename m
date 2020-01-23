Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E6AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1081B206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsQ2WtIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1081B206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuaY1-0003DP-8g
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 06:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iuaXN-0002lj-MO
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:20:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iuaXJ-00021m-R0
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:20:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41560
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iuaXJ-00021P-NZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579778433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hL7imjsoSkyG8ewkYqJjIGjoQ7tSoExc90gKSE7nVfE=;
 b=GsQ2WtIq9RP/V6RD+B/snQn2L3xujAHcpp3CSdVQGzsvet3+ZtcqTuHdo9jiZtPabFpT8P
 YuxJOvUvUNAATNk18ZBcTqTT1fb4Fz7o0wChswtsN45sq9cJAub4Xu8lFzTfTVsd195uVh
 uB6nQG1fByRk6yMRmv0F5IHBAHspRZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-pAnalIbgMgi3IQTiMXmWgw-1; Thu, 23 Jan 2020 06:20:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 259BF477;
 Thu, 23 Jan 2020 11:20:30 +0000 (UTC)
Received: from gondolin (ovpn-116-120.ams2.redhat.com [10.36.116.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF64C5DA89;
 Thu, 23 Jan 2020 11:20:21 +0000 (UTC)
Date: Thu, 23 Jan 2020 12:20:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 1/6] tests/acceptance/virtio_seg_max_adjust: Only remove
 listed machines
Message-ID: <20200123122018.1b6b0ca1.cohuck@redhat.com>
In-Reply-To: <20200122223247.30419-2-philmd@redhat.com>
References: <20200122223247.30419-1-philmd@redhat.com>
 <20200122223247.30419-2-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: pAnalIbgMgi3IQTiMXmWgw-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Jan 2020 23:32:42 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Do not remove unavailable machines, this fixes:
>=20
>   VirtioMaxSegSettingsCheck.test_machine_types: ERROR: list.remove(x): x =
not in list (0.12 s)
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/virtio_seg_max_adjust.py | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptance=
/virtio_seg_max_adjust.py
> index 5458573138..4a417b8ef5 100755
> --- a/tests/acceptance/virtio_seg_max_adjust.py
> +++ b/tests/acceptance/virtio_seg_max_adjust.py
> @@ -109,14 +109,15 @@ class VirtioMaxSegSettingsCheck(Test):
>          return False
> =20
>      def test_machine_types(self):
> -        # collect all machine types except 'none', 'isapc', 'microvm'
> +        EXCLUDED_MACHINES =3D ['none', 'isapc', 'microvm']

That one seems more flexible as well.

> +        # collect all machine types except the ones in EXCLUDED_MACHINES
>          with QEMUMachine(self.qemu_bin) as vm:
>              vm.launch()
>              machines =3D [m['name'] for m in vm.command('query-machines'=
)]
>              vm.shutdown()
> -        machines.remove('none')
> -        machines.remove('isapc')
> -        machines.remove('microvm')
> +        for m in EXCLUDED_MACHINES:
> +            if m in machines:
> +                machines.remove(m)
> =20
>          for dev_type in DEV_TYPES:
>              # create the list of machine types and their parameters.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>



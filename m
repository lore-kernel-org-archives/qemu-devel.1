Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2E3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C4724125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXt92fTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C4724125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuc86-0004y9-7M
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iuays-00060L-8O
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:49:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iuayq-0007k2-S8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:49:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51178
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iuayq-0007ji-M8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NfGRJjtL0mrz5wsnRMh7k7VWJGSew4oR/uZnO3n83ss=;
 b=XXt92fTrpXb0yPdZeAgoZDJC/M8EQSqPhdA1LFa0ZAE01+2vB2p3NLQpAPLPFQAlJv5BW7
 mQTHPupm8B1pS+vKxGgLyX0yInt3nFobT6JzNauld77rLJmMbrlj5lvfv6zGJx/RfNHXlX
 EPfS7DpBE0Gfig5IJGfOFG4229Fo5TM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-fMVli3k6NbKEpdOA5ayA4w-1; Thu, 23 Jan 2020 06:48:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E57D88010DE;
 Thu, 23 Jan 2020 11:48:55 +0000 (UTC)
Received: from gondolin (ovpn-116-120.ams2.redhat.com [10.36.116.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 620D085750;
 Thu, 23 Jan 2020 11:48:46 +0000 (UTC)
Date: Thu, 23 Jan 2020 12:48:44 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 5/6] tests/acceptance/virtio_seg_max_adjust: Restrict to
 X86 architecture
Message-ID: <20200123124844.32e2aa09.cohuck@redhat.com>
In-Reply-To: <20200122223247.30419-6-philmd@redhat.com>
References: <20200122223247.30419-1-philmd@redhat.com>
 <20200122223247.30419-6-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: fMVli3k6NbKEpdOA5ayA4w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Jan 2020 23:32:46 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Running on mainstream KVM architectures, we get:
>=20
> - Aarch64
>=20
>   Timeout.
>=20
>   job.log:
>   -------
>   No machine specified, and there is no default
>   Use -machine help to list supported machines

The code probably needs to be made more clever to find the machines to
run?

>=20
> - MIPS:
>=20
>    (1/1) VirtioMaxSegSettingsCheck.test_machine_types: ERROR: argument of=
 type 'NoneType' is not iterable (0.14 s)
>=20
>   job.log:
>   -------
>   Could not load MIPS bios 'mipsel_bios.bin', and no -kernel argument was=
 specified

Probably needs some hint from mips folks how this can be set up.

>=20
> - PowerPC
>=20
>    (1/1) VirtioMaxSegSettingsCheck.test_machine_types: ERROR: invalid lit=
eral for int() with base 10: 'sxxm' (0.16 s)
>=20
>   job.log:
>   -------
>   >>> {'execute': 'query-machines'} =20
>   <<< {'return': [{'hotpluggable-cpus': True, 'name': 'pseries-2.12-sxxm'=
, 'numa-mem-supported': True, 'default-cpu-type': 'power8_v2.0-powerpc64-cp=
u', 'cpu-max': 1024, 'deprecated': False}, ...

This seems to be because the machine type parsing code cannot deal with
the format used here.

>=20
> - S390X:
>=20
>    (1/1) VirtioMaxSegSettingsCheck.test_machine_types: ERROR: invalid lit=
eral for int() with base 10: 'virtio' (0.14 s)
>=20
>   job.log:
>   -------
>   Traceback (most recent call last):
>     File "virtio_seg_max_adjust.py", line 139, in test_machine_types
>       if self.seg_max_adjust_enabled(m):
>     File "virtio_seg_max_adjust.py", line 113, in seg_max_adjust_enabled
>       major =3D int(ver[0])
>   ValueError: invalid literal for int() with base 10: 'virtio'
>   >>> {'execute': 'query-machines'} =20
>   <<< {'return': [{'hotpluggable-cpus': True, 'name': 's390-ccw-virtio-4.=
0', 'numa-mem-supported': False, 'default-cpu-type': 'qemu-s390x-cpu', 'cpu=
-max': 248, 'deprecated': False}, ...

Same here.

>=20
> Assuming this test is only expected to run on the X86 architecture,
> restrict the test to this particular architecture.
>=20
> When this test is run on other architecture, the tests will be skipped.
>=20
> Examples:
>=20
> - running on S390X:
>=20
>  (1/1) tests/acceptance/virtio_seg_max_adjust.py:VirtioMaxSegSettingsChec=
k.test_machine_types: SKIP: Architecture 's390' unsupported
>=20
> - running on Aarch64 setting the QEMU binary path:
>=20
>   $ uname -m && avocado --show=3Dapp run -p qemu_bin=3Dx86_64-softmmu/qem=
u-system-x86_64 tests/acceptance/virtio_seg_max_adjust.py
>   aarch64
>   JOB ID     : 92b7fae8868920aada0cb143f9571dffdf60931d
>   JOB LOG    : job-results/job-2020-01-22T17.54-92b7fae/job.log
>    (1/1) tests/acceptance/virtio_seg_max_adjust.py:VirtioMaxSegSettingsCh=
eck.test_machine_types: PASS (25.99 s)
>   RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 =
| CANCEL 0
>   JOB TIME   : 26.13 s
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/virtio_seg_max_adjust.py | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptance=
/virtio_seg_max_adjust.py
> index ad736bcda3..2fc6bfcbd8 100755
> --- a/tests/acceptance/virtio_seg_max_adjust.py
> +++ b/tests/acceptance/virtio_seg_max_adjust.py
> @@ -26,6 +26,7 @@ import logging
>  sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pyt=
hon'))
>  from qemu.machine import QEMUMachine
>  from avocado_qemu import Test
> +from avocado.core.exceptions import TestSkipError
> =20
>  #list of machine types and virtqueue properties to test
>  VIRTIO_SCSI_PROPS =3D {'seg_max_adjust': 'seg_max_adjust'}
> @@ -117,12 +118,22 @@ class VirtioMaxSegSettingsCheck(Test):
>          return False
> =20
>      def test_machine_types(self):
> +        """
> +        :avocado: tags=3Darch:i386
> +        :avocado: tags=3Darch:x86_64
> +        """
>          EXCLUDED_MACHINES =3D ['none', 'isapc', 'microvm']
>          if os.geteuid() !=3D 0:
>              EXCLUDED_MACHINES +=3D ['xenfv', 'xenpv']
>          # collect all machine types except the ones in EXCLUDED_MACHINES
>          with QEMUMachine(self.qemu_bin) as vm:
>              vm.launch()
> +            # Skip test if target is not X86
> +            # TODO: Move this check to Avocado (based on the test tags)
> +            target_arch =3D vm.command('query-target')['arch']
> +            if target_arch not in ['i386', 'x86_64']:
> +                errmsg =3D "Architecture '%s' unsupported" % target_arch
> +                raise TestSkipError(errmsg)

I think we should rather fix the machine parsing code, and only then
exclude architectures out of the box. (Sorry, my python-fu is lacking,
or I would try it myself.)

There does not seem to be anything that is really architecture specific
in there. Just explicitly requesting the -pci versions of virtio-blk
and virtio-scsi seems wrong, though, as this looks like a generic
property, and should work on -ccw as well. (And probably also for
virtio-mmio devices.) If not, I'd like to know :)

>              machines =3D [m['name'] for m in vm.command('query-machines'=
)]
>              vm.shutdown()
>          for m in EXCLUDED_MACHINES:



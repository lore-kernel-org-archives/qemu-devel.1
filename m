Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153B9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E552077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6Px9ySc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E552077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugtI-00014l-Ph
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iueul-0007Q0-Kc
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:01:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iueuj-0002sS-1M
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:01:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44434
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iueui-0002rR-R8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579795260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YFTDM+x0VAdB0nagmEK2b9vblxyqjSTWW94FriwaigY=;
 b=P6Px9yScsEeHrqqJ1t5IAtHjm/PIf0Fi362IE01KN9IKXMWrNiDX/iX/h3BMQaX7vdXnEo
 sC8NrCm6LPAZh3tW6xm4u0txVTryxbGpMgaoIb/trhLiqf9kXv9MzV1xgRoyy/Sn2xTue5
 rGGRl8ou7D1zi6XgHVsFt1FKXa2USx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-ipf40sDDONahXRoxuxyxgA-1; Thu, 23 Jan 2020 11:00:58 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2162210054E3;
 Thu, 23 Jan 2020 16:00:57 +0000 (UTC)
Received: from gondolin (ovpn-116-120.ams2.redhat.com [10.36.116.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 997E010016EB;
 Thu, 23 Jan 2020 16:00:43 +0000 (UTC)
Date: Thu, 23 Jan 2020 17:00:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 5/6] tests/acceptance/virtio_seg_max_adjust: Restrict to
 X86 architecture
Message-ID: <20200123170040.2ffdd0d8.cohuck@redhat.com>
In-Reply-To: <814cb9da-696c-0716-c1fe-247fd4e6cb05@redhat.com>
References: <20200122223247.30419-1-philmd@redhat.com>
 <20200122223247.30419-6-philmd@redhat.com>
 <20200123124844.32e2aa09.cohuck@redhat.com>
 <814cb9da-696c-0716-c1fe-247fd4e6cb05@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ipf40sDDONahXRoxuxyxgA-1
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
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 11:36:55 -0200
Wainer dos Santos Moschetta <wainersm@redhat.com> wrote:

> On 1/23/20 9:48 AM, Cornelia Huck wrote:
> > On Wed, 22 Jan 2020 23:32:46 +0100
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> > =20
> >> Running on mainstream KVM architectures, we get:
> >>
> >> - Aarch64
> >>
> >>    Timeout.
> >>
> >>    job.log:
> >>    -------
> >>    No machine specified, and there is no default
> >>    Use -machine help to list supported machines =20
> > The code probably needs to be made more clever to find the machines to
> > run?
> > =20
> >> - MIPS:
> >>
> >>     (1/1) VirtioMaxSegSettingsCheck.test_machine_types: ERROR: argumen=
t of type 'NoneType' is not iterable (0.14 s)
> >>
> >>    job.log:
> >>    -------
> >>    Could not load MIPS bios 'mipsel_bios.bin', and no -kernel argument=
 was specified =20
> > Probably needs some hint from mips folks how this can be set up.
> > =20
> >> - PowerPC
> >>
> >>     (1/1) VirtioMaxSegSettingsCheck.test_machine_types: ERROR: invalid=
 literal for int() with base 10: 'sxxm' (0.16 s)
> >>
> >>    job.log:
> >>    ------- =20
> >>    >>> {'execute': 'query-machines'} =20
> >>    <<< {'return': [{'hotpluggable-cpus': True, 'name': 'pseries-2.12-s=
xxm', 'numa-mem-supported': True, 'default-cpu-type': 'power8_v2.0-powerpc6=
4-cpu', 'cpu-max': 1024, 'deprecated': False}, ... =20
> > This seems to be because the machine type parsing code cannot deal with
> > the format used here. =20
>=20
>=20
> Indeed, looking at the comments in code the parser was meant for PC types=
.
>=20
> Is there a way to obtain the machine type version other than parsing its=
=20
> name? If not, wouldn't be useful for management apps have that=20
> information returned with 'query-machines'?

The question would be "What version?". The pseries machine type the
code chokes upon above has an additional suffix. Not all machine types
are versioned, obviously, and we don't have an uniform way to build
machine type names, either.

If I understand this test correctly, the idea is to distinguish between
"version that defaults the feature to off" and "version that defaults
the feature to on". So, the pseries machine with the extra suffix from
above and the one without would basically be the same 2.12 compatible
machine (both in the first bucket). For other tests, those two machines
might be very different, though.

tl;dr "version" might not be well-defined enough.

>=20
> - Wainer
>=20
> >> - S390X:
> >>
> >>     (1/1) VirtioMaxSegSettingsCheck.test_machine_types: ERROR: invalid=
 literal for int() with base 10: 'virtio' (0.14 s)
> >>
> >>    job.log:
> >>    -------
> >>    Traceback (most recent call last):
> >>      File "virtio_seg_max_adjust.py", line 139, in test_machine_types
> >>        if self.seg_max_adjust_enabled(m):
> >>      File "virtio_seg_max_adjust.py", line 113, in seg_max_adjust_enab=
led
> >>        major =3D int(ver[0])
> >>    ValueError: invalid literal for int() with base 10: 'virtio' =20
> >>    >>> {'execute': 'query-machines'} =20
> >>    <<< {'return': [{'hotpluggable-cpus': True, 'name': 's390-ccw-virti=
o-4.0', 'numa-mem-supported': False, 'default-cpu-type': 'qemu-s390x-cpu', =
'cpu-max': 248, 'deprecated': False}, ... =20
> > Same here.



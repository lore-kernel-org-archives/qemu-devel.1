Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DDCC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3974B214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3974B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAYDx-0001lC-9z
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 07:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1iAYCY-0001AO-Ks
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iAYCW-0000oF-IC
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:32:50 -0400
Received: from mail.ispras.ru ([83.149.199.45]:45724)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iAYCV-0000mS-6I
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:32:48 -0400
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id D457054011C;
 Wed, 18 Sep 2019 14:32:43 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>
References: <156872146565.1757.3033215873677512474.stgit@pasha-Precision-3630-Tower>
 <87blvi21cz.fsf@linaro.org> <001101d56dfa$bef4e630$3cdeb290$@ru>
 <8736gt28dp.fsf@linaro.org>
In-Reply-To: <8736gt28dp.fsf@linaro.org>
Date: Wed, 18 Sep 2019 14:32:46 +0300
Message-ID: <001c01d56e14$cbccb710$63662530$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdVuDcU84dkeosxXRBOPH+KCLOi5rAABMZ1Q
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: Re: [Qemu-devel] [for-4.2 PATCH 0/6] Block-related record/replay
 fixes
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com,
 boost.lists@gmail.com, thomas.dullien@googlemail.com, pbonzini@redhat.com,
 mreitz@redhat.com, artem.k.pisarenko@gmail.com, dgilbert@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>=20
> >> -----Original Message-----
> >> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> >> Sent: Tuesday, September 17, 2019 10:02 PM
> >> To: Pavel Dovgalyuk
> >> Cc: qemu-devel@nongnu.org; kwolf@redhat.com; =
peter.maydell@linaro.org;
> >> crosthwaite.peter@gmail.com; boost.lists@gmail.com; =
artem.k.pisarenko@gmail.com;
> >> quintela@redhat.com; ciro.santilli@gmail.com; jasowang@redhat.com; =
mst@redhat.com;
> >> armbru@redhat.com; mreitz@redhat.com; =
maria.klimushenkova@ispras.ru; dovgaluk@ispras.ru;
> >> kraxel@redhat.com; pavel.dovgaluk@ispras.ru; =
thomas.dullien@googlemail.com;
> >> pbonzini@redhat.com; dgilbert@redhat.com; rth@twiddle.net
> >> Subject: Re: [for-4.2 PATCH 0/6] Block-related record/replay fixes
> >>
> >>
> >> Pavel Dovgalyuk <pavel.dovgaluk@gmail.com> writes:
> >>
> >> > The set of patches include the block-related updates
> >> > of the record/replay icount feature:
> >> >  - application of 'snapshot' option on the file layer instead of
> >> >    the top one: command line and documentation fix
> >> >  - implementation of bdrv_snapshot_goto for blkreplay driver
> >> >  - start/stop fix in replay mode with attached block devices
> >> >  - record/replay of bh oneshot events, used in the block layer
> >>
> >> Can we come up with a reasonable smoke test to verify record/replay =
is
> >> functional? AIUI we don't need a full OS but we do need a block =
device
> >> to store the replay data. Could we use one of the simple system =
tests
> >> like "memory" and run that through a record and replay cycle?
> >
> > That's would be great.
> > I'm not familiar with testing framework and couldn't find "memory"
> > test that you refer to.
>=20
> The memory test code is in tests/tcg/multiarch/system and gets =
combined
> with the boot code for whichever target can build it. For example on
> aarch64 it is run like:
>=20
>   timeout 15  $BLD/aarch64-softmmu/qemu-system-aarch64 -monitor none =
-display none -chardev
> file,path=3Dmemory.out,id=3Doutput  -M virt -cpu max -display none =
-semihosting-config
> enable=3Don,target=3Dnative,chardev=3Doutput -kernel memory

Yes, rr testing could be that simple, but in full system emulation mode.
Simplest tests may be run even without the block devices:

qemu-system-aarch64 -monitor none -display none -chardev =
file,path=3Dmemory.out,id=3Doutput
-M virt -cpu max -kernel memory -net none -icount =
shift=3D5,rr=3Drecord,rrfile=3Drecord.bin

Better testing must include some block device like Linux boot image or =
something similar.

> The test binaries will be in $BLD/tests/tcg/aarch64-softmmu and are
> built when you run "make check-tcg" and have either the appropriate
> cross compilers installed on your system or docker enabled and setup
> (see docs/devel/testing.rst).
>=20
> > Replay test must at least the following:
> > 1. record some execution
> > 2. replay that execution
> >
> > And there could be several endings:
> > 1. record stalled
> > 2. record crashed
> > 3. replay stalled
> > 4. replay crashed
> > 5. all executions finished successfully
>=20
> If you can provide an appropriate set of invocations I can plumb them
> into the Makefiles for you.

That will be great, thank you.

Pavel Dovgalyuk



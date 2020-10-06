Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27EFC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5339206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FW6jEptr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5339206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPrXP-0007QD-S7
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 14:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kPrVr-0006w2-2o
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kPrVo-0004WU-42
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602008191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F62U6VnsSZCXNzc9e/muUHBjPWJ0lsQNU9qgDqcThOo=;
 b=FW6jEptrNpHuIdpbkMFXy8YF8s7NWqWsIdbmEPuL/84kfjsS+bs42SM3CxI3IpEGL+P6+B
 wVMbGAyWnYm0YSz0cLRz8rZgwf6eSKxv5+z9ThnvA9SobzVz+4v6ogsum1uL3ZhY3Rvo4P
 NE4zikt5P1XPsjzG4hx5kLRxAQMCMFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-VdYTBBIAPHWQDSfr2UcNCw-1; Tue, 06 Oct 2020 14:16:25 -0400
X-MC-Unique: VdYTBBIAPHWQDSfr2UcNCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 160778015A6;
 Tue,  6 Oct 2020 18:16:22 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A6B019D7C;
 Tue,  6 Oct 2020 18:16:17 +0000 (UTC)
Date: Tue, 6 Oct 2020 14:16:15 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH v7 14/14] tests/acceptance: add reverse debugging test
Message-ID: <20201006181615.GF240186@localhost.localdomain>
References: <160174516520.12451.10785284392438702137.stgit@pasha-ThinkPad-X280>
 <160174524678.12451.13258942849173670277.stgit@pasha-ThinkPad-X280>
 <20201006133638.GD240186@localhost.localdomain>
 <794a0cc6-0b15-a92b-6a41-1a3961fdb324@ispras.ru>
MIME-Version: 1.0
In-Reply-To: <794a0cc6-0b15-a92b-6a41-1a3961fdb324@ispras.ru>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1Y7d0dPL928TPQbc"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 alex.bennee@linaro.org, mtosatti@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--1Y7d0dPL928TPQbc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 06, 2020 at 06:09:55PM +0300, Pavel Dovgalyuk wrote:
> On 06.10.2020 16:36, Cleber Rosa wrote:
> > On Sat, Oct 03, 2020 at 08:14:06PM +0300, Pavel Dovgalyuk wrote:
> > > From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
> > >=20
> > > This is a test for GDB reverse debugging commands: reverse step and r=
everse continue.
> > > Every test in this suite consists of two phases: record and replay.
> > > Recording saves the execution of some instructions and makes an initi=
al
> > > VM snapshot to allow reverse execution.
> > > Replay saves the order of the first instructions and then checks that=
 they
> > > are executed backwards in the correct order.
> > > After that the execution is replayed to the end, and reverse continue
> > > command is checked by setting several breakpoints, and asserting
> > > that the execution is stopped at the last of them.
> > >=20
> > > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> > > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > > Reviewed-by: Willian Rampazzo <willianr@redhat.com>
> > >=20
> > > --
> > >=20
> > > v5:
> > >   - disabled (as some other tests) when running on gitlab
> > >     due to the unidentified timeout problem
> > > ---
> > >   MAINTAINERS                           |    1
> > >   tests/acceptance/reverse_debugging.py |  208 ++++++++++++++++++++++=
+++++++++++
> > >   2 files changed, 209 insertions(+)
> > >   create mode 100644 tests/acceptance/reverse_debugging.py
> > >=20
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index ea4fa3e481..bd3a7efb75 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -2693,6 +2693,7 @@ F: include/sysemu/replay.h
> > >   F: docs/replay.txt
> > >   F: stubs/replay.c
> > >   F: tests/acceptance/replay_kernel.py
> > > +F: tests/acceptance/reverse_debugging.py
> > >   F: qapi/replay.json
> > >   IOVA Tree
> > > diff --git a/tests/acceptance/reverse_debugging.py b/tests/acceptance=
/reverse_debugging.py
> > > new file mode 100644
> > > index 0000000000..b72fdf6cdc
> > > --- /dev/null
> > > +++ b/tests/acceptance/reverse_debugging.py
> > > @@ -0,0 +1,208 @@
> > > +# Reverse debugging test
> > > +#
> > > +# Copyright (c) 2020 ISP RAS
> > > +#
> > > +# Author:
> > > +#  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> > > +#
> > > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > > +# later.  See the COPYING file in the top-level directory.
> > > +import os
> > > +import logging
> > > +
> > > +from avocado import skipIf
> > > +from avocado_qemu import BUILD_DIR
> > > +from avocado.utils import gdb
> > > +from avocado.utils import process
> > > +from avocado.utils.path import find_command
> > > +from boot_linux_console import LinuxKernelTest
> > > +
> > > +class ReverseDebugging(LinuxKernelTest):
> > > +    """
> > > +    Test GDB reverse debugging commands: reverse step and reverse co=
ntinue.
> > > +    Recording saves the execution of some instructions and makes an =
initial
> > > +    VM snapshot to allow reverse execution.
> > > +    Replay saves the order of the first instructions and then checks=
 that they
> > > +    are executed backwards in the correct order.
> > > +    After that the execution is replayed to the end, and reverse con=
tinue
> > > +    command is checked by setting several breakpoints, and asserting
> > > +    that the execution is stopped at the last of them.
> > > +    """
> > > +
> > > +    timeout =3D 10
> > > +    STEPS =3D 10
> > > +    endian_is_le =3D True
> >=20
> > Have you attmepted a "be" test too?  I'm curious about why this is
> > defined (and used later) but it's never used as `False`.
>=20
> It was intended to be used with PPC, but PPCs record-replay is not reliab=
le
> enough.
>

OK, thanks for the explanation.

> >=20
> > > +
> > > +    def run_vm(self, record, shift, args, replay_path, image_path):
> > > +        logger =3D logging.getLogger('replay')
> > > +        vm =3D self.get_vm()
> > > +        vm.set_console()
> > > +        if record:
> > > +            logger.info('recording the execution...')
> > > +            mode =3D 'record'
> > > +        else:
> > > +            logger.info('replaying the execution...')
> > > +            mode =3D 'replay'
> > > +            vm.add_args('-s', '-S')
> > > +        vm.add_args('-icount', 'shift=3D%s,rr=3D%s,rrfile=3D%s,rrsna=
pshot=3Dinit' %
> > > +                    (shift, mode, replay_path),
> > > +                    '-net', 'none')
> > > +        vm.add_args('-drive', 'file=3D%s,if=3Dnone' % image_path)
> > > +        if args:
> > > +            vm.add_args(*args)
> > > +        vm.launch()
> > > +        return vm
> > > +
> > > +    @staticmethod
> > > +    def get_reg_le(g, reg):
> > > +        res =3D g.cmd(b'p%x' % reg)
> > > +        num =3D 0
> > > +        for i in range(len(res))[-2::-2]:
> > > +            num =3D 0x100 * num + int(res[i:i + 2], 16)
> > > +        return num
> > > +
> > > +    @staticmethod
> > > +    def get_reg_be(g, reg):
> > > +        res =3D g.cmd(b'p%x' % reg)
> > > +        return int(res, 16)
> > > +
> > > +    def get_reg(self, g, reg):
> > > +        # value may be encoded in BE or LE order
> > > +        if self.endian_is_le:
> > > +            return self.get_reg_le(g, reg)
> > > +        else:
> > > +            return self.get_reg_be(g, reg)
> > > +
> > > +    def get_pc(self, g):
> > > +        return self.get_reg(g, self.REG_PC)
> > > +
> > > +    def check_pc(self, g, addr):
> > > +        pc =3D self.get_pc(g)
> > > +        if pc !=3D addr:
> > > +            self.fail('Invalid PC (read %x instead of %x)' % (pc, ad=
dr))
> > > +
> > > +    @staticmethod
> > > +    def gdb_step(g):
> > > +        g.cmd(b's', b'T05thread:01;')
> > > +
> > > +    @staticmethod
> > > +    def gdb_bstep(g):
> > > +        g.cmd(b'bs', b'T05thread:01;')
> > > +
> > > +    @staticmethod
> > > +    def vm_get_icount(vm):
> > > +        return vm.qmp('query-replay')['return']['icount']
> > > +
> > > +    def reverse_debugging(self, shift=3D7, args=3DNone):
> > > +        logger =3D logging.getLogger('replay')
> > > +
> > > +        # create qcow2 for snapshots
> > > +        logger.info('creating qcow2 image for VM snapshots')
> > > +        image_path =3D os.path.join(self.workdir, 'disk.qcow2')
> > > +        qemu_img =3D os.path.join(BUILD_DIR, 'qemu-img')
> > > +        if not os.path.exists(qemu_img):
> > > +            qemu_img =3D find_command('qemu-img', False)
> > > +        if qemu_img is False:
> > > +            self.cancel('Could not find "qemu-img", which is require=
d to '
> > > +                        'create the temporary qcow2 image')
> >=20
> > This snippet is clearly modeled after the snippet in
> > `boot_linux.BootLinuxBase.download_boot()`.  I'm adding an action
> > item to create a generic utility:
> >=20
> >    https://gitlab.com/cleber.gnu/qemu/-/issues/1
> >=20
> > > +        cmd =3D '%s create -f qcow2 %s 128M' % (qemu_img, image_path=
)
> > > +        process.run(cmd)
> > > +
> > > +        replay_path =3D os.path.join(self.workdir, 'replay.bin')
> > > +
> > > +        # record the log
> > > +        vm =3D self.run_vm(True, shift, args, replay_path, image_pat=
h)
> > > +        while self.vm_get_icount(vm) <=3D self.STEPS:
> > > +            pass
> > > +        last_icount =3D self.vm_get_icount(vm)
> > > +        vm.shutdown()
> > > +
> > > +        logger.info("recorded log with %s+ steps" % last_icount)
> > > +
> > > +        # replay and run debug commands
> > > +        vm =3D self.run_vm(False, shift, args, replay_path, image_pa=
th)
> > > +        logger.info('connecting to gdbstub')
> > > +        g =3D gdb.GDBRemote('127.0.0.1', 1234, False, False)
> > > +        g.connect()
> > > +        r =3D g.cmd(b'qSupported')
> > > +        if b'qXfer:features:read+' in r:
> > > +            g.cmd(b'qXfer:features:read:target.xml:0,ffb')
> > > +        if b'ReverseStep+' not in r:
> > > +            self.fail('Reverse step is not supported by QEMU')
> > > +        if b'ReverseContinue+' not in r:
> > > +            self.fail('Reverse continue is not supported by QEMU')
> > > +
> > > +        logger.info('stepping forward')
> > > +        steps =3D []
> > > +        # record first instruction addresses
> > > +        for _ in range(self.STEPS):
> > > +            pc =3D self.get_pc(g)
> > > +            logger.info('saving position %x' % pc)
> > > +            steps.append(pc)
> > > +            self.gdb_step(g)
> >=20
> > Do you think it'd make sense to have more utility methods, such as
> > `step()` and `bstep()` in `avocado.utils.gdb.GDBRemote` itself?
>=20
> I thought about it, but it was easier to not have the dependency on newer
> avocado version.

Agreed.

> But now we can move these functions into avocado in two steps.
>

OK.  I think the versions of these functions in
`avocado.utils.gdb.GDBRemote` can benefit from parsing the reply
packets.  With that, in addition to using a strict expected reponse
(like you've done with b'T05thread:01;') the caller may inspect
only the aspects that it deems important.

For instance, one may be interested in asserting that the signal
was a SIGTRAP, but may not care about the thread ID.

Anyway, I'm opening an issue on the Avocado project page:

   https://github.com/avocado-framework/avocado/issues/4258

If you have ideas about the interface, please let me know.

Thanks,
- Cleber.

--1Y7d0dPL928TPQbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl98tGwACgkQZX6NM6Xy
CfO7EhAAnll2KjKbZxb1zIS+OziSZjqErs1I5UOf7kf1aK+YQk+N5G7UIWSA1ke3
57zUp46CTbq1XCd7BdiJ0/akKpMC3uSw55fusENin/MkvSeVQn9XAc17kPZBU6CK
VICoc3A0ltajtyYoV0Y7FAZMWB2gwBJ5SCrfStL270FCU1eWipj5OZrAOe8o3922
V5r4egUzerOS0L2P86RakTEOIm4F6E8t2MQzll4Ct/uWDSLBdPGisREaWbBfUMKG
B7/YzCRV2Bq4RIBkV7ivXKt1WkguWZtcA3lNLp8LYj0BLRyM153CvvQEQygiB/ks
KADE5JvJubsBsj8Efdk5kRTCDy80vrofQU8uULnEd0gKKeBBvBa+KiIp05rsOJvs
EP7aWUEZk4RPu2fxf9pOQXFFNvkXx4STS9EEHlidmw3guKMW6Ck2RQC2rLNMtxuz
lGzRXnAyPCMJd5YSJjLN5hKNmoMPmD6kbOTD4sg1gyWFz6fvgucDs9OUaWpgQ6WJ
jWQo00GW+TB2V0nybNPWEzZfnUIiHiyFINzG3Ky67pv83++x25sb8KJTbKNI7Y+Q
XZIAkbZNH4AP+KyKoV+PpVm4lN1AImhqOsB3abMS4PkxfR09whp5EfINSws1Z08C
xahpWhdARAuFO8FyoU08+uQ1gMGZhDowMBHwLjx/vF5FMfKoQSM=
=jDIZ
-----END PGP SIGNATURE-----

--1Y7d0dPL928TPQbc--



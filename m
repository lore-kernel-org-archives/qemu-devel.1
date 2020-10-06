Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75934C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F52320760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjfCXWlL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F52320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPnAK-0008P3-Fa
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 09:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kPn9D-0007wJ-ED
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 09:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kPn9A-0007JY-BR
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 09:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601991409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uy7jCAN3XiXakN073T+GtZ1CcR3ME5ecjjiHyrN1Q2s=;
 b=MjfCXWlL59ahK/KG8Dyc4b46RKRvU/SwpBp+Nc2A7xAy3tlX3vxqLG4JIJnjY4fFQf5iwp
 j+6mwlPN+G8QxXhFNB8rJTgFr+NjsxXC3/a6PQ0RTQr+EbK7iP7xmbBvplplRD4044vDBC
 MUM+ZtDgGiBzGAw/9orcayK3VgMlxyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-h0BnkF-4NAiyQdVkAHHfVg-1; Tue, 06 Oct 2020 09:36:46 -0400
X-MC-Unique: h0BnkF-4NAiyQdVkAHHfVg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD67D80400D;
 Tue,  6 Oct 2020 13:36:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E44191002C22;
 Tue,  6 Oct 2020 13:36:39 +0000 (UTC)
Date: Tue, 6 Oct 2020 09:36:38 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH v7 14/14] tests/acceptance: add reverse debugging test
Message-ID: <20201006133638.GD240186@localhost.localdomain>
References: <160174516520.12451.10785284392438702137.stgit@pasha-ThinkPad-X280>
 <160174524678.12451.13258942849173670277.stgit@pasha-ThinkPad-X280>
MIME-Version: 1.0
In-Reply-To: <160174524678.12451.13258942849173670277.stgit@pasha-ThinkPad-X280>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
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

--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 03, 2020 at 08:14:06PM +0300, Pavel Dovgalyuk wrote:
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
>=20
> This is a test for GDB reverse debugging commands: reverse step and rever=
se continue.
> Every test in this suite consists of two phases: record and replay.
> Recording saves the execution of some instructions and makes an initial
> VM snapshot to allow reverse execution.
> Replay saves the order of the first instructions and then checks that the=
y
> are executed backwards in the correct order.
> After that the execution is replayed to the end, and reverse continue
> command is checked by setting several breakpoints, and asserting
> that the execution is stopped at the last of them.
>=20
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Reviewed-by: Willian Rampazzo <willianr@redhat.com>
>=20
> --
>=20
> v5:
>  - disabled (as some other tests) when running on gitlab
>    due to the unidentified timeout problem
> ---
>  MAINTAINERS                           |    1=20
>  tests/acceptance/reverse_debugging.py |  208 +++++++++++++++++++++++++++=
++++++
>  2 files changed, 209 insertions(+)
>  create mode 100644 tests/acceptance/reverse_debugging.py
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea4fa3e481..bd3a7efb75 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2693,6 +2693,7 @@ F: include/sysemu/replay.h
>  F: docs/replay.txt
>  F: stubs/replay.c
>  F: tests/acceptance/replay_kernel.py
> +F: tests/acceptance/reverse_debugging.py
>  F: qapi/replay.json
> =20
>  IOVA Tree
> diff --git a/tests/acceptance/reverse_debugging.py b/tests/acceptance/rev=
erse_debugging.py
> new file mode 100644
> index 0000000000..b72fdf6cdc
> --- /dev/null
> +++ b/tests/acceptance/reverse_debugging.py
> @@ -0,0 +1,208 @@
> +# Reverse debugging test
> +#
> +# Copyright (c) 2020 ISP RAS
> +#
> +# Author:
> +#  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +import os
> +import logging
> +
> +from avocado import skipIf
> +from avocado_qemu import BUILD_DIR
> +from avocado.utils import gdb
> +from avocado.utils import process
> +from avocado.utils.path import find_command
> +from boot_linux_console import LinuxKernelTest
> +
> +class ReverseDebugging(LinuxKernelTest):
> +    """
> +    Test GDB reverse debugging commands: reverse step and reverse contin=
ue.
> +    Recording saves the execution of some instructions and makes an init=
ial
> +    VM snapshot to allow reverse execution.
> +    Replay saves the order of the first instructions and then checks tha=
t they
> +    are executed backwards in the correct order.
> +    After that the execution is replayed to the end, and reverse continu=
e
> +    command is checked by setting several breakpoints, and asserting
> +    that the execution is stopped at the last of them.
> +    """
> +
> +    timeout =3D 10
> +    STEPS =3D 10
> +    endian_is_le =3D True

Have you attmepted a "be" test too?  I'm curious about why this is
defined (and used later) but it's never used as `False`.

> +
> +    def run_vm(self, record, shift, args, replay_path, image_path):
> +        logger =3D logging.getLogger('replay')
> +        vm =3D self.get_vm()
> +        vm.set_console()
> +        if record:
> +            logger.info('recording the execution...')
> +            mode =3D 'record'
> +        else:
> +            logger.info('replaying the execution...')
> +            mode =3D 'replay'
> +            vm.add_args('-s', '-S')
> +        vm.add_args('-icount', 'shift=3D%s,rr=3D%s,rrfile=3D%s,rrsnapsho=
t=3Dinit' %
> +                    (shift, mode, replay_path),
> +                    '-net', 'none')
> +        vm.add_args('-drive', 'file=3D%s,if=3Dnone' % image_path)
> +        if args:
> +            vm.add_args(*args)
> +        vm.launch()
> +        return vm
> +
> +    @staticmethod
> +    def get_reg_le(g, reg):
> +        res =3D g.cmd(b'p%x' % reg)
> +        num =3D 0
> +        for i in range(len(res))[-2::-2]:
> +            num =3D 0x100 * num + int(res[i:i + 2], 16)
> +        return num
> +
> +    @staticmethod
> +    def get_reg_be(g, reg):
> +        res =3D g.cmd(b'p%x' % reg)
> +        return int(res, 16)
> +
> +    def get_reg(self, g, reg):
> +        # value may be encoded in BE or LE order
> +        if self.endian_is_le:
> +            return self.get_reg_le(g, reg)
> +        else:
> +            return self.get_reg_be(g, reg)
> +
> +    def get_pc(self, g):
> +        return self.get_reg(g, self.REG_PC)
> +
> +    def check_pc(self, g, addr):
> +        pc =3D self.get_pc(g)
> +        if pc !=3D addr:
> +            self.fail('Invalid PC (read %x instead of %x)' % (pc, addr))
> +
> +    @staticmethod
> +    def gdb_step(g):
> +        g.cmd(b's', b'T05thread:01;')
> +
> +    @staticmethod
> +    def gdb_bstep(g):
> +        g.cmd(b'bs', b'T05thread:01;')
> +
> +    @staticmethod
> +    def vm_get_icount(vm):
> +        return vm.qmp('query-replay')['return']['icount']
> +
> +    def reverse_debugging(self, shift=3D7, args=3DNone):
> +        logger =3D logging.getLogger('replay')
> +
> +        # create qcow2 for snapshots
> +        logger.info('creating qcow2 image for VM snapshots')
> +        image_path =3D os.path.join(self.workdir, 'disk.qcow2')
> +        qemu_img =3D os.path.join(BUILD_DIR, 'qemu-img')
> +        if not os.path.exists(qemu_img):
> +            qemu_img =3D find_command('qemu-img', False)
> +        if qemu_img is False:
> +            self.cancel('Could not find "qemu-img", which is required to=
 '
> +                        'create the temporary qcow2 image')

This snippet is clearly modeled after the snippet in
`boot_linux.BootLinuxBase.download_boot()`.  I'm adding an action
item to create a generic utility:

  https://gitlab.com/cleber.gnu/qemu/-/issues/1

> +        cmd =3D '%s create -f qcow2 %s 128M' % (qemu_img, image_path)
> +        process.run(cmd)
> +
> +        replay_path =3D os.path.join(self.workdir, 'replay.bin')
> +
> +        # record the log
> +        vm =3D self.run_vm(True, shift, args, replay_path, image_path)
> +        while self.vm_get_icount(vm) <=3D self.STEPS:
> +            pass
> +        last_icount =3D self.vm_get_icount(vm)
> +        vm.shutdown()
> +
> +        logger.info("recorded log with %s+ steps" % last_icount)
> +
> +        # replay and run debug commands
> +        vm =3D self.run_vm(False, shift, args, replay_path, image_path)
> +        logger.info('connecting to gdbstub')
> +        g =3D gdb.GDBRemote('127.0.0.1', 1234, False, False)
> +        g.connect()
> +        r =3D g.cmd(b'qSupported')
> +        if b'qXfer:features:read+' in r:
> +            g.cmd(b'qXfer:features:read:target.xml:0,ffb')
> +        if b'ReverseStep+' not in r:
> +            self.fail('Reverse step is not supported by QEMU')
> +        if b'ReverseContinue+' not in r:
> +            self.fail('Reverse continue is not supported by QEMU')
> +
> +        logger.info('stepping forward')
> +        steps =3D []
> +        # record first instruction addresses
> +        for _ in range(self.STEPS):
> +            pc =3D self.get_pc(g)
> +            logger.info('saving position %x' % pc)
> +            steps.append(pc)
> +            self.gdb_step(g)

Do you think it'd make sense to have more utility methods, such as
`step()` and `bstep()` in `avocado.utils.gdb.GDBRemote` itself?

> +
> +        # visit the recorded instruction in reverse order
> +        logger.info('stepping backward')
> +        for addr in steps[::-1]:
> +            self.gdb_bstep(g)
> +            self.check_pc(g, addr)
> +            logger.info('found position %x' % addr)
> +
> +        logger.info('seeking to the end (icount %s)' % (last_icount - 1)=
)
> +        vm.qmp('replay-break', icount=3Dlast_icount - 1)
> +        # continue - will return after pausing
> +        g.cmd(b'c', b'T02thread:01;')
> +
> +        logger.info('setting breakpoints')
> +        for addr in steps:
> +            # hardware breakpoint at addr with len=3D1
> +            g.cmd(b'Z1,%x,1' % addr, b'OK')
> +
> +        logger.info('running reverse continue to reach %x' % steps[-1])
> +        # reverse continue - will return after stopping at the breakpoin=
t
> +        g.cmd(b'bc', b'T05thread:01;')
> +
> +        # assume that none of the first instructions is executed again
> +        # breaking the order of the breakpoints
> +        self.check_pc(g, steps[-1])
> +        logger.info('successfully reached %x' % steps[-1])
> +
> +        logger.info('exitting gdb and qemu')
> +        vm.shutdown()
> +
> +class ReverseDebugging_X86_64(ReverseDebugging):
> +    REG_PC =3D 0x10
> +    REG_CS =3D 0x12
> +    def get_pc(self, g):
> +        return self.get_reg_le(g, self.REG_PC) \
> +            + self.get_reg_le(g, self.REG_CS) * 0x10
> +

Nitpick: avoid backslash as line continuation, and favor parentheses,
that is:

    def get_pc(self, g):
        return (self.get_reg_le(g, self.REG_PC) +
                self.get_reg_le(g, self.REG_CS) * 0x10)

Despite the comments and questions, this LGTM:

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl98cuMACgkQZX6NM6Xy
CfOpkRAAtSSMJB4gPpqqnsp39VQEzBS9tq8toH88WdiQQWqtKAiBunwf6bXJbAsS
+asRKEDVfzy9gJZNp+vAVncPqgp0SrslpPbXwDxes9/9qGA3bJhdr1U4oD4Y0MwU
Yz5aRP6mb0a2rHMHY9T7dFsYXDqWpq2m2KixvciKHe+9e50twCvrltHX9Yct2oGi
rl2NcoM19wvpg311J9JFvfyZhMy5+twNIacx/wod5fBE1EhHtVFrAtVW57bvzBwo
SiAG0Ez/+/24nRteQSytsqKyjiB3/Js9PFYgy3pfziBjeR4Z9NdH1iOu1B+g/V7v
d61RbrXweRb90Bc83vJtQNRQIVd+SVo1XX38HVj+8oKlsZ7UZO5HWFtJBsBxpZIe
T4P6OSsL5VH/mF6u6C299XhlDmiBt7av28bGbhUe8+W9RWGxNl8QQW/tggMmPF4w
yhqz486eHlYR7CoVvE/kez96n6TE6XyKUBW5K7ypOBYVJ/PkLlSywnWceow3XoU7
EjGdHu43jB+m4suEYWxmSMAc8yBkdfHpfFgblMjmYnFjdYEngRDLl5uHso8MIfu2
kBkX6eT9oAxjiNX2+ORCccvj3+Vi88QQw78uXpe1NeZ+CQwn6Ylj2K02qHkZD0kd
xas3PVFKIxOD1QoRav7dgEd+eYUaFhXB5MyGntYguZ/8MVoHSBY=
=nNhk
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--



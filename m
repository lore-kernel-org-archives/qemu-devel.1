Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7A7C35679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 09:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA0020828
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 09:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOOYP64E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA0020828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6A0o-0005m2-1a
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 04:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1j69zy-00051j-V9
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 04:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1j69zw-0003Mi-FK
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 04:25:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43390
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1j69zw-0003Lc-4m
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 04:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582536354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=feuzw/uGtf5zD26hm3tTCSC1zFjSQe1cYFpISgzbMNQ=;
 b=iOOYP64ETTNYRQY67Ja8z2wrBtFE6tCSH1iudwqv4lDFwTWbKoMJgXDWNbJoNOPydK2BOA
 gUSHe7ZP7fl4L8tdvp5WIdwUOw7ql1/BpnXizVeCliVjSqBNDkzmN7+SN5a29X4xT+dST0
 5DeDd0o5/myqgFN/ztuGl9LLUlPw0JY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-nItz8xEQNk6d_6v0dd1evQ-1; Mon, 24 Feb 2020 04:25:49 -0500
X-MC-Unique: nItz8xEQNk6d_6v0dd1evQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A95318A5508;
 Mon, 24 Feb 2020 09:25:48 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 66A028B755;
 Mon, 24 Feb 2020 09:25:43 +0000 (UTC)
Date: Mon, 24 Feb 2020 10:25:41 +0100
From: Andrew Jones <drjones@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v9 2/3] Acceptance test: add "boot_linux" tests
Message-ID: <20200224092541.h3fprgkuczvl7ujf@kamzik.brq.redhat.com>
References: <20200220020652.16276-1-crosa@redhat.com>
 <20200220020652.16276-3-crosa@redhat.com>
 <4fe4f011-1d4a-aaea-2536-223194dacd8c@redhat.com>
 <20200220195245.GA14444@dhcp-17-202.bos.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200220195245.GA14444@dhcp-17-202.bos.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 20, 2020 at 02:52:45PM -0500, Cleber Rosa wrote:
> On Thu, Feb 20, 2020 at 01:49:40PM -0300, Wainer dos Santos Moschetta wro=
te:
> > On 2/19/20 11:06 PM, Cleber Rosa wrote:
> > > +
> > > +    def test_virt_tcg(self):
> > > +        """
> > > +        :avocado: tags=3Daccel:tcg
> > > +        :avocado: tags=3Dcpu:cortex-a53
> > > +        """
> > > +        if not tcg_available(self.qemu_bin):
> > > +            self.cancel(TCG_NOT_AVAILABLE)
> > > +        self.vm.add_args("-accel", "tcg")
> > > +        self.vm.add_args('-cpu', 'cortex-a53')

Should use '-cpu max'. gic-version will be '2' by default, which is good
for tcg, but I would probably add an explicit '-machine gic-version=3D2'
anyway.

> > > +        self.add_common_args()
> > > +        self.launch_and_wait()
> > > +
> > > +    def test_virt_kvm(self):
> > > +        """
> > > +        :avocado: tags=3Daccel:kvm
> > > +        :avocado: tags=3Dcpu:host
> > > +        """
> > > +        if not kvm_available(self.arch, self.qemu_bin):
> > > +            self.cancel(KVM_NOT_AVAILABLE)
> > > +        self.vm.add_args("-accel", "kvm")
> > > +        self.vm.add_args("-cpu", "host")

kvm needs '-machine gic-version=3Dmax' and could use '-cpu max' too,
because, for kvm, CPU::max =3D=3D CPU::host

> > > +        self.add_common_args()
> > > +        self.launch_and_wait()
> >=20
> >=20
> > For aarch64 tests it seems '-cpu max' is the best choice. See in
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg672755.html
> >=20
> >
>=20
> +drew
>=20
> Thanks for pointing that out.  There's one thing, though, which I can
> not agree on.  And I know that Drew is an expert on the matter, which
> makes it harder to disagree on... but, I've got results which clearly
> indicate that *not using* the gic-version machine parameter still gets
> me KVM:

The gic-version machine property is completely independent of whether kvm
or tcg is selected. However, if you select kvm and a gic-version that is
incompatible with the host then the guest will not start. If gic-version
is not specified it defaults to '2'. Below the kvm guest started
successfully because it happened to be started on a host with gicv2 or
on a host with gicv3 that supports gicv2-on-v3 (which is an optional
feature that doesn't appear to be getting implemented in modern AArch64
servers). The test below would have failed to start the guest on a host
with only gicv3.

When kvm is in use, one must use gic-version=3Dmax in order to automaticall=
y
select the latest host-compatible gic version, or the guest will not start
on all hosts.

>=20
> ./tests/venv/bin/avocado run tests/acceptance/boot_linux.py:BootLinuxAarc=
h64.test_virt_kvm
> JOB ID     : 21a394b884b474ceee0a045b3e74f98da0aee023
> JOB LOG    : /home/cleber/avocado/job-results/job-2020-02-20T14.28-21a394=
b/job.log
>  (1/1) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_kvm: PAS=
S (35.10 s)
> RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0
> JOB TIME   : 35.87 s
>=20
> VM launch command:
>    aarch64-softmmu/qemu-system-aarch64
>    -display none
>    -vga none
>    -chardev socket,id=3Dmon,path=3D/var/tmp/tmpntz_r_h7/qemu-18331-monito=
r.sock
>    -mon chardev=3Dmon,mode=3Dcontrol
>    -machine virt
>    -chardev socket,id=3Dconsole,path=3D/var/tmp/tmpntz_r_h7/qemu-18331-co=
nsole.sock,server,nowait
>    -serial chardev:console
>    -smp 2
>    -m 1024
>    -drive file=3D/var/tmp/avocado_u9jm04di/avocado_job_28oth9kk/1-tests_a=
cceptance_boot_linux.py_BootLinuxAarch64.test_virt_kvm/Fedora-Cloud-Base-31=
-1.9.aarch64-05265df5.qcow2 -drive file=3D/var/tmp/avocado_u9jm04di/avocado=
_job_28oth9kk/1-tests_acceptance_boot_linux.py_BootLinuxAarch64.test_virt_k=
vm/cloudinit.iso,format=3Draw
>    -accel kvm
>    -cpu host
>    -bios /home/cleber/build/qemu/pc-bios/edk2-aarch64-code.fd
>    -device virtio-rng-pci,rng=3Drng0
>    -object rng-random,id=3Drng0,filename=3D/dev/urandom
>=20
> Guest boot messages shows:
> [    1.538955] systemd[1]: Detected virtualization kvm.
> [    1.539828] systemd[1]: Detected architecture arm64.
>=20
> This is in contrast with:
>=20
> ./tests/venv/bin/avocado run tests/acceptance/boot_linux.py:BootLinuxAarc=
h64.test_virt_tcg=20
> JOB ID     : 90b9412f700e52428b59e97719496c30b4f54435
> JOB LOG    : /home/cleber/avocado/job-results/job-2020-02-20T14.32-90b941=
2/job.log
>  (1/1) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PAS=
S (581.14 s)
> RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0
> JOB TIME   : 581.93 s
>=20
> VM launch command:
>    aarch64-softmmu/qemu-system-aarch64
>    -display none
>    -vga none
>    -chardev socket,id=3Dmon,path=3D/var/tmp/tmpa6i4livg/qemu-18498-monito=
r.sock
>    -mon chardev=3Dmon,mode=3Dcontrol
>    -machine virt
>    -chardev socket,id=3Dconsole,path=3D/var/tmp/tmpa6i4livg/qemu-18498-co=
nsole.sock,server,nowait
>    -serial chardev:console
>    -smp 2
>    -m 1024
>    -drive file=3D/var/tmp/avocado_slcj2x9e/avocado_job_x5u__309/1-tests_a=
cceptance_boot_linux.py_BootLinuxAarch64.test_virt_tcg/Fedora-Cloud-Base-31=
-1.9.aarch64-5b006a2f.qcow2 -drive file=3D/var/tmp/avocado_slcj2x9e/avocado=
_job_x5u__309/1-tests_acceptance_boot_linux.py_BootLinuxAarch64.test_virt_t=
cg/cloudinit.iso,format=3Draw
>    -accel tcg
>    -cpu cortex-a53
>    -bios /home/cleber/build/qemu/pc-bios/edk2-aarch64-code.fd
>    -device virtio-rng-pci,rng=3Drng0
>    -object rng-random,id=3Drng0,filename=3D/dev/urandom'
>=20
> Guest boot messages shows:
> [   28.606310] systemd[1]: Detected virtualization qemu.
> [   28.607861] systemd[1]: Detected architecture arm64.
>=20
> And with regards to the CPU type, IIRC, "max" will fallback to the
> best CPU on TCG mode.

No, it doesn't fallback. It implements the cortex-a57 and enables all
optional CPU features. Why was the cortex-a53 chosen for the tests?

> As a general best practice in testing, I'd
> rather not have this dynamic aspect where we can avoid it.  Looks like
> with TCG we can set it to one CPU and validate that the guests work on
> that configuration.

The only dynamic aspect is that as new CPU features are implemented
they'll get enabled. Personally I'd prefer the tests run with the latest
code enabled in order to find the latest bugs.

>=20
> IIUC, by using either "-cpu host" or "-cpu max" for KVM, we may end up
> having the same test PASS or FAIL because of the (dynamic) host CPU.
> That's not ideal for testing purposes, but given it's outside of our
> control, do best we can do is keep track of the host CPU (via Avocado's
> sysinfo collection).

Right. AArch64 KVM must use '-cpu host' (or equivalently '-cpu max'). That
can't be changed. Capturing the host CPU type is a good idea.

>=20
> Also, I've used the same CPU model that has been used on
> boot_linux_console.py:BootLinuxConsole.test_aarch64_virt, which may be
> a plus.

Is that the cortex-a53? Was some justification given for its use there?
If not, then maybe it should be changed there too.

Thanks,
drew



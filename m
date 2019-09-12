Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA9EC5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5209E206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5209E206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8MRr-0003uU-1x
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 06:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i8MNP-0007uV-6F
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i8MNN-0004CM-G6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:30:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:46162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i8MNN-0004Bf-9h
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:30:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i8MNL-0006gr-SS
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 10:30:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D52A02E80C8
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 10:30:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Sep 2019 10:16:32 -0000
From: James Harvey <jamespharvey20@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dgilbert-h jamespharvey20
X-Launchpad-Bug-Reporter: James Harvey (jamespharvey20)
X-Launchpad-Bug-Modifier: James Harvey (jamespharvey20)
References: <156790812963.29382.11232177290822294099.malonedeb@chaenomeles.canonical.com>
Message-Id: <156828339303.28699.8537272828952910638.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 3e6536ca27d00e488c45102131016aab036d53a8
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1843151] Re: Regression: QEMU 4.1.0 qxl and KMS
 resoluiton only 4x10
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1843151 <1843151@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bisection is not going well at all with this code base!

Before your last reply, I started, and the first between 4.0.0 and 4.1.0
is aae6500972 which fails compilation:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

...
  CC      stubs/pci-host-piix.o
  CC      stubs/ram-block.o
  CC      stubs/ramfb.o
  CC      stubs/fw_cfg.o
  CC      stubs/semihost.o
  CC      qemu-keymap.o
  CC      util/filemonitor-stub.o

Warning, treated as error:
/build/qemu-bisect/src/qemu/docs/interop/bitmaps.rst:202:Could not lex lite=
ral_block as "json". Highlighting skipped.
  CC      ui/input-keymap.o
  CC      contrib/elf2dmp/main.o
  CC      contrib/elf2dmp/addrspace.o
  CC      contrib/elf2dmp/download.o
  CC      contrib/elf2dmp/pdb.o
  CC      contrib/elf2dmp/qemu_elf.o
  CC      contrib/ivshmem-client/ivshmem-client.o
  CC      contrib/ivshmem-client/main.o
  CC      contrib/ivshmem-server/ivshmem-server.o

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I tried just marking it as good and hoping it was a more recent
regression, instead of even doing a skip, but efa85a4d1a fails with the
same error.  I double checked that 4.0.0 and 4.1.0 still get past that
spot for me, and they do.

I tried your suggestion, be812c0, but that compiled with this error:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  CC      crypto/cipher.o
  CC      crypto/tlscreds.o
  CC      crypto/tlscredsanon.o
/build/qemu-bisect/src/qemu/block/gluster.c: In function =E2=80=98qemu_glus=
ter_co_pwrite_zeroes=E2=80=99:
/build/qemu-bisect/src/qemu/block/gluster.c:994:52: warning: passing argume=
nt 4 of =E2=80=98glfs_zerofill_async=E2=80=99 from incompatible pointer typ=
e [-Wincompatible-pointer
-types]
  994 |     ret =3D glfs_zerofill_async(s->fd, offset, size, gluster_finish=
_aiocb, &acb);
      |                                                    ^~~~~~~~~~~~~~~~=
~~~~
      |                                                    |
      |                                                    void (*)(struct =
glfs_fd *, ssize_t,  void *) {aka void (*)(struct glfs_fd *, long int,  voi=
d *)}
In file included from /build/qemu-bisect/src/qemu/block/gluster.c:12:
/usr/include/glusterfs/api/glfs.h:993:73: note: expected =E2=80=98glfs_io_c=
bk=E2=80=99 {aka =E2=80=98void (*)(struct glfs_fd *, long int,  struct glfs=
_stat *, struct glfs_stat *, void
 *)=E2=80=99} but argument is of type =E2=80=98void (*)(struct glfs_fd *, s=
size_t,  void *)=E2=80=99 {aka =E2=80=98void (*)(struct glfs_fd *, long int=
,  void *)=E2=80=99}
  993 | glfs_zerofill_async(glfs_fd_t *fd, off_t length, off_t len, glfs_io=
_cbk fn,
      |                                                             ~~~~~~~=
~~~~~^~
/build/qemu-bisect/src/qemu/block/gluster.c: In function =E2=80=98qemu_glus=
ter_do_truncate=E2=80=99:
/build/qemu-bisect/src/qemu/block/gluster.c:1035:13: error: too few argumen=
ts to function =E2=80=98glfs_ftruncate=E2=80=99
 1035 |         if (glfs_ftruncate(fd, offset)) {
      |             ^~~~~~~~~~~~~~
In file included from /build/qemu-bisect/src/qemu/block/gluster.c:12:
/usr/include/glusterfs/api/glfs.h:768:1: note: declared here
  768 | glfs_ftruncate(glfs_fd_t *fd, off_t length, struct glfs_stat *prest=
at,
      | ^~~~~~~~~~~~~~
/build/qemu-bisect/src/qemu/block/gluster.c:1046:13: error: too few argumen=
ts to function =E2=80=98glfs_ftruncate=E2=80=99
 1046 |         if (glfs_ftruncate(fd, offset)) {
      |             ^~~~~~~~~~~~~~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

So, I looked at configure and saw a "--disable-glusterfs" option, and
tried it.  It still failed with:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  GEN     it.mo
  GEN     bg.mo
  GEN     fr_FR.mo
  GEN     zh_CN.mo
  GEN     de_DE.mo
  GEN     hu.mo
  GEN     tr.mo
for obj in hu.mo tr.mo it.mo bg.mo fr_FR.mo zh_CN.mo de_DE.mo; do \
    base=3D$(basename $obj .mo); \
    install -d /build/qemu-bisect/pkg/qemu-bisect/usr/share/locale/$base/LC=
_MESSAGES; \
    install -m644 $obj /build/qemu-bisect/pkg/qemu-bisect/usr/share/locale/=
$base/LC_MESSAGES/qemu.mo; \
done
make[1]: Leaving directory '/build/qemu-bisect/src/build-full/po'
install -d -m 0755 "/build/qemu-bisect/pkg/qemu-bisect/usr/share/qemu/keyma=
ps"
set -e; for x in da     en-gb  et  fr     fr-ch  is  lt  no  pt-br  sv ar  =
    de     en-us  fi  fr-be  hr     it  lv  nl         pl  ru     th de-ch =
 es     fo  fr-ca  hu     ja  mk  pt  sl     tr bepo    cz; do \
        install -c -m 0644 /build/qemu-bisect/src/qemu/pc-bios/keymaps/$x "=
/build/qemu-bisect/pkg/qemu-bisect/usr/share/qemu/keymaps"; \
done
install -c -m 0644 /build/qemu-bisect/src/build-full/trace-events-all "/bui=
ld/qemu-bisect/pkg/qemu-bisect/usr/share/qemu/trace-events-all"
for d in aarch64-softmmu alpha-softmmu arm-softmmu cris-softmmu hppa-softmm=
u i386-softmmu lm32-softmmu m68k-softmmu microblazeel-softmmu microblaze-so=
ftmmu mips64el-softmmu mips64-softmmu mipsel-softmmu mips-softmmu moxie-sof=
tmmu nios2-softmmu or1k-softmmu ppc64-softmmu ppc-softmmu riscv32-softmmu r=
iscv64-softmmu s390x-softmmu sh4eb-softmmu sh4-softmmu sparc64-softmmu spar=
c-softmmu tricore-softmmu unicore32-softmmu x86_64-softmmu xtensaeb-softmmu=
 xtensa-softmmu aarch64_be-linux-user aarch64-linux-user alpha-linux-user a=
rmeb-linux-user arm-linux-user cris-linux-user hppa-linux-user i386-linux-u=
ser m68k-linux-user microblazeel-linux-user microblaze-linux-user mips64el-=
linux-user mips64-linux-user mipsel-linux-user mips-linux-user mipsn32el-li=
nux-user mipsn32-linux-user nios2-linux-user
or1k-linux-user ppc64abi32-linux-user ppc64le-linux-user ppc64-linux-user p=
pc-linux-user riscv32-linux-user riscv64-linux-user s390x-linux-user sh4eb-=
linux-user sh4-linux-user sparc32plus-linux-user sparc64-linux-user sparc-l=
inux-user tilegx-linux-user x86_64-linux-user xtensaeb-linux-user xtensa-li=
nux-user; do \
make --no-print-directory --quiet BUILD_DIR=3D/build/qemu-bisect/src/build-=
full TARGET_DIR=3D$d/ -C $d install || exit 1 ; \
        done
make: Leaving directory '/build/qemu-bisect/src/build-full'
rm: cannot remove 'qemu/block-gluster.so': No such file or directory

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

All of these builds are in clean chroot environments, so they're
starting from source scratch builds without interference between
previous attempts.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1843151

Title:
  Regression: QEMU 4.1.0 qxl and KMS resoluiton only 4x10

Status in QEMU:
  New

Bug description:
  Host is Arch Linux.  linux 5.2.13, qemu 4.1.0.  virt-viewer 8.0.

  Guest is Arch Linux Sept 2019 ISO.  linux 5.2.11.

  Have replicated this both on a system using amdgpu and one using
  integrated ASPEED graphics.

  Downgrading from 4.1.0 to 4.0.0 works as usual, see:
  https://www.youtube.com/watch?v=3DNyMdcYwOCvY

  Going back to 4.1.0 reproduces, see:
  https://www.youtube.com/watch?v=3DH3nGG2Mk6i0

  4.1.0 displays fine until KMS kicks in.

  Using 4.1.0 with virtio-vga doesn't cause this.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1843151/+subscriptions


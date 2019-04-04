Return-Path: <SRS0=qZCI=SG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97BAC4360F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2019 22:32:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BD9206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2019 22:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BD9206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60482 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCAuU-0006PX-I7
	for qemu-devel@archiver.kernel.org; Thu, 04 Apr 2019 18:32:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCAtW-0005pt-ND
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 18:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCAtU-0000sD-LJ
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 18:31:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCAtU-0000mn-2E
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 18:31:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so4734967wmf.5
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 15:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to;
	bh=1xbRNpTaYCmghX6I03m+/kRqpOzcmrtb2JDc31g2jl0=;
	b=Wbd3ZmN3BVTvbCXc6rZsKlfPJ5c+HZpZhieo/l4iXNbLm3iipFJOkbMDYo7XXRTBbW
	UbqreqkdPaKBFr5BDxJOlB1/8EvShYmRiAD1EEy330MYvP672EWTtY8jbK/yjpjGzCjI
	oRg3W7nMu4G+GBFC7524JQdfLfi68TCi/R8b9wOS87nPghzQRabV9CAY+TptwLg2sAtF
	LBgoKu6MMq3POc6e1J/m1WHLIjbiAmI/DvS9tp2lqNZMD8D6mV/iy+8y2sybJ0oJVN29
	u+0ov9S/0kvBu1BL4vF64INW1lRDIRMZu5hoUR0DAR8XHabwKSnD3lUZSKZQtnQUFSdY
	ZTYw==
X-Gm-Message-State: APjAAAXI4snN+h40PH7ry/w4N2JEfBqgnIradBzvkfEA3z/powvfMVcA
	R6Mvnxma5G9AMj/rTOkZlLT9vQ==
X-Google-Smtp-Source: APXvYqwwS44FcN1kKZQpFpz3RkWu8GFhbK0owgXPbuakN9S6DFJ2aZx/B0J5JV8ONqdPrVqVb5nwqg==
X-Received: by 2002:a1c:6455:: with SMTP id y82mr4135232wmb.104.1554417094799; 
	Thu, 04 Apr 2019 15:31:34 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	q17sm17083157wrw.70.2019.04.04.15.31.33
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 04 Apr 2019 15:31:33 -0700 (PDT)
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ce68c2dc-857a-aff0-0fb7-a8e48e921c54@redhat.com>
Date: Fri, 5 Apr 2019 00:31:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CjEPqEUjcmo2Hzyw6Kjd9tIsJ89AS04dE"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 00/97] Patch Round-up for stable 3.0.1,
 freeze on 2019-04-08
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Hannes Reinecke <hare@suse.com>,
	Michael Tokarev <mjt@tls.msk.ru>, Peter Lieven <pl@kamp.de>,
	qemu-stable@nongnu.org, Yuval Shaia <yuval.shaia@oracle.com>,
	Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190404223131.oq1i3AX5S5BjugfkxE0TfKKVVuk4BdE8IusX4VF7Qg8@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CjEPqEUjcmo2Hzyw6Kjd9tIsJ89AS04dE
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>,
 Hannes Reinecke <hare@suse.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Gerd Hoffmann <kraxel@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce68c2dc-857a-aff0-0fb7-a8e48e921c54@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/97] Patch Round-up for stable 3.0.1,
 freeze on 2019-04-08
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/1/19 10:58 PM, Michael Roth wrote:
> Hi everyone,                                                           =
                                  =20
>=20
> The following new patches are queued for QEMU stable v3.0.1:
>=20
>   https://github.com/mdroth/qemu/commits/stable-3.0-staging
>=20
> The release is planned for 2019-04-11:
>=20
>   https://wiki.qemu.org/Planning/3.0
>=20
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
>=20
> Note that this update falls outside the normal stable release support
> window (~1 development cycle), but is being release now since it was
> delayed from its intended release date.
>=20
> Thanks!
>=20
> ----------------------------------------------------------------
> Alberto Garcia (1):
>       block: Fix use after free error in bdrv_open_inherit()
>=20
> BALATON Zoltan (1):
>       i2c: Move typedef of bitbang_i2c_interface to i2c.h
>=20
> Bharata B Rao (1):
>       spapr_cpu_core: vmstate_[un]register per-CPU data from (un)realiz=
efn
>=20
> Christian Borntraeger (1):
>       iotests: make 235 work on s390 (and others)
>=20
> Corey Minyard (2):
>       i2c: Add a length check to the SMBus write handling
>       pc:piix4: Update smbus I/O space after a migration
>=20
> Daniel Henrique Barboza (1):
>       qga: update docs with systemd suspend support info
>=20
> Daniel P. Berrang=C3=A9 (1):
>       qemu-img: fix regression copying secrets during convert
>=20
> Denis V. Lunev (1):
>       nbd: fix NBD_FLAG_SEND_CACHE value
>=20
> Eduardo Habkost (1):
>       i386: Disable TOPOEXT by default on "-cpu host"
>=20
> Eric Blake (4):
>       nbd/server: Advertise all contexts in response to bare LIST
>       nbd/client: Make x-dirty-bitmap more reliable
>       nbd/client: Send NBD_CMD_DISC if open fails after connect
>       bitmap: Update count after a merge
>=20
> Fam Zheng (5):
>       nvme: Fix nvme_init error handling
>       aio-posix: Don't count ctx->notifier as progress when polling
>       aio: Do aio_notify_accept only during blocking aio_poll
>       slirp: Add sanity check for str option length
>       job: Fix nested aio_poll() hanging in job_txn_apply
>=20
> Gerd Hoffmann (3):
>       fmops: fix off-by-one in AR_TABLE and DR_TABLE array size
>       usb-mtp: outlaw slashes in filenames
>       usb-mtp: use O_NOFOLLOW and O_CLOEXEC.
>=20
> Greg Kurz (1):
>       9p: fix QEMU crash when renaming files
>=20
> Igor Mammedov (1):
>       pc: acpi: revert back to 1 SRAT entry for hotpluggable area
>=20
> Ilya Maximets (1):
>       migration: Stop postcopy fault thread before notifying
>=20
> Janosch Frank (1):
>       s390x: Return specification exception for unimplemented diag 308 =
subcodes
>=20
> Jason Wang (5):
>       ne2000: fix possible out of bound access in ne2000_receive
>       rtl8139: fix possible out of bound access
>       pcnet: fix possible buffer overflow
>       net: ignore packet size greater than INT_MAX
>       net: drop too large packet early
>=20
> Jeff Cody (6):
>       block: for jobs, do not clear user_paused until after the resume
>       block: iotest to catch abort on forced blockjob cancel
>       block/rbd: pull out qemu_rbd_convert_options
>       block/rbd: Attempt to parse legacy filenames
>       block/rbd: add iotest for rbd legacy keyvalue filename parsing
>       block/rbd: add deprecation documentation for filename keyvalue pa=
irs
>=20
> Kevin Wolf (4):
>       block/qapi: Fix memory leak in qmp_query_blockstats()
>       mirror: Fail gracefully for source =3D=3D target
>       block-backend: Set werror/rerror defaults in blk_new()
>       block: Fix invalidate_cache error path for parent activation
>=20
> Liam Merwick (1):
>       tpm_tis: fix loop that cancels any seizure by a lower locality
>=20
> Marc-Andr=C3=A9 Lureau (1):
>       monitor: fix oob command leak
>=20
> Marcel Apfelbaum (1):
>       hw/rdma: another clang compilation fix
>=20
> Mark Cave-Ayland (1):
>       fdc: fix segfault in fdctrl_stop_transfer() when DMA is disabled
>=20
> Markus Armbruster (1):
>       vfio-helpers: Fix qemu_vfio_open_pci() crash
>=20
> Max Filippov (3):
>       target/xtensa: fix FPU2000 bugs
>       target/xtensa: fix s32c1i TCGMemOp flags
>       target/xtensa: drop num_[core_]regs from dc232b/dc233c configs
>=20
> Max Reitz (2):
>       qemu-img: Fix typo
>       qemu-img: Fix leak
>=20
> Michael Roth (1):
>       make-release: add skiboot .version file
>=20
> Michael S. Tsirkin (1):
>       tests: update acpi expected files
>=20
> Paolo Bonzini (3):
>       virtio: update MemoryRegionCaches when guest negotiates features
>       virtio: do not take address of packed members
>       nvme: fix out-of-bounds access to the CMB
>=20
> Paul A. Clarke (1):
>       Changes requirement for "vsubsbs" instruction
>=20
> Peter Maydell (4):
>       virt: Suppress external aborts on virt-2.10 and earlier
>       target/arm: Correct condition for v8M callee stack push
>       linux-user: make pwrite64/pread64(fd, NULL, 0, offset) return 0
>       exec.c: Don't reallocate IOMMUNotifiers that are in use
>=20
> Peter Wu (1):
>       vnc: fix memleak of the "vnc-worker-output" name
>=20
> Peter Xu (2):
>       intel_iommu: introduce vtd_reset_caches()
>       intel_iommu: better handling of dmar state switch
>=20
> Prasad J Pandit (1):
>       tpm: use loop iterator to set sts data field
>=20
> Prasad Singamsetty (1):
>       kvm: add call to qemu_add_opts() for -overcommit option
>=20
> Richard Henderson (16):
>       target/arm: Fix sign of sve_cmpeq_ppzw/sve_cmpne_ppzw
>       target/arm: Fix typo in do_sat_addsub_64
>       target/arm: Reorganize SVE WHILE
>       target/arm: Fix typo in helper_sve_movz_d
>       target/arm: Fix typo in helper_sve_ld1hss_r
>       target/arm: Fix sign-extension in sve do_ldr/do_str
>       target/arm: Fix offset for LD1R instructions
>       target/arm: Fix offset scaling for LD_zprr and ST_zprr
>       target/arm: Reformat integer register dump
>       target/arm: Dump SVE state if enabled
>       target/arm: Add sve-max-vq cpu property to -cpu max
>       target/arm: Adjust FPCR_MASK for FZ16
>       target/arm: Ignore float_flag_input_denormal from fp_status_f16
>       target/arm: Use fp_status_fp16 for do_fmpa_zpzzz_h
>       target/arm: Use FZ not FZ16 for SVE FCVT single-half and double-h=
alf
>       target/arm: Fix cpu_get_tb_cpu_state() for non-SVE CPUs
>=20
> Stefan Berger (4):
>       tpm: Zero-init structure to avoid uninitialized variables in valg=
rind log
>       tpm: Make sure new locality passed to tpm_tis_prep_abort() is val=
id
>       tpm: Make sure the locality received from backend is valid
>       acpi: Make TPM 2.0 with TIS available as MSFT0101
>=20
> Thomas Huth (1):
>       hw/s390x: Fix bad mask in time2tod()
>=20
> Tony Garnock-Jones (1):
>       linux-user: write(fd, NULL, 0) parity with linux's treatment of s=
ame
>=20
> Vladimir Sementsov-Ogievskiy (4):
>       nbd/server: fix bitmap export
>       nbd/server: fix NBD_CMD_CACHE
>       mirror: fix dead-lock
>       iotests: simple mirror test with kvm on 1G image
>=20
> William Bowling (1):
>       slirp: check sscanf result when emulating ident
>=20
> Yury Kotov (1):
>       vhost: fix invalid downcast
>=20
> Zheng Xiang (1):
>       pcie: set link state inactive/active after hot unplug/plug
>=20
> liujunjie (1):
>       clean up callback when del virtqueue
>=20
> yuchenlin (1):
>       vhost-scsi: prevent using uninitialized vqs
>=20
>  block.c                                    |   2 +
>  block/block-backend.c                      |   3 +
>  block/mirror.c                             |  18 ++---
>  block/nbd-client.c                         |  22 +++++-
>  block/nvme.c                               |  37 ++++------
>  block/qapi.c                               |   3 +-
>  block/rbd.c                                |  90 ++++++++++++++++++++-=
---
>  exec.c                                     |  10 +--
>  hw/9pfs/9p.c                               |   3 +
>  hw/acpi/piix4.c                            |   1 +
>  hw/arm/virt.c                              |   2 +
>  hw/audio/fmopl.h                           |   4 +-
>  hw/block/fdc.c                             |   2 +-
>  hw/block/nvme.c                            |   2 +-
>  hw/char/virtio-serial-bus.c                |   6 +-
>  hw/i2c/bitbang_i2c.h                       |   2 -
>  hw/i2c/smbus.c                             |   6 +-
>  hw/i386/acpi-build.c                       |  85 ++++++---------------=
--
>  hw/i386/intel_iommu.c                      |  34 ++++++---
>  hw/net/ne2000.c                            |   4 +-
>  hw/net/pcnet.c                             |   4 +-
>  hw/net/rtl8139.c                           |   8 +--
>  hw/pci/pcie.c                              |  12 ++++
>  hw/ppc/spapr_cpu_core.c                    |  62 +++++++++--------
>  hw/rdma/rdma_rm_defs.h                     |   4 +-
>  hw/scsi/vhost-scsi.c                       |   2 +-
>  hw/tpm/tpm_emulator.c                      |   1 +
>  hw/tpm/tpm_tis.c                           |  10 ++-
>  hw/usb/dev-mtp.c                           |  19 ++++--
>  hw/virtio/vhost.c                          |   4 +-
>  hw/virtio/virtio.c                         |  17 ++++-
>  include/block/nbd.h                        |   4 +-
>  include/hw/i2c/i2c.h                       |   2 +
>  include/hw/i2c/ppc4xx_i2c.h                |   3 -
>  include/hw/s390x/tod.h                     |   2 +-
>  include/net/net.h                          |   6 --
>  job.c                                      |  20 ++----
>  linux-user/syscall.c                       |  44 +++++++++---
>  migration/postcopy-ram.c                   |  11 +--
>  monitor.c                                  |   2 +
>  nbd/server.c                               |   9 ++-
>  net/net.c                                  |  23 +++++--
>  net/slirp.c                                |   9 +++
>  qemu-deprecated.texi                       |  15 ++++
>  qemu-img.c                                 |  35 +++++-----
>  qga/qapi-schema.json                       |  25 ++++---
>  scripts/make-release                       |   1 +
>  slirp/bootp.c                              |  32 ++++++---
>  slirp/tcp_subr.c                           |  10 +--
>  target/arm/cpu.c                           |   6 +-
>  target/arm/cpu.h                           |   5 +-
>  target/arm/cpu64.c                         |  29 ++++++++
>  target/arm/helper.c                        |  55 +++++++++------
>  target/arm/sve_helper.c                    |  23 +++----
>  target/arm/translate-a64.c                 | 106 +++++++++++++++++++++=
+++-----
>  target/arm/translate-sve.c                 |  81 +++++++++++++--------=
-
>  target/i386/cpu.c                          |   6 ++
>  target/ppc/translate/vmx-ops.inc.c         |   2 +-
>  target/s390x/diag.c                        |   2 +-
>  target/xtensa/core-dc232b.c                |   2 -
>  target/xtensa/core-dc232b/gdb-config.inc.c |   1 +
>  target/xtensa/core-dc233c.c                |   2 -
>  target/xtensa/core-dc233c/gdb-config.inc.c |   1 +
>  target/xtensa/translate.c                  |   8 +--
>  tests/Makefile.include                     |   2 +-
>  tests/acpi-test-data/pc/DSDT               | Bin 5144 -> 5131 bytes
>  tests/acpi-test-data/pc/DSDT.bridge        | Bin 7003 -> 6990 bytes
>  tests/acpi-test-data/pc/DSDT.cphp          | Bin 5607 -> 5594 bytes
>  tests/acpi-test-data/pc/DSDT.dimmpxm       | Bin 6803 -> 6790 bytes
>  tests/acpi-test-data/pc/DSDT.ipmikcs       | Bin 5216 -> 5203 bytes
>  tests/acpi-test-data/pc/DSDT.memhp         | Bin 6509 -> 6496 bytes
>  tests/acpi-test-data/pc/DSDT.numamem       | Bin 5150 -> 5137 bytes
>  tests/acpi-test-data/pc/SRAT.dimmpxm       | Bin 472 -> 392 bytes
>  tests/acpi-test-data/pc/SRAT.memhp         | Bin 264 -> 264 bytes
>  tests/acpi-test-data/q35/DSDT              | Bin 7828 -> 7815 bytes
>  tests/acpi-test-data/q35/DSDT.bridge       | Bin 7845 -> 7832 bytes
>  tests/acpi-test-data/q35/DSDT.cphp         | Bin 8291 -> 8278 bytes
>  tests/acpi-test-data/q35/DSDT.dimmpxm      | Bin 9487 -> 9474 bytes
>  tests/acpi-test-data/q35/DSDT.ipmibt       | Bin 7903 -> 7890 bytes
>  tests/acpi-test-data/q35/DSDT.memhp        | Bin 9193 -> 9180 bytes
>  tests/acpi-test-data/q35/DSDT.numamem      | Bin 7834 -> 7821 bytes
>  tests/acpi-test-data/q35/SRAT.dimmpxm      | Bin 472 -> 392 bytes
>  tests/acpi-test-data/q35/SRAT.memhp        | Bin 264 -> 264 bytes
>  tests/nvme-test.c                          |  68 +++++++++++++++---
>  tests/qemu-iotests/041                     |   6 ++
>  tests/qemu-iotests/041.out                 |   4 +-
>  tests/qemu-iotests/067.out                 |   1 +
>  tests/qemu-iotests/229                     |  95 +++++++++++++++++++++=
+++++
>  tests/qemu-iotests/229.out                 |  23 +++++++
>  tests/qemu-iotests/231                     |  62 +++++++++++++++++
>  tests/qemu-iotests/231.out                 |   9 +++
>  tests/qemu-iotests/235                     |  78 +++++++++++++++++++++=

>  tests/qemu-iotests/235.out                 |   3 +
>  tests/qemu-iotests/group                   |   3 +
>  ui/vnc-jobs.c                              |   3 +-
>  util/aio-posix.c                           |   7 +-
>  util/aio-win32.c                           |   3 +-
>  util/hbitmap.c                             |   3 +
>  util/vfio-helpers.c                        |   2 +-
>  vl.c                                       |   1 +
>  100 files changed, 1033 insertions(+), 401 deletions(-)
>  create mode 100755 tests/qemu-iotests/229
>  create mode 100644 tests/qemu-iotests/229.out
>  create mode 100755 tests/qemu-iotests/231
>  create mode 100644 tests/qemu-iotests/231.out
>  create mode 100755 tests/qemu-iotests/235
>  create mode 100644 tests/qemu-iotests/235.out

I'm not sure about 4c257911dcc7c4189768e9651755c849ce9db4e8
"i386: remove the 'INTEL_PT' CPUID bit from named CPU models"

What about 334c43e2c342e878311c66b4e62343f0a7c2c6be?
"qemu-img: fix error reporting for -object"

Also ade0075523478fa015afd5c6f6cc70681687818d:
"contrib/rdmacm-mux: Fix out-of-bounds risk"

And 3fd2092fd11b9e4220a08eca0663cc59178a6c3f:
"hw/usb: fix mistaken de-initialization of CCID state"

Eventually:
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg00843.html
"megasas: fix mapped frame size"

Regards,

Phil.


--CjEPqEUjcmo2Hzyw6Kjd9tIsJ89AS04dE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlymhcQACgkQoqP9bt6t
wN50IRAAsUkkS6kUjjBUuKCFaLpI6RVq5fRvBpb/2aqq/laWRiG2COIcUcUKhrZa
3TLwk3UjqeQqauX9TGtIYbdS0udbdkGAXtOTwT7pW7oB+R1N0aQ7Qmujoxlt6cRK
JjHTmfFo51T4i4rEBpj0a9ogeQ7DFtyrWyYQKXwl1c94f/Txoer70x4ybKlo067/
O6PLcnfIuc64Ya+QXiTcxiv/e7xC1MSENGxO008XoqYl569/ernXR3ntagbRbqHX
K5GGFzVQO1F3cTBGxNBjtOilvgdNZ6oFtBbRLXQhMxXwzWOgWDATB/Zy1vAr/cXU
TS8d21e2c2yH7MyNH0o7diM+O0Smeh5yXeiAjiDlRPi8ci6QO/ofanvXVqYOKphf
T8mxMUVK0qNrWg+Tqr9mQ0fSZEO4fRw7c0uxhXgGkyV+FwqpIPkou9We46vREwvG
zBx+WWvanATJLS4LTrY8EC4HfKcP+0GXWBP9jRnUON2jwlDtc5fB8xKgO56XAQHb
TOHxzVRz/kJNjGV3GwDOSZMob/WD/7w68Yj/WMAFrMqScYjzXZDm1jsKyGpysPRq
vFFMPhBASU3H7oG2rd/gjKjowjHXm0KHx9+bAdaEqv3l981s9eaVbSdD+Sf69fPt
aRTpcL1k6VQwE+1woBBNlHSywcRaK9DeAn2jeJvtF8W/4gjRHDw=
=ffno
-----END PGP SIGNATURE-----

--CjEPqEUjcmo2Hzyw6Kjd9tIsJ89AS04dE--


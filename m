Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F83CC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 20:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6FDC205F4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 20:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8PfH2LR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FDC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hte1B-0001Tr-4I
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 16:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58970)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <flukshun@gmail.com>) id 1hte0H-0000nI-TL
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 16:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1hte0B-0004fz-CU
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 16:18:14 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:41546)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>)
 id 1hte0B-0004e1-7N; Fri, 02 Aug 2019 16:18:11 -0400
Received: by mail-oi1-x233.google.com with SMTP id g7so57728212oia.8;
 Fri, 02 Aug 2019 13:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=0hGJjYqri99ERbAUweb/Km/0TP040pXwgA/VmqAH6J0=;
 b=e8PfH2LRjcK2lYf2V4/LI3SMWT0ZTO+4H9hFRVetil6kWk67cCjjihg1VfeToYWJfR
 cHmfxVdopZeK17U7vNiSV3AAoNyOL1Gr7hmCQ6j9yOlHmc0933d1c4qr2M9bAw8PbAHa
 QWuAhwY/GrLQNubyNSWzYawtFkmsq6EiLFmQobuBj64xnp/XrjYmbPepVEZFJY+kmOH/
 f56unLzdsE+wYIJJ6YDV+h5WKr4eP5VyeEba6ZNcYC4amxayXtqYNhYk+f3oZntd56ei
 rT7U4MxN52mGKg6+yuc9UVFiY7eAXJXTQMOq0TapOehaXfTaKQByWm+/h6xvCiGNH+LE
 G3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=0hGJjYqri99ERbAUweb/Km/0TP040pXwgA/VmqAH6J0=;
 b=F/ivsS369//+UTA7emXvgAK+hWynVS74iGGLQZWm7O+wUJMNgw9wrvSiOjTD2ldOJT
 74PlJyVucX9sibC8Y7XAxdNOCAPq4jDyjxT90BBdzgkvSSNMonYO6kQmY3benFbNeLeq
 fnptSp2Vl52LDPYujoKNKbgRpCf8hxS3g3S1nr0nqlV73C/LyRekrHMSH23BafiCh/tJ
 mJyecKjHbu5cTbSNRSMYygTdCPFNvm8NZUTY8Mxj57ZfQAhg/6UcSCiIXrt94Sy0CTSp
 l0S1UwVv5OpuKONG5ooHomyXXwmktg7FUSF7NQY6j7T07gIWFd/etL7tVhreea7gA3rn
 UMhQ==
X-Gm-Message-State: APjAAAXae5HuEVS3NR6C+W/z0ryYtdC4vl+eYux/spl/nc+mpK2TGOef
 tDRflB3L04Gvq2+geQ1E7dI=
X-Google-Smtp-Source: APXvYqy1ct5ChI/sk9rltW5Or3EcAvHUK9wLG3qFAf/PlMD3oD/gCPKQMsVnWUl7iaDBMhAmiLXTVQ==
X-Received: by 2002:aca:75c2:: with SMTP id q185mr4200340oic.103.1564777089723; 
 Fri, 02 Aug 2019 13:18:09 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id b188sm26050389oia.57.2019.08.02.13.18.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 02 Aug 2019 13:18:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <011320cc-6555-3195-7af8-d94de45f85dc@redhat.com>
References: <156476820179.5178.16916748630705802997@sif>
 <011320cc-6555-3195-7af8-d94de45f85dc@redhat.com>
Message-ID: <156477707814.16169.16002487239961621525@sif>
User-Agent: alot/0.7
Date: Fri, 02 Aug 2019 15:17:58 -0500
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 3.1.1 Stable released
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Philippe Mathieu-Daud=C3=A9 (2019-08-02 12:59:08)
> On 8/2/19 7:50 PM, Michael Roth wrote:
> > Hi everyone,
> > =

> > I am pleased to announce that the QEMU v3.1.1 stable release is now
> > available:
> > =

> > You can grab the tarball from our download page here:
> > =

> >   https://www.qemu.org/download/#source
> > =

> > v3.1.1 is now tagged in the official qemu.git repository,
> > and the stable-3.1 branch has been updated accordingly:
> > =

> >   https://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Drefs/heads/stable=
-3.1
> > =

> > This update contains a fix for CVE-2018-16872 (usb-mtp) and bug/security
> > fixes for a number of areas.
> > =

> > Please see the changelog for additional details and update accordingly.
> > =

> > Thank you to everyone involved!
> > =

> > CHANGELOG:
> > =

> > 71049d2a74: Update version for 3.1.1 release (Michael Roth)
> > 03d7712b4b: qemu-bridge-helper: restrict interface name to IFNAMSIZ (Pr=
asad J Pandit)
> > 4482258130: block: Fix hangs in synchronous APIs with iothreads (Kevin =
Wolf)
> > 41dd30ff63: pvrdma: release ring object in case of an error (Prasad J P=
andit)
> > a1001760ab: pvrdma: check return value from pvrdma_idx_ring_has_ routin=
es (Prasad J Pandit)
> > 2a0e6f1369: pvrdma: check number of pages when creating rings (Prasad J=
 Pandit)
> > 017f271f7a: device_tree: Fix integer overflowing in load_device_tree() =
(Markus Armbruster)
> > 5149630fed: device_tree.c: Don't use load_image() (Peter Maydell)
> > 59a823017a: sun4u: add power_mem_read routine (Prasad J Pandit)
> > 3be7eb2f47: qxl: check release info object (Prasad J Pandit)
> > 576964bf2a: seccomp: don't kill process for resource control syscalls (=
Daniel P. Berrang=C3=A9)
> > 4c7f4c4bbb: i2c-ddc: fix oob read (Gerd Hoffmann)
> > 4e74e7a867: slirp: check data length while emulating ident function (Pr=
asad J Pandit)
> > 375667af78: scsi-generic: avoid possible out-of-bounds access to r->buf=
 (Paolo Bonzini)
> > bceff528ba: pvrdma: add uar_read routine (Prasad J Pandit)
> > 1549e3a54a: pvrdma: release device resources in case of an error (Prasa=
d J Pandit)
> > 86d4f40141: gluster: the glfs_io_cbk callback function pointer adds pre=
/post stat args (Niels de Vos)
> > 37867211d9: gluster: Handle changed glfs_ftruncate signature (Prasanna =
Kumar Kalever)
> > 43a3a1b694: hw/block/pflash_cfi01: Add missing DeviceReset() handler (P=
hilippe Mathieu-Daud=C3=A9)
> > ddacb784b3: hw: Use PFLASH_CFI0{1,2} and TYPE_PFLASH_CFI0{1,2} (Markus =
Armbruster)
> > 03f130c682: pflash: Rename *CFI_PFLASH* to *PFLASH_CFI* (Markus Armbrus=
ter)
> > 10b1d6070a: pflash_cfi01: Log use of flawed "write to buffer" (Markus A=
rmbruster)
> > e634054c9d: pflash_cfi01: Do not exit() on guest aborting "write to buf=
fer" (Markus Armbruster)
> > 13cb31ce08: pflash: Rename pflash_t to PFlashCFI01, PFlashCFI02 (Markus=
 Armbruster)
> > d0cb440280: block/pflash_cfi02: Fix memory leak and potential use-after=
-free (Stephen Checkoway)
> > 21e5c69b85: hw/display/xlnx_dp: Avoid crash when reading empty RX FIFO =
(Philippe Mathieu-Daud=C3=A9)
> > e2ec206ea9: hw/ssi/mss-spi: Avoid crash when reading empty RX FIFO (Phi=
lippe Mathieu-Daud=C3=A9)
> > 1f30e35861: hw/ssi/xilinx_spips: Avoid out-of-bound access to lqspi_buf=
[] (Philippe Mathieu-Daud=C3=A9)
> > 19f55e7ab5: target/m68k: Fix a tcg_temp leak (Philippe Mathieu-Daud=C3=
=A9)
> > c6b77a64b4: virtio-balloon: free pbp more aggressively (Michael S. Tsir=
kin)
> > 0965d5583e: virtio-balloon: don't track subpages for the PBP (David Hil=
denbrand)
> > 14d9028a7d: virtio-balloon: Use temporary PBP only (David Hildenbrand)
> > 2aa5009412: virtio-balloon: Rework pbp tracking data (David Hildenbrand)
> > 46275f9091: virtio-balloon: Better names for offset variables in inflat=
e/deflate code (David Hildenbrand)
> > b0d6feca99: virtio-balloon: Simplify deflate with pbp (David Hildenbran=
d)
> > 07026c30c3: virtio-balloon: Fix QEMU crashes on pagesize > BALLOON_PAGE=
_SIZE (David Hildenbrand)
> > 11dd808dc0: virtio-balloon: Fix wrong sign extension of PFNs (David Hil=
denbrand)
> > f8364784f0: virtio-balloon: Restore MADV_WILLNEED hint on balloon defla=
te (David Gibson)
> > 38e8e9007d: virtio-balloon: Fix possible guest memory corruption with i=
nflates & deflates (David Gibson)
> > 80c96a7b60: virtio-balloon: Don't mismatch g_malloc()/free (CID 1399146=
) (David Gibson)
> > 118112024d: virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host page=
 size (David Gibson)
> > 83cddbaadf: virtio-balloon: Use ram_block_discard_range() instead of ra=
w madvise() (David Gibson)
> > 89b0e359bc: virtio-balloon: Rework ballon_page() interface (David Gibso=
n)
> > b260cdec21: virtio-balloon: Corrections to address verification (David =
Gibson)
> > 7a31a0af31: virtio-balloon: Remove unnecessary MADV_WILLNEED on deflate=
 (David Gibson)
> > f0a334345b: hw/virtio/virtio-balloon: zero-initialize the virtio_balloo=
n_config struct (Peter Maydell)
> > fc6c2bce38: i386/acpi: show PCI Express bus on pxb-pcie expanders (Evge=
ny Yakovlev)
> > 11665ca918: i386/acpi: fix gint overflow in crs_range_compare (Evgeny Y=
akovlev)
> > df42bc4897: ioapic: kvm: Skip route updates for masked pins (Jan Kiszka)
> > c00635946f: tpm_emulator: Translate TPM error codes to strings (Stefan =
Berger)
> > 51ce84e119: tpm: Exit in reset when backend indicates failure (Stefan B=
erger)
> > 0318166a9f: vhost: fix vhost_log size overflow during migration (Li Han=
gjing)
> > 261d7f653a: iotests: Test unaligned raw images with O_DIRECT (Max Reitz)
> > 044b0bcedf: block/file-posix: Unaligned O_DIRECT block-status (Max Reit=
z)
> > 1742e3c74e: iotests: Filter second BLOCK_JOB_ERROR from 229 (Max Reitz)
> > f173a43a6d: megasas: fix mapped frame size (Peter Lieven)
> > 2157938f7b: s390x/cpumodel: ignore csske for expansion (Christian Bornt=
raeger)
> > f56e70ee4f: do not call vhost_net_cleanup() on running net from char us=
er event (Dan Streetman)
> > 8a5aaad6c2: block: Fix AioContext switch for bs->drv =3D=3D NULL (Kevin=
 Wolf)
> > 3c9e488dbe: cutils: Fix size_to_str() on 32-bit platforms (Eric Blake)
> > c627cc38be: qcow2: Avoid COW during metadata preallocation (Kevin Wolf)
> > b443db97c1: qemu-img: fix error reporting for -object (Daniel P. Berran=
g=C3=A9)
> > 6b29db871d: usb-mtp: use O_NOFOLLOW and O_CLOEXEC. (Gerd Hoffmann)
> > 6c77b5ab35: qga: update docs with systemd suspend support info (Daniel =
Henrique Barboza)
> > 11cd30e71a: mac_newworld: use node name instead of alias name for hd de=
vice in FWPathProvider (Mark Cave-Ayland)
> > 4a25ba2e2b: mac_oldworld: use node name instead of alias name for hd de=
vice in FWPathProvider (Mark Cave-Ayland)
> > 847fe10828: configure: improve usbfs check (Thomas Petazzoni)
> > f3a70a4ae1: qga-win: include glib when building VSS DLL (Michael Roth)
> > d7cae05bf5: json: Fix % handling when not interpolating (Christophe Fer=
geau)
> > d03c389511: i386: remove the 'INTEL_PT' CPUID bit from named CPU models=
 (Paolo Bonzini)
> > 02d735c274: i386: remove the new CPUID 'PCONFIG' from Icelake-Server CP=
U model (Robert Hoo)
> > 821314aec3: vfio-ap: flag as compatible with balloon (Cornelia Huck)
> > 7c693f0c3f: tpm_tis: fix loop that cancels any seizure by a lower local=
ity (Liam Merwick)
> > 83cd9ed3d7: slirp: check sscanf result when emulating ident (William Bo=
wling)
> > c6f25642e0: hw/rdma: another clang compilation fix (Marcel Apfelbaum)
> > 27df37c1ea: block: Fix invalidate_cache error path for parent activatio=
n (Kevin Wolf)
> > fe87edd5ed: tpm: Make sure the locality received from backend is valid =
(Stefan Berger)
> > 27b0c099fd: tpm: Make sure new locality passed to tpm_tis_prep_abort() =
is valid (Stefan Berger)
> > 00d0932e0b: exec.c: Don't reallocate IOMMUNotifiers that are in use (Pe=
ter Maydell)
> > 2e5502300e: s390x: Return specification exception for unimplemented dia=
g 308 subcodes (Janosch Frank)
> > 8ec7368c8f: linux-user: make pwrite64/pread64(fd, NULL, 0, offset) retu=
rn 0 (Peter Maydell)
> > 85bfce130a: hw/s390x: Fix bad mask in time2tod() (Thomas Huth)
> > 98cf1bb872: pc:piix4: Update smbus I/O space after a migration (Corey M=
inyard)
> > 5363028d1f: pcie: set link state inactive/active after hot unplug/plug =
(Zheng Xiang)
> > 0d6b9ce17c: Changes requirement for "vsubsbs" instruction (Paul A. Clar=
ke)
> > def04278d1: iotests: make 235 work on s390 (and others) (Christian Born=
traeger)
> > 08c410e390: i2c: Move typedef of bitbang_i2c_interface to i2c.h (BALATO=
N Zoltan)
> =

> I was testing the CVE-2019-14378 fix, 7min too late :(

We could possibly do a 3.1.1.1 CVE release if it's serious.


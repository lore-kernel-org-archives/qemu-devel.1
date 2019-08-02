Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182F6C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 18:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A4220665
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 18:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A4220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htbv1-0006Ds-1R
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 14:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57156)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1htbq1-0004YS-9M
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 13:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1htbpx-0002fy-9Y
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 13:59:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1htbpq-0002RE-AM
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 13:59:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id d4so73245365edr.13
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 10:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mCodFAXbNCkOP5rtlOahiE4VocdNLxL00Ztn3+H9WBo=;
 b=dvgRbraKJzk2EJENmMd0et5sbSsXAFmbCv3ZD5CgoCbkAbS7/0WUdaJmFRCd8v9hYz
 MgIug5b8mcAv2F3ph5BnXy9dFy06QR+WewBgMc8OR2+ksIISofC5nAD7axXS9U9BllEZ
 wxwcXSEObhQJipj68Lv12hRzr+dFr9IfTpr/0YFHCh7UZdJrnta38n1ZZpPQqMEGKuVO
 Mqrl3/TLDsifnvja9eYPQjfFKj8EnMxqvSpmyzZpj6YRfuQIdTKv80LS63BcZNXv9Yvq
 lZ4E5M80HeX43No/0NhqdO0WIzVLt9mf7+3xhDZ4EDZE66nr6WpFQVcZI5T0RGvtVPIL
 tYNA==
X-Gm-Message-State: APjAAAXgpqQc4o/9WIOlA9CfTduNDWvbpr0o5iurXY9EdLMV7XDPmHck
 NOcw+RSpBFqmDDFuRB4wFYKIxw==
X-Google-Smtp-Source: APXvYqwTBs+S37zKDilhBqtLF15Ze1KINv8NSQiWWwEVcUZaJSuHPWVjjY+qsTW/V7PV7tojOXWPbQ==
X-Received: by 2002:aa7:d918:: with SMTP id a24mr7062448edr.235.1564768751419; 
 Fri, 02 Aug 2019 10:59:11 -0700 (PDT)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id oa21sm11915969ejb.60.2019.08.02.10.59.10
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 10:59:10 -0700 (PDT)
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <156476820179.5178.16916748630705802997@sif>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <011320cc-6555-3195-7af8-d94de45f85dc@redhat.com>
Date: Fri, 2 Aug 2019 19:59:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156476820179.5178.16916748630705802997@sif>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.66
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

On 8/2/19 7:50 PM, Michael Roth wrote:
> Hi everyone,
> 
> I am pleased to announce that the QEMU v3.1.1 stable release is now
> available:
> 
> You can grab the tarball from our download page here:
> 
>   https://www.qemu.org/download/#source
> 
> v3.1.1 is now tagged in the official qemu.git repository,
> and the stable-3.1 branch has been updated accordingly:
> 
>   https://git.qemu.org/?p=qemu.git;a=shortlog;h=refs/heads/stable-3.1
> 
> This update contains a fix for CVE-2018-16872 (usb-mtp) and bug/security
> fixes for a number of areas.
> 
> Please see the changelog for additional details and update accordingly.
> 
> Thank you to everyone involved!
> 
> CHANGELOG:
> 
> 71049d2a74: Update version for 3.1.1 release (Michael Roth)
> 03d7712b4b: qemu-bridge-helper: restrict interface name to IFNAMSIZ (Prasad J Pandit)
> 4482258130: block: Fix hangs in synchronous APIs with iothreads (Kevin Wolf)
> 41dd30ff63: pvrdma: release ring object in case of an error (Prasad J Pandit)
> a1001760ab: pvrdma: check return value from pvrdma_idx_ring_has_ routines (Prasad J Pandit)
> 2a0e6f1369: pvrdma: check number of pages when creating rings (Prasad J Pandit)
> 017f271f7a: device_tree: Fix integer overflowing in load_device_tree() (Markus Armbruster)
> 5149630fed: device_tree.c: Don't use load_image() (Peter Maydell)
> 59a823017a: sun4u: add power_mem_read routine (Prasad J Pandit)
> 3be7eb2f47: qxl: check release info object (Prasad J Pandit)
> 576964bf2a: seccomp: don't kill process for resource control syscalls (Daniel P. Berrangé)
> 4c7f4c4bbb: i2c-ddc: fix oob read (Gerd Hoffmann)
> 4e74e7a867: slirp: check data length while emulating ident function (Prasad J Pandit)
> 375667af78: scsi-generic: avoid possible out-of-bounds access to r->buf (Paolo Bonzini)
> bceff528ba: pvrdma: add uar_read routine (Prasad J Pandit)
> 1549e3a54a: pvrdma: release device resources in case of an error (Prasad J Pandit)
> 86d4f40141: gluster: the glfs_io_cbk callback function pointer adds pre/post stat args (Niels de Vos)
> 37867211d9: gluster: Handle changed glfs_ftruncate signature (Prasanna Kumar Kalever)
> 43a3a1b694: hw/block/pflash_cfi01: Add missing DeviceReset() handler (Philippe Mathieu-Daudé)
> ddacb784b3: hw: Use PFLASH_CFI0{1,2} and TYPE_PFLASH_CFI0{1,2} (Markus Armbruster)
> 03f130c682: pflash: Rename *CFI_PFLASH* to *PFLASH_CFI* (Markus Armbruster)
> 10b1d6070a: pflash_cfi01: Log use of flawed "write to buffer" (Markus Armbruster)
> e634054c9d: pflash_cfi01: Do not exit() on guest aborting "write to buffer" (Markus Armbruster)
> 13cb31ce08: pflash: Rename pflash_t to PFlashCFI01, PFlashCFI02 (Markus Armbruster)
> d0cb440280: block/pflash_cfi02: Fix memory leak and potential use-after-free (Stephen Checkoway)
> 21e5c69b85: hw/display/xlnx_dp: Avoid crash when reading empty RX FIFO (Philippe Mathieu-Daudé)
> e2ec206ea9: hw/ssi/mss-spi: Avoid crash when reading empty RX FIFO (Philippe Mathieu-Daudé)
> 1f30e35861: hw/ssi/xilinx_spips: Avoid out-of-bound access to lqspi_buf[] (Philippe Mathieu-Daudé)
> 19f55e7ab5: target/m68k: Fix a tcg_temp leak (Philippe Mathieu-Daudé)
> c6b77a64b4: virtio-balloon: free pbp more aggressively (Michael S. Tsirkin)
> 0965d5583e: virtio-balloon: don't track subpages for the PBP (David Hildenbrand)
> 14d9028a7d: virtio-balloon: Use temporary PBP only (David Hildenbrand)
> 2aa5009412: virtio-balloon: Rework pbp tracking data (David Hildenbrand)
> 46275f9091: virtio-balloon: Better names for offset variables in inflate/deflate code (David Hildenbrand)
> b0d6feca99: virtio-balloon: Simplify deflate with pbp (David Hildenbrand)
> 07026c30c3: virtio-balloon: Fix QEMU crashes on pagesize > BALLOON_PAGE_SIZE (David Hildenbrand)
> 11dd808dc0: virtio-balloon: Fix wrong sign extension of PFNs (David Hildenbrand)
> f8364784f0: virtio-balloon: Restore MADV_WILLNEED hint on balloon deflate (David Gibson)
> 38e8e9007d: virtio-balloon: Fix possible guest memory corruption with inflates & deflates (David Gibson)
> 80c96a7b60: virtio-balloon: Don't mismatch g_malloc()/free (CID 1399146) (David Gibson)
> 118112024d: virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host page size (David Gibson)
> 83cddbaadf: virtio-balloon: Use ram_block_discard_range() instead of raw madvise() (David Gibson)
> 89b0e359bc: virtio-balloon: Rework ballon_page() interface (David Gibson)
> b260cdec21: virtio-balloon: Corrections to address verification (David Gibson)
> 7a31a0af31: virtio-balloon: Remove unnecessary MADV_WILLNEED on deflate (David Gibson)
> f0a334345b: hw/virtio/virtio-balloon: zero-initialize the virtio_balloon_config struct (Peter Maydell)
> fc6c2bce38: i386/acpi: show PCI Express bus on pxb-pcie expanders (Evgeny Yakovlev)
> 11665ca918: i386/acpi: fix gint overflow in crs_range_compare (Evgeny Yakovlev)
> df42bc4897: ioapic: kvm: Skip route updates for masked pins (Jan Kiszka)
> c00635946f: tpm_emulator: Translate TPM error codes to strings (Stefan Berger)
> 51ce84e119: tpm: Exit in reset when backend indicates failure (Stefan Berger)
> 0318166a9f: vhost: fix vhost_log size overflow during migration (Li Hangjing)
> 261d7f653a: iotests: Test unaligned raw images with O_DIRECT (Max Reitz)
> 044b0bcedf: block/file-posix: Unaligned O_DIRECT block-status (Max Reitz)
> 1742e3c74e: iotests: Filter second BLOCK_JOB_ERROR from 229 (Max Reitz)
> f173a43a6d: megasas: fix mapped frame size (Peter Lieven)
> 2157938f7b: s390x/cpumodel: ignore csske for expansion (Christian Borntraeger)
> f56e70ee4f: do not call vhost_net_cleanup() on running net from char user event (Dan Streetman)
> 8a5aaad6c2: block: Fix AioContext switch for bs->drv == NULL (Kevin Wolf)
> 3c9e488dbe: cutils: Fix size_to_str() on 32-bit platforms (Eric Blake)
> c627cc38be: qcow2: Avoid COW during metadata preallocation (Kevin Wolf)
> b443db97c1: qemu-img: fix error reporting for -object (Daniel P. Berrangé)
> 6b29db871d: usb-mtp: use O_NOFOLLOW and O_CLOEXEC. (Gerd Hoffmann)
> 6c77b5ab35: qga: update docs with systemd suspend support info (Daniel Henrique Barboza)
> 11cd30e71a: mac_newworld: use node name instead of alias name for hd device in FWPathProvider (Mark Cave-Ayland)
> 4a25ba2e2b: mac_oldworld: use node name instead of alias name for hd device in FWPathProvider (Mark Cave-Ayland)
> 847fe10828: configure: improve usbfs check (Thomas Petazzoni)
> f3a70a4ae1: qga-win: include glib when building VSS DLL (Michael Roth)
> d7cae05bf5: json: Fix % handling when not interpolating (Christophe Fergeau)
> d03c389511: i386: remove the 'INTEL_PT' CPUID bit from named CPU models (Paolo Bonzini)
> 02d735c274: i386: remove the new CPUID 'PCONFIG' from Icelake-Server CPU model (Robert Hoo)
> 821314aec3: vfio-ap: flag as compatible with balloon (Cornelia Huck)
> 7c693f0c3f: tpm_tis: fix loop that cancels any seizure by a lower locality (Liam Merwick)
> 83cd9ed3d7: slirp: check sscanf result when emulating ident (William Bowling)
> c6f25642e0: hw/rdma: another clang compilation fix (Marcel Apfelbaum)
> 27df37c1ea: block: Fix invalidate_cache error path for parent activation (Kevin Wolf)
> fe87edd5ed: tpm: Make sure the locality received from backend is valid (Stefan Berger)
> 27b0c099fd: tpm: Make sure new locality passed to tpm_tis_prep_abort() is valid (Stefan Berger)
> 00d0932e0b: exec.c: Don't reallocate IOMMUNotifiers that are in use (Peter Maydell)
> 2e5502300e: s390x: Return specification exception for unimplemented diag 308 subcodes (Janosch Frank)
> 8ec7368c8f: linux-user: make pwrite64/pread64(fd, NULL, 0, offset) return 0 (Peter Maydell)
> 85bfce130a: hw/s390x: Fix bad mask in time2tod() (Thomas Huth)
> 98cf1bb872: pc:piix4: Update smbus I/O space after a migration (Corey Minyard)
> 5363028d1f: pcie: set link state inactive/active after hot unplug/plug (Zheng Xiang)
> 0d6b9ce17c: Changes requirement for "vsubsbs" instruction (Paul A. Clarke)
> def04278d1: iotests: make 235 work on s390 (and others) (Christian Borntraeger)
> 08c410e390: i2c: Move typedef of bitbang_i2c_interface to i2c.h (BALATON Zoltan)

I was testing the CVE-2019-14378 fix, 7min too late :(


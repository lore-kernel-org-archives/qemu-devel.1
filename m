Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DC2C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BDE2072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knWRkm3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BDE2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioYTa-0002QF-MC
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1ioYSt-0001yE-1Q
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1ioYSr-0003j9-98
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:55:02 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:32910)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>)
 id 1ioYSr-0003iP-2X; Mon, 06 Jan 2020 14:55:01 -0500
Received: by mail-oi1-x243.google.com with SMTP id v140so16765972oie.0;
 Mon, 06 Jan 2020 11:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=l2b+kv/gZMocs+0ayg7lmK/Rp83ff0VM1eGdR/Hw4VE=;
 b=knWRkm3D8TJA/7jNP2Ri1/Avxd4Z/WpMmQFNCYOnYnXYzR788ksPJ4COEjd32sLL0J
 cXa/MXBMCRLMvTBAFoYdifNVMlfsxiMHmeDRDRQ88J1XkRxbf+KnL/hq8dlMxSu74G2A
 8xmAjx/TG4w+qjmglH/N+1AtEe/mEubVl1M2TxnFLDlii2rzbF4fJmOW1ux45jGcWb6N
 XCx7sv9U02zVZxAl8l0dEa/dTkrFOHsYcCadVn6mjoVZWtgBRu//VK316IErYdmX9UUt
 74zqZOji2xHgOEqahBZ2edWby9U602wzn1wlDGZhtjwElWfA3xBBMgBhzguzRH1XG+tc
 cmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition:in-reply-to
 :user-agent;
 bh=l2b+kv/gZMocs+0ayg7lmK/Rp83ff0VM1eGdR/Hw4VE=;
 b=IEjYOmy1sfWmREpxo00dwxzTNvJ+B6bo7tFBpjkNdZcycdVsQhDLv+32pwLWNiIx+k
 pXj7KN0s3JQKq0AWIbHkL+PEl3eDKURV6AusjN77w2JSWNONr+gB/2Dpuqd3gVid7elr
 /xNcE2tqrKaGhoFBIt5m+Bl+4F3jeaqc8bLvEEw2JKOgHr+L4OfeARBdxN4bFJI5HDpa
 Fr+6IWRH8fBS1urJx69v0CHMVnmZUynEI5kNBJ8E0jwn/ggiq3c979cELIkl4qF6b7j1
 Q0KnY8dyWOkxVRj+6ovVFnzAHa33b1Rl3Q4U5wV5OtfLB5LeqU0yIsMJRl3s1T5ab43K
 TwmQ==
X-Gm-Message-State: APjAAAUK3xsSisGGetKpFGegtIhjeTlmVJmToMcjEfd0aKazzEpCXdq/
 2RLHEL2ve05VE1RaNXMtLQ==
X-Google-Smtp-Source: APXvYqypHD2sht7gw6aTf9I/WdjGJJGPJceay8TWxY269Hcvw4gDb11P3kCVOrzK4kcupgaX5uJcHg==
X-Received: by 2002:a05:6808:208:: with SMTP id
 l8mr5965360oie.112.1578340499979; 
 Mon, 06 Jan 2020 11:54:59 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id v25sm24260566otk.51.2020.01.06.11.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 11:54:59 -0800 (PST)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:adc3:7c20:81:d62b])
 by serve.minyard.net (Postfix) with ESMTPSA id AA851180050;
 Mon,  6 Jan 2020 19:54:58 +0000 (UTC)
Date: Mon, 6 Jan 2020 13:54:57 -0600
From: Corey Minyard <minyard@acm.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v1 00/59] trivial unneeded labels cleanup
Message-ID: <20200106195457.GE2886@minyard.net>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Reply-To: minyard@acm.org
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 06, 2020 at 03:23:26PM -0300, Daniel Henrique Barboza wrote:
> Hello,
> 
> This is the type of cleanup I've contributed to Libvirt
> during the last year. Figured QEMU also deserves the same
> care.
> 
> The idea here is remove unneeded labels. By 'unneeded' I
> mean labels that does nothing but a 'return' call. One
> common case is something like this:
> 
> if ()
>     goto cleanup;
> [...]
>  cleanup:
>     return 0;
> 
> This code can be simplified to:
> 
> if ()
>     return 0;
> 
> 
> Which is cleaner and requires less brain cycles to wonder
> whether the 'cleanup' label does anything special, such
> as a heap memory cleanup.

I would disagree with this analysis.  To me, I often wonder
when I have to add cleanup code to a routine whether there is
some hidden return in the middle of the function.  That's a lot
harder to spot than just looking for the cleanup label at the
end of the function to see what it does.  For non-trivial
functions I prefer to have one point of return at the end
(and maybe some minor checks with returns right at the beginning).
I'm not adamant about this, just my opinion.

But if we are going to fix things like this, it might be best to add
them to the coding style document and checkpatch script.  Otherwise
these sorts of things will just continue.

-corey

> 
> Another common case uses a variable to set a return value,
> generally an error, then return:
> 
> if () {
>     ret = -ENOENT;
>     goto out;
> }
> [..]
>  out:
>     return ret;
> 
> Likewise, it is clearer to just 'return -ENOENT' instead of
> jumping to a label. There are other cases being handled in
> these patches, but these are the most common.
> 
> There are still a handful of unneeded labels hanging around after
> this series. There are cases in which the label name is
> part of the code semantics and I judged not worth removing.
> search_chunk() in block/dmg.c has an example of an unneeded
> 'err' label that I decided to not remove.
> 
> No functional change was made. If any of these patches changes
> existing behavior it is unintended and an error from my
> part.
> 
> 
> 
> Daniel Henrique Barboza (59):
>   spapr.c: remove 'out' label in spapr_dt_cas_updates()
>   ppc440_bamboo.c: remove label from bamboo_load_device_tree()
>   kvm-all.c: remove unneeded labels
>   paaudio.c: remove unneeded labels
>   ram.c: remove unneeded labels
>   mips-semi.c: remove 'uhi_done' label in helper_do_semihosting()
>   unicore32/softmmu.c: remove 'do_fault' label in get_phys_addr_ucv2()
>   chardev/char-mux.c: remove 'send_char' label
>   chardev/char-pipe.c: remove 'fail' label in win_chr_pipe_init()
>   chardev/char-win.c: remove 'fail' label in win_chr_serial_init()
>   exec.c: remove 'err' label in ram_block_discard_range()
>   virtfs-proxy-helper.c: remove 'err_out' label in setugid()
>   block/vdi.c: remove 'fail' label in vdi_open()
>   block/file-posix.c: remove unneeded labels
>   block/blkreplay.c: remove unneeded 'fail' label in blkreplay_open()
>   block/gluster.c: remove unneeded 'exit' label
>   block/dmg.c: remove unneeded 'fail' label in dmg_read_mish_block()
>   qcow2-refcount.c: remove unneeded 'fail' label in
>     qcow2_refcount_init()
>   block/ssh.c: remove unneeded labels
>   block/vpc.c: remove unneeded 'fail' label in create_dynamic_disk()
>   block/backup.c remove unneeded 'out' label in backup_run()
>   block/vmdk.c: remove unneeded labels
>   block/vxhs.c: remove unneeded 'out' label in vxhs_iio_callback()
>   block/vhdx-log.c: remove unneeded labels
>   block/vhdx.c: remove unneeded 'exit' labels
>   block/replication.c: remove unneeded label in replication_co_writev
>   crypto/block-luks.c: remove unneeded label in
>     qcrypto_block_luks_find_key
>   qga/commands-win32.c: remove 'out' label in get_pci_info
>   cryptodev-vhost.c: remove unneeded 'err' label in
>     cryptodev_vhost_start
>   util/module.c: remove unneeded label in module_load_file()
>   util/aio-posix.c: remove unneeded 'out' label in aio_epoll
>   qemu-img.c: remove 'out4' label in img_compare
>   ipmi/ipmi_bmc_sim.c: remove unneeded labels
>   ipmi/ipmi_bt.c: remove unneeded label in ipmi_bt_handle_event
>   ipmi_bmc_extern.c: remove unneeded label in
>     ipmi_bmc_extern_handle_command
>   ipmi/ipmi_kcs.c: remove unneeded label in ipmi_kcs_handle_event
>   s390x/event-facility.c: remove unneeded labels
>   s390x/sclp.c: remove unneeded label in sclp_service_call()
>   usb/dev-mtp.c: remove unneeded label in write_retry()
>   hsb/hcd-ehci.c: remove unneeded labels
>   intc/s390_flic_kvm.c: remove unneeded label in kvm_flic_load()
>   i386/intel_iommu.c: remove unneeded labels
>   i386/amd_iommu.c: remove unneeded label in amdvi_int_remap_msi()
>   9p-local.c: remove unneeded label in local_unlinkat_common()
>   9pfs/9p.c: remove unneeded labels
>   alpha/typhoon.c: remove unneeded label in typhoon_translate_iommu()
>   pvrdma_main.c: remove unneeded labels
>   pvrdma_dev_ring.c: remove unneeded label in pvrdma_ring_init()
>   rdma/rdma_rm.c: remove unneeded label in rdma_rm_alloc_pd()
>   rdma/rdma_backend.c: remove unneeded label in rdma_backend_init()
>   virtio/vhost.c: remove unneeded labels
>   net/vhost_net.c: remove unneeded labels
>   net/net_tx_pkt.c: remove unneeded label in net_tx_pkt_get_gso_type()
>   ivshmem-server/main.c: remove unneeded label in main()
>   linux-user/flatload.c: remove unused 'out' label
>   linux-user/signal.c: remove unneeded label in do_sigaltstack()
>   linux-user/syscall.c: fix trailing whitespaces and style
>   linux-user/syscall.c: remove unneeded labels
>   linux-user/vm86.c: remove unneeded label in do_vm86()
> 
>  accel/kvm/kvm-all.c           | 30 +++++-------
>  audio/paaudio.c               | 10 +---
>  backends/cryptodev-vhost.c    |  4 +-
>  block/backup.c                |  6 +--
>  block/blkreplay.c             |  8 +---
>  block/dmg.c                   | 10 +---
>  block/file-posix.c            | 10 ++--
>  block/gluster.c               |  3 +-
>  block/qcow2-refcount.c        |  7 +--
>  block/replication.c           |  9 ++--
>  block/ssh.c                   | 61 ++++++++-----------------
>  block/vdi.c                   | 40 ++++++----------
>  block/vhdx-log.c              | 86 +++++++++++++----------------------
>  block/vhdx.c                  | 10 ++--
>  block/vmdk.c                  | 37 ++++++---------
>  block/vpc.c                   | 12 ++---
>  block/vxhs.c                  |  4 +-
>  chardev/char-mux.c            |  3 +-
>  chardev/char-pipe.c           | 13 ++----
>  chardev/char-win.c            | 19 ++++----
>  contrib/ivshmem-server/main.c |  9 ++--
>  crypto/block-luks.c           |  3 +-
>  exec.c                        | 13 +++---
>  fsdev/virtfs-proxy-helper.c   |  4 +-
>  hw/9pfs/9p-local.c            | 12 ++---
>  hw/9pfs/9p.c                  |  9 ++--
>  hw/alpha/typhoon.c            | 18 ++++----
>  hw/i386/amd_iommu.c           | 13 ++----
>  hw/i386/intel_iommu.c         |  8 ++--
>  hw/intc/s390_flic_kvm.c       | 10 ++--
>  hw/ipmi/ipmi_bmc_extern.c     |  5 +-
>  hw/ipmi/ipmi_bmc_sim.c        |  9 +---
>  hw/ipmi/ipmi_bt.c             |  8 ++--
>  hw/ipmi/ipmi_kcs.c            |  4 +-
>  hw/net/net_tx_pkt.c           | 11 ++---
>  hw/net/vhost_net.c            |  7 ++-
>  hw/ppc/ppc440_bamboo.c        |  8 +---
>  hw/ppc/spapr.c                |  9 ++--
>  hw/rdma/rdma_backend.c        |  4 +-
>  hw/rdma/rdma_rm.c             | 11 ++---
>  hw/rdma/vmw/pvrdma_dev_ring.c |  7 +--
>  hw/rdma/vmw/pvrdma_main.c     | 10 ++--
>  hw/s390x/event-facility.c     | 21 +++------
>  hw/s390x/sclp.c               | 16 ++-----
>  hw/usb/dev-mtp.c              | 13 ++----
>  hw/usb/hcd-ehci.c             | 32 ++++---------
>  hw/virtio/vhost.c             | 11 ++---
>  linux-user/flatload.c         |  1 -
>  linux-user/signal.c           | 20 +++-----
>  linux-user/syscall.c          | 54 ++++++++++------------
>  linux-user/vm86.c             |  7 +--
>  migration/ram.c               | 18 ++------
>  qemu-img.c                    |  7 +--
>  qga/commands-win32.c          | 17 ++++---
>  target/mips/mips-semi.c       | 15 +++---
>  target/unicore32/softmmu.c    | 23 +++-------
>  util/aio-posix.c              |  3 +-
>  util/module.c                 | 11 ++---
>  58 files changed, 293 insertions(+), 550 deletions(-)
> 
> -- 
> 2.24.1
> 
> 


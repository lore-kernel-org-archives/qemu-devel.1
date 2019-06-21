Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76349C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE5B20679
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBwj2OxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE5B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35782 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heKvw-0003Wg-SL
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 10:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46178)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <skrtbhtngr@gmail.com>) id 1heKoS-0003VW-C2
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <skrtbhtngr@gmail.com>) id 1heKoQ-0006Ky-6f
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:46:48 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:46773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <skrtbhtngr@gmail.com>)
 id 1heKoP-0006Bh-TZ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:46:46 -0400
Received: by mail-pf1-x42f.google.com with SMTP id 81so3702408pfy.13
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 07:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8kxShQMD2pLEtqA5t1fFufIc2q0rmZaSupiozOi3vec=;
 b=pBwj2OxKn27nxYH8bBh5lHrtbL0Qi9cPvukb0Je+bPIegmzx18nD353U6TLMKMLV3y
 CftawFJSl0QlcOfiIZSLOJjqzCd09RiqHcTQa243VjJIY1+zBI54DruL+FNlLV39UoBI
 PPCo2UNdkG9gq8kiSvifhStCJ2Jz0BTA1BS5AcT3P+//LHrVkDBXqQKoFcMxX2U4hJKc
 HR0cv7af7TVkWRmhqSNJuvB8YhmQnkcKX3zteME93GAtJot+nqpuXK5pfefEJX6THzfV
 jRogRtPdZ/L8PnhTUo5A7hsFO7b9jhwnxX+s2v39Wt1yR7Jjspc3RqRWr9bo/uW0/aNE
 ZpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8kxShQMD2pLEtqA5t1fFufIc2q0rmZaSupiozOi3vec=;
 b=akS5DShg3XTYfaTq61/VhcT5nMq9oWCi+/0igbcMBRNVPpufzsp7A5xcYwGfzfOFGs
 ulYWFViuuvPRpe7XYP2pQqG6PXFFAJPLSRq7MPtyDPHlxqaJ2l/FmbfYqlRcn+NRzsW5
 /MfosIcARdG4lwY/3Tubecii06QGoSSNxRNfRIMNDqz9ic+4xV4bAMycvB0Ega+zq/+x
 O1DtmEHFT+1b5lwW2RZ1DMTV0jPWjsLFHLPrsaQdtSeVnqvCRN9bIRqWjUV6X+yHhYIU
 ick3yAOLxOBjmSjFucmY266H5ByItAuu7hEDRyUKE7O1l0GmEpjfFxXWrk9TvYdZqPal
 7kmg==
X-Gm-Message-State: APjAAAX788fk+gcOHPGGvvfQKBS5oM/3WsXFqXu556IMDP0CiZM/CTPa
 qCThH9ex0/SEfz6DXgnRH0XjcJPs
X-Google-Smtp-Source: APXvYqxN4eRJ6j5nvVBllDVtTBnzMfXR9LI6FuuWMm+ael01FxLU+zM/8ZrhqXdIljiVlssw6hsRfw==
X-Received: by 2002:a17:90a:d587:: with SMTP id
 v7mr7363237pju.28.1561128393170; 
 Fri, 21 Jun 2019 07:46:33 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2081:a5f2:5e1e:1cae:baa8:1943])
 by smtp.gmail.com with ESMTPSA id v5sm3338591pgq.66.2019.06.21.07.46.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 21 Jun 2019 07:46:32 -0700 (PDT)
From: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 20:15:40 +0530
Message-Id: <20190621144541.13770-1-skrtbhtngr@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42f
Subject: [Qemu-devel] [RFC 0/1] Add live migration support to the PVRDMA
 device
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
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I am a GSoC participant, trying to implement live migration for the
pvrdma device with help from my mentors Marcel and Yuval.
My current task is to save and load the various addresses that the
device uses for DMA mapping. We will be adding the device state into
live migration, incrementally. As the first step in the implementation,
we are performing migration to the same host. This will save us from
many complexities, such as GID change, at this stage, and we will
address migration across hosts at a later point when same-host migration
works.

Currently, the save and load logic uses SaveVMHandlers, which is the
legcay way, and will be ported to VMStateDescription once the
existing issues are solved.

This RFC is meant to request suggestions on the things which are
working and for help on the things which are not.


What is working:

* pvrdma device is getting initialized in a VM, its GID entry is
  getting added to the host, and rc_pingpong is successful between
  two such VMs. This is when libvirt is used to launch the VMs.

* The dma, cmd_slot_dma and resp_slot_dma addresses are saved at the
  source and loaded properly in the destination upon migration. That is,
  the values loaded at the dest during migration are the same as the
  ones saved.

  `dma` is provided by the guest device when it writes to BAR1, stored
  in dev->dsr_info.dma. A DSR is created on mapping to this address.
  `cmd_slot_dma` and `resp_slot_dma` are the dma addresses of the command
  and response buffers, respectively, which are provided by the guest
  through the DSR.

* The DSR successfully (re)maps to the dma address loaded from
  migration at the dest.


What is not working:

* In the pvrdma_load() logic, the mapping to DSR is successful at dest.
  But the mapping for cmd and resp slots fails.
  rdma_pci_dma_map() eventually calls address_space_map(). Inside the
  latter, a global BounceBuffer bounce is checked to see if it is in use
  (the atomic_xchg() primitive).
  At the dest, it is in use and the dma remapping fails there, which
  fails the whole migration process. Essentially, I am looking for a
  way to remap guest physical address after a live migration (to the
  same host). Any tips on avoiding the BounceBuffer will also be great.

  I have also tried unmapping the cmd and resp slots at the source before
  saving the dma addresses in pvrdma_save(), but the mapping fails anyway.

* It seems that vmxnet3 migration itself is not working properly, at least
  for me. The pvrdma device depends on it, vmxnet3 is function 0 and pvrdma
  is function 1. This is happening even for a build of unmodified code from
  the master branch.
  After migration, the network connectivity is lost at destination.
  Things are fine at the source before migration.
  This is the command I am using at src:

  sudo /home/skrtbhtngr/qemu/build/x86_64-softmmu/qemu-system-x86_64 \
    -enable-kvm \
    -m 2G -smp cpus=2 \
    -hda /home/skrtbhtngr/fedora.img \
    -netdev tap,id=hostnet0 \
    -device vmxnet3,netdev=hostnet0,id=net0,mac=52:54:00:99:ff:bc \
    -monitor telnet:127.0.0.1:4444,server,nowait \
    -trace events=/home/skrtbhtngr/trace-events \
    -vnc 0.0.0.0:0

  Similar command is used for the dest. Currently, I am trying
  same-host migration for testing purpose, without the pvrdma device.
  Two tap interfaces, for src and dest were created successfully at
  the host. Kernel logs:
  ...
  br0: port 2(tap0) entered forwarding state
  ...
  br0: port 3(tap1) entered forwarding state

  tcpdump at the dest reports only outgoing ARP packets, which ask
  for gateway: "ARP, Request who-has _gateway tell guest1".

  Tried using user (slirp) as the network backend, but no luck.
  
  Also tried git bisect to find the issue using a working commit (given
  by Marcel), but it turns out that it is very old and I faced build
  errors one after another.

  Please note that e1000 live migration is working fine in the same setup.

* Since we are aiming at trying on same-host migration first, I cannot
  use libvirt as it does not allow this. Currently, I am running the
  VMs using qemu-system commands. But libvirt is needed to add the GID
  entry of the guest device in the host. I am looking for a workaround,
  if that is possible at all.
  I started a thread few days ago for the same on libvirt-users:
  https://www.redhat.com/archives/libvirt-users/2019-June/msg00011.html


Sukrit Bhatnagar (1):
  hw/pvrdma: Add live migration support

 hw/rdma/vmw/pvrdma_main.c | 56 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

-- 
2.21.0



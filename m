Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8674AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA502177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD3ekkrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA502177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIqR-0008LI-Jy
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 10:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kBIpk-0007oU-8m
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:24:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:55224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kBIpi-0003YC-9l
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:24:55 -0400
Received: by mail-wm1-x32f.google.com with SMTP id s13so5354972wmh.4
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 07:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=sk1tp0q1v5kyEcp30nm5DF5bA4VgIczZ3YYVuEzGKgY=;
 b=cD3ekkrDdK7rf1a4lEToxTZlrZe+VFzKLgmaVtcynkuvSMCQgXMq7lsvUoxI6E36Gn
 +Uhv31FWFXmHGV4OvVc4k9q/OlWgm6EqPV7rL4W2V4yjTATmbo+Q6VPobuv4sotv1khb
 uRgag3QCj73jSM1z3eYwdtld23manY1QJMLs1GC2G+vm3yBOjZmpp+pSvT1+/yogDZeR
 k4IbTKj/48gQJ59z3bPijvzy2KLloWRbbPPjfr3PUxxmRzKRKRUtxB4XdtBVlgXM0G1g
 ns+L0xSDujveu3YrmBwje1WvG07jVJkbo50IG0Q1f/teQtOuq6uv433ITns88z1PJyHF
 J0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=sk1tp0q1v5kyEcp30nm5DF5bA4VgIczZ3YYVuEzGKgY=;
 b=EeZArLqyc97zIrYxeIos7UXtaF/6NhA/LtrkaKFxznqboEenulIAm+frItQYbjHsZf
 j4g4mzI70ijqwLI1+bQVXJ2gW/0Z+FiYdZSkUMwPCe3EvJgxi6F0GhdroqW8HWm8DaQa
 Uc+14qj+gSFg48AUjtf7ZPbebvKnLhV2wENM769Q6BU64n8UOqGHSDj0Tz8gol1gF1m3
 EKrDBWP6kWWxkXnfoyinw2uZlsATCWuOYxFZQv3ib22+om6bnv36H+OL8z46JbawyP5D
 K1/oMdGswIKW9YroLz7EvN51wrDnjzC7IloF86NaX4E/D8QYT9NELhiD9bRHVliukIg3
 EXWw==
X-Gm-Message-State: AOAM532Oag53zvUbPX475BkmpdJDa+zrqLtHyycd7QtLwVop/nBEA8M/
 O0l+CXW9CBxRDO5mAxrPPdk=
X-Google-Smtp-Source: ABdhPJxNIbiPWizsQlp29gxE4MadYVGbItVM+fCpAr2KOvsL33xwj+Dq3SCH1wg5TEZFcLvKBgdG4Q==
X-Received: by 2002:a1c:f60e:: with SMTP id w14mr11726428wmc.19.1598538291904; 
 Thu, 27 Aug 2020 07:24:51 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id x2sm6993624wrg.73.2020.08.27.07.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 07:24:50 -0700 (PDT)
Date: Mon, 24 Aug 2020 14:44:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: QEMU 5.0 virtio-blk performance regression with high queue depths
Message-ID: <20200824134431.GA35623@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Denis,
A performance regression was found after the virtio-blk queue-size
property was increased from 128 to 256 in QEMU 5.0 in commit
c9b7d9ec21dfca716f0bb3b68dee75660d86629c ("virtio: increase virtqueue
size for virtio-scsi and virtio-blk"). I wanted to let you know if case
you have ideas or see something similar.

Throughput and IOPS of the following fio benchmarks dropped by 30-40%:

  # mkfs.xfs /dev/vdb
  # mount /dev/vdb /mnt
  # fio --rw=%s --bs=%s --iodepth=64 --runtime=1m --direct=1 --filename=/mnt/%s --name=job1 --ioengine=libaio --thread --group_reporting --numjobs=16 --size=512MB --time_based --output=/tmp/fio_result &> /dev/null
    - rw: read write
    - bs: 4k 64k

Note that there are 16 threads submitting 64 requests each! The guest
block device queue depth will be maxed out. The virtqueue should be full
most of the time.

Have you seen regressions after virtio-blk queue-size was increased in
QEMU 5.0?

Here are the details of the host storage:

  # mkfs.xfs /dev/sdb # 60GB SSD drive
  # mount /dev/sdb /mnt/test
  # qemu-img create -f qcow2 /mnt/test/storage2.qcow2 40G

The guest command-line is:

  # MALLOC_PERTURB_=1 numactl \
    -m 1  /usr/libexec/qemu-kvm \
    -S  \
    -name 'avocado-vt-vm1'  \
    -sandbox on  \
    -machine q35 \
    -device pcie-root-port,id=pcie-root-port-0,multifunction=on,bus=pcie.0,addr=0x1,chassis=1 \
    -device pcie-pci-bridge,id=pcie-pci-bridge-0,addr=0x0,bus=pcie-root-port-0  \
    -nodefaults \
    -device VGA,bus=pcie.0,addr=0x2 \
    -m 4096  \
    -smp 2,maxcpus=2,cores=1,threads=1,dies=1,sockets=2  \
    -cpu 'IvyBridge',+kvm_pv_unhalt \
    -chardev socket,server,id=qmp_id_qmpmonitor1,nowait,path=/var/tmp/avocado_bapfdqao/monitor-qmpmonitor1-20200721-014154-5HJGMjxW  \
    -mon chardev=qmp_id_qmpmonitor1,mode=control \
    -chardev socket,server,id=qmp_id_catch_monitor,nowait,path=/var/tmp/avocado_bapfdqao/monitor-catch_monitor-20200721-014154-5HJGMjxW  \
    -mon chardev=qmp_id_catch_monitor,mode=control \
    -device pvpanic,ioport=0x505,id=id31BN83 \
    -chardev socket,server,id=chardev_serial0,nowait,path=/var/tmp/avocado_bapfdqao/serial-serial0-20200721-014154-5HJGMjxW \
    -device isa-serial,id=serial0,chardev=chardev_serial0  \
    -chardev socket,id=seabioslog_id_20200721-014154-5HJGMjxW,path=/var/tmp/avocado_bapfdqao/seabios-20200721-014154-5HJGMjxW,server,nowait \
    -device isa-debugcon,chardev=seabioslog_id_20200721-014154-5HJGMjxW,iobase=0x402 \
    -device pcie-root-port,id=pcie-root-port-1,port=0x1,addr=0x1.0x1,bus=pcie.0,chassis=2 \
    -device qemu-xhci,id=usb1,bus=pcie-root-port-1,addr=0x0 \
    -device usb-tablet,id=usb-tablet1,bus=usb1.0,port=1 \
    -blockdev node-name=file_image1,driver=file,aio=threads,filename=rootfs.qcow2,cache.direct=on,cache.no-flush=off \
    -blockdev node-name=drive_image1,driver=qcow2,cache.direct=on,cache.no-flush=off,file=file_image1 \
    -device pcie-root-port,id=pcie-root-port-2,port=0x2,addr=0x1.0x2,bus=pcie.0,chassis=3 \
    -device virtio-blk-pci,id=image1,drive=drive_image1,bootindex=0,write-cache=on,bus=pcie-root-port-2,addr=0x0 \
    -blockdev node-name=file_disk1,driver=file,aio=threads,filename=/mnt/test/storage2.qcow2,cache.direct=on,cache.no-flush=off \
    -blockdev node-name=drive_disk1,driver=qcow2,cache.direct=on,cache.no-flush=off,file=file_disk1 \
    -device pcie-root-port,id=pcie-root-port-3,port=0x3,addr=0x1.0x3,bus=pcie.0,chassis=4 \
    -device virtio-blk-pci,id=disk1,drive=drive_disk1,bootindex=1,write-cache=on,bus=pcie-root-port-3,addr=0x0 \
    -device pcie-root-port,id=pcie-root-port-4,port=0x4,addr=0x1.0x4,bus=pcie.0,chassis=5 \
    -device virtio-net-pci,mac=9a:37:37:37:37:4e,id=idBMd7vy,netdev=idLb51aS,bus=pcie-root-port-4,addr=0x0  \
    -netdev tap,id=idLb51aS,fd=14  \
    -vnc :0  \
    -rtc base=utc,clock=host,driftfix=slew  \
    -boot menu=off,order=cdn,once=c,strict=off \
    -enable-kvm \
    -device pcie-root-port,id=pcie_extra_root_port_0,multifunction=on,bus=pcie.0,addr=0x3,chassis=6

Stefan

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9DxD8ACgkQnKSrs4Gr
c8g9ZQgAoq73hEo7BjmJlktqBICoVtFNugz30SuZIPCUOC36s9vN91x26uWS9AQY
CxUVmrk9SOI6fHz+ilHa2q9qfKXoZqhbXWqe8Egzn3elZyRLbAfltO2/v2yy+n3f
4wsNHNfuVzqruS4673seVTIfs7ZM43kXqXU1hLdaFh+PzCXAcWQcXW5ERPUPGem/
2QjqmN2xp4R9uqQK/Qao10bZGH+ThZpf8edhT8IrBYxLQHrbdwq81OBtGlgcIjAq
wVFEu/feWDqhRLnHOMZBz0cEAwL3av5dIDv7xBBixTdT+U58d2nf6VLwClQJZIGo
F8tx7Nkg73+T5TZGtZCD/Lsk3S5GKQ==
=GqSi
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--


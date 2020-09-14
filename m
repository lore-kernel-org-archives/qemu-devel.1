Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75213C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCDEA2076C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W04S40Fl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDEA2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHlqN-0003sM-Gk
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 06:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kHlpL-0002vp-Uv; Mon, 14 Sep 2020 06:35:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kHlpH-0001qX-PF; Mon, 14 Sep 2020 06:35:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id m6so18160281wrn.0;
 Mon, 14 Sep 2020 03:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TNOvuABr6IZN3/NrK/ulMs03AXcRfia1fthuSt4P56g=;
 b=W04S40FlkyT7fipBjkqC9UnTE8+UCuJ0P2SP+9F1YQ6nQKSk3vUxIiyFTDNciZVFD3
 hxVJyHpOzXGmEXDqEV0JQS3CzliaYTpvZ2JUAgYZfXNL3yJEeR31fk1D4OFLQYInEWfu
 ewfUrQzaZNbmR/dIXAV3+A6SDJxmmB16kTYrSqWVAf/e7N3yTCvwYj5LqEPc3Wvy70Pv
 uYQno7dXES/KiB7WVU3aMhcYF5+3SrlLREnUCTF6GI4QLnYy34C7qhBCeMSiqQ1r3lZJ
 islgtZc3Gb/8Jo23AkmcbUI5p9pPzmiPfMXNzBZS9r088KNB2DTkpisEu5XDeCLq4jO6
 N0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TNOvuABr6IZN3/NrK/ulMs03AXcRfia1fthuSt4P56g=;
 b=fYCamN0DVetmpgAONXhepB0Vpwh/XjY43+Q3kp4UUyOlfLXLkIhEQU9P+mgR2YXiO7
 hXWCBe0xxbRJkHCl0lu/u/vMNkG9Qk3fZmfIvjrSd64j479EC2iBkumC54ACf/Zmuyej
 Hyb0MmXW0VZmQgnkbFKxKo6SdbC7QWh9sjuwSzACR2imoUsySjBEN7wPPzqPj+DW9xxe
 P4U92j3qUk+Vjw6ao5SXQfGur5vxziiwjeIynyxR6y7PaBoeE1v2F8kY8x4xw1T+lWJA
 7ueqDtkoBLbccTUPLIp6Z37evt2CweZk1n1hutKtR6rPc7lLblgeKsNwqvypAixiMVg+
 TOVQ==
X-Gm-Message-State: AOAM530hCfaNLCFPfw8MqaMyidOIMgIED/E3IzsrNSr35jnCfRaqRzeM
 w7RTWQBsZmowtrAe7JjFapU=
X-Google-Smtp-Source: ABdhPJwh6UtFqEYVkcqnxXGu9kMGJvZJVybftWw5wL5xXDt7UOYs0qh6DkRb0T21Iq8rmREn3exQuw==
X-Received: by 2002:adf:ed09:: with SMTP id a9mr14906662wro.407.1600079709552; 
 Mon, 14 Sep 2020 03:35:09 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id m13sm19346517wrr.74.2020.09.14.03.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 03:35:08 -0700 (PDT)
Date: Mon, 14 Sep 2020 11:35:07 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [qemu-web PATCH] Add QEMU storage overview blog post
Message-ID: <20200914103507.GG579094@stefanha-x1.localdomain>
References: <20200907150421.8106-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JbKQpFqZXJ2T76Sg"
Content-Disposition: inline
In-Reply-To: <20200907150421.8106-1-stefanha@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, afrosi@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2020 at 04:04:21PM +0100, Stefan Hajnoczi wrote:
> I want to kick of a series of posts about storage. The first post covers
> high-level concepts, features, and utilities in QEMU. Later posts will
> discuss configuration details, architecture, and performance.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  _posts/2020-09-07-qemu-storage-overview.md | 122 +++++++
>  screenshots/2020-09-07-block-device-io.svg | 366 +++++++++++++++++++++
>  screenshots/2020-09-07-lifecycle.svg       | 328 ++++++++++++++++++
>  3 files changed, 816 insertions(+)
>  create mode 100644 _posts/2020-09-07-qemu-storage-overview.md
>  create mode 100644 screenshots/2020-09-07-block-device-io.svg
>  create mode 100644 screenshots/2020-09-07-lifecycle.svg

Ping? Thomas, you would you be able to merge this?

> diff --git a/_posts/2020-09-07-qemu-storage-overview.md b/_posts/2020-09-=
07-qemu-storage-overview.md
> new file mode 100644
> index 0000000..79f60c4
> --- /dev/null
> +++ b/_posts/2020-09-07-qemu-storage-overview.md
> @@ -0,0 +1,122 @@
> +---
> +layout: post
> +title:  "An Overview of QEMU Storage Features"
> +date:   2020-09-07 07:00:00 +0000
> +categories: [storage]
> +---
> +This article introduces QEMU storage concepts including disk images, emu=
lated
> +storage controllers, block jobs, the qemu-img utility, and qemu-storage-=
daemon.
> +If you are new to QEMU or want an overview of storage functionality in Q=
EMU
> +then this article explains how things fit together.
> +
> +## Storage technologies
> +Persistently storing data and retrieving it later is the job of storage =
devices
> +such as hard disks, solid state drives (SSDs), USB flash drives, network
> +attached storage, and many others. Technologies vary in their storage ca=
pacity
> +(disk size), access speed, price, and other factors but most of them fol=
low the
> +same block device model.
> +
> +![Block device I/O](/screenshots/2020-09-07-block-device-io.svg)
> +
> +Block devices are accessed in storage units called blocks. It is not pos=
sible
> +to access individual bytes, instead an entire block must be transferred.=
 Block
> +sizes vary between devices with 512 bytes and 4KB block sizes being the =
most
> +common.
> +
> +As an emulator and virtualizer of computer systems, QEMU naturally has t=
o offer
> +block device functionality. QEMU is capable of emulating hard disks, sol=
id
> +state drives (SSDs), USB flash drives, SD cards, and more.
> +
> +## Storage for virtual machines
> +There is more to storage than just persisting data on behalf of a virtual
> +machine. The lifecycle of a disk image includes several operations that =
are
> +briefly covered below.
> +
> +![Block device I/O](/screenshots/2020-09-07-lifecycle.svg)
> +
> +Virtual machines consist of device configuration (how much RAM, which
> +graphics card, etc) and the contents of their disks. Transferring virtual
> +machines either to migrate them between hosts or to distribute them to u=
sers is
> +an important workflow that QEMU and its utilities support.
> +
> +Much like ISO files are used to distribute operating system installer im=
ages,
> +QEMU supports disk image file formats that are more convenient for trans=
ferring
> +disk images than the raw contents of a disk. In fact, disk image file fo=
rmats
> +offer many other features such as the ability to import/export disks fro=
m other
> +hypervisors, snapshots, and instantiating new disk images from a backing=
 file.
> +
> +Finally, managing disk images also involves the ability to take backups =
and
> +restore them should it be necessary to roll back after the current disk
> +contents have been lost or corrupted.
> +
> +## Emulated storage controllers
> +
> +The virtual machine accesses block devices through storage controllers. =
These
> +are the devices that the guest talks to in order to read or write blocks=
=2E Some
> +storage controllers facilitate access to multiple block devices, such as=
 a SCSI
> +Host Bus Adapter that provides access to many SCSI disks.
> +
> +Storage controllers vary in their features, performance, and guest opera=
ting
> +system support. They expose a storage interface such as virtio-blk, NVMe=
, or
> +SCSI. Virtual machines program storage controller registers to transfer =
data
> +between memory buffers in RAM and block devices. Modern storage controll=
ers
> +support multiple request queues so that I/O can processed in parallel at=
 high
> +rates.
> +
> +The most common storage controllers in QEMU are virtio-blk, virtio-scsi,=
 AHCI
> +(SATA), IDE for legacy systems, and SD Card controllers on embedded or s=
maller
> +boards.
> +
> +## Disk image file formats
> +
> +Disk image file formats handle the layout of blocks within a host file or
> +device. The simplest format is the raw format where each block is locate=
d at
> +its Logical Block Address (LBA) in the host file. This simple scheme doe=
s not
> +offer much in the way of features.
> +
> +QEMU's native disk image format is QCOW2 and it offers a number of featu=
res:
> +* Compactness - the host file grows as blocks are written so a sparse di=
sk image can be much smaller than the virtual disk size.
> +* Backing files - disk images can be based on a parent image so that a m=
aster image can be shared by virtual machines.
> +* Snapshots - the state of the disk image can be saved and later reverte=
d.
> +* Compression - block compression reduces the image size.
> +* Encryption - the disk image can be encrypted to protect data at rest.
> +* Dirty bitmaps - backup applications can track changed blocks so that e=
fficient incremental backups are possible.
> +
> +A number of other disk image file formats are available for importing/ex=
porting
> +disk images for use with other software including VMware and Hyper-V.
> +
> +## Block jobs
> +
> +Block jobs are background operations that manipulate disk images:
> +* Commit - merging backing files to shorten a backing file chain.
> +* Backup - copying out a point-in-time snapshot of a disk.
> +* Mirror - copying an image to a new destination while the virtual machi=
ne can still write to it.
> +* Stream - populating a disk image from its backing file.
> +* Create - creating new disk image files.
> +
> +These background operations are powerful tools for building storage migr=
ation
> +and backup workflows.
> +
> +Some operations like mirror and stream can take a long time because they=
 copy
> +large amounts of data. Block jobs support throttling to limit the perfor=
mance
> +impact on virtual machines.
> +
> +## qemu-img and qemu-storage-daemon
> +
> +The [qemu-img utility](https://www.qemu.org/docs/master/interop/qemu-img=
=2Ehtml) manipulates disk images. It can create, resize, snapshot,
> +repair, and inspect disk images. It has both human-friendly and JSON out=
put
> +formats, making it suitable for manual use as well as scripting.
> +
> +qemu-storage-daemon exposes QEMU's storage functionality in a server pro=
cess
> +without running a virtual machine. It can export disk images over the Ne=
twork
> +Block Device (NBD) protocol as well as run block jobs and other storage
> +commands. This makes qemu-storage-daemon useful for applications that wa=
nt to
> +automate disk image manipulation.
> +
> +## Conclusion
> +
> +QEMU presents block devices to virtual machines via emulated storage
> +controllers. On the host side the disk image file format, block jobs, and
> +qemu-img/qemu-storage-daemon utilities provide functionality for working=
 with
> +disk images. Future blog posts will dive deeper into some of these areas=
 and
> +describe best practices for configuring storage.
> diff --git a/screenshots/2020-09-07-block-device-io.svg b/screenshots/202=
0-09-07-block-device-io.svg
> new file mode 100644
> index 0000000..b1effcc
> --- /dev/null
> +++ b/screenshots/2020-09-07-block-device-io.svg
> @@ -0,0 +1,366 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
> +<svg
> +   xmlns:dc=3D"http://purl.org/dc/elements/1.1/"
> +   xmlns:cc=3D"http://creativecommons.org/ns#"
> +   xmlns:rdf=3D"http://www.w3.org/1999/02/22-rdf-syntax-ns#"
> +   xmlns:svg=3D"http://www.w3.org/2000/svg"
> +   xmlns=3D"http://www.w3.org/2000/svg"
> +   xmlns:sodipodi=3D"http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
> +   xmlns:inkscape=3D"http://www.inkscape.org/namespaces/inkscape"
> +   sodipodi:docname=3D"block-device-io.svg"
> +   inkscape:version=3D"1.0 (4035a4fb49, 2020-05-01)"
> +   id=3D"svg8"
> +   version=3D"1.1"
> +   viewBox=3D"0 0 211.66667 105.83334"
> +   height=3D"400"
> +   width=3D"800">
> +  <defs
> +     id=3D"defs2">
> +    <rect
> +       id=3D"rect3368"
> +       height=3D"12.31036"
> +       width=3D"21.572843"
> +       y=3D"87.814795"
> +       x=3D"5.0839274" />
> +    <marker
> +       inkscape:isstock=3D"true"
> +       style=3D"overflow:visible"
> +       id=3D"Arrow2Mstart"
> +       refX=3D"0.0"
> +       refY=3D"0.0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Arrow2Mstart">
> +      <path
> +         transform=3D"scale(0.6) translate(0,0)"
> +         d=3D"M 8.7185878,4.0337352 L -2.2072895,0.016013256 L 8.7185884=
,-4.0017078 C 6.9730900,-1.6296469 6.9831476,1.6157441 8.7185878,4.0337352 =
z "
> +         style=3D"fill-rule:evenodd;stroke-width:0.625;stroke-linejoin:r=
ound;stroke:#5f9857;stroke-opacity:1;fill:#5f9857;fill-opacity:1"
> +         id=3D"path975" />
> +    </marker>
> +    <marker
> +       inkscape:isstock=3D"true"
> +       style=3D"overflow:visible"
> +       id=3D"Arrow1Sstart"
> +       refX=3D"0.0"
> +       refY=3D"0.0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Arrow1Sstart">
> +      <path
> +         transform=3D"scale(0.2) translate(6,0)"
> +         style=3D"fill-rule:evenodd;stroke:#a02e2e;stroke-width:1pt;stro=
ke-opacity:1;fill:#a02e2e;fill-opacity:1"
> +         d=3D"M 0.0,0.0 L 5.0,-5.0 L -12.5,0.0 L 5.0,5.0 L 0.0,0.0 z "
> +         id=3D"path963" />
> +    </marker>
> +    <marker
> +       inkscape:isstock=3D"true"
> +       style=3D"overflow:visible;"
> +       id=3D"Arrow2Mend"
> +       refX=3D"0.0"
> +       refY=3D"0.0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Arrow2Mend">
> +      <path
> +         transform=3D"scale(0.6) rotate(180) translate(0,0)"
> +         d=3D"M 8.7185878,4.0337352 L -2.2072895,0.016013256 L 8.7185884=
,-4.0017078 C 6.9730900,-1.6296469 6.9831476,1.6157441 8.7185878,4.0337352 =
z "
> +         style=3D"fill-rule:evenodd;stroke-width:0.625;stroke-linejoin:r=
ound;stroke:#a02e2e;stroke-opacity:1;fill:#a02e2e;fill-opacity:1"
> +         id=3D"path978" />
> +    </marker>
> +    <marker
> +       inkscape:isstock=3D"true"
> +       style=3D"overflow:visible;"
> +       id=3D"marker1287"
> +       refX=3D"0.0"
> +       refY=3D"0.0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Arrow1Mend">
> +      <path
> +         transform=3D"scale(0.4) rotate(180) translate(10,0)"
> +         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;stro=
ke-opacity:1;fill:#000000;fill-opacity:1"
> +         d=3D"M 0.0,0.0 L 5.0,-5.0 L -12.5,0.0 L 5.0,5.0 L 0.0,0.0 z "
> +         id=3D"path1285" />
> +    </marker>
> +    <marker
> +       inkscape:isstock=3D"true"
> +       style=3D"overflow:visible;"
> +       id=3D"Arrow1Send"
> +       refX=3D"0.0"
> +       refY=3D"0.0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Arrow1Send">
> +      <path
> +         transform=3D"scale(0.2) rotate(180) translate(6,0)"
> +         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;stro=
ke-opacity:1;fill:#000000;fill-opacity:1"
> +         d=3D"M 0.0,0.0 L 5.0,-5.0 L -12.5,0.0 L 5.0,5.0 L 0.0,0.0 z "
> +         id=3D"path966" />
> +    </marker>
> +    <marker
> +       inkscape:isstock=3D"true"
> +       style=3D"overflow:visible;"
> +       id=3D"Arrow1Mend"
> +       refX=3D"0.0"
> +       refY=3D"0.0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Arrow1Mend">
> +      <path
> +         transform=3D"scale(0.4) rotate(180) translate(10,0)"
> +         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;stro=
ke-opacity:1;fill:#000000;fill-opacity:1"
> +         d=3D"M 0.0,0.0 L 5.0,-5.0 L -12.5,0.0 L 5.0,5.0 L 0.0,0.0 z "
> +         id=3D"path960" />
> +    </marker>
> +    <marker
> +       inkscape:isstock=3D"true"
> +       style=3D"overflow:visible;"
> +       id=3D"Arrow1Lend"
> +       refX=3D"0.0"
> +       refY=3D"0.0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Arrow1Lend">
> +      <path
> +         transform=3D"scale(0.8) rotate(180) translate(12.5,0)"
> +         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;stro=
ke-opacity:1;fill:#000000;fill-opacity:1"
> +         d=3D"M 0.0,0.0 L 5.0,-5.0 L -12.5,0.0 L 5.0,5.0 L 0.0,0.0 z "
> +         id=3D"path954" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-6"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path978-2"
> +         style=3D"fill:#a02e2e;fill-opacity:1;fill-rule:evenodd;stroke:#=
a02e2e;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +  </defs>
> +  <sodipodi:namedview
> +     inkscape:window-maximized=3D"1"
> +     inkscape:window-y=3D"0"
> +     inkscape:window-x=3D"0"
> +     inkscape:window-height=3D"1016"
> +     inkscape:window-width=3D"1920"
> +     units=3D"px"
> +     showgrid=3D"false"
> +     inkscape:document-rotation=3D"0"
> +     inkscape:current-layer=3D"layer1"
> +     inkscape:document-units=3D"mm"
> +     inkscape:cy=3D"200"
> +     inkscape:cx=3D"400"
> +     inkscape:zoom=3D"1"
> +     inkscape:pageshadow=3D"2"
> +     inkscape:pageopacity=3D"0.0"
> +     borderopacity=3D"1.0"
> +     bordercolor=3D"#666666"
> +     pagecolor=3D"#ffffff"
> +     id=3D"base" />
> +  <metadata
> +     id=3D"metadata5">
> +    <rdf:RDF>
> +      <cc:Work
> +         rdf:about=3D"">
> +        <dc:format>image/svg+xml</dc:format>
> +        <dc:type
> +           rdf:resource=3D"http://purl.org/dc/dcmitype/StillImage" />
> +        <dc:title></dc:title>
> +      </cc:Work>
> +    </rdf:RDF>
> +  </metadata>
> +  <g
> +     id=3D"layer1"
> +     inkscape:groupmode=3D"layer"
> +     inkscape:label=3D"Layer 1">
> +    <rect
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.329999;stroke=
-linejoin:round;stroke-opacity:1"
> +       id=3D"rect837-5-2-0"
> +       width=3D"14.319539"
> +       height=3D"14.319539"
> +       x=3D"151.85484"
> +       y=3D"43.375652" />
> +    <rect
> +       y=3D"43.375652"
> +       x=3D"57.398544"
> +       height=3D"14.319539"
> +       width=3D"14.319539"
> +       id=3D"rect837-5-2"
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.329999;stroke=
-linejoin:round;stroke-opacity:1" />
> +    <rect
> +       y=3D"72.115448"
> +       x=3D"8.5989037"
> +       height=3D"17.248669"
> +       width=3D"191.44061"
> +       id=3D"rect12"
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.325756;stroke=
-linejoin:round;stroke-opacity:1" />
> +    <rect
> +       y=3D"73.802719"
> +       x=3D"10.188523"
> +       height=3D"14.319539"
> +       width=3D"14.319539"
> +       id=3D"rect837"
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.329999;stroke=
-linejoin:round;stroke-opacity:1" />
> +    <rect
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.329999;stroke=
-linejoin:round;stroke-opacity:1"
> +       id=3D"rect837-3"
> +       width=3D"14.319539"
> +       height=3D"14.319539"
> +       x=3D"25.974277"
> +       y=3D"73.802719" />
> +    <rect
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.329999;stroke=
-linejoin:round;stroke-opacity:1"
> +       id=3D"rect837-6"
> +       width=3D"14.319539"
> +       height=3D"14.319539"
> +       x=3D"41.760025"
> +       y=3D"73.802719" />
> +    <rect
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.329999;stroke=
-linejoin:round;stroke-opacity:1"
> +       id=3D"rect837-7"
> +       width=3D"14.319539"
> +       height=3D"14.319539"
> +       x=3D"57.545776"
> +       y=3D"73.802719" />
> +    <rect
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.329999;stroke=
-linejoin:round;stroke-opacity:1"
> +       id=3D"rect837-5"
> +       width=3D"14.319539"
> +       height=3D"14.319539"
> +       x=3D"73.331528"
> +       y=3D"73.802719" />
> +    <rect
> +       y=3D"73.802719"
> +       x=3D"89.117271"
> +       height=3D"14.319539"
> +       width=3D"14.319539"
> +       id=3D"rect837-3-3"
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.329999;stroke=
-linejoin:round;stroke-opacity:1" />
> +    <rect
> +       y=3D"73.802719"
> +       x=3D"120.68877"
> +       height=3D"14.319539"
> +       width=3D"14.319539"
> +       id=3D"rect837-7-6"
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.329999;stroke=
-linejoin:round;stroke-opacity:1" />
> +    <rect
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.329999;stroke=
-linejoin:round;stroke-opacity:1"
> +       id=3D"rect837-2"
> +       width=3D"14.319539"
> +       height=3D"14.319539"
> +       x=3D"136.47447"
> +       y=3D"73.802719" />
> +    <rect
> +       y=3D"73.802719"
> +       x=3D"152.26022"
> +       height=3D"14.319539"
> +       width=3D"14.319539"
> +       id=3D"rect837-3-9"
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.329999;stroke=
-linejoin:round;stroke-opacity:1" />
> +    <rect
> +       y=3D"73.802719"
> +       x=3D"168.04596"
> +       height=3D"14.319539"
> +       width=3D"14.319539"
> +       id=3D"rect837-6-1"
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.329999;stroke=
-linejoin:round;stroke-opacity:1" />
> +    <rect
> +       y=3D"73.802719"
> +       x=3D"183.83174"
> +       height=3D"14.319539"
> +       width=3D"14.319539"
> +       id=3D"rect837-7-2"
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.329999;stroke=
-linejoin:round;stroke-opacity:1" />
> +    <ellipse
> +       ry=3D"1.3585734"
> +       rx=3D"1.4722615"
> +       cy=3D"80.826599"
> +       cx=3D"107.49885"
> +       id=3D"path926"
> +       style=3D"fill:#000000;stroke:none;stroke-width:0.329999;stroke-li=
nejoin:round;stroke-opacity:1" />
> +    <ellipse
> +       style=3D"fill:#000000;stroke:none;stroke-width:0.329999;stroke-li=
nejoin:round;stroke-opacity:1"
> +       id=3D"path926-6"
> +       cx=3D"111.95774"
> +       cy=3D"80.826599"
> +       rx=3D"1.4722615"
> +       ry=3D"1.3585734" />
> +    <ellipse
> +       style=3D"fill:#000000;stroke:none;stroke-width:0.329999;stroke-li=
nejoin:round;stroke-opacity:1"
> +       id=3D"path926-0"
> +       cx=3D"116.41663"
> +       cy=3D"80.826599"
> +       rx=3D"1.4722615"
> +       ry=3D"1.3585734" />
> +    <path
> +       id=3D"path949"
> +       d=3D"M 64.210031,52.265547 V 81.761421"
> +       style=3D"fill:none;fill-rule:evenodd;stroke:#a02e2e;stroke-width:=
1;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dash=
array:none;stroke-opacity:1;marker-end:url(#Arrow2Mend)" />
> +    <path
> +       style=3D"fill:none;fill-rule:evenodd;stroke:#5f9857;stroke-width:=
1;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dash=
array:none;stroke-opacity:1;marker-start:url(#Arrow2Mstart)"
> +       d=3D"M 159.26959,53.777385 V 83.273259"
> +       id=3D"path949-6" />
> +    <text
> +       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:11.2889px;line-height:125%;font-family:FreeS=
ans;-inkscape-font-specification:FreeSans;letter-spacing:0px;word-spacing:0=
px;white-space:pre;shape-inside:url(#rect3368);fill:#000000;fill-opacity:1;=
stroke:none;stroke-width:0.264583px;stroke-linecap:butt;stroke-linejoin:mit=
er;stroke-opacity:1;"
> +       id=3D"text3366"
> +       xml:space=3D"preserve"><tspan
> +         style=3D"visibility:hidden"
> +         x=3D"5.0839844"
> +         y=3D"110.11303"><tspan
> +           dx=3D"0 6.89571 7.1547813 3.1364193 5.8814716 3.5884151 3.136=
4193 5.8814735 3.5884132 6.9177589 3.5884171 4.4262619 6.9453201 5.8814697"
> +           style=3D"fill:none">This is a test</tspan></tspan></text>
> +    <text
> +       id=3D"text3386"
> +       y=3D"99.211525"
> +       x=3D"13.573332"
> +       style=3D"font-size:9.87778px;line-height:125%;font-family:sans-se=
rif;-inkscape-font-specification:sans-serif;letter-spacing:0px;word-spacing=
:0px;fill:none;stroke:#000000;stroke-width:0.264583px;stroke-linecap:butt;s=
troke-linejoin:miter;stroke-opacity:1"
> +       xml:space=3D"preserve"><tspan
> +         style=3D"font-size:9.87778px;fill:#000000;stroke-width:0.264583=
px"
> +         y=3D"99.211525"
> +         x=3D"13.573332"
> +         id=3D"tspan3384"
> +         sodipodi:role=3D"line">0   1   2   3   4   5 </tspan></text>
> +    <text
> +       id=3D"text3390"
> +       y=3D"98.842552"
> +       x=3D"113.57343"
> +       style=3D"font-size:7.7611px;line-height:125%;font-family:sans-ser=
if;-inkscape-font-specification:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:none;stroke:#000000;stroke-width:0.264583px;stroke-linecap:butt;st=
roke-linejoin:miter;stroke-opacity:1"
> +       xml:space=3D"preserve"><tspan
> +         style=3D"font-style:italic;font-variant:normal;font-weight:norm=
al;font-stretch:normal;font-family:sans-serif;-inkscape-font-specification:=
'sans-serif Italic';fill:#000000;stroke-width:0.264583px"
> +         y=3D"98.842552"
> +         x=3D"113.57343"
> +         id=3D"tspan3388"
> +         sodipodi:role=3D"line">Logical Block Address</tspan></text>
> +    <text
> +       id=3D"text3394"
> +       y=3D"36.814297"
> +       x=3D"51.45319"
> +       style=3D"font-size:9.87778px;line-height:125%;font-family:sans-se=
rif;-inkscape-font-specification:sans-serif;letter-spacing:0px;word-spacing=
:0px;fill:none;stroke:#000000;stroke-width:0.264583px;stroke-linecap:butt;s=
troke-linejoin:miter;stroke-opacity:1"
> +       xml:space=3D"preserve"><tspan
> +         style=3D"font-size:9.87778px;fill:#000000;stroke-width:0.264583=
px"
> +         y=3D"36.814297"
> +         x=3D"51.45319"
> +         id=3D"tspan3392"
> +         sodipodi:role=3D"line">Write</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-size:9.87777px;line-height:125%;font-family:sans-se=
rif;-inkscape-font-specification:sans-serif;letter-spacing:0px;word-spacing=
:0px;fill:none;stroke:#000000;stroke-width:0.264583px;stroke-linecap:butt;s=
troke-linejoin:miter;stroke-opacity:1"
> +       x=3D"145.80954"
> +       y=3D"36.814297"
> +       id=3D"text3394-9"><tspan
> +         sodipodi:role=3D"line"
> +         id=3D"tspan3392-4"
> +         x=3D"145.80954"
> +         y=3D"36.814297"
> +         style=3D"font-size:9.87777px;fill:#000000;stroke-width:0.264583=
px">Read</tspan></text>
> +    <text
> +       id=3D"text3428"
> +       y=3D"18.429882"
> +       x=3D"40.263172"
> +       style=3D"font-size:16.9333px;line-height:125%;font-family:sans-se=
rif;-inkscape-font-specification:sans-serif;letter-spacing:0px;word-spacing=
:0px;fill:none;stroke:#000000;stroke-width:0.264583px;stroke-linecap:butt;s=
troke-linejoin:miter;stroke-opacity:1"
> +       xml:space=3D"preserve"><tspan
> +         style=3D"font-size:16.9333px;fill:#000000;stroke-width:0.264583=
px"
> +         y=3D"18.429882"
> +         x=3D"40.263172"
> +         id=3D"tspan3426"
> +         sodipodi:role=3D"line">Block Device I/O</tspan></text>
> +  </g>
> +</svg>
> diff --git a/screenshots/2020-09-07-lifecycle.svg b/screenshots/2020-09-0=
7-lifecycle.svg
> new file mode 100644
> index 0000000..1c10668
> --- /dev/null
> +++ b/screenshots/2020-09-07-lifecycle.svg
> @@ -0,0 +1,328 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
> +<svg
> +   xmlns:dc=3D"http://purl.org/dc/elements/1.1/"
> +   xmlns:cc=3D"http://creativecommons.org/ns#"
> +   xmlns:rdf=3D"http://www.w3.org/1999/02/22-rdf-syntax-ns#"
> +   xmlns:svg=3D"http://www.w3.org/2000/svg"
> +   xmlns=3D"http://www.w3.org/2000/svg"
> +   xmlns:sodipodi=3D"http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
> +   xmlns:inkscape=3D"http://www.inkscape.org/namespaces/inkscape"
> +   width=3D"516.87274"
> +   height=3D"455.98318"
> +   viewBox=3D"0 0 136.75591 120.64555"
> +   version=3D"1.1"
> +   id=3D"svg8"
> +   inkscape:version=3D"1.0 (4035a4fb49, 2020-05-01)"
> +   sodipodi:docname=3D"2020-09-07-lifecycle.svg">
> +  <defs
> +     id=3D"defs2">
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mstart"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mstart"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path879"
> +         style=3D"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#=
000000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path882"
> +         style=3D"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#=
000000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <inkscape:perspective
> +       sodipodi:type=3D"inkscape:persp3d"
> +       inkscape:vp_x=3D"0 : 41.270551 : 1"
> +       inkscape:vp_y=3D"0 : 999.99999 : 0"
> +       inkscape:vp_z=3D"2.7936278 : 120.44608 : 1"
> +       inkscape:persp3d-origin=3D"79.374998 : 14.812218 : 1"
> +       id=3D"perspective833" />
> +    <marker
> +       inkscape:isstock=3D"true"
> +       style=3D"overflow:visible"
> +       id=3D"Arrow2Mend-3"
> +       refX=3D"0"
> +       refY=3D"0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Arrow2Mend">
> +      <path
> +         transform=3D"scale(-0.6)"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         style=3D"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#=
000000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         id=3D"path882-6" />
> +    </marker>
> +    <marker
> +       inkscape:isstock=3D"true"
> +       style=3D"overflow:visible"
> +       id=3D"Arrow2Mend-5"
> +       refX=3D"0"
> +       refY=3D"0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Arrow2Mend">
> +      <path
> +         transform=3D"scale(-0.6)"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         style=3D"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#=
000000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         id=3D"path882-3" />
> +    </marker>
> +    <marker
> +       inkscape:isstock=3D"true"
> +       style=3D"overflow:visible"
> +       id=3D"Arrow2Mstart-5"
> +       refX=3D"0"
> +       refY=3D"0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Arrow2Mstart">
> +      <path
> +         transform=3D"scale(0.6)"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         style=3D"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#=
000000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         id=3D"path879-6" />
> +    </marker>
> +    <marker
> +       inkscape:isstock=3D"true"
> +       style=3D"overflow:visible"
> +       id=3D"Arrow2Mend-1"
> +       refX=3D"0"
> +       refY=3D"0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Arrow2Mend">
> +      <path
> +         transform=3D"scale(-0.6)"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         style=3D"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#=
000000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         id=3D"path882-2" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mstart"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mstart-5-0"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path879-6-2"
> +         style=3D"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#=
000000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mend"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mend-1-7"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path882-2-5"
> +         style=3D"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#=
000000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(-0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:stockid=3D"Arrow2Mstart"
> +       orient=3D"auto"
> +       refY=3D"0"
> +       refX=3D"0"
> +       id=3D"Arrow2Mstart-5-2"
> +       style=3D"overflow:visible"
> +       inkscape:isstock=3D"true">
> +      <path
> +         id=3D"path879-6-28"
> +         style=3D"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#=
000000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         transform=3D"scale(0.6)" />
> +    </marker>
> +    <marker
> +       inkscape:isstock=3D"true"
> +       style=3D"overflow:visible"
> +       id=3D"Arrow2Mstart-5-0-9"
> +       refX=3D"0"
> +       refY=3D"0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Arrow2Mstart">
> +      <path
> +         transform=3D"scale(0.6)"
> +         d=3D"M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0=
017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
> +         style=3D"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#=
000000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
> +         id=3D"path879-6-2-7" />
> +    </marker>
> +  </defs>
> +  <sodipodi:namedview
> +     fit-margin-bottom=3D"12"
> +     fit-margin-right=3D"12"
> +     fit-margin-left=3D"12"
> +     fit-margin-top=3D"12"
> +     id=3D"base"
> +     pagecolor=3D"#ffffff"
> +     bordercolor=3D"#666666"
> +     borderopacity=3D"1.0"
> +     inkscape:pageopacity=3D"0.0"
> +     inkscape:pageshadow=3D"2"
> +     inkscape:zoom=3D"1"
> +     inkscape:cx=3D"360.2843"
> +     inkscape:cy=3D"268.52474"
> +     inkscape:document-units=3D"mm"
> +     inkscape:current-layer=3D"layer1"
> +     inkscape:document-rotation=3D"0"
> +     showgrid=3D"false"
> +     units=3D"px"
> +     inkscape:window-width=3D"1920"
> +     inkscape:window-height=3D"1016"
> +     inkscape:window-x=3D"0"
> +     inkscape:window-y=3D"0"
> +     inkscape:window-maximized=3D"1" />
> +  <metadata
> +     id=3D"metadata5">
> +    <rdf:RDF>
> +      <cc:Work
> +         rdf:about=3D"">
> +        <dc:format>image/svg+xml</dc:format>
> +        <dc:type
> +           rdf:resource=3D"http://purl.org/dc/dcmitype/StillImage" />
> +        <dc:title></dc:title>
> +      </cc:Work>
> +    </rdf:RDF>
> +  </metadata>
> +  <g
> +     transform=3D"translate(-10.508113,-3.0361619)"
> +     inkscape:label=3D"Layer 1"
> +     inkscape:groupmode=3D"layer"
> +     id=3D"layer1">
> +    <rect
> +       style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-width:=
0.329999;stroke-linejoin:round"
> +       id=3D"rect851"
> +       width=3D"20.53208"
> +       height=3D"20.53208"
> +       x=3D"69.127571"
> +       y=3D"52.292423" />
> +    <path
> +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:=
1;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dash=
array:none;stroke-opacity:1;marker-start:url(#Arrow2Mstart-5)"
> +       d=3D"m 93.304199,66.781605 c 7.939251,8.629964 30.888561,19.33622=
4 50.433181,0"
> +       id=3D"path853-7-9"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       id=3D"path853-70"
> +       d=3D"M 79.412848,76.366728 V 107.04289"
> +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:=
1;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dash=
array:none;stroke-opacity:1;marker-end:url(#Arrow2Mend-1)"
> +       sodipodi:nodetypes=3D"cc" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-size:9.87778px;line-height:125%;font-family:sans-se=
rif;-inkscape-font-specification:sans-serif;letter-spacing:0px;word-spacing=
:0px;fill:none;stroke:#000000;stroke-width:0.264583px;stroke-linecap:butt;s=
troke-linejoin:miter;stroke-opacity:1"
> +       x=3D"23.73085"
> +       y=3D"42.474926"
> +       id=3D"text1501"><tspan
> +         sodipodi:role=3D"line"
> +         id=3D"tspan1499"
> +         x=3D"23.73085"
> +         y=3D"42.474926"
> +         style=3D"font-size:9.87778px;fill:#000000;stroke-width:0.264583=
px">Import</tspan></text>
> +    <text
> +       id=3D"text1501-9"
> +       y=3D"88.298172"
> +       x=3D"23.458694"
> +       style=3D"font-size:9.87777px;line-height:125%;font-family:sans-se=
rif;-inkscape-font-specification:sans-serif;letter-spacing:0px;word-spacing=
:0px;fill:none;stroke:#000000;stroke-width:0.264583px;stroke-linecap:butt;s=
troke-linejoin:miter;stroke-opacity:1"
> +       xml:space=3D"preserve"><tspan
> +         style=3D"font-size:9.87777px;fill:#000000;stroke-width:0.264583=
px"
> +         y=3D"88.298172"
> +         x=3D"23.458694"
> +         sodipodi:role=3D"line"
> +         id=3D"tspan1521">Export</tspan></text>
> +    <text
> +       id=3D"text1501-6"
> +       y=3D"43.217697"
> +       x=3D"101.97588"
> +       style=3D"font-size:9.87777px;line-height:125%;font-family:sans-se=
rif;-inkscape-font-specification:sans-serif;letter-spacing:0px;word-spacing=
:0px;fill:none;stroke:#000000;stroke-width:0.264583px;stroke-linecap:butt;s=
troke-linejoin:miter;stroke-opacity:1"
> +       xml:space=3D"preserve"><tspan
> +         style=3D"font-size:9.87777px;fill:#000000;stroke-width:0.264583=
px"
> +         y=3D"43.217697"
> +         x=3D"101.97588"
> +         id=3D"tspan1499-0"
> +         sodipodi:role=3D"line">Backup</tspan></text>
> +    <text
> +       id=3D"text1501-62"
> +       y=3D"88.846954"
> +       x=3D"101.04363"
> +       style=3D"font-size:9.87777px;line-height:125%;font-family:sans-se=
rif;-inkscape-font-specification:sans-serif;letter-spacing:0px;word-spacing=
:0px;fill:none;stroke:#000000;stroke-width:0.264583px;stroke-linecap:butt;s=
troke-linejoin:miter;stroke-opacity:1"
> +       xml:space=3D"preserve"><tspan
> +         style=3D"font-size:9.87777px;fill:#000000;stroke-width:0.264583=
px"
> +         y=3D"88.846954"
> +         x=3D"101.04363"
> +         id=3D"tspan1499-6"
> +         sodipodi:role=3D"line">Restore</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-size:9.87777px;line-height:125%;font-family:sans-se=
rif;-inkscape-font-specification:sans-serif;letter-spacing:0px;word-spacing=
:0px;fill:none;stroke:#000000;stroke-width:0.264583px;stroke-linecap:butt;s=
troke-linejoin:miter;stroke-opacity:1"
> +       x=3D"61.443283"
> +       y=3D"118.31977"
> +       id=3D"text1501-62-1"><tspan
> +         sodipodi:role=3D"line"
> +         id=3D"tspan1499-6-8"
> +         x=3D"61.443283"
> +         y=3D"118.31977"
> +         style=3D"font-size:9.87777px;fill:#000000;stroke-width:0.264583=
px">Migrate</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-size:9.87777px;line-height:125%;font-family:sans-se=
rif;-inkscape-font-specification:sans-serif;letter-spacing:0px;word-spacing=
:0px;fill:none;stroke:#000000;stroke-width:0.264583px;stroke-linecap:butt;s=
troke-linejoin:miter;stroke-opacity:1"
> +       x=3D"64.39402"
> +       y=3D"13.674611"
> +       id=3D"text1501-62-7"><tspan
> +         sodipodi:role=3D"line"
> +         id=3D"tspan1499-6-9"
> +         x=3D"64.39402"
> +         y=3D"13.674611"
> +         style=3D"font-size:9.87777px;fill:#000000;stroke-width:0.264583=
px">Create</tspan></text>
> +    <path
> +       sodipodi:nodetypes=3D"cc"
> +       id=3D"path853-7-9-3"
> +       d=3D"m 142.86514,59.598947 c -7.93926,-8.629964 -30.88858,-19.336=
225 -50.433199,0"
> +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:=
1;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dash=
array:none;stroke-opacity:1;marker-start:url(#Arrow2Mstart-5-0)" />
> +    <path
> +       sodipodi:nodetypes=3D"cc"
> +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:=
1;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dash=
array:none;stroke-opacity:1;marker-end:url(#Arrow2Mend-1-7)"
> +       d=3D"m 79.894559,18.186064 v 29.58986"
> +       id=3D"path853-70-9" />
> +    <path
> +       sodipodi:nodetypes=3D"cc"
> +       id=3D"path853-7-9-36"
> +       d=3D"m 14.907024,66.297581 c 7.939251,8.629963 30.888562,19.33622=
4 50.433176,0"
> +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:=
1;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dash=
array:none;stroke-opacity:1;marker-start:url(#Arrow2Mstart-5-2)" />
> +    <path
> +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:=
1;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dash=
array:none;stroke-opacity:1;marker-start:url(#Arrow2Mstart-5-0-9)"
> +       d=3D"m 64.467963,59.114923 c -7.939257,-8.629965 -30.888578,-19.3=
36226 -50.433197,0"
> +       id=3D"path853-7-9-3-1"
> +       sodipodi:nodetypes=3D"cc" />
> +    <text
> +       id=3D"text933"
> +       y=3D"60.612328"
> +       x=3D"79.368111"
> +       style=3D"font-style:italic;font-size:5.64444px;line-height:125%;f=
ont-family:sans-serif;-inkscape-font-specification:'sans-serif Italic';lett=
er-spacing:0px;word-spacing:0px;fill:none;stroke:#000000;stroke-width:0.264=
583px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
> +       xml:space=3D"preserve"><tspan
> +         style=3D"font-size:5.64444px;text-align:center;text-anchor:midd=
le;fill:#000000;stroke-width:0.264583px"
> +         y=3D"60.612328"
> +         x=3D"79.368111"
> +         id=3D"tspan931"
> +         sodipodi:role=3D"line">Disk</tspan><tspan
> +         id=3D"tspan935"
> +         style=3D"font-size:5.64444px;text-align:center;text-anchor:midd=
le;fill:#000000;stroke-width:0.264583px"
> +         y=3D"67.667877"
> +         x=3D"79.368111"
> +         sodipodi:role=3D"line">Image</tspan></text>
> +  </g>
> +</svg>
> --=20
> 2.26.2
>=20

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9fR1sACgkQnKSrs4Gr
c8g+ywf+LjzX+ru/siIFtKO2HEHTYX+Ab+v3fTfXO9frK5znJo7dNudquuyVArS8
8YF4F4BEY1KmCu0FEwZnea2JTYYXK1qiJckkykn2GZ6zbgnJygXQ2mSldT9Q0/Su
Z5EZILQXbgfXm1vJzNMU4vsXmgV8s52+N634IiK+vTx6sQnxnHHUAmOM4lDrgojO
6nMnPOi5lV3c6A024OsIqKBCrYxHE/NLkEdVtcBkpalnB8uMSaLgnAl1ByjlRtZE
q50DzDv3SCCFz0bpsyTCXsKksZwDb2xspKPQUHicYVDl3gqhl+Vv1EQjSxSUOFAe
2kiK3nEDKl4mwPUqhvOJH2iXZ6hWWw==
=pnjH
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--


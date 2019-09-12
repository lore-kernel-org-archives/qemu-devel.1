Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57B0C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DCC12081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeJCsURb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCC12081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Ndq-0003tK-2V
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 07:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i8Nck-00030p-7S
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i8Nci-0004zm-Kk
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:50:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i8Nci-0004z6-Ca
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:50:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id y19so28111930wrd.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 04:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jQgRoHrAzq66RdeF9iR2FFcdgfXcu8CIK39K3Jz0Mb0=;
 b=KeJCsURbrm9bgnwgBkNnjt92bPAH+Be7ldExDebp0sGdBkcOycG7Pf/shdTi6AHx+T
 iDcWdhD/hKRvDJ0daj9aDULLSvltBTpFejmVCT8rt27WakTnx2JsZJa/4PW2IAL2mMTk
 idfk0uaoM7K3+8R0pA0Ygrp70McGCXjTZDVDJMzPskdpqnGO2G/BvTsLE4PF4k65Kbf2
 fl+O3ybGj7uqgjL3SpfRBci7J58tzRLF813eI0b9SLcE85ngWKbUNgpWWBhSepzAbJ8a
 BZpk6ulfcXrwj1RrCG1dkb5JmTFDhnvN1w9XgSENtKzntpO7bvp5JVy4sZQp3uo0aT6/
 mktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jQgRoHrAzq66RdeF9iR2FFcdgfXcu8CIK39K3Jz0Mb0=;
 b=sYmYHo2ABs6sgh7lteMJh0IgfvEec+PhlOsondXQWixtzftyg7ZpP109tiODsmzvGH
 vOSEW/Tw+b2O730k/Jker+xaJgtuwRzfiQ2WIGw4plpyDz/04uy5N/ygAMKyOYotu07e
 oM9eLXCm3hpLlqzyR+W392rWJsUF5fuNYNZAknF0maCgg5MKjJRsXRPeC+tqtizd0heJ
 sWDMQHANjiPKua4J9xRYRf1pHB1yLS1BdaHF2+2s/eNVFPyCCidoBfB9yzSINro+F0Ya
 uJxcBI5cvMYRksgrNn1Sos/XG6/6NaMm14W94sU21Tgvcbx7UWn3iZASzVvxIbesnKYZ
 IwVg==
X-Gm-Message-State: APjAAAXvyH1osisduGGNv3fkEN+Q36YNvtqlRv1b5U6VdtvJCFTmgBDL
 DfrmwLB5aeuu2qBPMBaR3tnou7dJe1A=
X-Google-Smtp-Source: APXvYqy1MIg2bEHV30zFckrmIsKr3I8etQLt40TQWI2ZyEUbLfgT43rFPwchpZCtkKqFxRczN+IoiA==
X-Received: by 2002:a5d:4444:: with SMTP id x4mr33468375wrr.11.1568289050968; 
 Thu, 12 Sep 2019 04:50:50 -0700 (PDT)
Received: from localhost (178.165.130.7.wireless.dyn.drei.com. [178.165.130.7])
 by smtp.gmail.com with ESMTPSA id t25sm5448366wmj.29.2019.09.12.04.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 04:50:50 -0700 (PDT)
Date: Thu, 12 Sep 2019 13:50:48 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Bug 1842787 <1842787@bugs.launchpad.net>
Message-ID: <20190912115048.GE23174@stefanha-x1.localdomain>
References: <156765384458.824.9301349840467221970.malonedeb@wampee.canonical.com>
 <156765492325.17024.3771322746781962015.launchpad@gac.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zaRBsRFn0XYhEU69"
Content-Disposition: inline
In-Reply-To: <156765492325.17024.3771322746781962015.launchpad@gac.canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [Bug 1842787] Re: Writes permanently hang with
 very heavy I/O on virtio-scsi - worse on virtio-blk
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


--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:42:03AM -0000, James Harvey wrote:
> ** Description changed:
>=20
>   Up to date Arch Linux on host and guest.  linux 5.2.11.  QEMU 4.1.0.
>   Full command line at bottom.
>  =20
>   Host gives QEMU two thin LVM volumes.  The first is the root filesystem,
>   and the second is for heavy I/O, on a Samsung 970 Evo 1TB.
>  =20
>   When maxing out the I/O on the second virtual block device using virtio-
>   blk, I often get a "lockup" in about an hour or two.  From the advise of
>   iggy in IRC, I switched over to virtio-scsi.  It ran perfectly for a few
>   days, but then "locked up" in the same way.
>  =20
>   By "lockup", I mean writes to the second virtual block device
>   permanently hang.  I can read files from it, but even "touch foo" never
>   times out, cannot be "kill -9"'ed, and is stuck in uninterruptible
>   sleep.
>  =20
>   When this happens, writes to the first virtual block device with the
>   root filesystem are fine, so the O/S itself remains responsive.
>  =20
>   The second virtual block device uses BTRFS.  But, I have also tried XFS
>   and reproduced the issue.
>  =20
>   In guest, when this starts, it starts logging "task X blocked for more
>   than Y seconds".  Below is an example of one of these.  At this point,
>   anything that is or does in the future write to this block device gets
>   stuck in uninterruptible sleep.
>  =20
>   -----
>  =20
>   INFO: task kcompactd:232 blocked for more than 860 seconds.
>   =A0=A0=A0=A0=A0=A0Not tained 5.2.11-1 #1
>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messae.
>   kcompactd0      D    0   232      2 0x80004000
>   Call Trace:
>   =A0? __schedule+0x27f/0x6d0
>   =A0schedule+0x3d/0xc0
>   =A0io_schedule+0x12/0x40
>   =A0__lock_page+0x14a/0x250
>   =A0? add_to_page_cache_lru+0xe0/0xe0
>   =A0migrate_pages+0x803/0xb70
>   =A0? isolate_migratepages_block+0x9f0/0x9f0
>   =A0? __reset_isolation_suitable+0x110/0x110
>   =A0compact_zone+0x6a2/0xd30
>   =A0kcompactd_do_work+0x134/0x260
>   =A0? kvm_clock_read+0x14/0x30
>   =A0? kvm_sched_clock_read+0x5/0x10
>   =A0kcompactd+0xd3/0x220
>   =A0? wait_woken+0x80/0x80
>   =A0kthread+0xfd/0x130
>   =A0? kcompactd_do_work+0x260/0x260
>   =A0? kthread_park+0x80/0x80
>   =A0ret_from_fork+0x35/0x40
>  =20
>   -----
>  =20
>   In guest, there are no other dmesg/journalctl entries other than
>   "task...blocked".
>  =20
>   On host, there are no dmesg/journalctl entries whatsoever.  Everything
>   else in host continues to work fine, including other QEMU VM's on the
>   same underlying SSD (but obviously different lvm volumes.)
>  =20
>   I understand there might not be enough to go on here, and I also
>   understand it's possible this isn't a QEMU bug.  Happy to run given
>   commands or patches to help diagnose what's going on here.
>  =20
>   I'm now running a custom compiled QEMU 4.1.0, with debug symbols, so I
>   can get a meaningful backtrace from the host point of view.
>  =20
>   I've only recently tried this level of I/O, so can't say if this is a
>   new issue.
>  =20
> + When writes are hanging, on host, I can connect to the monitor.  Running
> + "info block" shows nothing unusual.
> +=20
>   -----
>  =20
>   /usr/bin/qemu-system-x86_64
>   =A0=A0=A0-name arch,process=3Dqemu:arch
>   =A0=A0=A0-no-user-config
>   =A0=A0=A0-nodefaults
>   =A0=A0=A0-nographic
>   =A0=A0=A0-uuid 0528162b-2371-41d5-b8da-233fe61b6458
>   =A0=A0=A0-pidfile /tmp/0528162b-2371-41d5-b8da-233fe61b6458.pid
>   =A0=A0=A0-machine q35,accel=3Dkvm,vmport=3Doff,dump-guest-core=3Doff
>   =A0=A0=A0-cpu SandyBridge-IBRS
>   =A0=A0=A0-smp cpus=3D24,cores=3D12,threads=3D1,sockets=3D2
>   =A0=A0=A0-m 24G
>   =A0=A0=A0-drive if=3Dpflash,format=3Draw,readonly,file=3D/usr/share/ovm=
f/x64/OVMF_CODE.fd
>   =A0=A0=A0-drive if=3Dpflash,format=3Draw,readonly,file=3D/var/qemu/0528=
162b-2371-41d5-b8da-233fe61b6458.fd
>   =A0=A0=A0-monitor telnet:localhost:8000,server,nowait,nodelay
>   =A0=A0=A0-spice unix,addr=3D/tmp/0528162b-2371-41d5-b8da-233fe61b6458.s=
ock,disable-ticketing
>   =A0=A0=A0-device ioh3420,id=3Dpcie.1,bus=3Dpcie.0,slot=3D0
>   =A0=A0=A0-device virtio-vga,bus=3Dpcie.1,addr=3D0
>   =A0=A0=A0-usbdevice tablet
>   =A0=A0=A0-netdev bridge,id=3Dnetwork0,br=3Dbr0
>   =A0=A0=A0-device virtio-net-pci,netdev=3Dnetwork0,mac=3D02:37:de:79:19:=
09,bus=3Dpcie.0,addr=3D3
>   =A0=A0=A0-device virtio-scsi-pci,id=3Dscsi1
>   =A0=A0=A0-drive driver=3Draw,node-name=3Dhd0,file=3D/dev/lvm/arch_root,=
if=3Dnone,discard=3Dunmap
>   =A0=A0=A0-device scsi-hd,drive=3Dhd0,bootindex=3D1
>   =A0=A0=A0-drive driver=3Draw,node-name=3Dhd1,file=3D/dev/lvm/arch_nvme,=
if=3Dnone,discard=3Dunmap
>   =A0=A0=A0-device scsi-hd,drive=3Dhd1,bootindex=3D2

Please post backtrace of all QEMU threads when I/O is hung.  You can use
"gdb -p $(pidog qemu-system-x86_64)" to connect GDB and "thread apply
all bt" to produce a backtrace of all threads.

Stefan

--zaRBsRFn0XYhEU69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl16MRgACgkQnKSrs4Gr
c8gdDwf/cbJs5f9P7NlsqQJRotENMWFCBNSkwFAwuUyDzO/YI/54mEohh5JSRxpp
HGpFeI47sGYsG/PxOkVWF2gjE5ZdCZKCFGfo1dHJBQ8u/5mcu37dlzIz0JYZm3Zh
Kt9m0kYW+EIFvmAda9/g1/Ogtz12RBLNF+IVWrz/RLsFMIqZbFg1+LYbdrVrXWmz
BXypimXTr0Cwh1POul4dMVUzxRwJ0z5ctmYC80JmVCmuAOnKPgwWFT3W28rGKcWi
iuMNVjWKttxEoRHWWeso2l3RoUKrlhmBZXi5+0vPNKnk+h3U20zjlUACCktkwNje
iCPG1vOzpwW/ztqT5aWITox+MBdhLQ==
=eBnv
-----END PGP SIGNATURE-----

--zaRBsRFn0XYhEU69--


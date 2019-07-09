Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC28C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FBFB2082A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBFB2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hknyJ-00047m-RN
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 07:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39747)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hknwd-0003Cr-71
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hknwb-0007Bz-4b
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:05:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45198)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hknwa-0007A5-Pu
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:05:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AE09F883BA;
 Tue,  9 Jul 2019 11:05:53 +0000 (UTC)
Received: from work-vm (ovpn-117-75.ams2.redhat.com [10.36.117.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E2DA5C2EE;
 Tue,  9 Jul 2019 11:05:50 +0000 (UTC)
Date: Tue, 9 Jul 2019 12:05:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wolfgang Bumiller <w.bumiller@proxmox.com>
Message-ID: <20190709110545.GE2725@work-vm>
References: <20190627131252.GA14795@olga.proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627131252.GA14795@olga.proxmox.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 09 Jul 2019 11:05:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] balloon config change seems to break live
 migration from 3.0.1 to 4.0
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wolfgang Bumiller (w.bumiller@proxmox.com) wrote:
> While testing with 4.0 we've run into issues with live migration from
> 3.0.1 to 4.0 when a balloon device was involved.
> 
> We'd see the following error on the destination:
>   qemu-system-x86_64: get_pci_config_device: Bad config data: i=0x10 read: a1 device: 1 cmask: ff wmask: c0 w1cmask:0 
>   qemu-system-x86_64: Failed to load PCIDevice:config 
>   qemu-system-x86_64: Failed to load virtio-balloon:virtio 
>   qemu-system-x86_64: error while loading state for instance 0x0 of device '0000:00:03.0/virtio-balloon' 
>   qemu-system-x86_64: load of migration failed: Invalid argument
> 
> After looking through the commits I noticed that the pci config sent for
> the balloon device comes from
> include/standard-headers/linux/virtio_balloon.h and changed size between
> 3.1 and 4.0.
> As a "guess" I tried reverting that change (commented out the two last
> fields (and access to it in hw/virtio/virtio-balloon.c's
> virtio_balloon_get_config()), and then the migration seems to go through
> successfully.
> 
> I've since also rebuilt qemu without our patches (tags v3.0.1 and v4.0.0)
> and also tried with master (since dgilbert mentioned on irc remembering
> the issue and that there may have been a fix around), but got the same
> result.
> 
> Posting here now as dgilbert requested on irc.

Apologies for the delay, I was out last week.

Thanks for the command lines; I can confirm I can recreate it here using
a simplified version of your command line.

Dave

> Here are the commands used to start qemu:
>   Source:
>     /usr/bin/kvm \
>       -name randomclone \
>       -chardev 'socket,id=qmp,path=/var/run/qemu-server/101.qmp,server,nowait' \
>       -mon 'chardev=qmp,mode=control' \
>       -chardev 'socket,id=qmp-event,path=/var/run/qmeventd.sock,reconnect=5' \
>       -mon 'chardev=qmp-event,mode=control' \
>       -pidfile /var/run/qemu-server/101.pid \
>       -daemonize \
>       -smbios 'type=1,uuid=f3ab31f6-ca7d-469c-bf51-547fd9bbd2d9' \
>       -smp '4,sockets=1,cores=4,maxcpus=4' \
>       -nodefaults \
>       -boot 'menu=on,strict=on,reboot-timeout=1000,splash=/usr/share/qemu-server/bootsplash.jpg' \
>       -vnc unix:/var/run/qemu-server/101.vnc,password \
>       -cpu host,+pcid,+spec-ctrl,+ssbd,+pdpe1gb,+kvm_pv_unhalt,+kvm_pv_eoi \
>       -m 4096 \
>       -device 'pci-bridge,id=pci.2,chassis_nr=2,bus=pci.0,addr=0x1f' \
>       -device 'pci-bridge,id=pci.1,chassis_nr=1,bus=pci.0,addr=0x1e' \
>       -device 'vmgenid,guid=fb282779-7056-4f1d-96bb-70f578294e45' \
>       -device 'piix3-usb-uhci,id=uhci,bus=pci.0,addr=0x1.0x2' \
>       -device 'usb-tablet,id=tablet,bus=uhci.0,port=1' \
>       -device 'VGA,id=vga,bus=pci.0,addr=0x2' \
>       -device 'virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x3' \
>       -iscsi 'initiator-name=iqn.1993-08.org.debian:01:856d32b504d' \
>       -drive 'if=none,id=drive-ide2,media=cdrom,aio=threads' \
>       -device 'ide-cd,bus=ide.1,unit=0,drive=drive-ide2,id=ide2,bootindex=200' \
>       -device 'virtio-scsi-pci,id=scsihw0,bus=pci.0,addr=0x5' \
>       -drive 'file=rbd:rbd/vm-101-disk-0:conf=/etc/pve/ceph.conf:id=admin:keyring=/etc/pve/priv/ceph/rbd.keyring,if=none,id=drive-scsi0,discard=on,format=raw,cache=none,aio=native,detect-zeroes=unmap' \
>       -device 'scsi-hd,bus=scsihw0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0,id=scsi0,rotation_rate=1,bootindex=100' \
>       -netdev 'type=tap,id=net0,ifname=tap101i0,script=/var/lib/qemu-server/pve-bridge,downscript=/var/lib/qemu-server/pve-bridgedown,vhost=on' \
>       -device 'virtio-net-pci,mac=4E:5D:50:75:4D:ED,netdev=net0,bus=pci.0,addr=0x12,id=net0,bootindex=300' \
>       -machine 'type=pc' \
>       -enable-kvm
> 
>   Destination:
>     /usr/bin/kvm \
>       -name randomclone \
>       -chardev socket,id=qmp,path=/var/run/qemu-server/101.qmp,server,nowait \
>       -mon chardev=qmp,mode=control \
>       -chardev socket,id=qmp-event,path=/var/run/qmeventd.sock,reconnect=5 \
>       -mon chardev=qmp-event,mode=control \
>       -pidfile /var/run/qemu-server/101.pid \
>       -smbios type=1,uuid=f3ab31f6-ca7d-469c-bf51-547fd9bbd2d9 \
>       -smp 4,sockets=1,cores=4,maxcpus=4 \
>       -nodefaults \
>       -boot menu=on,strict=on,reboot-timeout=1000,splash=/usr/share/qemu-server/bootsplash.jpg \
>       -vnc unix:/var/run/qemu-server/101.vnc,password \
>       -cpu host,+pcid,+spec-ctrl,+ssbd,+pdpe1gb,+kvm_pv_unhalt,+kvm_pv_eoi \
>       -m 4096 \
>       -device pci-bridge,id=pci.1,chassis_nr=1,bus=pci.0,addr=0x1e \
>       -device pci-bridge,id=pci.2,chassis_nr=2,bus=pci.0,addr=0x1f \
>       -device vmgenid,guid=fb282779-7056-4f1d-96bb-70f578294e45 \
>       -device piix3-usb-uhci,id=uhci,bus=pci.0,addr=0x1.0x2 \
>       -device usb-tablet,id=tablet,bus=uhci.0,port=1 \
>       -device VGA,id=vga,bus=pci.0,addr=0x2 \
>       -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x3 \
>       -iscsi initiator-name=iqn.1993-08.org.debian:01:ee4e4a566b \
>       -drive if=none,id=drive-ide2,media=cdrom,aio=threads \
>       -device ide-cd,bus=ide.1,unit=0,drive=drive-ide2,id=ide2,bootindex=200 \
>       -device virtio-scsi-pci,id=scsihw0,bus=pci.0,addr=0x5 \
>       -drive file=rbd:rbd/vm-101-disk-0:conf=/etc/pve/ceph.conf:id=admin:keyring=/etc/pve/priv/ceph/rbd.keyring,if=none,id=drive-scsi0,discard=on,format=raw,cache=none,aio=native,detect-zeroes=unmap \
>       -device scsi-hd,bus=scsihw0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0,id=scsi0,rotation_rate=1,bootindex=100 \
>       -netdev type=tap,id=net0,ifname=tap101i0,script=/var/lib/qemu-server/pve-bridge,downscript=/var/lib/qemu-server/pve-bridgedown,vhost=on \
>       -device virtio-net-pci,mac=4E:5D:50:75:4D:ED,netdev=net0,bus=pci.0,addr=0x12,id=net0,bootindex=300 \
>       -machine type=pc-i440fx-3.0 \
>       -enable-kvm \
>       -incoming tcp:10.9.2.106:9989 \
>       -S
> 
> This is the exact test-change I made which seems to work around it, but
> a proper fix would be nicer. Not sure how, though.
> 
> ---8<---
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index d96e4aa96f..8d631d67a8 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -623,16 +623,16 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>      config.num_pages = cpu_to_le32(dev->num_pages);
>      config.actual = cpu_to_le32(dev->actual);
>  
> -    if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED) {
> -        config.free_page_report_cmd_id =
> -                       cpu_to_le32(dev->free_page_report_cmd_id);
> -    } else if (dev->free_page_report_status == FREE_PAGE_REPORT_S_STOP) {
> -        config.free_page_report_cmd_id =
> -                       cpu_to_le32(VIRTIO_BALLOON_CMD_ID_STOP);
> -    } else if (dev->free_page_report_status == FREE_PAGE_REPORT_S_DONE) {
> -        config.free_page_report_cmd_id =
> -                       cpu_to_le32(VIRTIO_BALLOON_CMD_ID_DONE);
> -    }
> +    //if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED) {
> +    //    config.free_page_report_cmd_id =
> +    //                   cpu_to_le32(dev->free_page_report_cmd_id);
> +    //} else if (dev->free_page_report_status == FREE_PAGE_REPORT_S_STOP) {
> +    //    config.free_page_report_cmd_id =
> +    //                   cpu_to_le32(VIRTIO_BALLOON_CMD_ID_STOP);
> +    //} else if (dev->free_page_report_status == FREE_PAGE_REPORT_S_DONE) {
> +    //    config.free_page_report_cmd_id =
> +    //                   cpu_to_le32(VIRTIO_BALLOON_CMD_ID_DONE);
> +    //}
>  
>      trace_virtio_balloon_get_config(config.num_pages, config.actual);
>      memcpy(config_data, &config, sizeof(struct virtio_balloon_config));
> diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
> index 9375ca2a70..86aca75972 100644
> --- a/include/standard-headers/linux/virtio_balloon.h
> +++ b/include/standard-headers/linux/virtio_balloon.h
> @@ -48,9 +48,9 @@ struct virtio_balloon_config {
>  	/* Number of pages we've actually got in balloon. */
>  	uint32_t actual;
>  	/* Free page report command id, readonly by guest */
> -	uint32_t free_page_report_cmd_id;
> -	/* Stores PAGE_POISON if page poisoning is in use */
> -	uint32_t poison_val;
> +	//uint32_t free_page_report_cmd_id;
> +	///* Stores PAGE_POISON if page poisoning is in use */
> +	//uint32_t poison_val;
>  };
>  
>  #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


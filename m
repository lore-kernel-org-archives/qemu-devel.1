Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B2CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9614207F5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9614207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeIMJ-0006Yl-3n
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 09:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <piaojun@huawei.com>)
 id 1jeILD-0005v8-Fl
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:12:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35274 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <piaojun@huawei.com>)
 id 1jeIL8-0000nY-PC
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:12:58 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 3F7CA3DA090C1B1B3566
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 21:12:42 +0800 (CST)
Received: from [10.174.149.79] (10.174.149.79) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 28 May
 2020 21:12:37 +0800
Subject: Re: [QUESTION]: vhost-user-gpu: Unable to find a satisfying
 vhost-user-gpu
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <f176ccff-4988-8ba0-e3db-d859cde0db20@huawei.com>
 <CAJ+F1CKS1EBuQTWqAhhiGLC0=9N_DxWXhcm6ZjHw2U2wham+SA@mail.gmail.com>
From: Jun Piao <piaojun@huawei.com>
Message-ID: <3bc20cdd-84f2-01a2-7e07-1c3c8eac0d72@huawei.com>
Date: Thu, 28 May 2020 21:12:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKS1EBuQTWqAhhiGLC0=9N_DxWXhcm6ZjHw2U2wham+SA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.149.79]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=piaojun@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 09:12:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



在 2020/5/27 20:29, Marc-André Lureau 写道:
> Hi
> 
> On Wed, May 27, 2020 at 11:18 AM Jun Piao <piaojun@huawei.com <mailto:piaojun@huawei.com>> wrote:
> 
>     Hi Marc-André,
> 
>     I encounter a problem when trying to use vhost-user-gpu as below. And
>     I'm not familiar to the libvirt code. Could you please help find out
>     the reason?
> 
>     # virsh create snap1.xml
>     error: Failed to create domain from snap1.xml
>     error: operation failed: Unable to find a satisfying vhost-user-gpu
> 
> 
> Libvirt implements the logic described in: https://git.qemu.org/?p=qemu.git;a=blob;f=docs/interop/vhost-user.json;h=ef8ac5941f5c8d14402566a984a0a0876d768c19;hb=HEAD#l171
> 
> Check if you have  /usr/share/qemu/vhost-user/50-qemu-gpu.json and if the binary location is correct.
> 
> If it fails after that, enable libvirt debugging for more details.
> 

Thanks for your reply, and I did as you said, but another error happend:

50-qemu-gpu.json:
{
  "description": "QEMU vhost-user-gpu",
  "type": "gpu",
  "binary": "/usr/local/libexec/vhost-user-gpu"
}

# virsh create /home/vm/snap1.xml
error: Failed to create domain from /home/vm/snap1.xml
error: internal error: Could not get process id of vhost-user-gpu

libvirt log:
----------------------------------------------------------------------
2020-05-28 13:10:48.345+0000: Starting external device: vhost-user-gpu
/usr/local/libexec/vhost-user-gpu
2020-05-28 13:10:48.374+0000: starting up libvirt version: 5.8.0, qemu version: 4.1.1, kernel: 4.18.0, hostname: localhost.localdomain
LC_ALL=C \
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin \
HOME=/var/lib/libvirt/qemu/domain-1-snap1 \
XDG_DATA_HOME=/var/lib/libvirt/qemu/domain-1-snap1/.local/share \
XDG_CACHE_HOME=/var/lib/libvirt/qemu/domain-1-snap1/.cache \
XDG_CONFIG_HOME=/var/lib/libvirt/qemu/domain-1-snap1/.config \
QEMU_AUDIO_DRV=spice \
/home/code/qemu-4.1.1/aarch64-softmmu/qemu-system-aarch64 \
-name guest=snap1,debug-threads=on \
-S \
-object secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-1-snap1/master-key.aes \
-machine virt-2.8,accel=kvm,usb=off,dump-guest-core=off,gic-version=3 \
-cpu host \
-drive file=/usr/share/edk2.git/aarch64/QEMU_EFI-pflash.raw,if=pflash,format=raw,unit=0,readonly=on \
-drive file=/var/lib/libvirt/qemu/nvram/euler_VARS.fd,if=pflash,format=raw,unit=1 \
-m 4096 \
-overcommit mem-lock=off \
-smp 4,sockets=4,cores=1,threads=1 \
-uuid 3eb97356-8642-4282-88de-8de0a36d3bc1 \
-smbios 'type=1,manufacturer=OpenStack Foundation,product=OpenStack Nova,version=13.0.1-517.11,family=Virtual Machine' \
-smbios 'type=3,manufacturer=Dell Inc.,version=2.12,serial=65X0XF2,asset=40000101,sku=Type3Sku1' \
-no-user-config \
-nodefaults \
-chardev socket,id=charmonitor,fd=34,server,nowait \
-mon chardev=charmonitor,id=monitor,mode=control \
-rtc base=2020-05-29T01:10:48,clock=vm,driftfix=slew \
-no-shutdown \
-no-acpi \
-boot strict=on \
-device pcie-root-port,port=0x8,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x1 \
-device pcie-pci-bridge,id=pci.2,bus=pci.1,addr=0x0 \
-device pcie-root-port,port=0x9,chassis=3,id=pci.3,bus=pcie.0,addr=0x1.0x1 \
-device pcie-root-port,port=0xa,chassis=4,id=pci.4,bus=pcie.0,addr=0x1.0x2 \
-device pcie-root-port,port=0xb,chassis=5,id=pci.5,bus=pcie.0,addr=0x1.0x3 \
-device usb-ehci,id=usb,bus=pci.2,addr=0x3 \
-device virtio-scsi-pci,id=scsi0,bus=pci.4,addr=0x0 \
-device ahci,id=sata0,bus=pci.2,addr=0x2 \
-device virtio-serial-pci,id=virtio-serial0,bus=pci.2,addr=0x4 \
-drive file=/home/vm/snap1.img,format=qcow2,if=none,id=drive-scsi0-0-0-0,cache=none,aio=native \
-device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,device_id=drive-scsi0-0-0-0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0,bootindex=1,write-cache=on \
-netdev tap,fd=37,id=hostnet0,vhost=on,vhostfd=40 \
-device virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:69:17:b1,bus=pci.5,addr=0x0 \
-chardev pty,id=charserial0 \
-serial chardev:charserial0 \
-device usb-tablet,id=input0,bus=usb.0,port=1 \
-device usb-kbd,id=input1,bus=usb.0,port=2 \
-spice unix,addr=/tmp/spice.socket1,disable-ticketing,gl=on,rendernode=/dev/dri/renderD128,seamless-migration=on \
-chardev socket,id=chr-vu-video0,fd=36 \
-device vhost-user-gpu-pci,id=video0,max_outputs=1,chardev=chr-vu-video0,bus=pci.3,addr=0x0 \
-device virtio-balloon-pci,id=balloon0,bus=pci.2,addr=0x5 \
-msg timestamp=on
2020-05-28 13:10:48.374+0000: Domain id=1 is tainted: host-cpu
libvirt:  error : libvirtd quit during handshake: Input/output error
2020-05-28 13:10:48.389+0000: shutting down, reason=failed

thanks,
Jun


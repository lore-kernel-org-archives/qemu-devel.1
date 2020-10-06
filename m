Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD99C47095
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D24206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElLesKrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D24206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPrDN-00082R-Uy
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 13:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prasadalok77@gmail.com>)
 id 1kPrCK-0007Fm-I2
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 13:56:24 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:39734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <prasadalok77@gmail.com>)
 id 1kPrCH-0001ib-76
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 13:56:24 -0400
Received: by mail-io1-xd43.google.com with SMTP id q9so548575iow.6
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 10:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=ZBth6tHOmiZ5t58IWd4Hvgj3sFlZ+bmlbYTR/T0jx4E=;
 b=ElLesKrxyhs/zBrg7jKMNx/Xy5WcNyjEdUIrQJMiXSctlN+GKkNHB5tTKegA2+6gIO
 AnM786XNAxQDwsf3NHXOjXNGG0mOUeempwLJzVP54ZjHgzt+vOIW62uRcxih2O+gbnm9
 2aJ3DsMT2nHeOSm396D3PTGSxOTCBs1m7Ars9u2iqEK+tVUlEwAqUerfpjGhLT4Eua2w
 fjhfX0ml8tNZwZL88Nk6nOhXbTIWn6J9aSaMqmjNq6IuwqLlVs0FrBl8GxZJ0F5E9do/
 glJyuq8zjZBaregKADFm5Wb1Tyqafw3uJghg9VOnIeVlMeY98yNItGjCTCB3Dm3OVJCn
 LVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=ZBth6tHOmiZ5t58IWd4Hvgj3sFlZ+bmlbYTR/T0jx4E=;
 b=DDfvSYl2LmuEQRINSvvy/N911/ije/7q0kV9qVA/3lFM5mUSr9pAoE3tY+TP7tHZHG
 uo0S5QNVr0GG33DEEqLn+D00DBMApZ6XqTPMYn+5kcpJMPZqmMZYg794m2xsFxcbWGqd
 zviHApvpJEfKBB6tcQRe80Uv/QqUmW6gIC9q8sOCsKMDvrQ7dRHbqjd/VJkKZg2uNmA+
 igoT2qWhKeiLz/bIX0FodwJK6wReEewNhMkrRWrQLH7XF9Ye1UonCpDmgP72J6Ok+Ikf
 938YhL6eWPeajcwc1lYgljnpsXG7K3mVhws78inCMu3DYor51tT2MxmHuluf+9EC1yNO
 M5Iw==
X-Gm-Message-State: AOAM531VJEFe70XjMLgAnnw4RINNgeSJj176BvJrKKQBoTOia6N/XIU2
 jTB0m4xtPuoHxs+XmOvlucUim5RVGkoAy8750HqdPmf70mPelg==
X-Google-Smtp-Source: ABdhPJzz5kqHdv44PkH2wrWp4kBnXor8SZ+QJChP7Nzw1bNI5caq8eyX/PsvcsmnrrjBAAGvg0Ihx3R0EdzsMQUTN9k=
X-Received: by 2002:a02:b187:: with SMTP id t7mr2465186jah.18.1602006979486;
 Tue, 06 Oct 2020 10:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJPzGv1Vd1V2a_7n2GW4RBUDgpsdyAH-8NMvW+368gigtYWd0g@mail.gmail.com>
In-Reply-To: <CAJPzGv1Vd1V2a_7n2GW4RBUDgpsdyAH-8NMvW+368gigtYWd0g@mail.gmail.com>
From: Alok Prasad <prasadalok77@gmail.com>
Date: Tue, 6 Oct 2020 23:26:08 +0530
Message-ID: <CAJPzGv0bFatmLJ_dy83KgZbyMS5zM0_pAqTynkSAHXNUST_JHg@mail.gmail.com>
Subject: Fwd: Enable IOMMU Inside QEMU
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f0a7bd05b10450fb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=prasadalok77@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 NUMERIC_HTTP_ADDR=1.242, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f0a7bd05b10450fb
Content-Type: text/plain; charset="UTF-8"

How Can i i enable vIOMMU inside QEMU
Have run the qemu with below parameters.

root@beta-hp-p70:/home/fastlinq/alok/KVM-VM# ps -ef | grep qemu
root     20347     1  2 06:06 ?        00:00:36 /usr/bin/qemu-system-x86_64
-name guest=centos7_8_vm,debug-threads=on -S -object
secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-15-centos7_8_vm/master-key.aes
-machine
pc-q35-4.2,accel=kvm,usb=off,dump-guest-core=off,kernel_irqchip=split -cpu
SandyBridge,vmx=on -m 4096 -realtime mlock=off -smp
1,sockets=1,cores=1,threads=1 -uuid f8ee6a5e-6253-453c-8304-7eca50fa7b94
-no-user-config -nodefaults -chardev
socket,id=charmonitor,path=/var/lib/libvirt/qemu/domain-15-centos7_8_vm/monitor.sock,server,nowait
-mon chardev=charmonitor,id=monitor,mode=control -rtc base=utc -no-shutdown
-no-acpi -boot strict=on -device intel-iommu,intremap=on,caching-mode=on
-device
pcie-root-port,port=0x10,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x2
-device pcie-root-port,port=0x11,chassis=2,id=pci.2,bus=pcie.0,addr=0x2.0x1
-device pcie-root-port,port=0x12,chassis=3,id=pci.3,bus=pcie.0,addr=0x2.0x2
-device pcie-root-port,port=0x13,chassis=4,id=pci.4,bus=pcie.0,addr=0x2.0x3
-device pcie-root-port,port=0x14,chassis=5,id=pci.5,bus=pcie.0,addr=0x2.0x4
-device pcie-root-port,port=0x15,chassis=6,id=pci.6,bus=pcie.0,addr=0x2.0x5
-device pcie-root-port,port=0x16,chassis=7,id=pci.7,bus=pcie.0,addr=0x2.0x6
-device pcie-root-port,port=0x17,chassis=8,id=pci.8,bus=pcie.0,addr=0x2.0x7
-device qemu-xhci,id=usb,bus=pci.5,addr=0x0 -device
virtio-serial-pci,id=virtio-serial0,bus=pci.3,addr=0x0 -drive
file=/home/fastlinq/centos-7.8.qcow2,format=qcow2,if=none,id=drive-virtio-disk0
-device
virtio-blk-pci,scsi=off,bus=pci.4,addr=0x0,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1
-drive
file=/home/fastlinq/dev.img,format=raw,if=none,id=drive-virtio-disk2,cache=none,aio=native
-device
virtio-blk-pci,scsi=off,bus=pci.8,addr=0x0,drive=drive-virtio-disk2,id=virtio-disk2
-netdev tap,fd=26,id=hostnet0 -device
rtl8139,netdev=hostnet0,id=net0,mac=52:54:00:b8:d3:f8,bus=pci.2,addr=0x0
-chardev pty,id=charserial0 -device
isa-serial,chardev=charserial0,id=serial0 -vnc 127.0.0.1:0 -device
cirrus-vga,id=video0,bus=pcie.0,addr=0x1 -device
virtio-balloon-pci,id=balloon0,bus=pci.6,addr=0x0 -msg timestamp=on

XML of the same ( ony relevant part)
  <resource>
    <partition>/machine</partition>
  </resource>
  <os>
    <type arch='x86_64' machine='pc-q35-4.2'>hvm</type>
    <boot dev='hd'/>
  </os>
  <features>
    <kvm>
      <hidden state='off'/>
    </kvm>
    <ioapic driver='qemu'/>
  </features>
  <cpu mode='custom' match='exact' check='partial'>
    <model fallback='allow'>SandyBridge</model>
    <feature policy='require' name='vmx'/>
  </cpu>
...
....
 <iommu model='intel'>
      <driver intremap='on' caching_mode='on'/>
    </iommu>

and in Guest VM

[root@centos-8 ~]# dmesg | grep DMAR
[    0.000000] DMAR: IOMMU enabled

[root@centos-8 ~]# cat /proc/cmdline
BOOT_IMAGE=(hd0,gpt2)/vmlinuz-4.18.0-193.6.3.el8_2.x86_64
root=UUID=4fd120e4-1f6d-46b3-a404-5569ef6af1f9 ro console=tty0
rd_NO_PLYMOUTH crashkernel=auto
resume=UUID=40f14688-2619-4046-a9eb-b7333fff1b84 console=ttyS0,115200
intel_iommu=on

I don't see other Prints related to IOMMU which seems that its not present
in guest VM. " DMAR: IOMMU enabled " just means its enabled in kernel
paramter.

ideally i should see some other prints e.g below

dmesg | grep -e DMAR -e IOMMU
[ 0.000000] ACPI: DMAR 0x000000003E86C000 000048 (v01 BOCHS BXPCDMAR
00000001
BXPC 00000001)
[ 0.000000] DMAR: IOMMU enabled ---> only shows that its enabled in OS/GRUB
[ 0.145746] DMAR: Host address width 39
[ 0.145747] DMAR: DRHD base: 0x000000fed90000 flags: 0x1
[ 0.145769] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 12008c22260286
ecap
f00f5a
[ 0.145776] DMAR: No RMRR found
[ 0.145776] DMAR: No ATSR found
[ 0.145825] DMAR: dmar0: Using Queued invalidation
[ 0.218192] DMAR: Setting RMRR:
[ 0.218193] DMAR: Prepare 0-16MiB unity mapping for LPC
[ 0.219038] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 -
0xffffff]
[ 0.257194] DMAR: Intel(R) Virtualization Technology for Directed I/O

root@beta-hp-p70:/home/fastlinq/alok/KVM-VM# /usr/bin/qemu-system-x86_64
--version
QEMU emulator version 4.2.1
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers



I am missing here something,? Is there seperate Branch for the same in qemu.

Thanks,
Alok

--000000000000f0a7bd05b10450fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">How Can i i enable vIOMMU inside QEMU<br></div><div dir=3D"=
ltr"><div>Have run the qemu with below parameters.</div><div><br><div>root@=
beta-hp-p70:/home/fastlinq/alok/KVM-VM# ps -ef | grep qemu<br>root =C2=A0 =
=C2=A0 20347 =C2=A0 =C2=A0 1 =C2=A02 06:06 ? =C2=A0 =C2=A0 =C2=A0 =C2=A000:=
00:36 /usr/bin/qemu-system-x86_64 -name guest=3Dcentos7_8_vm,debug-threads=
=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvir=
t/qemu/domain-15-centos7_8_vm/master-key.aes -machine pc-q35-4.2,accel=3Dkv=
m,usb=3Doff,dump-guest-core=3Doff,kernel_irqchip=3Dsplit -cpu SandyBridge,v=
mx=3Don -m 4096 -realtime mlock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=
=3D1 -uuid f8ee6a5e-6253-453c-8304-7eca50fa7b94 -no-user-config -nodefaults=
 -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-15-ce=
ntos7_8_vm/monitor.sock,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonit=
or,mode=3Dcontrol -rtc base=3Dutc -no-shutdown -no-acpi -boot strict=3Don -=
device intel-iommu,intremap=3Don,caching-mode=3Don -device pcie-root-port,p=
ort=3D0x10,chassis=3D1,id=3Dpci.1,bus=3Dpcie.0,multifunction=3Don,addr=3D0x=
2 -device pcie-root-port,port=3D0x11,chassis=3D2,id=3Dpci.2,bus=3Dpcie.0,ad=
dr=3D0x2.0x1 -device pcie-root-port,port=3D0x12,chassis=3D3,id=3Dpci.3,bus=
=3Dpcie.0,addr=3D0x2.0x2 -device pcie-root-port,port=3D0x13,chassis=3D4,id=
=3Dpci.4,bus=3Dpcie.0,addr=3D0x2.0x3 -device pcie-root-port,port=3D0x14,cha=
ssis=3D5,id=3Dpci.5,bus=3Dpcie.0,addr=3D0x2.0x4 -device pcie-root-port,port=
=3D0x15,chassis=3D6,id=3Dpci.6,bus=3Dpcie.0,addr=3D0x2.0x5 -device pcie-roo=
t-port,port=3D0x16,chassis=3D7,id=3Dpci.7,bus=3Dpcie.0,addr=3D0x2.0x6 -devi=
ce pcie-root-port,port=3D0x17,chassis=3D8,id=3Dpci.8,bus=3Dpcie.0,addr=3D0x=
2.0x7 -device qemu-xhci,id=3Dusb,bus=3Dpci.5,addr=3D0x0 -device virtio-seri=
al-pci,id=3Dvirtio-serial0,bus=3Dpci.3,addr=3D0x0 -drive file=3D/home/fastl=
inq/centos-7.8.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk0 -devi=
ce virtio-blk-pci,scsi=3Doff,bus=3Dpci.4,addr=3D0x0,drive=3Ddrive-virtio-di=
sk0,id=3Dvirtio-disk0,bootindex=3D1 -drive file=3D/home/fastlinq/dev.img,fo=
rmat=3Draw,if=3Dnone,id=3Ddrive-virtio-disk2,cache=3Dnone,aio=3Dnative -dev=
ice virtio-blk-pci,scsi=3Doff,bus=3Dpci.8,addr=3D0x0,drive=3Ddrive-virtio-d=
isk2,id=3Dvirtio-disk2 -netdev tap,fd=3D26,id=3Dhostnet0 -device rtl8139,ne=
tdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:b8:d3:f8,bus=3Dpci.2,addr=3D0x0 -c=
hardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharserial0,id=3Ds=
erial0 -vnc <a href=3D"http://127.0.0.1:0" target=3D"_blank">127.0.0.1:0</a=
> -device cirrus-vga,id=3Dvideo0,bus=3Dpcie.0,addr=3D0x1 -device virtio-bal=
loon-pci,id=3Dballoon0,bus=3Dpci.6,addr=3D0x0 -msg timestamp=3Don<br></div>=
</div><div><br></div><div>XML of the same ( ony relevant part)</div><div>=
=C2=A0 &lt;resource&gt;<br>=C2=A0 =C2=A0 &lt;partition&gt;/machine&lt;/part=
ition&gt;<br>=C2=A0 &lt;/resource&gt;<br>=C2=A0 &lt;os&gt;<br>=C2=A0 =C2=A0=
 &lt;type arch=3D&#39;x86_64&#39; machine=3D&#39;pc-q35-4.2&#39;&gt;hvm&lt;=
/type&gt;<br>=C2=A0 =C2=A0 &lt;boot dev=3D&#39;hd&#39;/&gt;<br>=C2=A0 &lt;/=
os&gt;<br>=C2=A0 &lt;features&gt;<br>=C2=A0 =C2=A0 &lt;kvm&gt;<br>=C2=A0 =
=C2=A0 =C2=A0 &lt;hidden state=3D&#39;off&#39;/&gt;<br>=C2=A0 =C2=A0 &lt;/k=
vm&gt;<br>=C2=A0 =C2=A0 &lt;ioapic driver=3D&#39;qemu&#39;/&gt;<br>=C2=A0 &=
lt;/features&gt;<br>=C2=A0 &lt;cpu mode=3D&#39;custom&#39; match=3D&#39;exa=
ct&#39; check=3D&#39;partial&#39;&gt;<br>=C2=A0 =C2=A0 &lt;model fallback=
=3D&#39;allow&#39;&gt;SandyBridge&lt;/model&gt;<br>=C2=A0 =C2=A0 &lt;featur=
e policy=3D&#39;require&#39; name=3D&#39;vmx&#39;/&gt;<br>=C2=A0 &lt;/cpu&g=
t;<br></div><div>...</div><div>....</div><div>=C2=A0&lt;iommu model=3D&#39;=
intel&#39;&gt;<br>=C2=A0 =C2=A0 =C2=A0 &lt;driver intremap=3D&#39;on&#39; c=
aching_mode=3D&#39;on&#39;/&gt;<br>=C2=A0 =C2=A0 &lt;/iommu&gt;<br></div><d=
iv><br></div><div>and in Guest VM=C2=A0</div><div><br></div><div>[root@cent=
os-8 ~]# dmesg | grep DMAR<br>[ =C2=A0 =C2=A00.000000] DMAR: IOMMU enabled<=
br><br></div><div>[root@centos-8 ~]# cat /proc/cmdline<br>BOOT_IMAGE=3D(hd0=
,gpt2)/vmlinuz-4.18.0-193.6.3.el8_2.x86_64 root=3DUUID=3D4fd120e4-1f6d-46b3=
-a404-5569ef6af1f9 ro console=3Dtty0 rd_NO_PLYMOUTH crashkernel=3Dauto resu=
me=3DUUID=3D40f14688-2619-4046-a9eb-b7333fff1b84 console=3DttyS0,115200 int=
el_iommu=3Don<br></div><div><br></div><div>I don&#39;t see other Prints rel=
ated to IOMMU which seems that its not present in guest VM. &quot;

DMAR: IOMMU enabled &quot; just means its enabled in kernel paramter.<br></=
div><div><br></div><div>ideally i should see some other prints e.g below=C2=
=A0</div><div><br></div><div>dmesg | grep -e DMAR -e IOMMU<br>[ 0.000000] A=
CPI: DMAR 0x000000003E86C000 000048 (v01 BOCHS BXPCDMAR 00000001<br>BXPC 00=
000001)<br>[ 0.000000] DMAR: IOMMU enabled ---&gt; only shows that its enab=
led in OS/GRUB<br>[ 0.145746] DMAR: Host address width 39<br>[ 0.145747] DM=
AR: DRHD base: 0x000000fed90000 flags: 0x1<br>[ 0.145769] DMAR: dmar0: reg_=
base_addr fed90000 ver 1:0 cap 12008c22260286 ecap<br>f00f5a<br>[ 0.145776]=
 DMAR: No RMRR found<br>[ 0.145776] DMAR: No ATSR found<br>[ 0.145825] DMAR=
: dmar0: Using Queued invalidation<br>[ 0.218192] DMAR: Setting RMRR:<br>[ =
0.218193] DMAR: Prepare 0-16MiB unity mapping for LPC<br>[ 0.219038] DMAR: =
Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]<br>[ 0.257194=
] DMAR: Intel(R) Virtualization Technology for Directed I/O<br></div><div><=
br></div><div>root@beta-hp-p70:/home/fastlinq/alok/KVM-VM# /usr/bin/qemu-sy=
stem-x86_64 --version<br>QEMU emulator version 4.2.1<br>Copyright (c) 2003-=
2019 Fabrice Bellard and the QEMU Project developers<br></div><div><br></di=
v><div><br></div><div><div><br></div><div>I am missing here something,? Is =
there seperate Branch for the same in qemu.</div></div><div><br></div><div>=
Thanks,</div><div>Alok</div><div><br></div></div>
</div></div>

--000000000000f0a7bd05b10450fb--


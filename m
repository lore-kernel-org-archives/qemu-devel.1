Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23656C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4CB20758
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDP42Bsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4CB20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOFbu-0008BQ-SB
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 03:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kOFb6-0007ZW-Cf
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kOFb2-0003WD-F3
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601624111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fnU+IOGvc3pSPHiHxqEALo+mCsruplku0v8NMmQL9Bw=;
 b=FDP42Bsley6zbOlXGrqHT7/br9APqSsLBKNAIZJehjR7079l2++lXiT2m7Zrd+/K3TOG56
 34gF9rpwOFzzWH+9HLDQvfpafTw2Qu1WF7E0glXiC2as7CHwZTc/nXX9oEluegFG7g9YxW
 /tdWOGRi26bKboiCpSYW+K3B3Pj9y1Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-ATImYo9TPX6e7c7Or8UOPQ-1; Fri, 02 Oct 2020 03:35:02 -0400
X-MC-Unique: ATImYo9TPX6e7c7Or8UOPQ-1
Received: by mail-wr1-f69.google.com with SMTP id d13so220476wrr.23
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 00:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fnU+IOGvc3pSPHiHxqEALo+mCsruplku0v8NMmQL9Bw=;
 b=opUyAzFVpCLDLmEQ1o/zg5lePbQ5Kda3pZ2JbBZpul2DbjORZXxbiQW+LSsTYDRuR3
 eNPBzShmG8EP2+UJ0KCkPdalbuEv05T8ZHYJ5yILKLhuKdc/dUa/9+avyaB9W0WWd2Q/
 qEmtfMNP3Oquo4ZkAd7cgynBalUgw0Z7JH5/a4D2F108jAjIMJH8z8S4PVh1ixixq/Tf
 48bvBSqIT1+sBhnSMP3Kg1raIKr03vMXujSTTcpU+mh3hf5bDspSQoJoU2HAWgwnl3gm
 j4vd2uryzWlmiLK1bfo9Nk9pP//nOdVyWaVhJn3CSIhVj+1Gr44LcEgSirvnQsNQ0h1Z
 YjaA==
X-Gm-Message-State: AOAM532xbp1GQgHzNAHvWBReTrITGqw40T3BL07RoDLs5OtmxrOdj1YV
 BTMD1rXO1O6ZvbH+O80qOaYoBE1jDl3MRkhAziD6DqFN8pYttprkezSzaOLMLWyvtk7iurt21Pa
 fs31ZesiiZ5lkwK8=
X-Received: by 2002:a05:600c:22c5:: with SMTP id
 5mr1315259wmg.34.1601624100628; 
 Fri, 02 Oct 2020 00:35:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzMBKKBBNkc0ohKpB95hgvY5gE8aBYAF+r4Fhl+DemnPV0/O9rE+hfuyYIV6r+RX1doafvxA==
X-Received: by 2002:a05:600c:22c5:: with SMTP id
 5mr1315242wmg.34.1601624100328; 
 Fri, 02 Oct 2020 00:35:00 -0700 (PDT)
Received: from steredhat (host-79-27-201-176.retail.telecomitalia.it.
 [79.27.201.176])
 by smtp.gmail.com with ESMTPSA id m10sm795455wmc.9.2020.10.02.00.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 00:34:59 -0700 (PDT)
Date: Fri, 2 Oct 2020 09:34:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: io_uring possibly the culprit for qemu hang (linux-5.4.y)
Message-ID: <20201002073457.jzkmefo5c65zlka7@steredhat>
References: <CAD14+f3G2f4QEK+AQaEjAG4syUOK-9bDagXa8D=RxdFWdoi5fQ@mail.gmail.com>
 <20201001085900.ms5ix2zyoid7v3ra@steredhat>
 <CAD14+f1m8Xk-VC1nyMh-X4BfWJgObb74_nExhO0VO3ezh_G2jA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD14+f1m8Xk-VC1nyMh-X4BfWJgObb74_nExhO0VO3ezh_G2jA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Ju,

On Thu, Oct 01, 2020 at 11:30:14PM +0900, Ju Hyung Park wrote:
> Hi Stefano,
> 
> On Thu, Oct 1, 2020 at 5:59 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > Please, can you share the qemu command line that you are using?
> > This can be useful for the analysis.
> 
> Sure.

Thanks for sharing.

The issue seems related to io_uring and the new io_uring fd monitoring
implementation available from QEMU 5.0.

I'll try to reproduce.

For now, as a workaround, you can rebuild qemu by disabling io-uring support:

  ../configure --disable-linux-io-uring ...


Thanks,
Stefano

> 
> QEMU:
> /usr/bin/qemu-system-x86_64 -name guest=win10,debug-threads=on -S
> -object secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-1-win10/master-key.aes
> -blockdev {"driver":"file","filename":"/usr/share/OVMF/OVMF_CODE.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"discard":"unmap"}
> -blockdev {"node-name":"libvirt-pflash0-format","read-only":true,"driver":"raw","file":"libvirt-pflash0-storage"}
> -blockdev {"driver":"file","filename":"/var/lib/libvirt/qemu/nvram/win10_VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,"discard":"unmap"}
> -blockdev {"node-name":"libvirt-pflash1-format","read-only":false,"driver":"raw","file":"libvirt-pflash1-storage"}
> -machine pc-q35-5.0,accel=kvm,usb=off,vmport=off,dump-guest-core=off,mem-merge=off,pflash0=libvirt-pflash0-format,pflash1=libvirt-pflash1-format
> -cpu Skylake-Client-IBRS,ss=on,vmx=on,hypervisor=on,tsc-adjust=on,clflushopt=on,umip=on,md-clear=on,stibp=on,arch-capabilities=on,ssbd=on,xsaves=on,pdpe1gb=on,ibpb=on,amd-ssbd=on,fma=off,avx=off,f16c=off,rdrand=off,bmi1=off,hle=off,avx2=off,bmi2=off,rtm=off,rdseed=off,adx=off,hv-time,hv-relaxed,hv-vapic,hv-spinlocks=0x1fff,hv-vpindex,hv-runtime,hv-synic,hv-stimer,hv-reset
> -m 8192 -mem-prealloc -mem-path /dev/hugepages/libvirt/qemu/1-win10
> -overcommit mem-lock=off -smp 4,sockets=1,dies=1,cores=2,threads=2
> -uuid 7ccc3031-1dab-4267-b72a-d60065b5ff7f -display none
> -no-user-config -nodefaults -chardev
> socket,id=charmonitor,fd=32,server,nowait -mon
> chardev=charmonitor,id=monitor,mode=control -rtc
> base=localtime,driftfix=slew -global kvm-pit.lost_tick_policy=delay
> -no-hpet -no-shutdown -global ICH9-LPC.disable_s3=1 -global
> ICH9-LPC.disable_s4=1 -boot menu=off,strict=on -device
> pcie-root-port,port=0x8,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x1
> -device pcie-root-port,port=0x9,chassis=2,id=pci.2,bus=pcie.0,addr=0x1.0x1
> -device pcie-root-port,port=0xa,chassis=3,id=pci.3,bus=pcie.0,addr=0x1.0x2
> -device pcie-root-port,port=0xb,chassis=4,id=pci.4,bus=pcie.0,addr=0x1.0x3
> -device pcie-pci-bridge,id=pci.5,bus=pci.2,addr=0x0 -device
> qemu-xhci,id=usb,bus=pci.1,addr=0x0 -blockdev
> {"driver":"host_device","filename":"/dev/disk/by-partuuid/05c3750b-060f-4703-95ea-6f5e546bf6e9","node-name":"libvirt-1-storage","cache":{"direct":false,"no-flush":true},"auto-read-only":true,"discard":"unmap"}
> -blockdev {"node-name":"libvirt-1-format","read-only":false,"discard":"unmap","detect-zeroes":"unmap","cache":{"direct":false,"no-flush":true},"driver":"raw","file":"libvirt-1-storage"}
> -device virtio-blk-pci,scsi=off,bus=pcie.0,addr=0xa,drive=libvirt-1-format,id=virtio-disk0,bootindex=1,write-cache=on
> -netdev tap,fd=34,id=hostnet0 -device
> e1000,netdev=hostnet0,id=net0,mac=52:54:00:c6:bb:bc,bus=pcie.0,addr=0x3
> -device ich9-intel-hda,id=sound0,bus=pcie.0,addr=0x4 -device
> hda-duplex,id=sound0-codec0,bus=sound0.0,cad=0 -device
> vfio-pci,host=0000:00:02.0,id=hostdev0,bus=pcie.0,addr=0x2,rombar=0
> -device virtio-balloon-pci,id=balloon0,bus=pcie.0,addr=0x8 -object
> rng-random,id=objrng0,filename=/dev/urandom -device
> virtio-rng-pci,rng=objrng0,id=rng0,bus=pcie.0,addr=0x9 -msg
> timestamp=on
> 
> And I use libvirt 6.3.0 to manage the VM. Here's an xml of my VM.
> 
> <domain type="kvm">
>   <name>win10</name>
>   <uuid>7ccc3031-1dab-4267-b72a-d60065b5ff7f</uuid>
>   <metadata>
>     <libosinfo:libosinfo
> xmlns:libosinfo="http://libosinfo.org/xmlns/libvirt/domain/1.0">
>       <libosinfo:os id="http://microsoft.com/win/10"/>
>     </libosinfo:libosinfo>
>   </metadata>
>   <memory unit="KiB">8388608</memory>
>   <currentMemory unit="KiB">8388608</currentMemory>
>   <memoryBacking>
>     <hugepages/>
>     <nosharepages/>
>   </memoryBacking>
>   <vcpu placement="static">4</vcpu>
>   <cputune>
>     <vcpupin vcpu="0" cpuset="0"/>
>     <vcpupin vcpu="1" cpuset="2"/>
>     <vcpupin vcpu="2" cpuset="1"/>
>     <vcpupin vcpu="3" cpuset="3"/>
>   </cputune>
>   <os>
>     <type arch="x86_64" machine="pc-q35-5.0">hvm</type>
>     <loader readonly="yes" type="pflash">/usr/share/OVMF/OVMF_CODE.fd</loader>
>     <nvram>/var/lib/libvirt/qemu/nvram/win10_VARS.fd</nvram>
>     <boot dev="hd"/>
>     <bootmenu enable="no"/>
>   </os>
>   <features>
>     <acpi/>
>     <apic/>
>     <hyperv>
>       <relaxed state="on"/>
>       <vapic state="on"/>
>       <spinlocks state="on" retries="8191"/>
>       <vpindex state="on"/>
>       <runtime state="on"/>
>       <synic state="on"/>
>       <stimer state="on"/>
>       <reset state="on"/>
>     </hyperv>
>     <vmport state="off"/>
>   </features>
>   <cpu mode="host-model" check="partial">
>     <topology sockets="1" dies="1" cores="2" threads="2"/>
>   </cpu>
>   <clock offset="localtime">
>     <timer name="rtc" tickpolicy="catchup"/>
>     <timer name="pit" tickpolicy="delay"/>
>     <timer name="hpet" present="no"/>
>     <timer name="hypervclock" present="yes"/>
>   </clock>
>   <on_poweroff>destroy</on_poweroff>
>   <on_reboot>restart</on_reboot>
>   <on_crash>destroy</on_crash>
>   <pm>
>     <suspend-to-mem enabled="no"/>
>     <suspend-to-disk enabled="no"/>
>   </pm>
>   <devices>
>     <emulator>/usr/bin/qemu-system-x86_64</emulator>
>     <disk type="block" device="disk">
>       <driver name="qemu" type="raw" cache="unsafe" discard="unmap"
> detect_zeroes="unmap"/>
>       <source dev="/dev/disk/by-partuuid/05c3750b-060f-4703-95ea-6f5e546bf6e9"/>
>       <target dev="vda" bus="virtio"/>
>       <address type="pci" domain="0x0000" bus="0x00" slot="0x0a"
> function="0x0"/>
>     </disk>
>     <controller type="pci" index="0" model="pcie-root"/>
>     <controller type="pci" index="1" model="pcie-root-port">
>       <model name="pcie-root-port"/>
>       <target chassis="1" port="0x8"/>
>       <address type="pci" domain="0x0000" bus="0x00" slot="0x01"
> function="0x0" multifunction="on"/>
>     </controller>
>     <controller type="pci" index="2" model="pcie-root-port">
>       <model name="pcie-root-port"/>
>       <target chassis="2" port="0x9"/>
>       <address type="pci" domain="0x0000" bus="0x00" slot="0x01"
> function="0x1"/>
>     </controller>
>     <controller type="pci" index="3" model="pcie-root-port">
>       <model name="pcie-root-port"/>
>       <target chassis="3" port="0xa"/>
>       <address type="pci" domain="0x0000" bus="0x00" slot="0x01"
> function="0x2"/>
>     </controller>
>     <controller type="pci" index="4" model="pcie-root-port">
>       <model name="pcie-root-port"/>
>       <target chassis="4" port="0xb"/>
>       <address type="pci" domain="0x0000" bus="0x00" slot="0x01"
> function="0x3"/>
>     </controller>
>     <controller type="pci" index="5" model="pcie-to-pci-bridge">
>       <model name="pcie-pci-bridge"/>
>       <address type="pci" domain="0x0000" bus="0x02" slot="0x00"
> function="0x0"/>
>     </controller>
>     <controller type="usb" index="0" model="qemu-xhci">
>       <address type="pci" domain="0x0000" bus="0x01" slot="0x00"
> function="0x0"/>
>     </controller>
>     <controller type="sata" index="0">
>       <address type="pci" domain="0x0000" bus="0x00" slot="0x1f"
> function="0x2"/>
>     </controller>
>     <interface type="network">
>       <mac address="52:54:00:c6:bb:bc"/>
>       <source network="default"/>
>       <model type="e1000"/>
>       <address type="pci" domain="0x0000" bus="0x00" slot="0x03"
> function="0x0"/>
>     </interface>
>     <input type="mouse" bus="ps2"/>
>     <input type="keyboard" bus="ps2"/>
>     <sound model="ich9">
>       <address type="pci" domain="0x0000" bus="0x00" slot="0x04"
> function="0x0"/>
>     </sound>
>     <hostdev mode="subsystem" type="pci" managed="yes">
>       <source>
>         <address domain="0x0000" bus="0x00" slot="0x02" function="0x0"/>
>       </source>
>       <rom bar="off"/>
>       <address type="pci" domain="0x0000" bus="0x00" slot="0x02"
> function="0x0"/>
>     </hostdev>
>     <memballoon model="virtio">
>       <address type="pci" domain="0x0000" bus="0x00" slot="0x08"
> function="0x0"/>
>     </memballoon>
>     <rng model="virtio">
>       <backend model="random">/dev/urandom</backend>
>       <address type="pci" domain="0x0000" bus="0x00" slot="0x09"
> function="0x0"/>
>     </rng>
>   </devices>
> </domain>
> 



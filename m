Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C99C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67E320650
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fnarfbargle.com header.i=@fnarfbargle.com header.b="GF/zttVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67E320650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fnarfbargle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6ESx-0001vq-TG
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 09:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lists2009@fnarfbargle.com>) id 1i6ES1-0000yf-4I
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lists2009@fnarfbargle.com>) id 1i6ERx-0002yt-Rd
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:38:57 -0400
Received: from ns3.fnarfbargle.com ([103.4.19.87]:41086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lists2009@fnarfbargle.com>)
 id 1i6ERp-0002sa-F2; Fri, 06 Sep 2019 09:38:46 -0400
Received: from [10.8.0.1] (helo=srv.home ident=heh13323)
 by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) (envelope-from <lists2009@fnarfbargle.com>)
 id 1i6ER7-00057c-2K; Fri, 06 Sep 2019 21:38:01 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=fnarfbargle.com; s=mail; 
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject;
 bh=iYZljXlwkPL0DO5Ec1cCPhYloZ8bq7b9fj9w0phTSSg=; 
 b=GF/zttVq64+mDy8G1HKqGGQH7Z5JaQNl/ntsmIxFrhhs3xn2tJ++VfU1gNaDbx8jqCkX5RLbNdz5IzcRwItfTgr3oSb+0KF04HOs0PMEKbN4tMgaOE83u9N8a2Tt1oG6XD30LxGZUp/r3ERw6w7pFIDmH1E9oP2QrP9T9VqRiMY=;
To: qemu-devel@nongnu.org, qemu-discuss@nongnu.org
References: <ed421291-7178-d7bc-5ed3-9863d28ceba9@fnarfbargle.com>
 <dd33a398-3c1f-0c92-2318-00ad144e1e5d@fnarfbargle.com>
 <b1782119-abbc-9678-8217-ef576dbf8c93@fnarfbargle.com>
From: Brad Campbell <lists2009@fnarfbargle.com>
Message-ID: <7da75f0a-aa48-a9db-d2f8-fe74031ecf58@fnarfbargle.com>
Date: Fri, 6 Sep 2019 21:38:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b1782119-abbc-9678-8217-ef576dbf8c93@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 103.4.19.87
Subject: Re: [Qemu-devel] Cross-posted : Odd QXL/KVM performance issue with
 a Windows 7 Guest
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

On 6/9/19 16:49, Brad Campbell wrote:
> On 2/9/19 6:23 pm, Brad Campbell wrote:
> 
>>
>> Here is the holdup :
>>
>> 11725@1567416625.003504:qxl_ring_command_check 0 native
>> 11725@1567416625.102653:qxl_io_write 0 native addr=0 (QXL_IO_NOTIFY_CMD) val=0 size=1 async=0
>>
>> ~100ms delay prior to each logged QXL_IO_NOTIFY_CMD on the AMD box which explains the performance difference. Now I just need to figure out if that lies in the guest, the guest QXL driver, QEMU or SPICE and why it exhibits on the AMD box and not the i7.
>>
>> To get to this point, I recompiled the kernel on the i7 box with both AMD and Intel KVM modules. Once that was running I cloned the drive and put it in the AMD box, so the OS, software stack and all dependencies are identical.
> 
>
Had a bit more of a poke and traced kvm and qxl on both machines at approximately comparative times of the same benchmark. From what I can ascertain in this context ioctl type 0xc008ae67 is KVM_IRQ_LINE_STATUS.

The i7 trace shows maybe 10ms spent hitting that. The Ryzen trace below shows the majority of the frame spent hitting that ioctl (some ~110ms).

i7 :

qxl/guest-0: 161680464256: qxldd: DrvCopyBits
7022@1567775823.999850:kvm_vcpu_ioctl cpu_index 1, type 0xae80, arg (nil)
7022@1567775824.000106:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.000115:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.001106:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.001117:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.002106:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.002115:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.003122:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.003145:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.004122:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.004144:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.005122:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.005144:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.006122:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.006144:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.007122:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.007144:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.008128:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.008150:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.009122:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.009144:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.010118:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.010139:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.011118:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.011139:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.012117:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.012138:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.012200:kvm_run_exit cpu_index 1, reason 2
7022@1567775824.012214:qxl_io_write 0 native addr=4 (QXL_IO_NOTIFY_OOM) val=0 size=1 async=0
7022@1567775824.012226:qxl_spice_oom 0
7022@1567775824.012238:kvm_vcpu_ioctl cpu_index 1, type 0xae80, arg (nil)
7022@1567775824.012280:qxl_ring_command_check 0 native
7022@1567775824.012288:qxl_ring_res_push 0 native s#=0 res#=2 last=0x7faee4c2d458 notify=yes
7022@1567775824.012296:qxl_ring_res_push_rest 0 ring 1/8 [2399,2398]
7022@1567775824.012307:qxl_send_events 0 1
7022@1567775824.012319:qxl_ring_cursor_check 0 native
7022@1567775824.012325:qxl_ring_command_check 0 native
7022@1567775824.012332:qxl_ring_cursor_check 0 native
7022@1567775824.012336:qxl_ring_command_check 0 native
7022@1567775824.012342:qxl_ring_cursor_check 0 native
7022@1567775824.012349:qxl_ring_command_check 0 native
7022@1567775824.012367:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c890
7022@1567775824.012388:kvm_run_exit cpu_index 1, reason 2
7022@1567775824.012399:qxl_io_write 0 native addr=3 (QXL_IO_UPDATE_IRQ) val=0 size=1 async=0
7022@1567775824.012416:kvm_vm_ioctl type 0xc008ae67, arg 0x7fb4f5a296b0
7022@1567775824.012426:kvm_vcpu_ioctl cpu_index 1, type 0xae80, arg (nil)
7022@1567775824.012444:kvm_run_exit cpu_index 1, reason 2
7022@1567775824.012452:qxl_io_write 0 native addr=3 (QXL_IO_UPDATE_IRQ) val=0 size=1 async=0
7022@1567775824.012466:kvm_vcpu_ioctl cpu_index 1, type 0xae80, arg (nil)
7022@1567775824.013106:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.013124:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.013642:kvm_run_exit cpu_index 1, reason 2
7022@1567775824.013652:qxl_io_write 0 native addr=0 (QXL_IO_NOTIFY_CMD) val=0 size=1 async=0
7022@1567775824.013667:kvm_vcpu_ioctl cpu_index 1, type 0xae80, arg (nil)
7022@1567775824.013726:qxl_ring_cursor_check 0 native
7022@1567775824.013739:qxl_ring_command_check 0 native
161694369320 qxl-0/cmd: cmd @ 0x10000000102d758 draw: surface_id 0 type copy effect opaque src 1000000018e3cf8 (id 16dbe0870780 type 0 flags 0 width 1920 height 1080, fmt 8 flags 0 x 1920 y 1080 stride 7680 palette 0 data 1000000018e3d28) area 1920x1080+0+0 rop 8
7022@1567775824.013816:qxl_ring_command_get 0 native
7022@1567775824.013858:qxl_ring_res_put 0 #res=1
7022@1567775824.013870:qxl_ring_command_check 0 native
7022@1567775824.013886:qxl_ring_cursor_check 0 native
7022@1567775824.013897:qxl_ring_command_check 0 native
7022@1567775824.013909:qxl_ring_command_req_notification 0
7022@1567775824.013918:qxl_ring_cursor_check 0 native
7022@1567775824.013927:qxl_ring_command_check 0 native
7022@1567775824.014106:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.014127:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.015104:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.015117:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.016105:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.016115:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.017104:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.017114:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.018105:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.018114:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.019105:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.019114:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.019820:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c960
7022@1567775824.019855:kvm_run_exit cpu_index 0, reason 2
7022@1567775824.019866:kvm_vcpu_ioctl cpu_index 0, type 0xae80, arg (nil)
7022@1567775824.019877:kvm_run_exit cpu_index 0, reason 2
7022@1567775824.019883:kvm_vcpu_ioctl cpu_index 0, type 0xae80, arg (nil)
7022@1567775824.019902:kvm_run_exit cpu_index 0, reason 2
7022@1567775824.019907:kvm_vcpu_ioctl cpu_index 0, type 0xae80, arg (nil)
7022@1567775824.019916:kvm_run_exit cpu_index 0, reason 2
7022@1567775824.019925:kvm_vm_ioctl type 0xc008ae67, arg 0x7fb4f622a770
7022@1567775824.019939:kvm_vcpu_ioctl cpu_index 0, type 0xae80, arg (nil)
7022@1567775824.019957:kvm_run_exit cpu_index 0, reason 2
7022@1567775824.019962:kvm_vcpu_ioctl cpu_index 0, type 0xae80, arg (nil)
7022@1567775824.020103:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.020111:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.021103:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
7022@1567775824.021113:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
7022@1567775824.022087:kvm_run_exit cpu_index 1, reason 2
7022@1567775824.022099:qxl_io_write 0 native addr=7 (QXL_IO_LOG) val=0 size=1 async=0
7022@1567775824.022108:qxl_io_log 0 qxldd: DrvCopyBits


Ryzen :

qxl/guest-0: 55011750066: qxldd: DrvCopyBits
6725@1567775954.186011:kvm_vcpu_ioctl cpu_index 2, type 0xae80, arg (nil)
6726@1567775954.186567:qxl_ring_res_put 0 #res=1
6694@1567775954.186779:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.186799:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.187777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.187786:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.188777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.188785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.189785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.189794:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.190777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.190785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.191777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.191785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.192777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.192785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.193781:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.193794:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.194781:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.194794:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.195781:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.195794:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.196781:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.196795:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.197777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.197786:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.198780:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.198794:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.199779:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.199789:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6725@1567775954.199821:kvm_run_exit cpu_index 2, reason 2
6725@1567775954.199852:qxl_io_write 0 native addr=4 (QXL_IO_NOTIFY_OOM) val=0 size=1 async=0
6725@1567775954.199885:qxl_spice_oom 0
6725@1567775954.199903:kvm_vcpu_ioctl cpu_index 2, type 0xae80, arg (nil)
6726@1567775954.199926:qxl_ring_command_check 0 native
6726@1567775954.199942:qxl_ring_res_push 0 native s#=0 res#=1 last=0x7f1b16c4b598 notify=yes
6726@1567775954.199973:qxl_ring_res_push_rest 0 ring 1/8 [130,129]
6726@1567775954.199994:qxl_send_events 0 1
6726@1567775954.200014:qxl_ring_cursor_check 0 native
6726@1567775954.200035:qxl_ring_command_check 0 native
6694@1567775954.200027:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631e90
6724@1567775954.200083:kvm_run_exit cpu_index 1, reason 2
6724@1567775954.200099:qxl_io_write 0 native addr=3 (QXL_IO_UPDATE_IRQ) val=0 size=1 async=0
6724@1567775954.200126:kvm_vm_ioctl type 0xc008ae67, arg 0x7f1d266df560
6724@1567775954.200148:kvm_vcpu_ioctl cpu_index 1, type 0xae80, arg (nil)
6724@1567775954.200174:kvm_run_exit cpu_index 1, reason 2
6724@1567775954.200200:qxl_io_write 0 native addr=3 (QXL_IO_UPDATE_IRQ) val=0 size=1 async=0
6724@1567775954.200254:kvm_vcpu_ioctl cpu_index 1, type 0xae80, arg (nil)
6694@1567775954.200777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.200797:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.201773:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.201781:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.202779:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.202793:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.203797:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.203832:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.204797:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.204810:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.205779:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.205788:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.206787:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.206800:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.207796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.207809:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.208796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.208809:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.209782:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.209791:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.210778:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.210787:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.211796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.211809:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.212796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.212809:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.213797:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.213810:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.214796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.214809:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.215796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.215809:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.216796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.216810:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.217779:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.217788:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.218796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.218809:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.219804:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.219824:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.220780:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.220788:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.221779:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.221787:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.222777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.222785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.223778:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.223786:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.224777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.224786:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.225777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.225786:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.226777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.226785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.227777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.227785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.228777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.228785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.229780:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.229789:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.230777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.230785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.231777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.231786:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.232777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.232785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.233777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.233785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.234782:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.234791:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.235777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.235785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.236777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.236785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.237777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.237785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.238777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.238785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.239780:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.239789:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.240777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.240785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.241777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.241785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.242777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.242786:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.243777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.243785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.244777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.244785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.245777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.245785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.246777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.246785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.247777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.247785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.248777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.248785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.249784:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.249794:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.250777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.250785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.251777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.251785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.252781:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.252794:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.253777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.253786:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.254777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.254785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.255780:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.255801:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.256777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.256785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.257779:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.257792:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.258781:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.258794:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.259783:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.259796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.260780:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.260794:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.261779:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.261792:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.262780:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.262794:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.263775:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.263784:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.264798:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.264811:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.265796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.265810:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.266798:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.266811:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.267797:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.267810:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.268796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.268810:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.269799:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.269820:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.270796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.270809:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.271796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.271809:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.272796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.272810:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.273796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.273809:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.274796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.274809:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.275796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.275809:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.276796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.276810:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.277779:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.277787:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.278779:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.278789:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.279800:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.279821:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.280778:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.280787:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.281795:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.281807:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.282796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.282809:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.283796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.283809:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.284796:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.284809:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.285779:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.285788:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.286779:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.286789:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.287777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.287785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.288778:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.288788:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.289780:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.289788:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.290777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.290786:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.291778:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.291788:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.292777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.292785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.293778:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.293788:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.294777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.294785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.295779:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.295788:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.296777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.296785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.297778:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.297788:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.298777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.298785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.299781:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.299791:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.300777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.300785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.301778:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.301787:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6694@1567775954.302777:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.302785:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6725@1567775954.302875:kvm_run_exit cpu_index 2, reason 2
6725@1567775954.302894:qxl_io_write 0 native addr=0 (QXL_IO_NOTIFY_CMD) val=0 size=1 async=0
6725@1567775954.302924:kvm_vcpu_ioctl cpu_index 2, type 0xae80, arg (nil)
6726@1567775954.302940:qxl_ring_cursor_check 0 native
6726@1567775954.302956:qxl_ring_command_check 0 native
55128722604 qxl-0/cmd: cmd @ 0x10000000104b498 draw: surface_id 0 type copy effect opaque src 100000001ecf950 (id d3e0870780 type 0 flags 0 width 1920 height 1080, fmt 8 flags 0 x 1920 y 1080 stride 7680 palette 0 data 100000001ecf980) area 1920x1080+0+0 rop 8
6726@1567775954.303062:qxl_ring_command_get 0 native
6726@1567775954.303119:qxl_ring_command_check 0 native
6726@1567775954.303143:qxl_ring_cursor_check 0 native
6726@1567775954.303160:qxl_ring_command_check 0 native
6726@1567775954.303174:qxl_ring_command_req_notification 0
6694@1567775954.303778:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f30
6694@1567775954.303799:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffc1b631f40
6725@1567775954.304197:kvm_run_exit cpu_index 2, reason 2
6725@1567775954.304231:qxl_io_write 0 native addr=7 (QXL_IO_LOG) val=0 size=1 async=0
6725@1567775954.304260:qxl_io_log 0 qxldd: DrvCopyBits

Does this look familiar to anyone?

Regards,
Brad
-- 
An expert is a person who has found out by his own painful
experience all the mistakes that one can make in a very
narrow field. - Niels Bohr


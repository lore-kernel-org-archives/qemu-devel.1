Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE5DC010A3
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 11:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9496206BA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 11:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="py/7Uo+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9496206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRx5m-0005bB-UG
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 06:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iRx4z-0004r8-US
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 06:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iRx4y-0003gP-7y
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 06:32:57 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38922)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iRx4x-0003ZW-VA
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 06:32:56 -0500
Received: by mail-wm1-x342.google.com with SMTP id t26so15630229wmi.4
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 03:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version; bh=wsIkqMSmVRI8x2Quhoekaz9JlLEnreCitrWAnERuauU=;
 b=py/7Uo+ERWk/M+sya6RM/jlRdN7XCrolNoXsoH+Zo1AqdOrBaOV82zULmUAxdqAATX
 FR6Szc4g66xgSL2ZKFF4H2PIKpUnidvDSWmeqEN/NcBabb70hnEKBXV5Po8j0Zsf8+FI
 TcfU1K2X1Ksd17ZXIsjjuxOdZG2BS+ZhM9SgeEQ0FfCvKS0B6Fawo2Vas+KzhhQippnA
 CdHZafElsQY6jF3UlKHiWMrAjrfwlYvVmWKYFAvACyp/KFLZyRCwNUPYE111U9lt94ro
 xnU3QBx7FnbixdPjustuvPGh2mBgSX60KZyD/vbmF22n3iFxLguetp+zvHj3icIRabVE
 SKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version;
 bh=wsIkqMSmVRI8x2Quhoekaz9JlLEnreCitrWAnERuauU=;
 b=D0KgLahxnPYUkSsPKNvpeYgfDMOaoPDuraPTvf94QiNp0d4+bKo0ohE7pdMwSv0Qvf
 SS5qZ78A2UmnqwOKWF0116gRQpnMTyTjMj63e9f/vz3o3IVNksO348r9YbEIllDOrljA
 xcpbVZghvfkKu20A8tSJPu/erfyAYe95q32YC7VhKSrfY8XwSapsguxNOdLRmlwAcuOG
 xFaG/yuHcgmse7wC5rsLcxl4SzrojX/0jrQsmV/QQ5nQJgollwh2ZXSuYp9cm79rmV+3
 FC52Xlh0P39ykuG0gRP6dR32u+tdEsACuJWnVQ/6NfgIk3ouoOnTEDNtIMBickT2oATC
 /ifw==
X-Gm-Message-State: APjAAAX9BMWu6QhGmGzwE+aUbiw/ETH51u5nGuGcbT5PK1ze27hPNjRn
 MlnXeQ1zJ5ZvlbET8I/wlsVuKpbvV7Q=
X-Google-Smtp-Source: APXvYqyF2EKIjdPyEW6CerxMBw2WdJFV3XJoRvD5qBcXdCaSwgR+aXEkUveINRjCgxmVEPNMSaJqSg==
X-Received: by 2002:a1c:f305:: with SMTP id q5mr3704469wmq.137.1572953573384; 
 Tue, 05 Nov 2019 03:32:53 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j14sm15180404wrp.16.2019.11.05.03.32.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 03:32:52 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A10EF1FF87
 for <qemu-devel@nongnu.org>; Tue,  5 Nov 2019 11:32:51 +0000 (GMT)
References: <ed421291-7178-d7bc-5ed3-9863d28ceba9@fnarfbargle.com>
 <dd33a398-3c1f-0c92-2318-00ad144e1e5d@fnarfbargle.com>
 <b1782119-abbc-9678-8217-ef576dbf8c93@fnarfbargle.com>
 <7da75f0a-aa48-a9db-d2f8-fe74031ecf58@fnarfbargle.com>
 <49b5d60f-b0cd-8d47-5e0f-75fc76b3ee47@fnarfbargle.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] Cross-posted : Odd QXL/KVM performance issue with
 a Windows 7 Guest
In-reply-to: <49b5d60f-b0cd-8d47-5e0f-75fc76b3ee47@fnarfbargle.com>
Date: Tue, 05 Nov 2019 11:32:51 +0000
Message-ID: <871rumk17g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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


Brad Campbell <lists2009@fnarfbargle.com> writes:

> On 6/9/19 21:38, Brad Campbell wrote:
>> 7022@1567775824.002106:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
>> 7022@1567775824.002115:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
>> 7022@1567775824.003122:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
>
>> Does this look familiar to anyone?
>
> Ugh. System timer.
>
> So with the timer interrupt removed and an added trace on IRQ > 0:
>
> qxl/guest-0: 79096403248: qxldd: DrvCopyBits
> 14955@1567780063.149527:kvm_vcpu_ioctl cpu_index 2, type 0xae80, arg (nil)
> 14956@1567780063.150291:qxl_ring_res_put 0 #res=1
> 14955@1567780063.163672:kvm_run_exit cpu_index 2, reason 2
> 14955@1567780063.163688:qxl_io_write 0 native addr=4 (QXL_IO_NOTIFY_OOM) val=0 size=1 async=0
> 14955@1567780063.163704:qxl_spice_oom 0
> 14955@1567780063.163720:kvm_vcpu_ioctl cpu_index 2, type 0xae80, arg (nil)
> 14956@1567780063.163755:qxl_ring_command_check 0 native
> 14956@1567780063.163779:qxl_ring_res_push 0 native s#=0 res#=1 last=0x7f3c0d44b6e0 notify=yes
> 14956@1567780063.163816:qxl_ring_res_push_rest 0 ring 1/8 [326,325]
> 14956@1567780063.163841:qxl_send_events 0 1
> 14956@1567780063.163868:qxl_ring_cursor_check 0 native
> 14956@1567780063.163888:qxl_ring_command_check 0 native
> 14924@1567780063.163879:kvm_set_irq irq 11, level 1, status 1
> 14954@1567780063.163895:kvm_run_exit cpu_index 1, reason 2
> 14954@1567780063.163965:qxl_io_write 0 native addr=3 (QXL_IO_UPDATE_IRQ) val=0 size=1 async=0
> 14954@1567780063.164006:kvm_set_irq irq 11, level 0, status 1
> 14954@1567780063.164029:kvm_vcpu_ioctl cpu_index 1, type 0xae80, arg (nil)
> 14954@1567780063.164065:kvm_run_exit cpu_index 1, reason 2
> 14954@1567780063.164080:qxl_io_write 0 native addr=3 (QXL_IO_UPDATE_IRQ) val=0 size=1 async=0
> 14954@1567780063.164104:kvm_vcpu_ioctl cpu_index 1, type 0xae80, arg (nil)
> 14955@1567780063.266778:kvm_run_exit cpu_index 2, reason 2
> 14955@1567780063.266790:qxl_io_write 0 native addr=0 (QXL_IO_NOTIFY_CMD) val=0 size=1 async=0
> 14955@1567780063.266809:kvm_vcpu_ioctl cpu_index 2, type 0xae80, arg (nil)
> 14956@1567780063.266822:qxl_ring_cursor_check 0 native
> 14956@1567780063.266842:qxl_ring_command_check 0 native
> 79213750625 qxl-0/cmd: cmd @ 0x10000000104b598 draw: surface_id 0 type copy effect opaque src 100000001fecbf8 (id 9fe0870780 type 0 flags 0 width 1920 height 1080, fmt 8 flags 0 x 1920 y 1080 stride 7680 palette 0 data 100000001fecc28) area 1920x1080+0+0 rop 8
> 14956@1567780063.266983:qxl_ring_command_get 0 native
> 14956@1567780063.267044:qxl_ring_command_check 0 native
> 14956@1567780063.267070:qxl_ring_cursor_check 0 native
> 14956@1567780063.267087:qxl_ring_command_check 0 native
> 14956@1567780063.267109:qxl_ring_command_req_notification 0
> 14955@1567780063.267967:kvm_run_exit cpu_index 2, reason 2
> 14955@1567780063.267987:qxl_io_write 0 native addr=7 (QXL_IO_LOG) val=0 size=1 async=0
> 14955@1567780063.268015:qxl_io_log 0 qxldd: DrvCopyBits
>
> So if I'm not mistaken (for the nth time), we have KVM_RUN on cpu index 2 here:
>
> 14955@1567780063.163720:kvm_vcpu_ioctl cpu_index 2, type 0xae80, arg (nil)
>
> And it returns here :
>
> 14955@1567780063.266778:kvm_run_exit cpu_index 2, reason 2
>
> Does that imply guest code is running for ~100ms on that vcpu?

Yes. In the KVM game vmexits is what kills performance. If QEMU is
involved in doing the emulation you have to exit the guest, go through
the kernel, exit the ioctl and then QEMU does it's thing before you
restart.

You can't avoid all exits - indeed VIRTIO is designed to limit the exits
to a single exit per transmission. However if you are emulating a legacy
device in QEMU every access to a memory mapped register will involve an
exit.

If you monitor QEMU with "perf record" and then look at the result
("perf report") see what QEMU is doing all that time. It's likely there
is a legacy device somewhere which the guest kernel is hammering.

--
Alex.


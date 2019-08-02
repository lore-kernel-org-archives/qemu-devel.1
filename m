Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B07C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 17:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F7120449
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 17:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F7120449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htbo2-0003nd-PZ
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 13:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56185)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1htblg-00033e-LE
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 13:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1htblf-0007Bc-8k
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 13:55:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1htblf-0007BH-29
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 13:55:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id v15so73215362eds.9
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 10:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DTF6hMQOyziGsQXZhY9GwtkVYI1pxMKFewbvVn3bkvU=;
 b=hLmy1sM42m3mBqacu8urEq2uiJHAvSJYMOPgv3J93n289WUz87tJAxexBJkfrYq/Pv
 MN4KKVYn8rpmtncXLlT2CMBwgDE2vNDVIPS5cHZpu7ylPpYY9pgDDqrc3Qr79lpueYlw
 96cBVYrBVqQaBrfFIQFvO4bbsgkUv2Iq8hzYWbS65ZTG8skx2n7Y9gRWBsOPbvfSqMi/
 fc4OnRLLrr8BJVXOMBLxOW+myolJdvHJluwiIjOVwBNUC4ka9tSZ4eheCzuu103/0HPk
 fbEoxpif4e/3B7kQk3cHDFqdmVZYxhRtSfPUIvSgKq3rpmCruYZIoMT0MmhWyG4p9gVa
 uUMA==
X-Gm-Message-State: APjAAAWD0o1bfb+pzzmxYgyhOpyphIQ5TBMgHO++MZKO0NFZSsow6fi8
 PUd/ohaq/vdkz9O4YycFj0FrbA==
X-Google-Smtp-Source: APXvYqw8TMGdzm4dRHw47YiPMjKNAQMAWMIgLvyuDAhpGkdFVWo5qPs+RPM7FgQuKEVNeoR1mDRovA==
X-Received: by 2002:a50:fa42:: with SMTP id c2mr122141450edq.48.1564768501930; 
 Fri, 02 Aug 2019 10:55:01 -0700 (PDT)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id q21sm13440912ejo.76.2019.08.02.10.55.00
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 10:55:01 -0700 (PDT)
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
 <156390781777.16169.2703233729883705323@sif>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e8f5f0ae-c698-87a0-5876-00daf141fc18@redhat.com>
Date: Fri, 2 Aug 2019 19:54:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156390781777.16169.2703233729883705323@sif>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.65
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH 00/36] Patch Round-up for
 stable 3.1.1, freeze on 2019-07-29
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
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/19 8:50 PM, Michael Roth wrote:
> Quoting Michael Roth (2019-07-23 12:00:28)
>> Hi everyone,                                                                                              
>>
>> The following new patches are queued for QEMU stable v3.1.1:
>>
>>   https://github.com/mdroth/qemu/commits/stable-3.1-staging
>>
>> The release is planned for 2019-08-01:
>>
>>   https://wiki.qemu.org/Planning/3.1
>>
>> Please respond here or CC qemu-stable@nongnu.org on any patches you
>> think should be included in the release.
>>
>> Note that this update falls outside the normal stable release support
>> window (~1 development cycle), but is being released now since it was
>> delayed from its intended release date.
>>
>> Thanks!
>>
> 
> Forgot to include the usual patch list:
> 
> ----------------------------------------------------------------
> BALATON Zoltan (1):
>       i2c: Move typedef of bitbang_i2c_interface to i2c.h
> 
> Christian Borntraeger (2):
>       iotests: make 235 work on s390 (and others)
>       s390x/cpumodel: ignore csske for expansion
> 
> Christophe Fergeau (1):
>       json: Fix % handling when not interpolating
> 
> Corey Minyard (1):
>       pc:piix4: Update smbus I/O space after a migration
> 
> Cornelia Huck (1):
>       vfio-ap: flag as compatible with balloon
> 
> Dan Streetman (1):
>       do not call vhost_net_cleanup() on running net from char user event
> 
> Daniel Henrique Barboza (1):
>       qga: update docs with systemd suspend support info
> 
> Daniel P. Berrangé (1):
>       qemu-img: fix error reporting for -object
> 
> Eric Blake (1):
>       cutils: Fix size_to_str() on 32-bit platforms
> 
> Gerd Hoffmann (1):
>       usb-mtp: use O_NOFOLLOW and O_CLOEXEC.
> 
> Janosch Frank (1):
>       s390x: Return specification exception for unimplemented diag 308 subcodes
> 
> Kevin Wolf (3):
>       block: Fix invalidate_cache error path for parent activation
>       qcow2: Avoid COW during metadata preallocation
>       block: Fix AioContext switch for bs->drv == NULL
> 
> Li Hangjing (1):
>       vhost: fix vhost_log size overflow during migration
> 
> Liam Merwick (1):
>       tpm_tis: fix loop that cancels any seizure by a lower locality
> 
> Marcel Apfelbaum (1):
>       hw/rdma: another clang compilation fix
> 
> Mark Cave-Ayland (2):
>       mac_oldworld: use node name instead of alias name for hd device in FWPathProvider
>       mac_newworld: use node name instead of alias name for hd device in FWPathProvider
> 
> Max Reitz (3):
>       iotests: Filter second BLOCK_JOB_ERROR from 229
>       block/file-posix: Unaligned O_DIRECT block-status
>       iotests: Test unaligned raw images with O_DIRECT
> 
> Michael Roth (1):
>       qga-win: include glib when building VSS DLL
> 
> Paolo Bonzini (1):
>       i386: remove the 'INTEL_PT' CPUID bit from named CPU models
> 
> Paul A. Clarke (1):
>       Changes requirement for "vsubsbs" instruction
> 
> Peter Lieven (1):
>       megasas: fix mapped frame size
> 
> Peter Maydell (2):
>       linux-user: make pwrite64/pread64(fd, NULL, 0, offset) return 0
>       exec.c: Don't reallocate IOMMUNotifiers that are in use
> 
> Robert Hoo (1):
>       i386: remove the new CPUID 'PCONFIG' from Icelake-Server CPU model
> 
> Stefan Berger (2):
>       tpm: Make sure new locality passed to tpm_tis_prep_abort() is valid
>       tpm: Make sure the locality received from backend is valid
> 
> Thomas Huth (1):
>       hw/s390x: Fix bad mask in time2tod()
> 
> Thomas Petazzoni (1):
>       configure: improve usbfs check
> 
> William Bowling (1):
>       slirp: check sscanf result when emulating ident
> 
> Zheng Xiang (1):
>       pcie: set link state inactive/active after hot unplug/plug

I am having a spice build failure fixed by this commit:

commit be812c0ab7d5ab741d0d87387a75a0e8bb6461e7
Author: Lukáš Hrázký <lhrazky@redhat.com>
Date:   Fri Feb 15 16:09:19 2019 +0100

 spice: set device address and device display ID in QXL interface

 Calls the new SPICE QXL interface function spice_qxl_set_device_info to
 set the hardware address of the graphics device represented by the QXL
 interface (e.g. a PCI path) and the device display IDs (the IDs of the
 device's monitors that belong to this QXL interface).

 Also stops using the deprecated spice_qxl_set_max_monitors, the new
 interface function replaces it.



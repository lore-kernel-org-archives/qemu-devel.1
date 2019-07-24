Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C025C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 13:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0373421926
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 13:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0373421926
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqHCy-0002vX-RN
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 09:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37951)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hqHCn-0002Wm-9p
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hqHCl-0004EM-UQ
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:21:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35949)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hqHCl-0004Ct-KN
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:21:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so37512764wme.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 06:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JU67xN+YmKT7rq6ot8cO0yHoJipVI10DfKFEZdKT+6w=;
 b=TYHkYCxaoZ7ihNUdNaKYg94uQJ03cyH1pbdEyz4DwRBJuA4aMGvS5Zr8zEcM9TFyad
 TNk1MbfOadB0LQabWOPCgZm2y9W/mn3+PKlQOnPHJdzymvW/BuZpFwS9B+u2rfMdeFGr
 /MtWXN6PgLUfujgS88mawNMKk2AZdUQ4lJRmgrpacaYUV5+YhYkPabrYf4O9Klg+LDXd
 kFiDoUCD+hV24hGvsAktajthV8hjGIyX7L294CnkLO2iSqProptYKXsPktzm6oN5/WCL
 N+NHQcyqa/65Yc/sKp17FMMXlDHvocH3fZYBDkov9eCyGOmLou+NhI9LQOlXQmMtIitJ
 3zRA==
X-Gm-Message-State: APjAAAUvGM2w++aqHGtHZejiW6V7YIbQBBh4mNMvy6WvpFOJShNPujlD
 lp2fj4azvzh7+95QkKayhhHl6A==
X-Google-Smtp-Source: APXvYqw9VIYkDOsvV49r5TDyWNXFM8isYkM77f0USYZ8g1QmY3alhPeXeuf8hGAOaj9n6Scc76Gfzg==
X-Received: by 2002:a1c:3cc4:: with SMTP id j187mr71123906wma.36.1563974473887; 
 Wed, 24 Jul 2019 06:21:13 -0700 (PDT)
Received: from [10.201.33.105] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id f10sm34893690wrs.22.2019.07.24.06.21.12
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2019 06:21:13 -0700 (PDT)
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
 <156390781777.16169.2703233729883705323@sif>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3430f529-a3bd-10c1-4efb-73a213ebdc8b@redhat.com>
Date: Wed, 24 Jul 2019 15:21:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156390781777.16169.2703233729883705323@sif>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

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

I have noted these too:

44c64e9095 target/m68k: Fix a tcg_temp leak
526668c734 hw/ssi/xilinx_spips: Avoid out-of-bound access to lqspi_buf[]
c0bccee9b4 hw/ssi/mss-spi: Avoid crash when reading empty RX FIFO
a09ef50404 hw/display/xlnx_dp: Avoid crash when reading empty RX FIFO
3a283507c0 hw/block/pflash_cfi01: Add missing DeviceReset() handler


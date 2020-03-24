Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497B2C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB4F20786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB4F20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGhPO-0002hM-6J
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 07:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jGhOe-0001k3-65
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jGhOc-0003Ba-Nm
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:07:00 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:43905)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jGhOc-0003B9-F0
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:06:58 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mf3yk-1jjigx1RgA-00gUSO; Tue, 24 Mar 2020 12:06:45 +0100
Subject: Re: [PULL 0/5] Linux user for 5.0 patches
To: qemu-devel@nongnu.org
References: <158504763369.13426.12844033914999219295@39012742ff91>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a5bb378b-d51b-fa9f-8e55-172adebb2e0b@vivier.eu>
Date: Tue, 24 Mar 2020 12:06:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <158504763369.13426.12844033914999219295@39012742ff91>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:X8VqXEMdcwb6hI7RicMIwWalfHEcEOxgp6VgKmjGd95qyXe1FRz
 dExfzMxmO5iyBPWTR4R89W33jCBO1Tz7ziWLVkshQmWyTM5Uydkr0+QVrcDg3W4dzZgDBIh
 XZ0UixYmjhXjjfgAbRJmWXR5IOaDkAnnIGbQR084tdJbVZRl1XBenmIz2a48AZcUslS1c6B
 GQBn4hcINKy6+dZMbObmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C/PGYD4UVtQ=:3R2mSZLRRwZMhjKIUeXwEB
 ay/QY30Gizd1DeN1NHSI//QPI4UIUxabKynTxxqjW4UtJD9SNYr8KUhzP7H8b1wyeZtNOlylj
 TTPvvyNHrjt+6TlU6Kx0qZviJ6wlwTpxQtdQXNnLS9AFM2m0Kyrbi4SDHgvtOz7Apiid4bRHx
 SEZKAq1yFLCopzwv0yQP7PYRjL//pch1vkR8T0KLou7CPDaz8uhRt77jO6c0xep3LmloNd+N3
 C6n9ImvtVQ6cF8V9DWwb6e+Uy2S7fv7zWi7hiTLScZ6Ghz/1nWoklC6VBcgbJOp6qtTdf193l
 RW8/dJasN7J0eU/oAVnp10rPVee79ejbeAN0zf06cDUvgPxzxhSvd08s1TpTkNrg0usedF0NT
 dSyKxchrMY9qkHzE6z210Iri+4awNyUGIYjZniJN46cR3Ye5kfOTo2byuHY9epB//90p7evOA
 haxjo2fjbUQFSqkOEOsCmCqODrgJMCZJPf8tW2zZKI38A0gHdfeT+iy+Jq9O9GYnFhkg8K1nq
 hxzcWjADN0vHS0HeWiBauRnMoQa+NAH3lFVu3DrM7bjrXUZKv9QNcMI5fysWbvkBamznXFGXS
 J3m5vsfcThHVNuXHn2hYyNsIqN6R3Z5KRhV8RFPNN6AmoEhjwdAVWM0JdEPkDqQSVM5nnsALm
 r0OA84lUEP5zXL6bgGnqs3WJbN5dyIx8PBjo6axZRbRaU8+UTRLgunDrhoLabWB1puo+qx1F6
 noxn2sRrtFzGFsOBh9Yp+JRQvy+2g7gpopZYoUZhSTd5j8hJ7oIUzvs62Y/YEZcqj39Acz1Lu
 jDqYVdAAwQCMEsMDS3tRmLQyr099PSNe3lP2hoaKXfD/z3P6WFoyA/GkVrM6k5/Hnj/rSG3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 24/03/2020 à 12:00, no-reply@patchew.org a écrit :
> Patchew URL: https://patchew.org/QEMU/20200324100311.588288-1-laurent@vivier.eu/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [PULL 0/5] Linux user for 5.0 patches
> Message-id: 20200324100311.588288-1-laurent@vivier.eu
> Type: series
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Switched to a new branch 'test'
> 58fa059 linux-user: Flush out implementation of gettimeofday
> f253e7a linux-user: Add x86_64 vsyscall page to /proc/self/maps
> ad06327 linux-user/i386: Emulate x86_64 vsyscalls
> 2dccb44 linux-user/i386: Split out gen_signal
> 1ab05c1 target/i386: Renumber EXCP_SYSCALL
> 
> === OUTPUT BEGIN ===
> 1/5 Checking commit 1ab05c10ed02 (target/i386: Renumber EXCP_SYSCALL)
> 2/5 Checking commit 2dccb4427740 (linux-user/i386: Split out gen_signal)
> 3/5 Checking commit ad0632716d07 (linux-user/i386: Emulate x86_64 vsyscalls)
> 4/5 Checking commit f253e7a47cf4 (linux-user: Add x86_64 vsyscall page to /proc/self/maps)
> ERROR: trailing whitespace
> #32: FILE: linux-user/syscall.c:7152:
> +    dprintf(fd, TARGET_FMT_lx "-" TARGET_FMT_lx $
> 
> total: 1 errors, 0 warnings, 16 lines checked
> 
> Patch 4/5 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 5/5 Checking commit 58fa0592ae77 (linux-user: Flush out implementation of gettimeofday)
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20200324100311.588288-1-laurent@vivier.eu/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 

Sorry, fixed that on previous PR, not in this new one.

I'm going to send a v2 shortly.

Thanks,
Laurent


Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D56EC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7FB52084D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FB52084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS56t-0000wP-0K
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 15:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS567-0008Rn-3b
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:06:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS565-0002fQ-Pv
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:06:39 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:59991)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iS55z-0002Qf-Db; Tue, 05 Nov 2019 15:06:31 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N17gy-1hmfXe20jK-012WjJ; Tue, 05 Nov 2019 21:06:08 +0100
Subject: Re: [Xen-devel] [PULL v2 0/3] Trivial branch patches
To: qemu-devel@nongnu.org
References: <157298160814.27285.16893877491189017648@37313f22b938>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <73852c81-87b7-e5f5-4041-d24f078cc7fa@vivier.eu>
Date: Tue, 5 Nov 2019 21:06:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157298160814.27285.16893877491189017648@37313f22b938>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3p1JZ1CwkuZlQUVF2ZmymEw1T4zz/u7V1caPHmFar31XUmlLtq7
 YjwS9uav+xCsjx+b3Ng1gd+keqfgZjUdWCiF0RLTWp1e/VRAizyPnx7RvphliNf/uAkqYNA
 fZPU/z7w61dFGB1bBj0csFP+labC/5M34s8jVWkOwhnPW5b0NHtr8g4OElKdUe81YePqVwQ
 5agErePOn8xRNocGnSJcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U80NqDDOsac=:rsApD5Nc3vJdDoGd4n2gRu
 IAknK0VlapT0e4qa3/ahDgoSgX8UjtI95dzHiI8ybs1BvTNRBS5Qcj7R/nHegDTKIMPfxIdnF
 TmLH48GwxFzBf0C7nhXLkV9WRMgqW30u7VjMIWdCpVMDe4qcr6hWqdQFsOi6qH7SDBhu/EsfN
 sW2WwrMyVQs1yjeZ8MGq6LYggRv4+z0inruzdaMyRK3EbJUGgul6Yco0woTKgWl2WQuhnchwR
 4+OITfU5TM3DMU1Y9nXYw6a0s83bcEkDQz7rYC/bCWYkBl+1aetRrmJ1+LYNvYbeERjaEHocD
 PVkSAtCwdSpUdCPrWdI/pRAN9/P5+oTa13XR2XlxNtmh8+1ykq+s7ai6zE0O6FLc0EVXexzR2
 LCZ+hqYMGQCFuBz6Ut+NA1S3ya9J9VH0kTYzjRn4O99gBemK8h5FUhkEDmHcsBOdhRgpT5imQ
 EPTl7OT1A6ZTivIzntrSCumsF9EGkPD82Dym/dHCFQnVWzsEpT8Gz2doG/Syjl0RYJ2lxzDed
 ayxfTfR8X+lX2QiA8MjuXSH+bcuLrqSK8+x+pUp3feMVmOSdrSzl6feKixgrsl21kSwxHwZJe
 oN7Nr+KVpbqq5hQqGmRLbueNs/DYhW7Lp92ZKvOdgdRmX6m/ptA8H2tMyPsw2CDBDZGQkwWyE
 AoBiC5VNiBecaw/jYd9XD4JxC3l63nlPpOpqmZ6j+Qx9c/F/Jetj47vN55V1zivCNYXVogp8Z
 os46/gDJkaYZ6ogZHphDlul/KuDYTUuEiEEVavZ5jBicjY8wovOzJsFOVvqBVxEhyd51AN2bH
 3f1p3uLKdeOx3A5EwJ/LQDbPrfz3IiMcmg87CjAc7PD/W5U5x8OvhYwjxGPruqz6MPSYsyX9G
 Wee5gkWnZJiQW/iCZVWQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.13
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
Cc: peter.maydell@linaro.org, sstabellini@kernel.org, ehabkost@redhat.com,
 paul@xen.org, qemu-trivial@nongnu.org, mjt@tls.msk.ru,
 claudio.fontana@huawei.com, chouteau@adacore.com,
 xen-devel@lists.xenproject.org, frederic.konrad@adacore.com,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, crosa@redhat.com,
 anthony.perard@citrix.com, marcandre.lureau@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 05/11/2019 à 20:20, no-reply@patchew.org a écrit :
> Patchew URL: https://patchew.org/QEMU/20191105175010.2591-1-laurent@vivier.eu/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [Xen-devel] [PULL v2 0/3] Trivial branch patches
> Type: series
> Message-id: 20191105175010.2591-1-laurent@vivier.eu
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
> 49a55f7 global: Squash 'the the'
> c0b5513 hw/misc/grlib_ahb_apb_pnp: Fix 8-bit accesses
> eb43395 hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to PnP registers
> 
> === OUTPUT BEGIN ===
> 1/3 Checking commit eb43395bf8f1 (hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to PnP registers)
> 2/3 Checking commit c0b5513f971a (hw/misc/grlib_ahb_apb_pnp: Fix 8-bit accesses)
> 3/3 Checking commit 49a55f7feb19 (global: Squash 'the the')
> ERROR: do not use C99 // comments
> #26: FILE: disas/libvixl/vixl/invalset.h:105:
> +  // Note that this does not mean the backing storage is empty: it can still

As reported by David Gilbert, this is a false positive as this file is a
C++ file.

Thanks,
LAurent



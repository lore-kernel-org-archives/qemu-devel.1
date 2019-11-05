Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32985C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08387214B2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08387214B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS1Hs-0005fu-6d
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 11:02:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS1CQ-0001Aa-8u
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:56:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS1CO-0001wl-R1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:56:54 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:39335)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iS1CN-0001qG-6C; Tue, 05 Nov 2019 10:56:52 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M7sUE-1iWwsL2Qa2-0055IN; Tue, 05 Nov 2019 16:56:19 +0100
Subject: Re: [PULL 0/4] Trivial branch patches
To: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Greg Kurz <groug@kaod.org>
References: <157296887817.27285.13935693519835086344@37313f22b938>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <41caef0b-3db3-3fcf-a0b4-329e8e88ff0f@vivier.eu>
Date: Tue, 5 Nov 2019 16:56:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157296887817.27285.13935693519835086344@37313f22b938>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FjHwSkz5ndl840sqMUwvfBm9wHQDnDDraGITrSyvauoeKq8xQTe
 R7rRPGcNLLaDXGL2hVsxEK+lk8or4FHdrmCx1BDh8O+RdvmkVvRI+/4AvkKsVZdG/ElfvjQ
 DXRoMIvWB3VtWvUgBJxFJoPzW36Gl84XER59Sx/0nYkMAEJZ9bbpfZ5KzEKn2uJfBAkCPk/
 9dBZtpnpYr7v5TL/Np0Gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z43f+oCTNgk=:ydHo1+7SSD9Jwas5xOuUIx
 Ii9+osTuZOnoPW3C3uwNwQ7/gHNpF6yguRgqVoVY17F9h6O5o451jLLhpspLLWXc6VFpqvGpy
 cv++mhvLR9ttEv3XI0+yk3VsB6qVtNpRAUfaLXuJS/ysxTWrQcj/NzBN5Fr7QhYjaBdBYOjTX
 uFq2WH4RfPKxUysQBY9HAYknW6XGTHUPslSL4RhnswZsiAutGBFQdwFp4x+EpVJQ/PmhwcVYW
 c29tSOTuWlkhllMP7r/l3f+L/oogLcb0jMzJYomYQVRj/EaSOxeJDFhOukLzG0G7hVIaWB33K
 eYrXtE7FcWTZsbnc3dV216QAm1XGg4HkMoc+3D3WizRNYdX95Tgx4EzoQS3E+TDlWK9AbY+sQ
 33RYXFRiIAahCyLmCVIaAeZBDFEWfLi/hZNaA9xxu15efDRpaE7L+ic0rU2fxeYI+ujZy/ZQd
 GhNydckZxe0fJ3bSoiLeWihMP/UHs2sAkwGDINZ9HraclvJyCTKxOKovLFuY6EjG7/5RGVxsU
 edo8Gh9mEvLcBkryZO98SDOGsBYBcuTuuunUpcQeWhj/eMSZJgOq6B6dFf0bpBASJZmDYdR25
 FooPnrXb0IBu+a9qE0LQCOVu40oynlQL62jdVQIfhDYrKKC11H5G5mvVWz812Ut7h1gPrFgBV
 d/JHnGMvv6uXJ11/Y+koA4vHgee0n0JY4oHgh9fmgA6GW9IJQspchQLyAzT/f168WVSJAb3pv
 lWkQzhcvohBNwQFcaTLMPr9FRFpKv64Uj1d6BszQeUXN3dGLepx0dHsuixyW1E8Na4ObEWwli
 QicVU5rUVaJvHbE2rmKDowVVpsl/BaHWAkIK0Dd8aniOO1Fw1gnOFkiMqmYRMbfi9Cx3Kbkku
 LURulaWwTFbm9/kxYw6Q==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, sstabellini@kernel.org, berrange@redhat.com,
 ehabkost@redhat.com, paul@xen.org, qemu-trivial@nongnu.org, mjt@tls.msk.ru,
 claudio.fontana@huawei.com, chouteau@adacore.com, marcandre.lureau@redhat.com,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 clg@kaod.org, crosa@redhat.com, anthony.perard@citrix.com, pbonzini@redhat.com,
 david@gibson.dropbear.id.au, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg, Dave,

could you fix that?

Thanks,
Laurent

Le 05/11/2019 à 16:48, no-reply@patchew.org a écrit :
> Patchew URL: https://patchew.org/QEMU/20191105144247.10301-1-laurent@vivier.eu/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [PULL 0/4] Trivial branch patches
> Type: series
> Message-id: 20191105144247.10301-1-laurent@vivier.eu
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
> 85ac453 global: Squash 'the the'
> 9dd7da4 qom: Fix error message in object_class_property_add()
> 2b76b45 hw/misc/grlib_ahb_apb_pnp: Fix 8-bit accesses
> bddcfd9 hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to PnP registers
> 
> === OUTPUT BEGIN ===
> 1/4 Checking commit bddcfd9b6b24 (hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to PnP registers)
> 2/4 Checking commit 2b76b451f9b7 (hw/misc/grlib_ahb_apb_pnp: Fix 8-bit accesses)
> 3/4 Checking commit 9dd7da421bfb (qom: Fix error message in object_class_property_add())
> WARNING: line over 80 characters
> #31: FILE: qom/object.c:1109:
> +        error_setg(errp, "attempt to add duplicate property '%s' to object (type '%s')",
> 
> WARNING: line over 80 characters
> #43: FILE: qom/object.c:1141:
> +        error_setg(errp, "attempt to add duplicate property '%s' to class (type '%s')",
> 
> total: 0 errors, 2 warnings, 22 lines checked
> 
> Patch 3/4 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 4/4 Checking commit 85ac453d1520 (global: Squash 'the the')
> ERROR: do not use C99 // comments
> #26: FILE: disas/libvixl/vixl/invalset.h:105:
> +  // Note that this does not mean the backing storage is empty: it can still
> 
> total: 1 errors, 0 warnings, 56 lines checked
> 
> Patch 4/4 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20191105144247.10301-1-laurent@vivier.eu/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


